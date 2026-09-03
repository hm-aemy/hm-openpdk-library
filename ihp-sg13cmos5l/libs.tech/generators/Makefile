HEIGHT ?= 200
WIDTH ?= 17

OUTPUT_DIR = ./hm_pg/hm_pg_lv/output
LIBS_REF_DIR = ../../libs.ref/hm_io
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
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_lv/spice/hm_pg_lv_template.spice --params ./hm_pg/hm_pg_lv/output/json/params_$(WIDTH)x$(HEIGHT).json --output ./hm_pg/hm_pg_lv/output/spice/hm_pg_lv_$(WIDTH)x$(HEIGHT).spice

.PHONY: xschem
xschem:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_lv/xschem/hm_pg_lv.sch --params ./hm_pg/hm_pg_lv/output/json/params_17x200.json --output ./hm_pg/hm_pg_lv/output/xschem/hm_pg_lv_17x200.sch

.PHONY: lef
lef: 
	GDS_FILE="$(OUTPUT_DIR)/gds/hm_pg_lv_$(WIDTH)x$(HEIGHT).gds" \
	CELL_NAME="hm_pg_lv_$(WIDTH)x$(HEIGHT)" \
	LEF_FILE="$(OUTPUT_DIR)/lef/hm_pg_lv_$(WIDTH)x$(HEIGHT).lef" \
	magic -dnull -noconsole ./helpers/extract_lef.tcl

.PHONY: release
release:
	mkdir -p $(LIBS_REF_DIR)/gds
	cp $(OUTPUT_DIR)/gds/hm_pg_lv_$(WIDTH)x$(HEIGHT).gds $(LIBS_REF_DIR)/gds/hm_pg_lv_$(WIDTH)x$(HEIGHT).gds
	mkdir -p $(LIBS_REF_DIR)/spice
	cp $(OUTPUT_DIR)/spice/hm_pg_lv_$(WIDTH)x$(HEIGHT).spice $(LIBS_REF_DIR)/spice/hm_pg_lv_$(WIDTH)x$(HEIGHT).spice
	mkdir -p $(LIBS_REF_DIR)/lef
	cp $(OUTPUT_DIR)/lef/hm_pg_lv_$(WIDTH)x$(HEIGHT).lef $(LIBS_REF_DIR)/lef/hm_pg_lv_$(WIDTH)x$(HEIGHT).lef

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)/gds
	rm -rf $(OUTPUT_DIR)/drc
	rm -rf $(OUTPUT_DIR)/json
	rm -rf $(OUTPUT_DIR)/spice
	rm -rf $(OUTPUT_DIR)/xschem
