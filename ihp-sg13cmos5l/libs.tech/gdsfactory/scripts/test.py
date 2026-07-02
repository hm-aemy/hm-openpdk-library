import gdsfactory as gf
from ihp import PDK
from ihp.cells import nmos, rfnmos, npn13G2, rsil, cmim

PDK.activate()

# Create a parametric NMOS transistor

c = nmos(width=2175, length=0.13, nf=290)
print(c.ports)
c.write_gds("my_nmos.gds")
