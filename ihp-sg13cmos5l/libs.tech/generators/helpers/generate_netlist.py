import argparse
import json
from pathlib import Path
import re

def main():
    parser = argparse.ArgumentParser(
        description="Generate a SPICE netlist from a template and JSON parameters."
    )

    parser.add_argument(
        "--template",
        type=Path,
        required=True,
        help="SPICE netlist template",
    )

    parser.add_argument(
        "--params",
        type=Path,
        required=True,
        help="JSON file containing template parameters",
    )

    parser.add_argument(
        "--output",
        type=Path,
        required=True,
        help="Output SPICE netlist",
    )

    args, extra_args = parser.parse_known_args()

    # Read template
    template = args.template.read_text()

    # Read parameters
    with args.params.open() as f:
        params = json.load(f)

    i = 0
    while i < len(extra_args):
        arg = extra_args[i]
        if not arg.startswith("--"):
            raise ValueError(f"Invalid extra argument: {arg}")
        arg = arg[2:]
        if "=" in arg:
            key, value = arg.split("=", 1)
        else:
            key = arg
            if i + 1 >= len(extra_args):
                raise ValueError(f"Missing value for --{key}")
            value = extra_args[i + 1]
            i += 1
        params[key] = value
        i += 1

    def replace_parameter(match):
        parameter = match.group(1)

        if parameter not in params:
            raise ValueError(
                f"Parameter '{parameter}' is required by the template "
                f"but was not found in {args.params}"
            )

        return str(params[parameter])

    netlist = re.sub(r"\{\{(\w+)\}\}", replace_parameter, template)

    # Create output directory if necessary
    args.output.parent.mkdir(parents=True, exist_ok=True)

    # Write generated netlist
    args.output.write_text(netlist)

    print(f"Generated netlist: {args.output}")


if __name__ == "__main__":
    main()
