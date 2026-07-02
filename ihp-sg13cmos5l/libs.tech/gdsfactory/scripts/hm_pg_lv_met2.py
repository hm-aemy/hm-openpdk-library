import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK

PDK.activate()

def power_gate_met2(
    width=10, 
    heigth=200, 
    
    gpwr_wing_width=10,
    wing_ext=3
) -> Component:
    c = Component("power_gate_met2")

    met2_sep=2

    c.add_polygon(
        [
            (wing_ext+met2_sep, 0),
            (width, 0),
            (width, heigth),
            (wing_ext+met2_sep, heigth),
            (wing_ext+met2_sep, heigth/2+gpwr_wing_width/2),
            (0, heigth/2+gpwr_wing_width/2),
            (0, heigth/2-gpwr_wing_width/2),
            (wing_ext+met2_sep, heigth/2-gpwr_wing_width/2),
        ],
        layer="Metal2drawing"
    )

    c.add_polygon(
        [
            (0, 0),
            (wing_ext, 0),
            (wing_ext, heigth/2-gpwr_wing_width/2-met2_sep),
            (0, heigth/2-gpwr_wing_width/2-met2_sep),
        ],
        layer="Metal2drawing"
    )
    
    c.add_polygon(
        [
            (0, heigth/2+gpwr_wing_width/2+met2_sep),
            (wing_ext, heigth/2+gpwr_wing_width/2+met2_sep),
            (wing_ext, heigth),
            (0, heigth),
        ],
        layer="Metal2drawing"
    )

    return c

top = power_gate_met2()
top.write_gds("hm_pg_lv_met2.gds")
