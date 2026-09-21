import gdsfactory as gf
from gdsfactory import Component
from ihp import PDK, tech
from ihp.cells import via_stack
from ihp.cells import place_contacts
import math

def floor_to_resolution(value: float, resolution: float = 0.005) -> float:
    return math.floor(value / resolution) * resolution

def populate_via_stack(c, column_width=10.0, row_width=10.0, center=[0,0], bottom_layer="Metal1", top_layer="Metal2"):

        
    via1_size = tech.TECH.via1_size_rf
    via1_spacing = tech.TECH.via1_spacing_wide
    via1_enc = tech.TECH.via1_enc

    column_num_float = (column_width-via1_enc+via1_spacing)/(via1_size+via1_spacing)
    column_num_int = int(column_num_float)
    column_num_dec = column_num_float-column_num_int

    row_num_float = (row_width-via1_enc+via1_spacing)/(via1_size+via1_spacing)
    row_num_int = int(row_num_float)

    via_stack1 = c.add_ref(via_stack(bottom_layer=bottom_layer, top_layer=top_layer, vn_columns=row_num_int, vn_rows=column_num_int, size=(row_width, column_width)))
    via_stack1.x=center[0]
    via_stack1.y=center[1]

    return via_stack1

def populate_contact(c, column_width=10.0, row_width=10.0, center=[0, 0]):

    cont_size = tech.TECH.cont_size
    cont_spacing = tech.TECH.cont_spacing

    xl = center[0]-row_width/2
    yl = center[1]-column_width/2
    xh = center[0]+row_width/2
    yh = center[1]+column_width/2
    ox = 0
    oy = tech.TECH.cont_enc_active

    place_contacts(
        c,
        "Contdrawing",
        xl=xl,
        yl=yl,
        xh=xh,
        yh=yh,
        ox=ox,
        oy=oy,
        ws=cont_size,
        ds=cont_spacing
    )

    c.add_polygon(
        [
            (xl, yl),
            (xh, yl),
            (xh, yh),
            (xl, yh)
        ],
        layer="Metal1drawing"
    )
    
def connect_gates_to_bus(
    c,
    device,
    length,
    layer="Metal1drawing",
    bus_side="bottom",
    pin_name=None
  ):
    
    polyBusWidth = 0.3

    gates = get_gates(device)

    xs = [float(gate.center[0]) for gate in gates]
    #ys = [float(gate.center[1]) for gate in gates]

    # Bus debajo de los dispositivos
    if bus_side=="bottom":
        bus_y = device.ports["G"].center[1]-device.ports["G"].width/2- polyBusWidth/2
    elif bus_side=="top":
        bus_y = device.ports["G"].center[1]+device.ports["G"].width/2 + polyBusWidth/2
    else:
        bus_y = device.ports["G"].center[1]-device.ports["G"].width/2 - polyBusWidth/2

    # Línea horizontal
    c.add_polygon(
        [
            (min(xs) - length / 2, bus_y - polyBusWidth / 2),
            (max(xs) + length / 2, bus_y - polyBusWidth / 2),
            (max(xs) + length / 2, bus_y + polyBusWidth / 2),
            (min(xs) - length / 2, bus_y + polyBusWidth / 2),
        ],
        layer=layer,
    )
    populate_contact(
        c,
        column_width = polyBusWidth,
        row_width = max(xs)-min(xs)+length,
        center = ((min(xs)+max(xs))/2, bus_y)
    )

    if pin_name != None:
        c.add_polygon(
            [
                (min(xs) - length / 2, bus_y - polyBusWidth / 2),
                (max(xs) + length / 2, bus_y - polyBusWidth / 2),
                (max(xs) + length / 2, bus_y + polyBusWidth / 2),
                (min(xs) - length / 2, bus_y + polyBusWidth / 2),
            ],
            layer="Metal1pin",
        )
        c.add_label(text=pin_name, position=((min(xs)+max(xs))/2, bus_y), layer="Metal1text")

        c.add_port(
            name=pin_name,
            center=((min(xs)+max(xs))/2, bus_y),
            width=max(xs)-min(xs)+length,
            orientation=0,
            layer="Metal1pin"
        )

def get_gates(ref):
    gates = []

    for p in ref.ports:
        if p.name=="G":
            continue
        if p.name.startswith("G"):
            #idx = int(p.name.replace("G", ""))
            gates.append(p)

    return gates
