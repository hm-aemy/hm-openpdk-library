# pex.tcl
set gds_file [file normalize $env(GDS_FILE)]
set cell_name $env(CELL_NAME)
set spice_file [file normalize $env(SPICE_FILE)]
if {![file isfile $gds_file]} {
    puts stderr "GDS file not found: $gds_file"
    exit 1
}
if {[tech name] ne "ihp-sg13cmos5l"} {
    puts stderr "Load ihp-sg13cmos5l.magicrc with -rcfile"
    exit 1
}
file mkdir [file dirname $spice_file]
cd [file dirname $spice_file]
drc off

gds read $gds_file
load $cell_name

# Full resistance extraction needs a flat layout. Do not save this copy.
flatten ${cell_name}__pex_flat
load ${cell_name}__pex_flat
cellname delete $cell_name
cellname rename ${cell_name}__pex_flat $cell_name

# Magic requires an active box even for port commands addressed by name.
select cell

# Address labels by name: the cursor box can overlap several labels.
foreach {name index class use} {
    GPWR 1 bidirectional power
    VAPWR 2 bidirectional power
    VDPWR 3 bidirectional power
    CTRL 4 input signal
    GND 5 bidirectional ground
} {
    if {[port $name index -quiet] eq ""} {
        port $name make $index
    }
    port $name index $index
    port $name class $class
    port $name use $use
}

# Stop if a missing label prevented creation of the expected interface.
foreach {name index} {GPWR 1 VAPWR 2 VDPWR 3 CTRL 4 GND 5} {
    if {[port $name index] ne "$index"} {
        puts stderr "PEX: missing or invalid port $name; check GDS labels"
        exit 1
    }
}

# Extract
extract do capacitance
extract do coupling
extract all

# Required before Magic 8.3.597; harmless on newer versions.
ext2sim default
ext2sim labels on
ext2sim
puts "PEX: starting resistance extraction"
extresist simplify off

extresist debug on
extresist threshold 0
extresist mindelay 0
extresist simplify off
extresist all

puts "PEX: resistance extraction finished"

# SPICE configuration
ext2spice default
ext2spice format ngspice
ext2spice scale off
ext2spice hierarchy off
ext2spice subcircuit on
ext2spice subcircuit top on
ext2spice cthresh 0
ext2spice extresist on

# Generate SPICE
puts "PEX: writing $spice_file"
ext2spice -o $spice_file $cell_name
if {![file isfile $spice_file] || [file size $spice_file] == 0} {
    puts stderr "PEX failed: no SPICE output at $spice_file"
    exit 1
}
puts "PEX: SPICE written to $spice_file"

quit -noprompt
