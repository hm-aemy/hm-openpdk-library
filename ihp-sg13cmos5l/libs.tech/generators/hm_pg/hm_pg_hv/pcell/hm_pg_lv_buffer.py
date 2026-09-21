import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK
from ihp.cells import nmos, pmos, ntap1, ptap1
from utils import connect_ports_to_bus_v2, connect_gates_to_bus, connect_gates_to_bus_v2, populate_via_stack

PDK.activate()

@gf.cell
def buffer(
    width_p = 2.0,
    width_n = 1.0,
    length = 0.13
) -> Component:
    c = Component("buffer")

    device_sep = 0.3
    device_horizontal_sep = 0.85

    p_0 = c.add_ref(pmos(width=width_p, length=length, nf=1))
    n_0 = c.add_ref(nmos(width=width_n, length=length, nf=1))
    p_0.x = n_0.x
    p_0.ymin = n_0.ymax + device_sep

    p_1 = c.add_ref(pmos(width=width_p, length=length, nf=1))
    n_1 = c.add_ref(nmos(width=width_n, length=length, nf=1))
    n_1.xmin = n_0.xmax + device_horizontal_sep
    p_1.x = n_1.x
    p_1.ymin = n_1.ymax + device_sep

    ntap = c.add_ref(ntap1(width=p_0.ports["SD1"].width, length=0.38, rows=3))
    ntap.center = ((p_0.xmax+p_1.xmin)/2, p_0.ports["SD1"].center[1])

    ptap = c.add_ref(ptap1(width=n_0.ports["SD1"].width, length=0.38, rows=3))
    ptap.center = ((n_0.xmax+n_1.xmin)/2, n_0.ports["SD1"].center[1])

    vssPath = [
        n_0.ports["SD1"].center,
        n_1.ports["SD0"].center
    ] 
    path = gf.Path(vssPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = n_0.ports["SD0"].width
    )
    c.add_ref(path_component)

    vddPath = [
        p_0.ports["SD1"].center,
        p_1.ports["SD0"].center
    ] 
    path = gf.Path(vddPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = p_0.ports["SD0"].width
    )
    c.add_ref(path_component)

    connect_ports_to_bus_v2(
        c,
        ports = [n_1.ports["SD1"], p_1.ports["SD1"]],
        distance=-0.3,
        hor_layer="Metal2drawing",
        ver_layer="Metal2drawing",
        polyBusWidth=0.3,
        bus_side="middle",
        pin_name="OUT_N"
    )

    connect_gates_to_bus_v2(
        c,
        gates=[n_0.ports["G"], p_0.ports["G"]],
        length=0.13,
        offset=-0.3,
        bus_side="middle",
        pin_name="IN_N_GATE"
    )
    connect_gates_to_bus_v2(
        c,
        gates=[n_1.ports["G"], p_1.ports["G"]],
        length=0.13,
        offset=-0.3,
        bus_side="middle",
        pin_name="IN"
    )

    populate_via_stack(
        c,
        column_width=n_1.ports["SD1"].width,
        row_width=0.3,
        center=n_1.ports["SD1"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=p_1.ports["SD1"].width,
        row_width=0.3,
        center=p_1.ports["SD1"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    
    outNPath = [
        c.ports["OUT_N"].center,
        c.ports["IN_N_GATE"].center
    ] 
    path = gf.Path(outNPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    outPathOffset = 0.3
    outPath = [
        (n_0.ports["SD0"].center[0]-outPathOffset, n_0.ports["SD0"].center[1]),
        (n_0.ports["SD0"].center[0]-outPathOffset, p_0.ports["SD0"].center[1]),
    ]
    path = gf.Path(outPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    outNConnPath = [
        n_0.ports["SD0"].center,
        (n_0.ports["SD0"].center[0]-outPathOffset, n_0.ports["SD0"].center[1]),
    ]
    path = gf.Path(outNConnPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = n_0.ports["SD0"].width
    )
    c.add_ref(path_component)
    outPConnPath = [
        p_0.ports["SD0"].center,
        (n_0.ports["SD0"].center[0]-outPathOffset, p_0.ports["SD0"].center[1]),
    ]
    path = gf.Path(outPConnPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = p_0.ports["SD0"].width
    )
    c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=n_0.ports["SD0"].width,
        row_width=0.3,
        center=(n_0.ports["SD0"].center[0]-outPathOffset, n_0.ports["SD0"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=p_0.ports["SD0"].width,
        row_width=0.3,
        center=(p_0.ports["SD0"].center[0]-outPathOffset, p_0.ports["SD0"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    populate_via_stack(
        c, 
        column_width=0.3,
        row_width=0.3,
        center=c.ports["IN_N_GATE"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    c.add_port(
        name="IN_P",
        center=n_0.ports["SD0"].center,
        width=n_0.ports["SD0"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="IN_N",
        center=c.ports["OUT_N"].center,
        width=c.ports["OUT_N"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="VSS",
        center=ptap.ports["TAP"].center,
        width=ptap.ports["TAP"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    return c

if __name__ == "__main__":
    top = buffer()
    top.write("hm_pg_lv_buffer.gds")
