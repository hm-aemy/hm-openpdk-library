import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK

PDK.activate()

def hm_pg_lv_met3(
    width=17,
    height=200.0,

    vpwrWidth=6,
    vpwrHeight=30,

    gpwrWidth=6,
    gpwrHeight=30,

    met3_sep=0.32,

    invInConnL=0.5,
    invInConny=199.5,
    invInConnSep=0.3

) -> Component:

    c = Component("hm_pg_lv_met3")

    # GND base
    c.add_polygon(
        [
            (0, 0),
            (width, 0),
            (width, height/2-gpwrHeight/2-met3_sep),
            (width-gpwrWidth-met3_sep, height/2-gpwrHeight/2-met3_sep),
            (width-gpwrWidth-met3_sep, height/2+gpwrHeight/2+met3_sep),
            (width, height/2+gpwrHeight/2+met3_sep),
            (width, invInConny-invInConnSep),
            (0, invInConny-invInConnSep),
            (0, height/2+vpwrHeight/2+met3_sep),
            (vpwrWidth+met3_sep, height/2+vpwrHeight/2+met3_sep),
            (vpwrWidth+met3_sep, height/2-vpwrHeight/2-met3_sep),
            (0, height/2-vpwrHeight/2-met3_sep)
        ],
        layer="Metal3drawing"
    )

    # VPWR Block
    c.add_polygon(
        [
            (0, height/2-vpwrHeight/2),
            (vpwrWidth, height/2-vpwrHeight/2),
            (vpwrWidth, height/2+vpwrHeight/2),
            (0, height/2+vpwrHeight/2),
        ],
        layer="Metal3drawing"
    )
    c.add_port(
        name="VPWR",
        center=((vpwrWidth)/2, height/2),
        width=vpwrHeight,
        orientation=0,
        layer="Metal3pin"
    )

    # GPWR Block
    c.add_polygon(
        [
            (width-gpwrWidth, height/2-gpwrHeight/2),
            (width, height/2-gpwrHeight/2),
            (width, height/2+gpwrHeight/2),
            (width-gpwrWidth, height/2+gpwrHeight/2),
        ],
        layer="Metal3drawing"
    )

    c.add_port(
        name="GPWR",
        center=((width-gpwrWidth+width)/2, height/2),
        width=gpwrHeight,
        orientation=0,
        layer="Metal3pin"
    )

    c.add_polygon(
        [
            (0, invInConny),
            (width, invInConny),
            (width, invInConny+invInConnL),
            (0, invInConny+invInConnL),
        ],
        layer="Metal3drawing"
    )
    c.add_polygon(
        [
            (0, invInConny),
            (width, invInConny),
            (width, invInConny+invInConnL),
            (0, invInConny+invInConnL),
        ],
        layer="Metal3pin"
    )
    c.add_label(text="CTRL", position=(width/2, invInConny+invInConnL), layer="Metal3text")

    return c

if __name__ == "__main__":
    top = hm_pg_lv_met3()
    top.write_gds("hm_pg_lv_met3_v2.gds")
