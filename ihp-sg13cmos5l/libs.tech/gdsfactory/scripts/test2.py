import gdsfactory as gf
from ihp import PDK
from ihp.cells import nmos
from ihp.tech import metal1_routing, route_bundle_metal_corner, layer_transitions, metal2_routing

def add_temp_port(
    component,
    name,
    base_port,
    orientation,
    layer=None,
    width=None,
):
    component.add_port(
        name=name,
        center=base_port.center,
        width=width if width is not None else base_port.width,
        orientation=orientation,
        layer=layer if layer is not None else base_port.layer,
        port_type=base_port.port_type,
    )

    for p in component.ports:
        if p.name == name:
            return p

    raise ValueError(f"Could not create temporary port {name}")

def get_port_by_name(ref, name):
    for port in ref.ports:
        if port.name == name:
            return port
    raise ValueError(f"Port {name} not found")

PDK.activate()

POLY = (5, 0)  # replace with the real IHP poly layer
METAL1 = (8, 0)
METAL2 = (10, 0)

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

sd_ports = [
    port for port in ref.ports
    if port.name.startswith("SD")
]

if not gate_ports:
    raise ValueError("No gate ports found. Check the printed port names.")
if not sd_ports:
    raise ValueError("No sd ports found. Check the printed port names.")

xg = [p.center[0] for p in gate_ports]
yg = [p.center[1] for p in gate_ports]

xsd = [p.center[0] for p in sd_ports]
ysd = [p.center[1] for p in sd_ports]

xg_min = min(xg)
xg_max = max(xg)
yg_center = yg[0]

xsd_min = min(xsd)
xsd_max = max(xsd)
ysd_center = ysd[0]

poly_width = 0.3
overlap = 0.18

top.add_polygon(
    [
        (xg_min - LENGTH/2, yg_center + NF_WIDTH/2 + overlap),
        (xg_max + LENGTH/2, yg_center + NF_WIDTH/2 + overlap),
        (xg_max + LENGTH/2, yg_center + NF_WIDTH/2 + overlap + poly_width),
        (xg_min - LENGTH/2, yg_center + NF_WIDTH/2 + overlap + poly_width),
    ],
    layer=POLY,
)

p1 = get_port_by_name(ref, "SD1")
p2 = get_port_by_name(ref, "SD3")

#p2_l = add_temp_port(top, "tmp_SD2_L", p2, orientation=180)

#route = gf.routing.route_single(
#    top,
#    port1=p1,
#    port2=p2,
#    route_width=0.5,
#    cross_section=metal1_routing,
#    auto_taper=False,
#)

#path = gf.path.straight(length=100)
#c = gf.path.extrude(path, cross_section=metal1_routing)
#top.add_ref(c)

routes = gf.routing.route_bundle(
    component=top,
    ports1=[p1],
    ports2=[p2],
    cross_section=metal2_routing(width=NF_WIDTH/2),
    straight="straight_metal",
    port_type="electrical",
    auto_taper=True,
    layer_transitions=layer_transitions,
)

#route = gf.routing.route_single(
#    component=top,
#    port1=p1,
#    port2=p2,
#    cross_section=metal2_routing,
#    auto_taper=True,
#    layer_transitions=layer_transitions,
#)

top.add_port(
    name="G",
    center=(xg_min - overlap, yg_center),
    width=poly_width,
    orientation=180,
    layer=POLY,
    port_type="electrical",
)

top.write_gds("my_nmos_gate_connected.gds")
top.show()





