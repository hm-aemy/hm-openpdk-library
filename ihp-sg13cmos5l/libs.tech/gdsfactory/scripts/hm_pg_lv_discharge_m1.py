import gdsfactory as gf
from gdsfactory import Component
from kfactory import technology
from ihp import PDK, tech
from ihp.cells import guard_ring, nmos, place_contacts, nmos_series

PDK.activate()

#def populate_contact(c, column_width=10, row_width=10, center=[0, 0]):
#
#    cont_size = tech.TECH.cont_size
#    cont_spacing = tech.TECH.cont_spacing
#
#    column_num_float = (column_width-cont_spacing)/(cont_size+cont_spacing)
#    column_num_int = int(column_num_float)
#    
#    contact_stack = c.add_ref

@gf.cell
def discharge_m1(
    width=0.5,
    length=0.65,
    stages=6,
    branches=2,
) -> Component:
    c = Component("discharge_m1")

    branch_sep = 0.2
    poly_width = 0.3
    contact_size = 0.16
    poly_pad_size = 0.30
    metal_pad_size = 0.26
    guard_width = 0.32
    guard_sep = 0.3

    refs = []
    next_x = 0

    for i in range(branches):
        ref = c.add_ref(
            nmos_series(
                width=width,
                length=length,
                stages=stages,
                model="sg13_lv_nmos",
                internal_sd_width=0.2
            )
        )
        ref.xmin = next_x
        refs.append(ref)
        next_x = ref.xmax + branch_sep

    gate_ymax = 0

    for branch, ref in enumerate(refs):
        gate_ports = [ref.ports["G"+str(i)] for i in range(1, stages+1)]
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

        c.add_port(
            name=f"G_{branch}",
            center=(gate_x, gate_y),
            width=gate_xmax-gate_xmin,
            orientation=90,
            layer="Metal1pin",
            port_type="electrical",
        )


        #c.add_polygon(
        #    [
        #        (gate_x-poly_pad_size/2, gate_y-poly_pad_size/2),
        #        (gate_x+poly_pad_size/2, gate_y-poly_pad_size/2),
        #        (gate_x+poly_pad_size/2, gate_y+poly_pad_size/2),
        #        (gate_x-poly_pad_size/2, gate_y+poly_pad_size/2),
        #    ],
        #    layer="GatPolydrawing"
        #)

        c.add_polygon(
            [
                (gate_xmin, gate_y-tech.TECH.cont_size/2),
                (gate_xmax, gate_y-tech.TECH.cont_size/2),
                (gate_xmax, gate_y+tech.TECH.cont_size/2),
                (gate_xmin, gate_y+tech.TECH.cont_size/2),
            ],
            layer="Metal1drawing"
        )

        #c.add_polygon(
        #    [
        #        (gate_x-contact_size/2, gate_y-contact_size/2),
        #        (gate_x+contact_size/2, gate_y-contact_size/2),
        #        (gate_x+contact_size/2, gate_y+contact_size/2),
        #        (gate_x-contact_size/2, gate_y+contact_size/2),
        #    ],
        #    layer="Contdrawing"
        #)

        place_contacts(
            c,
            "Contdrawing",
            gate_xmin, 
            gate_ymin,
            gate_xmax, 
            gate_ymax,
            tech.TECH.cont_enc_poly,
            0,
            tech.TECH.cont_size,
            tech.TECH.cont_spacing
        )

        c.add_port(
            name="GATE_"+str(branch),
            center=(gate_x, gate_y),
            width=metal_pad_size,
            orientation=90,
            layer="Metal1pin",
            port_type="electrical",
        )

    guard_bbox = (
        (min(ref.xmin for ref in refs), min(ref.ymin for ref in refs)),
        (max(ref.xmax for ref in refs), gate_ymax),
    )

    c.add_ref(
        guard_ring(
            width=guard_width,
            guardRingSpacing=guard_sep,
            guardRingType="psub",
            bbox=guard_bbox,
        )
    )

    drain_left = refs[0].ports["SD0"]
    drain_right = refs[-1].ports["SD"+str(stages)]
    source_left = refs[0].ports["SD"+str(stages)]
    source_right = refs[-1].ports["SD0"]
    active_ymin = drain_left.center[1]-drain_left.width/2
    active_ymax = drain_left.center[1]+drain_left.width/2
    ring_left = guard_bbox[0][0]-guard_sep-guard_width/2
    ring_right = guard_bbox[1][0]+guard_sep+guard_width/2

    for layer in ["Activdrawing", "Metal1drawing"]:
        c.add_polygon(
            [
                (ring_left, active_ymin),
                (drain_left.center[0], active_ymin),
                (drain_left.center[0], active_ymax),
                (ring_left, active_ymax),
            ],
            layer=layer
        )

        c.add_polygon(
            [
                (drain_right.center[0], active_ymin),
                (ring_right, active_ymin),
                (ring_right, active_ymax),
                (drain_right.center[0], active_ymax),
            ],
            layer=layer
        )

        c.add_polygon(
            [
                (source_left.center[0], active_ymin),
                (source_right.center[0], active_ymin),
                (source_right.center[0], active_ymax),
                (source_left.center[0], active_ymax),
            ],
            layer=layer
        )

    tie_x = guard_bbox[0][0] - guard_sep - guard_width/2
    tie_y = (guard_bbox[0][1]+guard_bbox[1][1])/2
    tie_x_r = guard_bbox[1][0] + guard_sep + guard_width/2

    c.add_port(
        name="TIE_L",
        center=(tie_x, tie_y),
        width=guard_bbox[1][1]-guard_bbox[0][1]+2*guard_sep+guard_width,
        orientation=90,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="TIE_R",
        center=(tie_x_r, tie_y),
        width=guard_bbox[1][1]-guard_bbox[0][1]+2*guard_sep+guard_width,
        orientation=90,
        layer="Metal1pin",
        port_type="electrical",
    )


    c.add_port(
        name="SOURCE",
        center=(ring_right, drain_right.center[1]),
        width=guard_width,
        orientation=0,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="DRAIN",
        center=((source_left.center[0]+source_right.center[0])/2, source_left.center[1]),
        width=source_left.width,
        orientation=90,
        layer="Metal1pin",
        port_type="electrical",
    )

    return c


if __name__ == "__main__":
    top = discharge_m1()
    top.write_gds("hm_pg_lv_discharge_m1.gds")
