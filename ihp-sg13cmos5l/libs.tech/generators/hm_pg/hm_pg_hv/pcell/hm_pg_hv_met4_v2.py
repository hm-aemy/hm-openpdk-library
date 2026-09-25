import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK

PDK.activate()

def hm_pg_hv_met4(
    width=17,
    height=200,

    vpwrWidth=6,

    gpwrWidth=6,

    met4_sep=0.32

) -> Component:

    c = Component("hm_pg_hv_met4")

    gnd_vpwrd_width = (width-vpwrWidth-gpwrWidth-3*met4_sep)/2

    #VPWR section
    c.add_polygon(
        [
            (0, 0),
            (vpwrWidth, 0),
            (vpwrWidth, height),
            (0, height)
        ],
        layer="Metal4drawing"
    )
    c.add_polygon(
        [
            (0, 0),
            (vpwrWidth, 0),
            (vpwrWidth, height),
            (0, height)
        ],
        layer="Metal4pin"
    )
    c.add_label(text="VPWRA", position=(vpwrWidth/2, height/2), layer="Metal4text")

    #GND section
    c.add_polygon(
        [
            (vpwrWidth+met4_sep, 0),
            (vpwrWidth+met4_sep+gnd_vpwrd_width, 0),
            (vpwrWidth+met4_sep+gnd_vpwrd_width, height),
            (vpwrWidth+met4_sep, height),
        ],
        layer="Metal4drawing"
    )
    c.add_polygon(
        [
            (vpwrWidth+met4_sep, 0),
            (vpwrWidth+met4_sep+gnd_vpwrd_width, 0),
            (vpwrWidth+met4_sep+gnd_vpwrd_width, height),
            (vpwrWidth+met4_sep, height),
        ],
        layer="Metal4pin"
    )
    c.add_port(
        name="GND",
        center=((2*vpwrWidth+2*met4_sep+gnd_vpwrd_width)/2, height/2),
        width=height,
        orientation=90,
        layer="Metal4pin"
    )
    c.add_label(text="GND", position=((2*vpwrWidth+2*met4_sep+gnd_vpwrd_width)/2, height/2), layer="Metal4text")

    #VPWRD section
    c.add_polygon(
        [
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width, 0),
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width+gnd_vpwrd_width, 0),
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width+gnd_vpwrd_width, height),
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width, height),
        ],
        layer="Metal4drawing"
    )
    c.add_polygon(
        [
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width, 0),
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width+gnd_vpwrd_width, 0),
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width+gnd_vpwrd_width, height),
            (vpwrWidth+2*met4_sep+gnd_vpwrd_width, height),        ],
        layer="Metal4pin"
    )
    c.add_port(
        name="VPWRD",
        center=((2*vpwrWidth+4*met4_sep+3*gnd_vpwrd_width)/2, height/2),
        width=height,
        orientation=90,
        layer="Metal4pin"
    )
    c.add_label(text="VPWRD", position=((2*vpwrWidth+4*met4_sep+3*gnd_vpwrd_width)/2, height/2), layer="Metal4text")


    #GPWR section
    c.add_polygon(
        [
            (width-gpwrWidth, 0),
            (width, 0),
            (width, height),
            (width-gpwrWidth, height)
        ],
        layer="Metal4drawing"
    )
    c.add_polygon(
        [
            (width-gpwrWidth, 0),
            (width, 0),
            (width, height),
            (width-gpwrWidth, height)
        ],
        layer="Metal4pin"
    )
    c.add_label(text="GPWR", position=((2*width-gpwrWidth)/2, height/2), layer="Metal4text")

    return c

if __name__ == "__main__":
    top = hm_pg_hv_met4()
    top.write_gds("hm_pg_hv_met4_v2.gds")
