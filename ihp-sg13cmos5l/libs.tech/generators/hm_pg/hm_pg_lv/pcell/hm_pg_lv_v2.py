import gdsfactory as gf
from gdsfactory import Component
from gdsfactory.components import via_stack
from ihp import PDK
import argparse
from pathlib import Path
import json

from hm_pg_lv_power_pmos_v2 import power_lv_pmos
from hm_pg_lv_discharge_m1 import discharge_m1
from hm_pg_lv_inv import inverter
from hm_pg_lv_met3_v2 import hm_pg_lv_met3
from hm_pg_lv_met4_v2 import hm_pg_lv_met4

from utils import populate_via_stack, populate_contact
from ihp.cells import via_stack

PDK.activate()

def hm_pg_lv(
    width=17,
    height=200,

    pmosL=0.13,
    pmosSDsep=0.5,

    vpwrWidth=7,
    met3_vpwrHeight=30,

    gpwrWidth=7,
    met3_gpwrHeight=30,

    met3Sep=0.32,
    met4Sep=0.32,

    blockSep=0.5 # there must be a better name.
) -> Component:
    c = Component(f"hm_pg_lv_{width}x{height}")
    invInConnL = 0.5
    invInConnSep =0.3

    ############ Place power pmos ############ 

    # the pmos has a left offset of 1.2 and
    # a right offset of 1.2 -> this is parametrized on the power pmos layout.
    # on the future we should take the value from there
    pmosMaxWf=width-(2.4)
    if pmosMaxWf>10:
        pmosMaxWf=pmosMaxWf-0.6 #TODO: Make it relative, is the separation between transistors of 2 rows.

    # assuming that the sizes of the inverter and the discharge are fixed. we then have
    # vertical offset = 2.55 + 2.46 + 2*blockSeparation
    pmosMaxHeight=height-(2.55+2.46+2*blockSep)-invInConnL
    print("pmosMaxHeight: ", pmosMaxHeight)

    # from pmos max height to max nf should be easy considering
    # top and bottom offset=1.02
    # endFingerTransWidth=0.34 and for internalFingerTransWidth=0.38 this values are form the Pcell
    endFingerTransWidth=0.34
    internalFingerTransWidth=0.38
    # then pmosHeight(nf)=2*endFingerTransWidth+(nf-1)*internalFingerTranWidth+nf*pmosL with V nf > 1
    pmosMaxHeighteff=pmosMaxHeight-2*1.11 #TODO: This must be changed to relative
    pmosMaxnf=int((pmosMaxHeighteff-2*endFingerTransWidth+internalFingerTransWidth)/(internalFingerTransWidth+pmosL))
    pmosWidth=int(pmosMaxnf*pmosMaxWf)
    print("Pmos Width: ", pmosWidth)
    print("Pmos Length: ", pmosL)
    print("Pmos nf: ", pmosMaxnf)

    power_pmos_ref = c.add_ref(
        power_lv_pmos(width=pmosWidth, length=pmosL, nf=pmosMaxnf, sd_sep=pmosSDsep)
    ).rotate(270)
    power_pmos_ref.dymin = 0
    power_pmos_ref.dxmin = 0

    ############ Place power discharge ############ 
    discharge_ref = c.add_ref(
        discharge_m1(stages=4)
    )
    discharge_ref.dymin = 0
    discharge_ref.dxmin = 0
    discharge_ref.dmovey(power_pmos_ref.ymax+blockSep)
    
    ############ Place power inverter ############ 
    inverter_ref = c.add_ref(
        inverter()
    ).rotate(90)
    inverter_ref.dymin = 0
    inverter_ref.dxmin = 0
    inverter_ref.dmovey(discharge_ref.ymax+blockSep)
    
    inverter_out_n = inverter_ref.ports["OUT_n"]
    inverter_out_p = inverter_ref.ports["OUT_p"]

    #inverter input connection
    invInConnWidth = 0.3
    invInConnExt = 4
    invInConny = height-invInConnL

    invInPoints = [
        inverter_ref.ports["IN"].center,
        (inverter_ref.ports["IN"].center[0], invInConny)
    ]
    path = gf.Path(invInPoints)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = invInConnWidth
    )
    c.add_ref(path_component)
    populate_via_stack(
        c,
        0.3,
        0.3,
        inverter_ref.ports["IN"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    c.add_polygon(
        [
            (inverter_ref.ports["IN"].center[0]-invInConnExt/2, invInConny),
            (inverter_ref.ports["IN"].center[0]+invInConnExt/2, invInConny),
            (inverter_ref.ports["IN"].center[0]+invInConnExt/2, invInConny+invInConnL),
            (inverter_ref.ports["IN"].center[0]-invInConnExt/2, invInConny+invInConnL),
        ],
        layer="Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=invInConnL,
        row_width=invInConnExt,
        center=(inverter_ref.ports["IN"].center[0], height-invInConnL/2),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    #inverter nmos out connection
    c.add_polygon(
        [
            (inverter_out_n.center[0]-inverter_out_n.width/2, inverter_ref.ymin-blockSep/2),
            (inverter_out_n.center[0]+inverter_out_n.width/2, inverter_ref.ymin-blockSep/2),
            (inverter_out_n.center[0]+inverter_out_n.width/2, inverter_out_n.center[1]),
            (inverter_out_n.center[0]-inverter_out_n.width/2, inverter_out_n.center[1]),
        ],
        layer = "Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=0.3,
        row_width=inverter_out_n.width,
        center=inverter_out_n.center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    #inverter VDD connection
    invVDDPort = inverter_ref.ports["VDD"]
    invVDDPortCenter = invVDDPort.center
    invInConnSep =0.3
    invVDDPortWidth = invVDDPort.width
    invVDDConnWidth = 0.32

    invVDDConnPoints = [
        (invVDDPortCenter[0], invVDDPortCenter[1]+invVDDPortWidth/2),
        (invVDDPortCenter[0], power_pmos_ref.ymax+blockSep),
        (power_pmos_ref.ports["S"].center[0]-power_pmos_ref.cell.info["wf"]/2+invVDDConnWidth/2, power_pmos_ref.ymax+blockSep),
        (power_pmos_ref.ports["S"].center[0]-power_pmos_ref.cell.info["wf"]/2+invVDDConnWidth/2, power_pmos_ref.ports["S"].center[1]+power_pmos_ref.ports["S"].width/2),
    ]
    path = gf.Path(invVDDConnPoints)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = invVDDConnWidth
    )
    c.add_ref(path_component)

    #c.add_polygon(
    #    [
    #        (inverter_ref.xmin, inverter_ref.ymin),
    #        (inverter_out_p.center[0]-inverter_out_p.width/2-0.3, inverter_ref.ymin),
    #        (inverter_out_p.center[0]-inverter_out_p.width/2-0.3, inverter_ref.ymax),
    #        (inverter_ref.xmin, inverter_ref.ymax),
    #    ],
    #    layer = "Metal2drawing"
    #)
    populate_via_stack(
        c,
        column_width=inverter_ref.ports["VDD"].width,
        row_width=0.3,
        center=inverter_ref.ports["VDD"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    #populate_via_stack(
    #    c, 
    #    column_width=inverter_ref.ymax-inverter_ref.ymin,
    #    row_width=inverter_out_p.center[0]-inverter_out_p.width/2-0.3-inverter_ref.xmin,
    #    center=((inverter_ref.xmin+inverter_out_p.center[0]-inverter_out_p.width/2-0.3)/2, (inverter_ref.ymin+inverter_ref.ymax)/2),
    #    bottom_layer="Metal2",
    #    top_layer="Metal3"
    #)

    #inverter VSS connection
    #c.add_polygon(
    #    [
    #        (inverter_out_n.center[0]+inverter_out_n.width/2+0.3, inverter_ref.ymin+0.5),
    #        (inverter_ref.xmax+0.5, inverter_ref.ymin+0.5),
    #        (inverter_ref.xmax+0.5, inverter_ref.ymax),
    #        (inverter_out_n.center[0]+inverter_out_n.width/2+0.3, inverter_ref.ymax),
    #    ],
    #    layer = "Metal2drawing"
    #)
    populate_via_stack(
        c,
        column_width=inverter_ref.ports["VSS"].width,
        row_width=0.3,
        center=inverter_ref.ports["VSS"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    #populate_via_stack(
    #    c,
    #    column_width=inverter_ref.ymax-inverter_ref.ymin-0.5,
    #    row_width=inverter_ref.xmax+0.5-(inverter_out_n.center[0]+inverter_out_n.width/2+0.3),
    #    center=((inverter_out_n.center[0]+inverter_out_n.width/2+0.3+inverter_ref.xmax+0.5)/2, (inverter_ref.ymin+inverter_ref.ymax+0.5)/2),
    #    bottom_layer="Metal2",
    #    top_layer="Metal3"
    #)
    populate_via_stack(
        c,
        column_width=inverter_ref.ports["VSS"].width,
        row_width=0.3,
        center=inverter_ref.ports["VSS"].center,
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    #inverter pmos out connection
    c.add_polygon(
        [
            (inverter_out_p.center[0]-inverter_out_p.width/2, inverter_ref.ymin-blockSep/2),
            (inverter_out_p.center[0]+inverter_out_p.width/2, inverter_ref.ymin-blockSep/2),
            (inverter_out_p.center[0]+inverter_out_p.width/2, inverter_out_p.center[1]),
            (inverter_out_p.center[0]-inverter_out_p.width/2, inverter_out_p.center[1]),
        ],
        layer = "Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=0.3,
        row_width=inverter_out_p.width,
        center=inverter_out_p.center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    #discharge VSS connection
    populate_via_stack(
        c,
        column_width=0.32,
        row_width=5,
        center=(discharge_ref.center[0], power_pmos_ref.ymax+blockSep+0.32/2),
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=0.32,
        row_width=5,
        center=(discharge_ref.center[0], power_pmos_ref.ymax+blockSep+0.32/2),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    #discharge gate 0 connection
    discharge_gate_0 = discharge_ref.ports["G_0"]
    discharge_gate_1 = discharge_ref.ports["G_1"]
    c.add_polygon(
        [
            (discharge_gate_0.center[0]-discharge_gate_0.width/2, discharge_gate_0.center[1]),
            (discharge_gate_0.center[0]+discharge_gate_0.width/2, discharge_gate_0.center[1]),
            (discharge_gate_0.center[0]+discharge_gate_0.width/2, discharge_ref.ymax+blockSep/2),
            (discharge_gate_0.center[0]-discharge_gate_0.width/2, discharge_ref.ymax+blockSep/2),
        ],
        layer = "Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=0.3,
        row_width=discharge_gate_0.width,
        center=discharge_gate_0.center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    #discharge gate 1 connection
    c.add_polygon(
        [
            (discharge_gate_1.center[0]-discharge_gate_1.width/2, discharge_gate_1.center[1]),
            (discharge_gate_1.center[0]+discharge_gate_1.width/2, discharge_gate_1.center[1]),
            (discharge_gate_1.center[0]+discharge_gate_1.width/2, discharge_ref.ymax+blockSep/2),
            (discharge_gate_1.center[0]-discharge_gate_1.width/2, discharge_ref.ymax+blockSep/2),
        ],
        layer = "Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=0.3,
        row_width=discharge_gate_1.width,
        center=discharge_gate_1.center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    
    #connection of inverter output to power_pmos gate
    power_pmos_gate_port = power_pmos_ref.ports["G"]
    inv2ppgate_offset = 0.4

    

    points = [
        (discharge_gate_0.center[0], discharge_ref.ymax+blockSep/2), 
        (discharge_ref.xmax+inv2ppgate_offset, discharge_ref.ymax+blockSep/2), 
        #(discharge_ref.xmax+inv2ppgate_offset, power_pmos_ref.ymax+blockSep/2),
        (power_pmos_gate_port.center[0], discharge_ref.ymax+blockSep/2), 
        (power_pmos_gate_port.center[0], power_pmos_ref.ymax+blockSep/2),
        (power_pmos_gate_port.center[0], power_pmos_ref.ymin)
    ]

    path = gf.Path(points)

    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )

    c.add_ref(path_component)

    populate_contact(
        c, 
        column_width=power_pmos_ref.ports["G"].width,
        row_width=0.3,
        center=power_pmos_ref.ports["G"].center
    )

    populate_via_stack(
        c,
        column_width=power_pmos_gate_port.width,
        row_width=0.3,
        center=power_pmos_gate_port.center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )

    #discharge GPWR connection to met2 GPWR
    dischDrainPort_center = discharge_ref.ports["DRAIN"].center
    dischDrainPort_width = discharge_ref.ports["DRAIN"].width

    dischSourcePort_center = discharge_ref.ports["SOURCE"].center
    dischSourcePort_width = discharge_ref.ports["SOURCE"].width

    populate_via_stack(
        c,
        column_width=dischDrainPort_width+0.2,
        row_width=0.6,
        center=dischDrainPort_center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    #populate_via_stack(
    #    c,
    #    column_width=0.32,
    #    row_width=dischSourcePort_center[0]-dischDrainPort_center[0],
    #    center=((dischDrainPort_center[0]+dischSourcePort_center[0])/2, (dischDrainPort_center[1]+dischSourcePort_center[1])/2),
    #    bottom_layer="Metal1",
    #    top_layer="Metal2"
    #)
    dischDrainConnR = power_pmos_ref.ports["D"].center[0]+power_pmos_ref.cell.info["wf"]/2
    dischDrainConnL = power_pmos_ref.ports["D"].center[0]-power_pmos_ref.cell.info["wf"]/2

    c.add_polygon(
        [
            (dischDrainPort_center[0], dischDrainPort_center[1]-0.32/2),
            (dischDrainConnR, dischDrainPort_center[1]-0.32/2),
            (dischDrainConnR, dischDrainPort_center[1]+0.32/2),
            (dischDrainPort_center[0], dischDrainPort_center[1]+0.32/2),
        ],
        layer="Metal2drawing"
    )
    c.add_polygon(
        [
            (dischDrainConnL, dischDrainPort_center[1]-5),
            (dischDrainConnR, dischDrainPort_center[1]-5),
            (dischDrainConnR, dischDrainPort_center[1]),
            (dischDrainConnL, dischDrainPort_center[1]),
        ],
        layer="Metal2drawing"
    )

    #place metal
    met3_ref = c.add_ref(
        hm_pg_lv_met3(
            width,
            height,
            vpwrWidth,
            met3_vpwrHeight,
            gpwrWidth,
            met3_gpwrHeight,
            met3Sep,
            invInConnL,
            invInConny,
            invInConnSep
        )
    )

    populate_via_stack(
        c,
        column_width=met3_ref.ports["GPWR"].width,
        row_width=1.02+pmosMaxWf-(width-gpwrWidth),
        center=((width-gpwrWidth+1.02+pmosMaxWf)/2, height/2),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR"].width,
        row_width=vpwrWidth-1.02,
        center=((1.02+vpwrWidth)/2, height/2),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    # power pmos guardRing connection to met2 vpwr
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR"].width,
        row_width=0.3,
        center=(power_pmos_ref.ports["GuardRingBottom"].center[0], height/2),
        bottom_layer="Metal1",
        top_layer="Metal3"
    ) # TODO: This can be solved differently, extend the metal2 VPWR to the guardring, so the connction can be done on the complete guardRing side.

    #Met 4 placement
    met4_ref = c.add_ref(
        hm_pg_lv_met4(
            width,
            height,
            vpwrWidth,
            gpwrWidth,
            met4Sep
        )
    )
    populate_via_stack(
        c,
        column_width=met3_ref.ports["GPWR"].width,
        row_width=gpwrWidth,
        center=met3_ref.ports["GPWR"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR"].width,
        row_width=vpwrWidth,
        center=met3_ref.ports["VPWR"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR"].width,
        row_width=width-gpwrWidth-met3Sep-(vpwrWidth+met3Sep),
        center=(width/2, height/2),
        bottom_layer="Metal3",
        top_layer="Metal4"
    )

    c.info["wf"] = power_pmos_ref.cell.info["wf"]*pmosMaxnf
    c.info["nf"] = pmosMaxnf
    c.info["length"] = pmosL
    c.info["m"] = power_pmos_ref.cell.info["m"]


    return c

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser()
    parser.add_argument("--width", type=int, required=True)
    parser.add_argument("--height", type=int, required=True)
    parser.add_argument("--output", type=Path, required=True, default=Path("output"))
    args = parser.parse_args()

    width = args.width
    height = args.height
    output_dir = args.output

    top = hm_pg_lv(width=width, height=height)
    top.write_gds(output_dir / f"gds/hm_pg_lv_{width}x{height}.gds")

    output_json_path = Path(output_dir / f"json/params_{width}x{height}.json")
    output_json_path.parent.mkdir(parents=True, exist_ok=True)

    data = {
        "width": top.info["wf"],
        "length": top.info["length"],
        "ng": top.info["nf"],
        "m": top.info["m"],
    }

    with open(output_json_path, "w") as f:
        json.dump(data, f, indent=4)
