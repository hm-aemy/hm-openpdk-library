import argparse
import json
from pathlib import Path


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

    args = parser.parse_args()

    # Read template
    template = args.template.read_text()

    # Read parameters
    with args.params.open() as f:
        params = json.load(f)

    # Replace template parameters
    try:
        netlist = template.format_map(params)
    except KeyError as error:
        missing_parameter = error.args[0]
        raise ValueError(
            f"Parameter '{missing_parameter}' is required by the template "
            f"but was not found in {args.params}"
        ) from error

    # Create output directory if necessary
    args.output.parent.mkdir(parents=True, exist_ok=True)

    # Write generated netlist
    args.output.write_text(netlist)

    print(f"Generated netlist: {args.output}")


if __name__ == "__main__":
    main()
