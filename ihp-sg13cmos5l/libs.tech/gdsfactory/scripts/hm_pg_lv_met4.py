import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK

PDK.activate()

def power_gate_met4(
    width=10, 
    heigth=200, 

    power_width=10,
    gnd_width=10,
    gpwr_width=10,

    gnd_size=3,

    power_sep=5,
    gnd_ext=2,
    gpwr_ext=5,

    power_inner_sep=10,
) -> Component:
    c = Component("power_gate_met4")

    met4_sep = 2
    power_ext = power_sep-gnd_ext-met4_sep

    if power_sep > (power_inner_sep+met4_sep+gpwr_ext):
        power_inner_sep = power_sep-met4_sep-gpwr_ext

    power_ext_sep = (heigth - ((gpwr_width+2*gpwr_ext)+2*(gnd_width+2*power_sep+2*power_width+power_inner_sep)+2*met4_sep))/2

    vpwr_heigth = gnd_width+2*power_width+2*power_sep+power_inner_sep+power_ext_sep
    c.add_polygon(
        [
            (0, 0),
            (width, 0),
            (width, vpwr_heigth),
            (0, vpwr_heigth),
            (0, power_ext_sep+power_width+power_sep+gnd_width+gnd_ext+met4_sep),
            (gnd_size+met4_sep, power_ext_sep+power_width+power_sep+gnd_width+gnd_ext+met4_sep),
            (gnd_size+met4_sep, power_ext_sep+power_width+power_ext),
            (0, power_ext_sep+power_width+power_ext)
        ],
        layer="Metal4drawing"
    )

    c.add_polygon(
        [
            (0, power_ext_sep+power_width+power_ext+met4_sep),
            (gnd_size, power_ext_sep+power_width+power_ext+met4_sep),
            (gnd_size, power_ext_sep+power_width+power_ext+met4_sep+gnd_width+2*gnd_ext),
            (0, power_ext_sep+power_width+power_ext+met4_sep+gnd_width+2*gnd_ext),
        ],
        layer="Metal4drawing"
    )

    gpwr_y0 = vpwr_heigth+met4_sep
    gpwr_heigth = gpwr_width+2*gpwr_ext
    c.add_polygon(
        [
            (0, gpwr_y0),
            (width, gpwr_y0),
            (width, gpwr_y0+gpwr_heigth),
            (0, gpwr_y0+gpwr_heigth)
        ],
        layer="Metal4drawing"
    )
    
    vpwr_top_y0 = gpwr_y0+gpwr_heigth+met4_sep
    c.add_polygon(
        [
            (0, vpwr_top_y0),
            (width, vpwr_top_y0),
            (width, vpwr_heigth+vpwr_top_y0),
            (0, vpwr_heigth+vpwr_top_y0),
            (0, vpwr_top_y0+power_inner_sep+power_width+power_sep+gnd_width+gnd_ext+met4_sep), 
            (gnd_size+met4_sep, vpwr_top_y0+power_inner_sep+power_width+power_sep+gnd_width+gnd_ext+met4_sep),  
            (gnd_size+met4_sep, vpwr_top_y0+power_inner_sep+power_width+power_ext),   
            (0, vpwr_top_y0+power_inner_sep+power_width+power_ext), 
        ],
        layer="Metal4drawing"
    )

    c.add_polygon(
        [
            (0, vpwr_top_y0+power_inner_sep+power_width+power_ext+met4_sep),
            (gnd_size, vpwr_top_y0+power_inner_sep+power_width+power_ext+met4_sep),
            (gnd_size, vpwr_top_y0+power_inner_sep+power_width+power_ext+met4_sep+gnd_width+2*gnd_ext),
            (0, vpwr_top_y0+power_inner_sep+power_width+power_ext+met4_sep+gnd_width+2*gnd_ext),
        ],
        layer="Metal4drawing"
    )

    return c

top = power_gate_met4()
top.write_gds("hm_pg_lv_met4.gds")
