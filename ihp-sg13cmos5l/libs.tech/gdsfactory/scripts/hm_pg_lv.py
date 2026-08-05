import gdsfactory as gf
from gdsfactory import Component
from gdsfactory.component import ComponentReference
from ihp import PDK

from hm_pg_lv_power_pmos import power_lv_pmos
from hm_pg_lv_discharge_m1 import discharge_m1
from hm_pg_lv_inv import inverter
from hm_pg_lv_met3 import power_gate_met3
from hm_pg_lv_met4 import power_gate_met4

from utils import populate_via_stack, populate_contact

PDK.activate()

def hm_pg_lv(
    width=10,
    length=160
) -> Component:
    c = Component("hm_pg_lv")

    vpwr_thickness=10
    gnd_thickness=10
    gpwr_thickness=20

    wings_width=3
    vpwr_sep=5
    
    gnd_ext=1
    gpwr_ext=5

    power_inner_sep=10
    ena_sep=2

    met3_sep=0.32
    met4_sep=0.32

    gpwr_wing_ext = 5

    modules_sep = 0.5

    power_pmos_sd_sep = 0.5

    ## place power_pmos
    power_pmos_ref = c.add_ref(
        power_lv_pmos(width=2175, length=0.13, nf=290, sd_sep=power_pmos_sd_sep)
    ).rotate(270)
    power_pmos_ref.dymin = 0
    power_pmos_ref.dxmin = 0

    #place discharge
    discharge_ref = c.add_ref(
        discharge_m1(stages=4)
    )
    discharge_ref.dymin = 0
    discharge_ref.dxmin = 0
    discharge_ref.dmovey(power_pmos_ref.ymax+modules_sep)

    #place_inverter
    inverter_ref = c.add_ref(
        inverter()
    ).rotate(90)
    inverter_ref.dymin = 0
    inverter_ref.dxmin = 0
    inverter_ref.dmovey(discharge_ref.ymax+modules_sep)
    
    inverter_out_n = inverter_ref.ports["OUT_n"]
    inverter_out_p = inverter_ref.ports["OUT_p"]


    #inverter nmos out connection
    c.add_polygon(
        [
            (inverter_out_n.center[0]-inverter_out_n.width/2, inverter_ref.ymin-modules_sep/2),
            (inverter_out_n.center[0]+inverter_out_n.width/2, inverter_ref.ymin-modules_sep/2),
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
    c.add_polygon(
        [
            (inverter_ref.xmin, inverter_ref.ymin),
            (inverter_out_p.center[0]-inverter_out_p.width/2-0.3, inverter_ref.ymin),
            (inverter_out_p.center[0]-inverter_out_p.width/2-0.3, inverter_ref.ymax),
            (inverter_ref.xmin, inverter_ref.ymax),
        ],
        layer = "Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=inverter_ref.ports["VDD"].width,
        row_width=0.3,
        center=inverter_ref.ports["VDD"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c, 
        column_width=inverter_ref.ymax-inverter_ref.ymin,
        row_width=inverter_out_p.center[0]-inverter_out_p.width/2-0.3-inverter_ref.xmin,
        center=((inverter_ref.xmin+inverter_out_p.center[0]-inverter_out_p.width/2-0.3)/2, (inverter_ref.ymin+inverter_ref.ymax)/2),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    #inverter VSS connection
    c.add_polygon(
        [
            (inverter_out_n.center[0]+inverter_out_n.width/2+0.3, inverter_ref.ymin+0.5),
            (inverter_ref.xmax+0.5, inverter_ref.ymin+0.5),
            (inverter_ref.xmax+0.5, inverter_ref.ymax),
            (inverter_out_n.center[0]+inverter_out_n.width/2+0.3, inverter_ref.ymax),
        ],
        layer = "Metal2drawing"
    )
    populate_via_stack(
        c,
        column_width=inverter_ref.ports["VSS"].width,
        row_width=0.3,
        center=inverter_ref.ports["VSS"].center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=inverter_ref.ymax-inverter_ref.ymin-0.5,
        row_width=inverter_ref.xmax+0.5-(inverter_out_n.center[0]+inverter_out_n.width/2+0.3),
        center=((inverter_out_n.center[0]+inverter_out_n.width/2+0.3+inverter_ref.xmax+0.5)/2, (inverter_ref.ymin+inverter_ref.ymax+0.5)/2),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    #inverter pmos out connection
    c.add_polygon(
        [
            (inverter_out_p.center[0]-inverter_out_p.width/2, inverter_ref.ymin-modules_sep/2),
            (inverter_out_p.center[0]+inverter_out_p.width/2, inverter_ref.ymin-modules_sep/2),
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

    #discharge gate 0 connection
    discharge_gate_0 = discharge_ref.ports["G_0"]
    discharge_gate_1 = discharge_ref.ports["G_1"]
    c.add_polygon(
        [
            (discharge_gate_0.center[0]-discharge_gate_0.width/2, discharge_gate_0.center[1]),
            (discharge_gate_0.center[0]+discharge_gate_0.width/2, discharge_gate_0.center[1]),
            (discharge_gate_0.center[0]+discharge_gate_0.width/2, discharge_ref.ymax+modules_sep/2),
            (discharge_gate_0.center[0]-discharge_gate_0.width/2, discharge_ref.ymax+modules_sep/2),
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
            (discharge_gate_1.center[0]+discharge_gate_1.width/2, discharge_ref.ymax+modules_sep/2),
            (discharge_gate_1.center[0]-discharge_gate_1.width/2, discharge_ref.ymax+modules_sep/2),
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
        (discharge_gate_0.center[0], discharge_ref.ymax+modules_sep/2), 
        (discharge_ref.xmax+inv2ppgate_offset, discharge_ref.ymax+modules_sep/2), 
        (discharge_ref.xmax+inv2ppgate_offset, power_pmos_ref.ymax+modules_sep/2),
        (power_pmos_gate_port.center[0], power_pmos_ref.ymax+modules_sep/2),
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

    #place metal3
    power_ext = vpwr_sep-gnd_ext-met4_sep
    if vpwr_sep > (power_inner_sep+met4_sep+gpwr_ext):
        power_inner_sep = vpwr_sep-met4_sep-gpwr_ext
    gnd_wing_ext = gpwr_thickness/2+gpwr_ext+met4_sep+power_inner_sep+vpwr_thickness+power_ext+met4_sep+gnd_ext+gnd_thickness/2

    met3_ref = c.add_ref(
        power_gate_met3(
            width,
            length,
            gnd_thickness,
            vpwr_thickness,
            gpwr_thickness,
            gnd_wing_ext,
            wings_width,
            gpwr_wing_ext,
            gpwr_ext,
            met3_sep
        )
    )
    
    # Met3 GPWR connection to Met2 GPWR
    gpwr_met3_left = width-gpwr_wing_ext
    gpwr_met2_left = power_pmos_ref.center[0]+power_pmos_sd_sep
    if gpwr_met2_left<gpwr_met3_left:
        gpwr_left = gpwr_met3_left
    else:
        gpwr_left = gpwr_met2_left

    gpwr_right = power_pmos_ref.center[0]+(2175/290)/2
    print("gpwr_center", power_pmos_ref.center[0])
    print("gpwr_right", gpwr_right)
    gpwr_center = ((gpwr_left+gpwr_right)/2, length/2)

    populate_via_stack(
        c,
        column_width=gpwr_thickness,
        row_width=gpwr_right-gpwr_left,
        center=gpwr_center,
        bottom_layer="Metal2",
        top_layer="Metal3"
    )


    # power pmos guardring connection to met3 VPWR

    # 4 section
    power_pmos_bottomguard_port = power_pmos_ref.ports["GuardRingBottom"]
    met3_vpwr_4_port = met3_ref.ports["VPWR_3"]
    gr_top = power_pmos_bottomguard_port.center[1]+power_pmos_bottomguard_port.width/2
    met3_vpwr_4_port_bottom = met3_vpwr_4_port.center[1]-met3_vpwr_4_port.width/2+met3_sep
    gr_top_ycenter = (met3_vpwr_4_port_bottom+gr_top)/2

    populate_via_stack(
        c,
        column_width=gr_top-met3_vpwr_4_port_bottom,
        row_width=0.3,
        center=(power_pmos_bottomguard_port.center[0], gr_top_ycenter),
        bottom_layer="Metal1",
        top_layer="Metal3"
    )
    # 3 section
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR_2"].width,
        row_width=0.3,
        center=(power_pmos_bottomguard_port.center[0], met3_ref.ports["VPWR_2"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal3"
    )
    # 2 section
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR_1"].width,
        row_width=0.3,
        center=(power_pmos_bottomguard_port.center[0], met3_ref.ports["VPWR_1"].center[1]),
        bottom_layer="Metal1",
        top_layer="Metal3"
    )
    # 1 section
    gr_bottom = power_pmos_bottomguard_port.center[1]-power_pmos_bottomguard_port.width/2
    met3_vpwr_1_port = met3_ref.ports["VPWR_0"]
    met3_vpwr_1_port_top =  met3_vpwr_1_port.center[1]+met3_vpwr_1_port.width/2
    gr_bottom_ycenter = (met3_vpwr_1_port_top+gr_bottom)/2
    populate_via_stack(
        c,
        column_width=met3_vpwr_1_port_top-gr_bottom,
        row_width=0.3,
        center=(power_pmos_bottomguard_port.center[0], gr_bottom_ycenter),
        bottom_layer="Metal1",
        top_layer="Metal3"
    )

    # Met3 VPWR connection to Met2 VPWR

    # 1 section
    vpwr_left = power_pmos_ref.center[0]-(2175/290)/2
    vpwr_right = wings_width
    vpwr_center = ((vpwr_left+vpwr_right)/2, met3_ref.ports["VPWR_0"].center[1])
    
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR_0"].width,
        row_width=vpwr_right-vpwr_left,
        center=vpwr_center,
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    # 2 section
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR_1"].width,
        row_width=vpwr_right-vpwr_left,
        center=(vpwr_center[0], met3_ref.ports["VPWR_1"].center[1]),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )
    # 3 section
    populate_via_stack(
        c,
        column_width=met3_ref.ports["VPWR_2"].width,
        row_width=vpwr_right-vpwr_left,
        center=(vpwr_center[0], met3_ref.ports["VPWR_2"].center[1]),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )
    # 4 section
    populate_via_stack(
        c,
        column_width=gr_top-met3_vpwr_4_port_bottom,
        row_width=vpwr_right-vpwr_left,
        center=(vpwr_center[0], gr_top_ycenter),
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    # discharge guard ring connection to metal3 GND
    dischTieLPort_center = discharge_ref.ports["TIE_L"].center
    dischTieLPort_width = discharge_ref.ports["TIE_L"].width
    dischTieRPort_center = discharge_ref.ports["TIE_R"].center
    dischTieRPort_width = discharge_ref.ports["TIE_R"].width

    c.add_polygon(
        [
            (dischTieLPort_center[0]-0.32/2, dischTieLPort_center[1]-dischTieLPort_width/2),
            (dischTieLPort_center[0]+0.32, dischTieLPort_center[1]-dischTieLPort_width/2),
            (dischTieLPort_center[0]+0.32, dischTieLPort_center[1]+dischTieLPort_width/2),
            (dischTieLPort_center[0]-0.32/2, dischTieLPort_center[1]+dischTieLPort_width/2),
        ],
        layer="Metal2drawing"
    )
    c.add_polygon(
        [
            (dischTieRPort_center[0]-0.32, dischTieRPort_center[1]-dischTieRPort_width/2),
            (dischTieRPort_center[0]+0.32/2, dischTieRPort_center[1]-dischTieRPort_width/2),
            (dischTieRPort_center[0]+0.32/2, dischTieRPort_center[1]+dischTieRPort_width/2),
            (dischTieRPort_center[0]-0.32, dischTieRPort_center[1]+dischTieRPort_width/2),
        ],
        layer="Metal2drawing"
    )

    points = [
        (dischTieLPort_center[0], dischTieLPort_center[1]-dischTieLPort_width/2), 
        (dischTieRPort_center[0], dischTieRPort_center[1]-dischTieRPort_width/2), 
    ]
    path = gf.Path(points)
    path_component = gf.path.extrude(
        path,
        layer = "Metal2drawing",
        width = 0.3
    )
    #c.add_ref(path_component)

    populate_via_stack(
        c,
        column_width=dischTieLPort_width,
        row_width=0.32,
        center=dischTieLPort_center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=dischTieRPort_width,
        row_width=0.32,
        center=dischTieRPort_center,
        bottom_layer="Metal1",
        top_layer="Metal2"
    )
    populate_via_stack(
        c,
        column_width=dischTieRPort_width,
        row_width=0.32,
        center=dischTieRPort_center,
        bottom_layer="Metal2",
        top_layer="Metal3"
    )

    #discharge GPWR connection to met3 GPWR
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
    dischDrainConnR = dischSourcePort_center[0]-1
    dischDrainConnL = dischDrainConnR - 1.5

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

    #Met 4 placement
    met4_ref = c.add_ref(
        power_gate_met4(
            width,
            length,
            vpwr_thickness,
            gnd_thickness,
            gpwr_thickness,
            wings_width,
            vpwr_sep,
            gnd_ext,
            gpwr_ext,
            power_inner_sep,
            met4_sep
        )
    )

    # met3 GPWR connection to Met3 GPWR
    populate_via_stack(
        c,
        column_width=met3_ref.ports["GPWR"].width,
        row_width = gpwr_wing_ext-0.1,
        center = met3_ref.ports["GPWR"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    # met3 VPWR connection to Met3 VPWR

    #0 section
    populate_via_stack(
        c,
        column_width=met4_ref.ports["VPWR_0"].width,
        row_width = wings_width,
        center = met4_ref.ports["VPWR_0"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    #1 section
    populate_via_stack(
        c,
        column_width=met4_ref.ports["VPWR_1"].width,
        row_width = wings_width,
        center = met4_ref.ports["VPWR_1"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    #2 section
    populate_via_stack(
        c,
        column_width=met4_ref.ports["VPWR_2"].width,
        row_width = wings_width,
        center = met4_ref.ports["VPWR_2"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    #3 section
    populate_via_stack(
        c,
        column_width=met4_ref.ports["VPWR_3"].width,
        row_width = wings_width,
        center = met4_ref.ports["VPWR_3"].center,
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    
    # GND Met4 conncetion to GND Met3
    populate_via_stack(
        c,
        column_width=gnd_thickness,
        row_width = wings_width,
        center = (wings_width/2, length/2+gnd_wing_ext),
        bottom_layer="Metal3",
        top_layer="Metal4"
    )
    populate_via_stack(
        c,
        column_width=gnd_thickness,
        row_width = wings_width,
        center = (wings_width/2, length/2-gnd_wing_ext),
        bottom_layer="Metal3",
        top_layer="Metal4"
    )


    return c

if __name__ == "__main__":
    top = hm_pg_lv()
    top.write_gds("hm_pg_lv.gds")   
    
