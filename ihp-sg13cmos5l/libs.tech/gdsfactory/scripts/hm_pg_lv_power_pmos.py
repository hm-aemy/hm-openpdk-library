import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK, tech
from ihp.cells import nmos, pmos, guard_ring
from ihp.cells import via_stack

PDK.activate()

def populate_via_stack(c, column_width=10, row_width=0.32, center=[0,0]):
    
    via1_size = tech.TECH.via1_size_rf
    via1_spacing = tech.TECH.via1_spacing_narrow
    via1_enc = tech.TECH.via1_enc

    column_num_float = (column_width-via1_enc+via1_spacing)/(via1_size+via1_spacing)
    column_num_int = int(column_num_float)
    column_num_dec = column_num_float-column_num_int

    via_stack1 = c.add_ref(via_stack(bottom_layer="Metal1", top_layer="Metal2", vn_columns=1, vn_rows=column_num_int, size=(row_width, column_width)))
    via_stack1.x=center[0]
    via_stack1.y=center[1]

    return via_stack1
   
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

def get_port_by_name(ref, name):
    for port in ref.ports:
        if port.name == name:
            return port
    raise ValueError(f"Port {name} not found")

@gf.cell
def power_lv_pmos(
    width=100,
    length=0.13,
    nf=10,
    sd_sep=0.5
) -> Component:

    nf_width = width/nf
    overlap = 0.18
    poly_conn_width = 0.3
    sd_conn_width = 0.16

    c = Component("power_lv_pmos")
    
    m = c.add_ref(pmos(width=width, length=length, nf=nf))

    gate_first_center = m.ports["G1"].center
    gate_last_center = m.ports["G"+str(nf)].center

    gate_center = ((gate_first_center[0]+gate_last_center[0])/2, gate_first_center[1] + nf_width/2 + overlap+poly_conn_width/2)
    gate_width = gate_last_center[0]-gate_first_center[0]+length

    c.add_polygon(
        [
            (gate_first_center[0] - length/2, gate_first_center[1] + nf_width/2 + overlap),
            (gate_last_center[0] + length/2, gate_first_center[1] + nf_width/2 + overlap),
            (gate_last_center[0] + length/2, gate_first_center[1] + nf_width/2 + overlap + poly_conn_width),
            (gate_first_center[0] - length/2, gate_first_center[1] + nf_width/2 + overlap + poly_conn_width),
        ],
        layer="GatPolydrawing"
    )

    s_first_center = m.ports["SD0"].center
    s_last_center = m.ports["SD"+str(nf)].center

    c.add_polygon(
        [
            (s_first_center[0] - sd_conn_width/2, s_first_center[1] - nf_width/2),
            (s_last_center[0] + sd_conn_width/2, s_first_center[1] - nf_width/2),
            (s_last_center[0] + sd_conn_width/2, s_first_center[1] - sd_sep/2),
            (s_first_center[0] - sd_conn_width/2, s_first_center[1] - sd_sep/2),
        ],
        layer="Metal2drawing"
    )

    #via_stack1 = c.add_ref(via_stack(bottom_layer="Metal1", top_layer="Metal2", vn_columns=1, vn_rows=5))
    #via_stack1.y = s_first_center[1]
    even_sd_ports, odd_sd_ports = get_sd_ports_even_odd(m)

    for p in even_sd_ports:
        populate_via_stack(
            c,
            column_width=p.width/2-sd_sep/2,
            center=[p.center[0], (p.center[1]-sd_sep/2)/2],
        )
    #populate_via_stack(c=c, column_width=nf_width/2-sd_sep/2, center=[s_first_center[0], (s_first_center[1] - sd_sep/2)/2])

    for p in odd_sd_ports:
        populate_via_stack(
            c,
            column_width=p.width/2-sd_sep/2,
            center=[p.center[0], p.width -(p.center[1]-sd_sep/2)/2],
        )

    d_first_center = m.ports["SD1"].center
    d_last_center = m.ports["SD"+str(nf-1)].center

    c.add_polygon(
        [
            (d_first_center[0] - sd_conn_width/2, d_first_center[1] + nf_width/2),
            (d_last_center[0] + sd_conn_width/2, d_first_center[1] + nf_width/2),
            (d_last_center[0] + sd_conn_width/2, d_first_center[1] + sd_sep/2),
            (d_first_center[0] - sd_conn_width/2, d_first_center[1] + sd_sep/2),
        ],
        layer="Metal2drawing"
    )

    guard_bbox = (
        (c.xmin, c.ymin),
        (c.xmax, c.ymax)
    )

    c.add_port(
        name="GuardRingBottom",
        center=((c.xmin+c.xmax)/2, c.ymin-0.15-0.16),
        width=c.xmax-c.xmin,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical"
    )
    c.add_port(
        name="GuardRingTop",
        center=((c.xmin+c.xmax)/2, c.ymax+0.15+0.16),
        width=c.xmax-c.xmin,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical"
    )

    c.add_ref(
        guard_ring(
            width=0.32,
            guardRingSpacing=0.15,
            guardRingType="nwell",
            bbox=guard_bbox
        )
    )


    c.add_port(
        name="G",
        center=gate_center,
        width=gate_width,
        orientation=180,
        layer="GatPolypin",
        port_type="electrical"
    )

    c.add_port(
        name="D",
        center=((d_first_center[0]+d_last_center[0])/2, d_first_center[1]+nf_width/4),
        width=d_last_center[0]-d_first_center[0],
        orientation=180,
        layer="Metal2pin",
        port_type="electrical"
    )
    c.add_port(
        name="S",
        center=((s_first_center[0]+s_last_center[0])/2, s_first_center[1]+nf_width/4),
        width=s_last_center[0]-s_first_center[0],
        orientation=180,
        layer="Metal2pin",
        port_type="electrical"
    )


    return c

if __name__ == "__main__":
    top = power_lv_pmos(width=2175, length=0.13, nf=290)
    top.write_gds("hm_pg_lv_power_pmos.gds")
    top.show()
