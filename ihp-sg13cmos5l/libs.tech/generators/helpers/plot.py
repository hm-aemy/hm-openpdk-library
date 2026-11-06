#!/usr/bin/env python3
"""Plot ngspice .raw files from the command line."""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from spicelib import RawRead


def load_raw(path: Path):
    """Read signals from the first step of an ngspice RAW file."""

    raw = RawRead(str(path))

    signals = {
        name: np.asarray(raw.get_trace(name).get_wave(0))
        for name in raw.get_trace_names()
    }

    if not signals:
        raise ValueError("The RAW file contains no signals.")

    axis = np.asarray(raw.get_axis(0))
    plot_type = raw.get_plot_name().lower()

    alias = (
        "time" if "transient" in plot_type else
        "frequency" if "ac" in plot_type else
        "sweep"
    )

    if alias not in signals:
        signals[alias] = axis

    return signals


def lookup(signals, name):
    """Match signal names without regard to letter case."""

    for key in signals:
        if key.lower() == name.lower():
            return key

    raise ValueError(
        f"Unknown signal '{name}'. "
        "Use --list to see available signals."
    )


def transform_signal(y, db=False, phase=False):
    """Transform signal for plotting."""

    if db:
        with np.errstate(divide="ignore"):
            return 20 * np.log10(np.abs(y))

    if phase:
        return np.degrees(np.unwrap(np.angle(y)))

    if np.iscomplexobj(y):
        if np.any(np.imag(y) != 0):
            raise ValueError(
                "Complex signal: use --db or --phase"
            )

        return y.real

    return y


def create_plots(signals, args):
    """Create one or multiple plots."""

    x_name = lookup(signals, args.x)
    x = signals[x_name]

    if np.iscomplexobj(x):
        if np.any(np.imag(x) != 0):
            raise ValueError("X axis must contain real numbers")
        x = x.real

    # Each --y represents one plot
    plot_groups = args.y
    nplots = len(plot_groups)

    # --------------------------------------------------
    # Create figures and axes
    # --------------------------------------------------

    if args.separate:

        figures = []
        axes = []

        for _ in range(nplots):
            fig, ax = plt.subplots(figsize=(10, 5.5))
            figures.append(fig)
            axes.append(ax)

    else:

        fig, ax_array = plt.subplots(
            nplots,
            1,
            figsize=(10, 4 * nplots),
            sharex=True,
            squeeze=False
        )

        figures = [fig]
        axes = ax_array[:, 0]

    # --------------------------------------------------
    # Plot each signal group
    # --------------------------------------------------

    for index, group in enumerate(plot_groups):

        ax = axes[index]

        for requested in group:

            name = lookup(signals, requested)
            y = signals[name]

            if len(x) != len(y):
                raise ValueError(
                    f"Different lengths for '{x_name}' and '{name}'"
                )

            y = transform_signal(
                y,
                db=args.db,
                phase=args.phase
            )

            ax.plot(x, y, label=name)

        # --------------------------------------------------
        # Axis configuration
        # --------------------------------------------------

        ax.set_ylabel(
            "Magnitude (dB)" if args.db else
            "Phase (deg)" if args.phase else
            "Value"
        )

        ax.grid(True, alpha=0.3)
        ax.legend()

        if args.logx:
            ax.set_xscale("log")

        if args.xmin is not None or args.xmax is not None:
            ax.set_xlim(
                left=args.xmin,
                right=args.xmax
            )

        if args.separate:
            ax.set_xlabel(x_name)
            ax.set_title(
                f"{args.title or args.file.stem} - Plot {index + 1}"
            )

    # --------------------------------------------------
    # Shared figure configuration
    # --------------------------------------------------

    if not args.separate:

        axes[-1].set_xlabel(x_name)

        fig.suptitle(
            args.title or args.file.stem
        )

    for fig in figures:
        fig.tight_layout()

    return figures


def main():

    parser = argparse.ArgumentParser(
        description="Plot ngspice .raw simulations"
    )

    parser.add_argument(
        "file",
        type=Path,
        help="ngspice RAW file"
    )

    parser.add_argument(
        "--x",
        help="Signal for the X axis"
    )

    parser.add_argument(
        "--y",
        nargs="+",
        action="append",
        help="Signals for one plot. Repeat --y for multiple plots."
    )

    parser.add_argument(
        "--list",
        action="store_true",
        help="List available signal names"
    )

    parser.add_argument(
        "--separate",
        action="store_true",
        help="Create separate figures instead of subplots"
    )

    parser.add_argument(
        "--title",
        help="Plot title"
    )

    parser.add_argument(
        "-o", "--output",
        type=Path,
        help="Save plot (PNG, PDF, SVG, etc.)"
    )

    parser.add_argument(
        "--xmin",
        type=float,
        help="Minimum X"
    )

    parser.add_argument(
        "--xmax",
        type=float,
        help="Maximum X"
    )

    parser.add_argument(
        "--logx",
        action="store_true",
        help="Logarithmic X axis"
    )

    parser.add_argument(
        "--db",
        action="store_true",
        help="Plot 20*log10(abs(Y))"
    )

    parser.add_argument(
        "--phase",
        action="store_true",
        help="Plot unwrapped phase in degrees"
    )

    args = parser.parse_args()

    # --------------------------------------------------
    # Validate arguments
    # --------------------------------------------------

    if not args.file.is_file():
        parser.error(f"File not found: {args.file}")

    if args.file.suffix.lower() != ".raw":
        parser.error("Only .raw files are supported")

    if args.db and args.phase:
        parser.error("--db and --phase cannot be used together")

    try:

        # --------------------------------------------------
        # Load RAW file
        # --------------------------------------------------

        signals = load_raw(args.file)

        if args.list:
            for name in signals:
                print(name)
            return

        if not args.x or not args.y:
            parser.error(
                "--x and --y are required (unless --list is used)"
            )

        # --------------------------------------------------
        # Create plots
        # --------------------------------------------------

        figures = create_plots(signals, args)

        # --------------------------------------------------
        # Save or display
        # --------------------------------------------------

        if args.output:

            args.output.parent.mkdir(
                parents=True,
                exist_ok=True
            )

            for index, fig in enumerate(figures):

                if len(figures) == 1:
                    output = args.output

                else:
                    output = args.output.with_name(
                        f"{args.output.stem}_{index + 1}"
                        f"{args.output.suffix}"
                    )

                fig.savefig(output, dpi=200)
                print(f"Saved {output}")

            plt.close("all")

        else:
            plt.show()

    except (ValueError, KeyError, IndexError) as error:
        parser.error(str(error))


if __name__ == "__main__":
    main()
