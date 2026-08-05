import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK
from ihp.cells import guard_ring, nmos
from ihp.cells2 import via_stack

PDK.activate()


@gf.cell
def discharge(
    width=0.5,
    length=0.65,
    stages=4,
    branches=2,
) -> Component:
    c = Component("discharge")

    branch_sep = 0.6
    poly_width = 0.3
    metal_width = 0.32

    refs = []
    next_x = 0

    for i in range(branches):
        ref = c.add_ref(
            nmos(
                width=width*stages,
                length=length,
                nf=stages,
            )
        )
        ref.xmin = next_x
        refs.append(ref)
        next_x = ref.xmax + branch_sep

    gate_ports = []
    for ref in refs:
        for i in range(1, stages+1):
            gate_ports.append(ref.ports["G"+str(i)])

    gate_xmin = min(p.center[0] for p in gate_ports) - length/2
    gate_xmax = max(p.center[0] for p in gate_ports) + length/2
    gate_ymin = max(p.center[1] + p.width/2 for p in gate_ports)
    gate_ymax = gate_ymin + poly_width

    c.add_polygon(
        [
            (gate_xmin, gate_ymin),
            (gate_xmax, gate_ymin),
            (gate_xmax, gate_ymax),
            (gate_xmin, gate_ymax),
        ],
        layer="GatPolydrawing"
    )

    gate_x = (gate_xmin+gate_xmax)/2
    gate_y = (gate_ymin+gate_ymax)/2
    contact_size = 0.16
    poly_pad_size = 0.30
    metal_pad_size = 0.26

    c.add_polygon(
        [
            (gate_x-poly_pad_size/2, gate_y-poly_pad_size/2),
            (gate_x+poly_pad_size/2, gate_y-poly_pad_size/2),
            (gate_x+poly_pad_size/2, gate_y+poly_pad_size/2),
            (gate_x-poly_pad_size/2, gate_y+poly_pad_size/2),
        ],
        layer="GatPolydrawing"
    )

    c.add_polygon(
        [
            (gate_x-metal_pad_size/2, gate_y-metal_pad_size/2),
            (gate_x+metal_pad_size/2, gate_y-metal_pad_size/2),
            (gate_x+metal_pad_size/2, gate_y+metal_pad_size/2),
            (gate_x-metal_pad_size/2, gate_y+metal_pad_size/2),
        ],
        layer="Metal1drawing"
    )

    c.add_polygon(
        [
            (gate_x-contact_size/2, gate_y-contact_size/2),
            (gate_x+contact_size/2, gate_y-contact_size/2),
            (gate_x+contact_size/2, gate_y+contact_size/2),
            (gate_x-contact_size/2, gate_y+contact_size/2),
        ],
        layer="Contdrawing"
    )

    vgnd_ports = [ref.ports["SD0"] for ref in refs]
    gpwr_ports = [ref.ports["SD"+str(stages)] for ref in refs]

    vgnd_y = min(ref.ymin for ref in refs) - 0.5
    gpwr_y = gate_ymax + 0.5

    for port in vgnd_ports+gpwr_ports:
        contact = c.add_ref(
            via_stack(
                bottom_layer="Metal1",
                top_layer="Metal2",
                vn_columns=1,
                vn_rows=1,
            )
        )
        contact.x = port.center[0]
        contact.y = port.center[1]

    for port in vgnd_ports:
        c.add_polygon(
            [
                (port.center[0]-metal_width/2, vgnd_y),
                (port.center[0]+metal_width/2, vgnd_y),
                (port.center[0]+metal_width/2, port.center[1]),
                (port.center[0]-metal_width/2, port.center[1]),
            ],
            layer="Metal2drawing"
        )

    for port in gpwr_ports:
        c.add_polygon(
            [
                (port.center[0]-metal_width/2, port.center[1]),
                (port.center[0]+metal_width/2, port.center[1]),
                (port.center[0]+metal_width/2, gpwr_y),
                (port.center[0]-metal_width/2, gpwr_y),
            ],
            layer="Metal2drawing"
        )

    vgnd_xmin = min(p.center[0] for p in vgnd_ports)
    vgnd_xmax = max(p.center[0] for p in vgnd_ports)
    gpwr_xmin = min(p.center[0] for p in gpwr_ports)
    gpwr_xmax = max(p.center[0] for p in gpwr_ports)

    c.add_polygon(
        [
            (vgnd_xmin, vgnd_y-metal_width/2),
            (vgnd_xmax, vgnd_y-metal_width/2),
            (vgnd_xmax, vgnd_y+metal_width/2),
            (vgnd_xmin, vgnd_y+metal_width/2),
        ],
        layer="Metal2drawing"
    )

    c.add_polygon(
        [
            (gpwr_xmin, gpwr_y-metal_width/2),
            (gpwr_xmax, gpwr_y-metal_width/2),
            (gpwr_xmax, gpwr_y+metal_width/2),
            (gpwr_xmin, gpwr_y+metal_width/2),
        ],
        layer="Metal2drawing"
    )

    guard_bbox = (
        (min(ref.xmin for ref in refs), vgnd_y-metal_width/2),
        (max(ref.xmax for ref in refs), gpwr_y+metal_width/2),
    )

    c.add_ref(
        guard_ring(
            width=0.32,
            guardRingSpacing=0.3,
            guardRingType="psub",
            bbox=guard_bbox,
        )
    )

    c.add_port(
        name="gate",
        center=(gate_x, gate_y),
        width=metal_pad_size,
        orientation=90,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="VGND",
        center=(vgnd_xmin, vgnd_y),
        width=metal_width,
        orientation=180,
        layer="Metal2pin",
        port_type="electrical",
    )

    c.add_port(
        name="GPWR",
        center=(gpwr_xmin, gpwr_y),
        width=metal_width,
        orientation=180,
        layer="Metal2pin",
        port_type="electrical",
    )

    return c


if __name__ == "__main__":
    top = discharge()
    top.write_gds("hm_pg_lv_discharge.gds")
