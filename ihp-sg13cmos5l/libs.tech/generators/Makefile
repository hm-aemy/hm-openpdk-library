HEIGHT ?= 200
WIDTH ?= 17

OUTPUT_DIR = ./hm_pg/hm_pg_lv/output
PDK=ihp-sg13cmos5l
PDK_ROOT?=../../../pdk/

.PHONY: layout
layout:
	python hm_pg/hm_pg_lv/pcell/hm_pg_lv_v2.py --width $(WIDTH) --height $(HEIGHT) --output $(OUTPUT_DIR)

.PHONY: drc
drc:
	python $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/drc/run_drc.py --path $(OUTPUT_DIR)/gds/hm_pg_lv_$(WIDTH)x$(HEIGHT).gds --no_density --run_dir $(OUTPUT_DIR)/drc

.PHONY: spice
spice:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_lv/spice/hm_pg_lv_template.spice --params ./hm_pg/hm_pg_lv/output/json/params_17x200.json --output ./hm_pg/hm_pg_lv/output/spice/hm_pg_lv_17x200.spice

.PHONY: xschem
xschem:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_lv/xschem/hm_pg_lv.sch --params ./hm_pg/hm_pg_lv/output/json/params_17x200.json --output ./hm_pg/hm_pg_lv/output/xschem/hm_pg_lv_17x200.sch

.PHONY: lef
lef: 
	GDS_FILE="$(OUTPUT_DIR)/gds/hm_pg_lv_$(WIDTH)x$(HEIGHT).gds" \
	CELL_NAME="hm_pg_lv_$(WIDTH)x$(HEIGHT)" \
	LEF_FILE="$(OUTPUT_DIR)/my_cell.lef" \
	magic -dnull -noconsole ./helpers/extract_lef.tcl
