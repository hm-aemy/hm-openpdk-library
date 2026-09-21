import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK
from ihp.cells import nmos_hv, pmos_hv, guard_ring, ptap1, ntap1
from utils import connect_gates_to_bus, populate_via_stack, get_sd_ports_even_odd, connect_ports_to_bus, connect_gates_to_bus_v2

from hm_pg_lv_buffer import buffer

PDK.activate()

@gf.cell
def cross_couple_inv_hv(
    cc_nmos_width = 1.0,
    cc_pmos_width = 1.0,
    cc_nmos_length = 0.45,
    cc_pmos_length = 0.4,

    inv_lv_width =  1.0,
    
    inv_hv_pmos_width = 2.0,
    inv_hv_nmos_width = 1.0
) -> Component:
    c = Component("cross_couple_inv_hv")

    device_sep = 0.1

    # cross-coupled network
    nmos_cc = c.add_ref(nmos_hv(width=cc_nmos_width, length=0.45, nf=1))
    pmos_inv_hv_cc = c.add_ref(pmos_hv(width=cc_pmos_width+inv_hv_pmos_width, length=0.4, nf=3))

    pmos_inv_hv_cc.xmin = 0 
    nmos_cc.ymin = 0
    nmos_cc.xmin = 0
    pmos_inv_hv_cc.ymin = nmos_cc.ymax + device_sep

    # inverter hv
    nmos_inv_hv = c.add_ref(nmos_hv(width=inv_hv_nmos_width, length=0.45, nf=1))

    nmos_inv_hv.ymin = 0
    nmos_inv_hv.xmax = pmos_inv_hv_cc.xmax

    connect_gates_to_bus(c, pmos_inv_hv_cc, length=0.45, layer="GatPolydrawing", bus_side="bottom", pin_name="ccGate")

    pmos_inv_hv_cc_drains, pmos_inv_hv_cc_sources = get_sd_ports_even_odd(pmos_inv_hv_cc)
    nmos_inv_hv_sources, nmos_inv_hv_drains = get_sd_ports_even_odd(nmos_inv_hv)
    nmos_cc_drains, nmos_cc_sources = get_sd_ports_even_odd(nmos_cc)

    populate_via_stack(
        c,
        column_width=pmos_inv_hv_cc_drains[1].width,
        row_width=0.3,
        center=pmos_inv_hv_cc_drains[1].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=pmos_inv_hv_cc_sources[0].width,
        row_width=0.3,
        center=pmos_inv_hv_cc_sources[0].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=pmos_inv_hv_cc_sources[1].width,
        row_width=0.3,
        center=pmos_inv_hv_cc_sources[1].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=nmos_inv_hv_drains[0].width,
        row_width=0.3,
        center=nmos_inv_hv_drains[0].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=nmos_inv_hv_sources[0].width,
        row_width=0.3,
        center=nmos_inv_hv_sources[0].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=nmos_cc_sources[0].width,
        row_width=0.3,
        center=nmos_cc_sources[0].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=nmos_cc_drains[0].width,
        row_width=0.3,
        center=nmos_cc_drains[0].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    invHvGatePath = [
        nmos_inv_hv.ports["G"].center,
        (nmos_inv_hv.ports["G"].center[0], c.ports["ccGate"].center[1]),
        c.ports["ccGate"].center
    ]
    path = gf.Path(invHvGatePath)
    path_component = gf.path.extrude(
        path,
        layer = "GatPolydrawing",
        width = 0.3
    )
    c.add_ref(path_component)

    invHvOutPath = [
        pmos_inv_hv_cc_drains[1].center,
        (pmos_inv_hv_cc_drains[1].center[0], (pmos_inv_hv_cc.ymin+nmos_inv_hv.ymax)/2),
        (nmos_inv_hv_drains[0].center[0], (pmos_inv_hv_cc.ymin+nmos_inv_hv.ymax)/2),
        nmos_inv_hv_drains[0].center
    ]
    path = gf.Path(invHvOutPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    nmosVSSPath = [
        nmos_cc_sources[0].center,
        nmos_inv_hv_sources[0].center
    ]
    path = gf.Path(nmosVSSPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = nmos_cc_sources[0].width
    )
    c.add_ref(path_component)

    c.add_port(
        name="ccDrain",
        center=pmos_inv_hv_cc_drains[0].center,
        width=pmos_inv_hv_cc_drains[0].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="ccNmosDrain",
        center=nmos_cc_drains[0].center,
        width=nmos_cc_drains[0].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="ccSource_0",
        center=pmos_inv_hv_cc_sources[0].center,
        width=pmos_inv_hv_cc_sources[0].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="ccSource_1",
        center=pmos_inv_hv_cc_sources[1].center,
        width=pmos_inv_hv_cc_sources[1].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_polygon(
        [
            (nmos_inv_hv.xmax, nmos_inv_hv.ymin),
            (nmos_cc.xmin, nmos_cc.ymin),
            (nmos_cc.xmin, nmos_cc.ymax),
            (nmos_inv_hv.xmax, nmos_inv_hv.ymax),
        ],
        layer="ThickGateOxdrawing"
    )

    c.add_polygon(
        [
            (nmos_cc.xmin, nmos_cc.ymax),
            (nmos_inv_hv.xmax, nmos_inv_hv.ymax),
            (pmos_inv_hv_cc.xmax, pmos_inv_hv_cc.ymin),
            (pmos_inv_hv_cc.xmin, pmos_inv_hv_cc.ymin),
        ],
        layer="ThickGateOxdrawing"
    )

    guardNmos = c.add_ref(
        ptap1(
            width=nmos_cc_sources[0].width,
            length=0.38,
            rows=5
        )
    )
    guardNmos.center = ((nmos_cc_sources[0].center[0]+nmos_inv_hv_sources[0].center[0])/2, nmos_cc_sources[0].center[1])
    populate_via_stack(
        c,
        column_width=guardNmos.ports["TAP"].width,
        row_width=0.3,
        center=guardNmos.ports["TAP"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    ntap = c.add_ref(
        ntap1(
            width=pmos_inv_hv_cc_sources[0].width,
            length=0.38,
            rows=5
        )
    )
    ntap.center = (pmos_inv_hv_cc.xmax, pmos_inv_hv_cc_sources[1].center[1])

    c.add_polygon(
        [
            (pmos_inv_hv_cc.xmax, pmos_inv_hv_cc.ymin),
            (c.xmax+0.31, pmos_inv_hv_cc.ymin),
            (c.xmax+0.31, pmos_inv_hv_cc.ymax),
            (pmos_inv_hv_cc.xmax, pmos_inv_hv_cc.ymax)
        ],
        layer="ThickGateOxdrawing"
    )
    c.add_polygon(
        [
            (pmos_inv_hv_cc.xmax, pmos_inv_hv_cc.ymin),
            (c.xmax, pmos_inv_hv_cc.ymin),
            (c.xmax, pmos_inv_hv_cc.ymax),
            (pmos_inv_hv_cc.xmax, pmos_inv_hv_cc.ymax)
        ],
        layer="NWelldrawing"
    )

    c.add_port(
        name="NTAP",
        center=ntap.ports["TAP"].center,
        width=ntap.ports["TAP"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="PTAP",
        center=guardNmos.ports["TAP"].center,
        width=guardNmos.ports["TAP"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="IN",
        center=nmos_cc.ports["G"].center,
        width=nmos_cc.ports["G"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="OUT",
        center=nmos_inv_hv.ports["SD1"].center,
        width=nmos_inv_hv.ports["SD1"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    return c

@gf.cell
def cross_couple(

) -> Component:
    c = Component("cross_couple")

    cc_0 = c.add_ref(cross_couple_inv_hv())
    cc_1 = c.add_ref(cross_couple_inv_hv())
    cc_1.mirror_y()
    cc_1.ymin = cc_0.ymax-0.44


    ccGatePath_0 = [
        cc_0.ports["ccNmosDrain"].center,
        (cc_1.ports["ccNmosDrain"].center[0], cc_1.ports["ccDrain"].center[1])
    ]
    path = gf.Path(ccGatePath_0)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    met2_sep = 0.21

    ccGatePath_1 = [
        cc_1.ports["ccNmosDrain"].center,
        (cc_1.ports["ccNmosDrain"].center[0]-0.3-met2_sep, cc_1.ports["ccNmosDrain"].center[1]),
        (cc_0.ports["ccNmosDrain"].center[0]-0.3-met2_sep, cc_0.ports["ccDrain"].center[1])
    ]
    path = gf.Path(ccGatePath_1)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    ccGate2ccDrainPath_0 = [
        cc_1.ports["ccDrain"].center,
        (cc_0.ports["ccNmosDrain"].center[0], cc_1.ports["ccDrain"].center[1])
    ]
    path = gf.Path(ccGate2ccDrainPath_0)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = cc_1.ports["ccDrain"].width
    )
    c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=cc_1.ports["ccDrain"].width,
        row_width=0.3,
        center=(cc_0.ports["ccNmosDrain"].center[0], cc_1.ports["ccDrain"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    ccGate2ccDrainPath_1 = [
        cc_0.ports["ccDrain"].center,
        (cc_1.ports["ccNmosDrain"].center[0]-0.3-met2_sep, cc_0.ports["ccDrain"].center[1])
    ]
    path = gf.Path(ccGate2ccDrainPath_1)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = cc_0.ports["ccDrain"].width
    )
    c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=cc_0.ports["ccDrain"].width,
        row_width=0.3,
        center=(cc_1.ports["ccNmosDrain"].center[0]-0.3-met2_sep, cc_0.ports["ccDrain"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    ccGatePathConn_0 = [
        cc_0.ports["ccGate"].center,
        (cc_0.ports["ccNmosDrain"].center[0], cc_0.ports["ccGate"].center[1]),
    ]
    path = gf.Path(ccGatePathConn_0)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=0.3,
        row_width=0.3,
        center=(cc_0.ports["ccNmosDrain"].center[0], cc_0.ports["ccGate"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    ccGatePathConn_1 = [
        cc_1.ports["ccGate"].center,
        (cc_1.ports["ccNmosDrain"].center[0]-0.3-met2_sep, cc_1.ports["ccGate"].center[1]),
    ]
    path = gf.Path(ccGatePathConn_1)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=0.3,
        row_width=0.3,
        center=(cc_1.ports["ccNmosDrain"].center[0]-0.3-met2_sep, cc_1.ports["ccGate"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    connect_ports_to_bus(
        c,
        ports=[cc_0.ports["ccSource_0"], cc_0.ports["ccSource_1"], cc_0.ports["NTAP"],cc_1.ports["ccSource_0"], cc_1.ports["ccSource_1"], cc_1.ports["NTAP"]],
        distance=0.0, 
        layer="Metal2drawing",
        bus_side="middle"
    )
    
    c.add_port(
        name="IN_P",
        center=cc_1.ports["IN"].center,
        width=cc_1.ports["IN"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="IN_N",
        center=cc_0.ports["IN"].center,
        width=cc_0.ports["IN"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="OUT_P",
        center=cc_1.ports["OUT"].center,
        width=cc_1.ports["OUT"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="VDD_CC",
        center=(cc_0.ports["NTAP"].center[0], (cc_0.ports["NTAP"].center[1]+cc_1.ports["NTAP"].center[1])/2),
        width=cc_0.ports["NTAP"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    c.add_port(
        name="VSS_0",
        center=cc_0.ports["PTAP"].center,
        width=cc_0.ports["PTAP"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_port(
        name="VSS_1",
        center=cc_1.ports["PTAP"].center,
        width=cc_1.ports["PTAP"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )

    return c

def lv2hv() -> Component:
    c = Component("lv2hv")
    
    cc = c.add_ref(cross_couple())
    cc.rotate(270)
    cc.ymin = 0

    sep = 0.3
    inBuf = c.add_ref(buffer())
    inBuf.center = cc.center
    inBuf.xmin = cc.xmax + sep

    connect_gates_to_bus_v2(
        c,
        [cc.ports["IN_P"]],
        length=0.45,
        offset=0.0,
        bus_side="bottom"
    )
    connect_gates_to_bus_v2(
        c,
        [cc.ports["IN_N"]],
        length=0.45,
        offset=0.0,
        bus_side="bottom"
    )

    inpConnPath = [
        cc.ports["IN_P"].center,
        (inBuf.ports["IN_P"].center[0], cc.ports["IN_P"].center[1])
    ]
    path = gf.Path(inpConnPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    inBufPWidth = 2
    innConnPath = [
        inBuf.ports["IN_N"].center,
        (inBuf.ports["IN_N"].center[0], inBuf.ports["IN_N"].center[1]+inBufPWidth+1.5),
        (cc.ports["IN_N"].center[0]-cc.ports["IN_N"].width/2-0.3, inBuf.ports["IN_N"].center[1]+inBufPWidth+1.5),
        (cc.ports["IN_N"].center[0]-cc.ports["IN_N"].width/2-0.3, cc.ports["IN_N"].center[1]),
    ]
    path = gf.Path(innConnPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    innConnGPath = [
        cc.ports["IN_N"].center,
        (cc.ports["IN_N"].center[0]-cc.ports["IN_N"].width/2-0.3, cc.ports["IN_N"].center[1])
    ]
    path = gf.Path(innConnGPath)
    path_component = gf.path.extrude(
        path,
        layer = "Metal1drawing",
        width = 0.3
    )
    c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=0.3,
        row_width=0.3,
        center=(cc.ports["IN_N"].center[0]-cc.ports["IN_N"].width/2-0.3, cc.ports["IN_N"].center[1]),
    )

    c.add_port(
        name="IN",
        center=inBuf.ports["IN"].center,
        width=inBuf.ports["IN"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_label(text="IN", position=inBuf.ports["IN"].center, layer="Metal1text")


    c.add_port(
        name="OUT_P",
        center=cc.ports["OUT_P"].center,
        width=cc.ports["OUT_P"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_label(text="OUT_P", position=cc.ports["OUT_P"].center, layer="Metal1text")

    c.add_port(
        name="VSS_0",
        center=cc.ports["VSS_0"].center,
        width=cc.ports["VSS_0"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_label(text="VSS_0", position=cc.ports["VSS_0"].center, layer="Metal1text")
    c.add_port(
        name="VSS_1",
        center=cc.ports["VSS_1"].center,
        width=cc.ports["VSS_1"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_label(text="VSS_1", position=cc.ports["VSS_1"].center, layer="Metal1text")

    c.add_port(
        name="VSS_BUFF",
        center=inBuf.ports["VSS"].center,
        width=inBuf.ports["VSS"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_label(text="VSS_BUFF", position=inBuf.ports["VSS"].center, layer="Metal1text")

    c.add_port(
        name="VDD_CC",
        center=cc.ports["VDD_CC"].center,
        width=cc.ports["VDD_CC"].width,
        orientation=180,
        layer="Metal1pin",
        port_type="electrical",
    )
    c.add_label(text="VDD_CC", position=cc.ports["VDD_CC"].center, layer="Metal1text")

    return c

if __name__ == "__main__":
    top = lv2hv()
    top.write_gds("hm_pg_hv_lv2hv.gds")
