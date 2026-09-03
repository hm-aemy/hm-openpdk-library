# gds_to_lef.tcl
set gds_file $env(GDS_FILE)
set cell_name $env(CELL_NAME)
set lef_file $env(LEF_FILE)

gds read $gds_file
load $cell_name

select cell
findlabel VPWR
port class bidirectional
port use power

findlabel GPWR
port class bidirectional
port use power
	
findlabel GND
port class bidirectional
port use ground

findlabel CTRL
port class input
port use signal

lef write $lef_file -hide -pinonly

quit -noprompt
