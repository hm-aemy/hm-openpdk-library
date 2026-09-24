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


def get_sd_ports_even_odd(ref):
    sd_ports = []

    for p in ref.ports:
        if p.name.startswith("SD"):
            idx = int(p.name.replace("SD", ""))
            sd_ports.append((idx, p))

    sd_ports = sorted(sd_ports, key=lambda x: x[0])

    even_ports = [p for idx, p in sd_ports if idx % 2 == 0]
    odd_ports  = [p for idx, p in sd_ports if idx % 2 == 1]

    return even_ports, odd_ports       

def connect_ports_to_bus(
    c,
    ports,
    distance=0.5,
    layer="Metal1drawing",
    bus_side="bottom",
    pin_name=None
  ):
    if layer=="Metal1drawing":
        polyBusWidth = gf.get_cross_section("metal1_routing").width
        pin_layer = "Metal1pin"
        text_layer = "Metal1text"
    elif layer=="Metal2drawing":
        polyBusWidth = gf.get_cross_section("metal2_routing").width
        pin_layer = "Metal2pin"
        text_layer = "Metal2text"
    else:
        polyBusWidth = gf.get_cross_section("metal1_routing").width
        pin_layer = "Metal1pin"
        text_layer = "Metal1text"

    xs = [float(port.center[0]) for port in ports]
    ys = [float(port.center[1]) for port in ports]

    # Bus debajo de los dispositivos
    if bus_side=="bottom":
        bus_y = min(ys) - distance
    elif bus_side=="top":
        bus_y = max(ys) + distance
    elif bus_side=="middle":
        bus_y = (min(ys)+max(ys))/2+distance
    else:
        bus_y = min(ys) - distance

    # Línea horizontal
    c.add_polygon(
        [
            (min(xs) - polyBusWidth / 2, bus_y - polyBusWidth / 2),
            (max(xs) + polyBusWidth / 2, bus_y - polyBusWidth / 2),
            (max(xs) + polyBusWidth / 2, bus_y + polyBusWidth / 2),
            (min(xs) - polyBusWidth / 2, bus_y + polyBusWidth / 2),
        ],
        layer=layer,
    )
    if pin_name != None:
        c.add_polygon(
            [
                (min(xs) - polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (max(xs) + polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (max(xs) + polyBusWidth / 2, bus_y + polyBusWidth / 2),
                (min(xs) - polyBusWidth / 2, bus_y + polyBusWidth / 2),
            ],
            layer=pin_layer,
        )
        c.add_label(text=pin_name, position=((min(xs)+max(xs))/2, bus_y), layer=text_layer)

    # Ramas verticales
    for port in ports:
        x, y = map(float, port.center)

        c.add_polygon(
            [
                (x - polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (x + polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (x + polyBusWidth / 2, y + polyBusWidth / 2),
                (x - polyBusWidth / 2, y + polyBusWidth / 2),
            ],
            layer="Metal1drawing",
        )

        populate_via_stack(
            c,
            column_width=polyBusWidth,
            row_width=polyBusWidth,
            center=(x,bus_y)
        )

def connect_gates_to_bus_v2(
    c,
    gates,
    length=0.45,
    offset=0.0,
    layer="GatPolydrawing",
    pin_layer="Metal1pin",
    text_layer="Metal1text",
    bus_side="bottom",
    pin_name=None
):
    polyBusWidth = 0.3

    
    xs = [float(gate.center[0]) for gate in gates]
    ys = [float(gate.center[1]) for gate in gates]

    if bus_side=="bottom":
        bus_y = min(ys) - offset
    elif bus_side=="top":
        bus_y = max(ys) + offset
    elif bus_side=="middle":
        bus_y = (min(ys)+max(ys))/2+offset
    else:
        bus_y = min(ys) - offset

    c.add_polygon(
        [
            (min(xs) - polyBusWidth / 2, bus_y - polyBusWidth / 2),
            (max(xs) + polyBusWidth / 2, bus_y - polyBusWidth / 2),
            (max(xs) + polyBusWidth / 2, bus_y + polyBusWidth / 2),
            (min(xs) - polyBusWidth / 2, bus_y + polyBusWidth / 2),
        ],
        layer=layer,
    )

    populate_contact(
        c,
        column_width = polyBusWidth,
        row_width = max(xs)-min(xs)+polyBusWidth,
        center = ((min(xs)+max(xs))/2, bus_y)
    )

    for gate in gates:
        x, y = map(float, gate.center)

        c.add_polygon(
            [
                (x - length / 2, bus_y - length / 2),
                (x + length / 2, bus_y - length / 2),
                (x + length / 2, y + length / 2),
                (x - length / 2, y + length / 2),
            ],
            layer=layer,
        )

        #populate_via_stack(
        #    c,
        #    column_width=polyBusWidth,
        #    row_width=polyBusWidth,
        #    center=(x,bus_y)
        #)

    if pin_name != None:
            c.add_polygon(
                [
                    (min(xs) - polyBusWidth / 2, bus_y - polyBusWidth / 2),
                    (max(xs) + polyBusWidth / 2, bus_y - polyBusWidth / 2),
                    (max(xs) + polyBusWidth / 2, bus_y + polyBusWidth / 2),
                    (min(xs) - polyBusWidth / 2, bus_y + polyBusWidth / 2),
                ],
                layer=pin_layer,
            )
            c.add_label(text=pin_name, position=((min(xs)+max(xs))/2, bus_y), layer=text_layer)

            c.add_port(
                name=pin_name,
                center=((min(xs)+max(xs))/2, bus_y),
                width=max(xs)-min(xs)+polyBusWidth,
                orientation=0,
                layer="Metal1pin"
            )

def connect_ports_to_bus_v2(
    c,
    ports,
    distance=0.5,
    hor_layer="Metal1drawing",
    ver_layer="Metal1drawing",
    polyBusWidth=None,
    bus_side="bottom",
    pin_name=None
  ):
    if hor_layer=="Metal1drawing":
        if polyBusWidth == None:
            polyBusWidth = gf.get_cross_section("metal1_routing").width
        pin_layer = "Metal1pin"
        text_layer = "Metal1text"
    elif hor_layer=="Metal2drawing":
        if polyBusWidth == None:
            polyBusWidth = gf.get_cross_section("metal2_routing").width
        pin_layer = "Metal2pin"
        text_layer = "Metal2text"
    else:
        if polyBusWidth == None:
            polyBusWidth = gf.get_cross_section("metal1_routing").width
        pin_layer = "Metal1pin"
        text_layer = "Metal1text"

    xs = [float(port.center[0]) for port in ports]
    ys = [float(port.center[1]) for port in ports]

    # Bus debajo de los dispositivos
    if bus_side=="bottom":
        bus_y = min(ys) - distance
    elif bus_side=="top":
        bus_y = max(ys) + distance
    elif bus_side=="middle":
        bus_y = (min(ys)+max(ys))/2+distance
    else:
        bus_y = min(ys) - distance

    # Línea horizontal
    c.add_polygon(
        [
            (min(xs) - polyBusWidth / 2, bus_y - polyBusWidth / 2),
            (max(xs) + polyBusWidth / 2, bus_y - polyBusWidth / 2),
            (max(xs) + polyBusWidth / 2, bus_y + polyBusWidth / 2),
            (min(xs) - polyBusWidth / 2, bus_y + polyBusWidth / 2),
        ],
        layer=hor_layer,
    )
    if pin_name != None:
        c.add_polygon(
            [
                (min(xs) - polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (max(xs) + polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (max(xs) + polyBusWidth / 2, bus_y + polyBusWidth / 2),
                (min(xs) - polyBusWidth / 2, bus_y + polyBusWidth / 2),
            ],
            layer=pin_layer,
        )
        c.add_label(text=pin_name, position=((min(xs)+max(xs))/2, bus_y), layer=text_layer)

        c.add_port(
            name=pin_name,
            center=((min(xs)+max(xs))/2, bus_y),
            width=max(xs)-min(xs)+polyBusWidth,
            orientation=0,
            layer="Metal1pin"
        )

    # Ramas verticales
    for port in ports:
        x, y = map(float, port.center)

        c.add_polygon(
            [
                (x - polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (x + polyBusWidth / 2, bus_y - polyBusWidth / 2),
                (x + polyBusWidth / 2, y + polyBusWidth / 2),
                (x - polyBusWidth / 2, y + polyBusWidth / 2),
            ],
            layer=ver_layer,
        )

        if hor_layer != ver_layer:

            populate_via_stack(
                c,
                column_width=polyBusWidth,
                row_width=polyBusWidth,
                center=(x,bus_y)
            )

def _connect_ports_to_bus_v3(
    c,
    ports,
    offset=0.5,
    verticalConnWidth = 0.3,
    horizontalConnWidth = 0.3,
    horizontalLayer="Metal1drawing",
    verticalLayer="Metal1drawing",
    busWidth = 0.3,
    busSide="bottom",
    busDirection="Horizontal",
    pinName=None,
    pinLayer=None,
    pinTextLayer=None
):

    xs = [float(port.center[0]) for port in ports]
    ys = [float(port.center[1]) for port in ports]


    if busDirection=="Horizontal":
        if busSide=="bottom":
            bus_y = min(ys) - offset
        elif busSide=="top":
            bus_y = max(ys) + offset
        elif busSide=="middle":
            bus_y = (min(ys)+max(ys))/2+offset
        else:
            bus_y = min(ys) - offset

        c.add_polygon(
            [
                (min(xs) - verticalConnWidth / 2, bus_y - busWidth / 2),
                (max(xs) + verticalConnWidth / 2, bus_y - busWidth / 2),
                (max(xs) + verticalConnWidth / 2, bus_y + busWidth / 2),
                (min(xs) - verticalConnWidth / 2, bus_y + busWidth / 2),
            ],
            layer=horizontalLayer,
        )

        for port in ports:
            x, y = map(float, port.center)

            c.add_polygon(
                [
                    (x - verticalConnWidth / 2, min(y,bus_y) - busWidth / 2),
                    (x + verticalConnWidth / 2, min(y,bus_y) - busWidth / 2),
                    (x + verticalConnWidth / 2, max(y,bus_y) + busWidth / 2),
                    (x - verticalConnWidth / 2, max(y,bus_y) + busWidth / 2),
                ],
                layer=verticalLayer,
            )

            if horizontalLayer != verticalLayer:
                bottom_layer, top_layer = _via_stack_layers(horizontalLayer, verticalLayer)

                populate_via_stack(
                    c,
                    column_width=busWidth,
                    row_width=busWidth,
                    center=(x,bus_y),
                    bottom_layer=bottom_layer,
                    top_layer=top_layer
                )
    elif busDirection=="Vertical":
        # Bus al lado de los dispositivos
        if busSide=="left":
            bus_x = min(xs) - offset
        elif busSide=="right":
            bus_x = max(xs) + offset
        elif busSide=="middle":
            bus_x = (min(xs)+max(xs))/2+offset
        else:
            bus_x = min(xs) - offset

        c.add_polygon(
            [
                (bus_x - busWidth / 2, min(ys) - busWidth / 2),
                (bus_x + busWidth / 2, min(ys) - busWidth / 2),
                (bus_x + busWidth / 2, max(ys) + busWidth / 2),
                (bus_x - busWidth / 2, max(ys) + busWidth / 2),
            ],
            layer=verticalLayer,
        )

        for port in ports:
            x, y = map(float, port.center)

            c.add_polygon(
                [
                    (min(x,bus_x) - horizontalConnWidth / 2, y - horizontalConnWidth / 2),
                    (max(x,bus_x) + horizontalConnWidth / 2, y - horizontalConnWidth / 2),
                    (max(x,bus_x) + horizontalConnWidth / 2, y + horizontalConnWidth / 2),
                    (min(x,bus_x) - horizontalConnWidth / 2, y + horizontalConnWidth / 2),
                ],
                layer=horizontalLayer,
            )

            if horizontalLayer != verticalLayer:
                bottom_layer, top_layer = _via_stack_layers(horizontalLayer, verticalLayer)

                populate_via_stack(
                    c,
                    column_width=busWidth,
                    row_width=busWidth,
                    center=(bus_x,y),
                    bottom_layer=bottom_layer,
                    top_layer=top_layer
                )

    if pinName != None and busDirection=="Horizontal":
        c.add_polygon(
            [
                (min(xs) - verticalConnWidth / 2, bus_y - busWidth / 2),
                (max(xs) + verticalConnWidth / 2, bus_y - busWidth / 2),
                (max(xs) + verticalConnWidth / 2, bus_y + busWidth / 2),
                (min(xs) - verticalConnWidth / 2, bus_y + busWidth / 2),
            ],
            layer=pinLayer,
        )
        c.add_label(text=pinName, position=((min(xs)+max(xs))/2, bus_y), layer=pinTextLayer)

        print(max(xs))
        print("Port width: ", max(xs)-min(xs)+verticalConnWidth)
        c.add_port(
            name=pinName,
            center=((min(xs)+max(xs))/2, bus_y),
            width=max(xs)-min(xs)+busWidth,
            orientation=0,
            layer=pinLayer
        )
    elif pinName != None and busDirection=="Vertical":
        c.add_polygon(
            [
                (bus_x - busWidth / 2, min(ys) - busWidth / 2),
                (bus_x + busWidth / 2, min(ys) - busWidth / 2),
                (bus_x + busWidth / 2, max(ys) + busWidth / 2),
                (bus_x - busWidth / 2, max(ys) + busWidth / 2),
            ],
            layer=pinLayer,
        )
        c.add_label(text=pinName, position=(bus_x, (min(ys)+max(ys))/2), layer=pinTextLayer)

        c.add_port(
            name=pinName,
            center=(bus_x, (min(ys)+max(ys))/2),
            width=max(ys)-min(ys)+busWidth,
            orientation=90,
            layer=pinLayer
        )

def _via_stack_layers(first_layer, second_layer):
    # Los nombres de dibujo se convierten a los nombres usados por via_stack.
    layer_order = {
        "Activ": 0,
        "GatPoly": 0,
        "Metal1": 1,
        "Metal2": 2,
        "Metal3": 3,
        "Metal4": 4,
        "Metal5": 5,
        "TopMetal1": 6,
        "TopMetal2": 7,
    }
    first = first_layer.removesuffix("drawing")
    second = second_layer.removesuffix("drawing")
    for layer in (first, second):
        if layer not in layer_order:
            raise ValueError(f"Unsupported via stack layer: {layer}")
    if first != second and layer_order[first] == layer_order[second]:
        raise ValueError(f"Cannot stack between {first} and {second}")
    if layer_order[first] <= layer_order[second]:
        return first, second
    return second, first

