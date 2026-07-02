import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK

PDK.activate()

def power_gate_met3(
    width=10, 
    heigth=200, 
    
    gnd_wing_width=10,
    vpwr_wing_width=10,
    gpwr_wing_width=10,

    gnd_wing_ext=30,
    wing_ext=3
) -> Component:
    c = Component("power_gate_met3")

    met3_sep = 2
    gnd_ext_sep = (heigth/2-(gnd_wing_ext+gnd_wing_width/2))
    
    c.add_polygon(
        [
            (wing_ext+met3_sep, 0),
            (width, 0),
            (width, heigth),
            (wing_ext+met3_sep, heigth),
            (wing_ext+met3_sep, heigth/2+gnd_wing_ext+gnd_wing_width/2),
            (0, heigth/2+gnd_wing_ext+gnd_wing_width/2),
            (0, heigth/2+gnd_wing_ext-gnd_wing_width/2),
            (wing_ext+met3_sep, heigth/2+gnd_wing_ext-gnd_wing_width/2),
            (wing_ext+met3_sep, heigth/2-gnd_wing_ext+gnd_wing_width/2),
            (0, heigth/2-gnd_wing_ext+gnd_wing_width/2),
            (0, heigth/2-gnd_wing_ext-gnd_wing_width/2),
            (wing_ext+met3_sep, heigth/2-gnd_wing_ext-gnd_wing_width/2),
        ],
        layer="Metal3drawing"
    )

    c.add_polygon(
        [
            (0, heigth/2-gnd_wing_width/2),
            (wing_ext, heigth/2-gnd_wing_width/2),
            (wing_ext, heigth/2+gnd_wing_width/2),
            (0, heigth/2+gnd_wing_width/2),
        ],
        layer="Metal3drawing"
    )

    c.add_polygon(
        [
            (0, 0),
            (wing_ext, 0),
            (wing_ext, gnd_ext_sep-met3_sep),
            (0, gnd_ext_sep-met3_sep),
        ],
        layer="Metal3drawing"
    )

    c.add_polygon(
        [
            (0, gnd_ext_sep+gnd_wing_width+met3_sep),
            (wing_ext, gnd_ext_sep+gnd_wing_width+met3_sep),
            (wing_ext, heigth/2-gpwr_wing_width/2-met3_sep),
            (0, heigth/2-gpwr_wing_width/2-met3_sep),
        ],
        layer="Metal3drawing"
    )

    c.add_polygon(
        [
            (0, heigth/2+gnd_wing_ext+gnd_wing_width/2+met3_sep),
            (wing_ext, heigth/2+gnd_wing_ext+gnd_wing_width/2+met3_sep),
            (wing_ext, heigth),
            (0, heigth),
        ],
        layer="Metal3drawing"
    )

    c.add_polygon(
        [
            (0, heigth/2+gpwr_wing_width/2+met3_sep),
            (wing_ext, heigth/2+gpwr_wing_width/2+met3_sep),
            (wing_ext, heigth/2+gnd_wing_ext-gnd_wing_width/2-met3_sep),
            (0, heigth/2+gnd_wing_ext-gnd_wing_width/2-met3_sep),
        ],
        layer="Metal3drawing"
    )

    return c

top = power_gate_met3()
top.write_gds("hm_pg_lv_met3.gds")
