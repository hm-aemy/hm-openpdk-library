import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK, tech
from ihp.cells import nmos, pmos, guard_ring
from utils import populate_via_stack

PDK.activate()
   
def get_sd_ports_even_odd(ref):
    sd_ports = []

    for p in ref.ports:
        if p.name.startswith("SD"):
            idx = int(p.name.replace("SD", ""))
            sd_ports.append((idx, p))

    sd_ports = sorted(sd_ports, key=lambda x: x[0])

    even_ports = [p for idx, p in sd_ports if idx % 2 == 0]
    odd_ports  = [p for idx, p in sd_ports if idx % 2 == 1]

    return even_ports, odd_ports

@gf.cell
def power_lv_pmos(
    width=100,
    length=0.13,
    nf=10,
    sd_sep=0.5
) -> Component:

    pmosSep=-0.02 #Needed for both psD to meet.

    Wf = width/nf
    doubleRow=False
    if Wf>10:
        Wf = Wf/2
        doubleRow=True
        print("Wf > 10, generating double row")

    overlap = 0.18
    polyConnW = 0.3
    sdConnW = 0.16

    c = Component("power_lv_pmos")

    if doubleRow:
    
        m1 = c.add_ref(pmos(width=width/2, length=length, nf=nf))
        m1.dymin=0
        m1.dxmin=0
        m2 = c.add_ref(pmos(width=width/2, length=length, nf=nf))
        m2.dymin=0
        m2.dxmin=0
        m2.movey(m1.ymax+pmosSep) 

        m = [m1, m2]
        
    else:
        m1 = c.add_ref(pmos(width=width, length=length, nf=nf))
        m = [m1]

    if doubleRow:
        m1EvenSDPorts, m1OddSDPorts = get_sd_ports_even_odd(m[0])
        m2EvenSDPorts, m2OddSDPorts = get_sd_ports_even_odd(m[1])
        sFirstCenter = m1EvenSDPorts[0].center
        sFirstWidth = m1EvenSDPorts[0].width
        sLastCenter = m1EvenSDPorts[-1].center
        c.add_polygon(
            [
                (sFirstCenter[0] - sdConnW/2, sFirstCenter[1]-sFirstWidth/2),
                (sLastCenter[0] + sdConnW/2, sFirstCenter[1]-sFirstWidth/2),
                (sLastCenter[0] + sdConnW/2, sFirstCenter[1]+sFirstWidth/2),
                (sFirstCenter[0] - sdConnW/2, sFirstCenter[1]+sFirstWidth/2),
            ],
            layer="Metal2drawing"
        )
        for p in m1EvenSDPorts:
            populate_via_stack(
                c,
                column_width=p.width,
                row_width=0.3,
                center=p.center,
            )
            m1W=0.16
            m1S=0.6
            c.add_polygon(
                [
                    (p.center[0]-m1W/2, p.center[1]+p.width/2),
                    (p.center[0]+m1W/2, p.center[1]+p.width/2),
                    (p.center[0]+m1W/2, p.center[1]+p.width/2+m1S),
                    (p.center[0]-m1W/2, p.center[1]+p.width/2+m1S),
                ],
                layer="Metal1drawing"
            )
        c.add_port(
            name="S",
            center=((sFirstCenter[0]+sLastCenter[0])/2, sFirstCenter[1]),
            width=sLastCenter[0]-sFirstCenter[0],
            orientation=180,
            layer="Metal2pin",
            port_type="electrical"
        )

        dFirstCenter = m2OddSDPorts[0].center
        dFirstWidth = m2OddSDPorts[0].width
        dLastCenter = m2OddSDPorts[-1].center

        c.add_polygon(
            [
                (dFirstCenter[0] - sdConnW/2, dFirstCenter[1]-dFirstWidth/2),
                (dLastCenter[0] + sdConnW/2, dFirstCenter[1]-dFirstWidth/2),
                (dLastCenter[0] + sdConnW/2, dFirstCenter[1]+dFirstWidth/2),
                (dFirstCenter[0] - sdConnW/2, dFirstCenter[1]+dFirstWidth/2),
            ],
            layer="Metal2drawing"
        )
        for p in m2OddSDPorts:
            populate_via_stack(
                c,
                column_width=p.width,
                row_width=0.3,
                center=p.center,
            )
            m1W=0.16
            m1S=0.6
            c.add_polygon(
                [
                    (p.center[0]-m1W/2, p.center[1]-p.width/2),
                    (p.center[0]+m1W/2, p.center[1]-p.width/2),
                    (p.center[0]+m1W/2, p.center[1]-p.width/2-m1S),
                    (p.center[0]-m1W/2, p.center[1]-p.width/2-m1S),
                ],
                layer="Metal1drawing"
            )
        c.add_port(
            name="D",
            center=((dFirstCenter[0]+dLastCenter[0])/2, dFirstCenter[1]),
            width=dLastCenter[0]-dFirstCenter[0],
            orientation=180,
            layer="Metal2pin",
            port_type="electrical"
        )

    guard_bbox = (
        (c.xmin, c.ymin-overlap/2),
        (c.xmax, c.ymax+overlap/2)
    )
    c.add_ref(
        guard_ring(
            width=0.32,
            guardRingSpacing=0.24,
            guardRingType="nwell",
            bbox=guard_bbox
        )
    )

    for i in range(len(m)):
        gateFirstCenter = m[i].ports["G1"].center
        gateLastCenter = m[i].ports["G"+str(nf)].center

        c.add_polygon(
            [
                (gateFirstCenter[0]-length/2, gateFirstCenter[1]+Wf/2+overlap),
                (gateLastCenter[0]+length/2, gateFirstCenter[1]+Wf/2+overlap),
                (gateLastCenter[0]+length/2, gateFirstCenter[1]+Wf/2+overlap+polyConnW),
                (gateFirstCenter[0]-length/2, gateFirstCenter[1]+Wf/2+overlap+polyConnW),
            ],
            layer="GatPolydrawing"
        )

    
    gateFirstCenter = m[1].ports["G1"].center
    gateLastCenter = m[1].ports["G"+str(nf)].center
    gateCenter = ((gateFirstCenter[0]+gateLastCenter[0])/2, gateFirstCenter[1]+Wf/2+overlap+polyConnW/2)

    c.add_port(
        name="G",
        center=gateCenter,
        width=gateLastCenter[0]-gateFirstCenter[0],
        orientation=180,
        layer="GatPolypin",
        port_type="electrical"
    )

    c.add_port(
        name="GuardRingBottom",
        center=((c.xmin+c.xmax)/2, c.ymin+0.15+0.24), #TODO: Change for relative values
        width=c.xmax-c.xmin,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical"
    )
    c.add_port(
        name="GuardRingTop",
        center=((c.xmin+c.xmax)/2, c.ymax-0.15-0.24), #TODO: Change for relative values
        width=c.xmax-c.xmin,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical"
    )

    c.info["wf"] = Wf

    if doubleRow:
        c.info["m"] = 2
    else:
        c.info["m"] =1 



    return c

if __name__ == "__main__":
    top = power_lv_pmos(width=2175, length=0.13, nf=150)
    top.write_gds("hm_pg_lv_power_pmos_v2.gds")
