import gdsfactory as gf
from ihp import PDK
from ihp.cells import nmos

PDK.activate()

POLY = (5, 0)  # replace with the real IHP poly layer
WIDTH = 2175
NF = 290
LENGTH = 0.13
NF_WIDTH = WIDTH/NF

top = gf.Component("nmos_gate_connected")

m = nmos(width=WIDTH, length=LENGTH, nf=NF)
ref = top << m

# Debug: print available ports
for port in ref.ports:
    print(
        port.name,
        port.center,
        port.width,
        port.orientation,
        port.layer,
        port.port_type,
    )

gate_ports = [
    port for port in ref.ports
    if "g" in port.name.lower()
]

if not gate_ports:
    raise ValueError("No gate ports found. Check the printed port names.")

xs = [p.center[0] for p in gate_ports]
ys = [p.center[1] for p in gate_ports]

x_min = min(xs)
x_max = max(xs)
y_center = ys[0]

poly_width = 0.3
overlap = 0.18

top.add_polygon(
    [
        (x_min - LENGTH/2, y_center + NF_WIDTH/2 + overlap),
        (x_max + LENGTH/2, y_center + NF_WIDTH/2 + overlap),
        (x_max + LENGTH/2, y_center + NF_WIDTH/2 + overlap + poly_width),
        (x_min - LENGTH/2, y_center + NF_WIDTH/2 + overlap + poly_width),
    ],
    layer=POLY,
)

top.add_port(
    name="G",
    center=(x_min - overlap, y_center),
    width=poly_width,
    orientation=180,
    layer=POLY,
    port_type="electrical",
)

top.write_gds("my_nmos_gate_connected.gds")
top.show()
