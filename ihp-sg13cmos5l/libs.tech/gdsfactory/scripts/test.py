import gdsfactory as gf
from ihp import PDK
from ihp.cells import nmos, rfnmos, npn13G2, rsil, cmim
from gdsfactory import Component

from utils import populate_via_stack

PDK.activate()

c = Component("power_lv_pmos")

populate_via_stack(
    c,
    20,
    20,
    (0, 0),
    bottom_layer="Metal1",
    top_layer="Metal2"
)

c.write_gds("my_nmos.gds")
