import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK
from ihp.cells import guard_ring, nmos, pmos

PDK.activate()


@gf.cell
def inverter(
    width_p=4.44,
    width_n=2.6,
    length=0.13,
) -> Component:
    c = Component("inverter")

    device_sep = 0.3
    input_ext = 0.5
    output_ext = 0.5
    metal_width = 0.16

    n = c.add_ref(nmos(width=width_n, length=length, nf=1))
    p = c.add_ref(pmos(width=width_p, length=length, nf=1))

    p.x = n.x
    p.ymin = n.ymax + device_sep

    guard_width = 0.32
    guard_sep = 0.3

    n_guard_xmin = n.xmin - guard_sep - guard_width/2
    n_guard_xmax = n.xmax + guard_sep + guard_width/2
    n_guard_ymin = n.ymin - guard_sep - guard_width/2
    n_guard_ymax = n.center[1] + width_n/2

    c.add_ref(
        guard_ring(
            width=guard_width,
            guardRingType="psub",
            bbox=None,
            path=[
                (n_guard_xmin, n_guard_ymax),
                (n_guard_xmin, n_guard_ymin),
                (n_guard_xmax, n_guard_ymin),
                (n_guard_xmax, n_guard_ymax),
            ],
        )
    )

    well_excess_hor = 0.3
    well_excess_ver = 0.13

    p_guard_xmin = p.xmin - guard_sep - guard_width/2 + well_excess_hor
    p_guard_xmax = p.xmax + guard_sep + guard_width/2 - well_excess_hor
    p_guard_ymin = p.center[1] - width_p/2
    p_guard_ymax = p.ymax + guard_sep + guard_width/2 - well_excess_ver

    c.add_ref(
        guard_ring(
            width=guard_width,
            guardRingType="nwell",
            bbox=None,
            path=[
                (p_guard_xmin, p_guard_ymin),
                (p_guard_xmin, p_guard_ymax),
                (p_guard_xmax, p_guard_ymax),
                (p_guard_xmax, p_guard_ymin),
            ],
        )
    )

    gate_n = n.ports["G"]
    gate_p = p.ports["G"]
    gate_y = (gate_n.center[1] - width_p/2 + gate_p.center[1] + width_n/2) / 2
    input_x = gate_n.center[0] - input_ext

    c.add_polygon(
        [
            (gate_n.center[0] - length/2, gate_n.center[1]),
            (gate_n.center[0] + length/2, gate_n.center[1]),
            (gate_p.center[0] + length/2, gate_p.center[1]),
            (gate_p.center[0] - length/2, gate_p.center[1]),
        ],
        layer="GatPolydrawing"
    )

    c.add_polygon(
        [
            (input_x, gate_y - metal_width/2),
            (gate_n.center[0], gate_y - metal_width/2),
            (gate_n.center[0], gate_y + metal_width/2),
            (input_x, gate_y + metal_width/2),
        ],
        layer="Metal1drawing"
    )

    contact_size = 0.16
    poly_pad_size = 0.30
    metal_pad_size = 0.26

    c.add_polygon(
        [
            (gate_n.center[0] - poly_pad_size/2, gate_y - poly_pad_size/2),
            (gate_n.center[0] + poly_pad_size/2, gate_y - poly_pad_size/2),
            (gate_n.center[0] + poly_pad_size/2, gate_y + poly_pad_size/2),
            (gate_n.center[0] - poly_pad_size/2, gate_y + poly_pad_size/2),
        ],
        layer="GatPolydrawing"
    )

    c.add_polygon(
        [
            (gate_n.center[0] - metal_pad_size/2, gate_y - metal_pad_size/2),
            (gate_n.center[0] + metal_pad_size/2, gate_y - metal_pad_size/2),
            (gate_n.center[0] + metal_pad_size/2, gate_y + metal_pad_size/2),
            (gate_n.center[0] - metal_pad_size/2, gate_y + metal_pad_size/2),
        ],
        layer="Metal1drawing"
    )

    c.add_polygon(
        [
            (gate_n.center[0] - contact_size/2, gate_y - contact_size/2),
            (gate_n.center[0] + contact_size/2, gate_y - contact_size/2),
            (gate_n.center[0] + contact_size/2, gate_y + contact_size/2),
            (gate_n.center[0] - contact_size/2, gate_y + contact_size/2),
        ],
        layer="Contdrawing"
    )

    drain_n = n.ports["D"]
    drain_p = p.ports["D"]
    source_n = n.ports["S"]
    source_p = p.ports["S"]
    output_y = source_n.center[1]
    output_x = source_n.center[0] 

    c.add_polygon(
        [
            (drain_p.center[0] - metal_width/2, drain_p.center[1]),
            (drain_p.center[0] + metal_width/2, drain_p.center[1]),
            (drain_p.center[0] + metal_width/2, p_guard_ymax),
            (drain_p.center[0] - metal_width/2, p_guard_ymax),
        ],
        layer="Metal1drawing"
    )

    c.add_polygon(
        [
            (drain_n.center[0] - metal_width/2, n_guard_ymin),
            (drain_n.center[0] + metal_width/2, n_guard_ymin),
            (drain_n.center[0] + metal_width/2, drain_n.center[1]),
            (drain_n.center[0] - metal_width/2, drain_n.center[1]),
        ],
        layer="Metal1drawing"
    )

    #c.add_polygon(
    #    [
    #        (drain_n.center[0], output_y - metal_width/2),
    #        (output_x, output_y - metal_width/2),
    #        (output_x, output_y + metal_width/2),
    #        (drain_n.center[0], output_y + metal_width/2),
    #    ],
    #    layer="Metal1drawing"
    #)

    c.add_port(
        name="IN",
        center=(input_x, gate_y),
        width=metal_width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="OUT_n",
        center=(output_x, output_y),
        width=width_n,
        orientation=0,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="OUT_p",
        center=(source_p.center[0], source_p.center[1]),
        width=width_p,
        orientation=0,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="VDD",
        center=((p_guard_xmin+p_guard_xmax)/2, p_guard_ymax),
        width=p_guard_xmax-p_guard_xmin,
        orientation=0,
        layer="Metal1pin",
        port_type="electrical"
    )

    c.add_port(
        name="VSS",
        center=((n_guard_xmin+n_guard_xmax)/2, n_guard_ymin),
        width=n_guard_xmax-n_guard_xmin,
        orientation=0,
        layer="Metal1pin",
        port_type="electrical"
    )

    #c.add_port(name="VDD", port=p.ports["S"])
    #c.add_port(name="GND", port=n.ports["S"])

    return c


if __name__ == "__main__":
    top = inverter()
    top.write_gds("hm_pg_lv_inv.gds")
