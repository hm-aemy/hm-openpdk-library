HEIGHT ?= 200
WIDTH ?= 17
TYPE ?= lv

OUTPUT_DIR = ./hm_pg/hm_pg_$(TYPE)/output
LIBS_REF_DIR = ../../libs.ref/hm_pg
PDK=ihp-sg13cmos5l
PDK_ROOT?=../../../pdk/
GDSFACTORY_VENV=.venv

.PHONY: all
all: layout drc cdl lvs lef vh release

.PHONY: layout
layout:
	mkdir -p $(OUTPUT_DIR)
	$(GDSFACTORY_VENV)/bin/python hm_pg/hm_pg_$(TYPE)/pcell/hm_pg_$(TYPE)_v2.py --width $(WIDTH) --height $(HEIGHT) --output $(OUTPUT_DIR)

.PHONY: drc
drc:
	python $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/drc/run_drc.py --path $(OUTPUT_DIR)/gds/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).gds --no_density --run_dir $(OUTPUT_DIR)/drc

.PHONY: spice
spice:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_$(TYPE)/spice/hm_pg_$(TYPE)_template.spice --params ./hm_pg/hm_pg_$(TYPE)/output/json/params_$(WIDTH)x$(HEIGHT).json --output ./hm_pg/hm_pg_$(TYPE)/output/spice/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice

.PHONY: cdl
cdl:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_$(TYPE)/cdl/hm_pg_$(TYPE)_template.spice --params ./hm_pg/hm_pg_$(TYPE)/output/json/params_$(WIDTH)x$(HEIGHT).json --output ./hm_pg/hm_pg_$(TYPE)/output/cdl/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice --WIDTH $(WIDTH) --HEIGHT $(HEIGHT)

.PHONY: vh
vh:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_$(TYPE)/vh/hm_pg_$(TYPE)_template.vh --params ./hm_pg/hm_pg_$(TYPE)/output/json/params_$(WIDTH)x$(HEIGHT).json --output ./hm_pg/hm_pg_$(TYPE)/output/vh/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).vh --WIDTH $(WIDTH) --HEIGHT $(HEIGHT)

.PHONY: $(TYPE)s
$(TYPE)s:
	python $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/$(TYPE)s/run_$(TYPE)s.py --layout hm_pg/hm_pg_$(TYPE)/output/gds/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).gds --netlist hm_pg/hm_pg_$(TYPE)/output/cdl/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice --ignore_top_ports_mismatch --run_dir $(OUTPUT_DIR)/lvs


.PHONY: xschem
xschem:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_$(TYPE)/xschem/hm_pg_$(TYPE).sch --params ./hm_pg/hm_pg_$(TYPE)/output/json/params_17x200.json --output ./hm_pg/hm_pg_$(TYPE)/output/xschem/hm_pg_$(TYPE)_17x200.sch

.PHONY: lef
lef: 
	GDS_FILE="$(OUTPUT_DIR)/gds/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).gds" \
	CELL_NAME="hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT)" \
	LEF_FILE="$(OUTPUT_DIR)/lef/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).lef" \
	magic -dnull -noconsole ./helpers/extract_lef.tcl

.PHONY: release
release:
	mkdir -p $(LIBS_REF_DIR)/gds
	cp $(OUTPUT_DIR)/gds/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).gds $(LIBS_REF_DIR)/gds/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).gds
	mkdir -p $(LIBS_REF_DIR)/spice
	cp $(OUTPUT_DIR)/spice/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice $(LIBS_REF_DIR)/spice/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice
	mkdir -p $(LIBS_REF_DIR)/lef
	cp $(OUTPUT_DIR)/lef/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).lef $(LIBS_REF_DIR)/lef/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).lef
	mkdir -p $(LIBS_REF_DIR)/cdl
	cp $(OUTPUT_DIR)/cdl/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice $(LIBS_REF_DIR)/cdl/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).spice
	mkdir -p $(LIBS_REF_DIR)/vh
	cp $(OUTPUT_DIR)/vh/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).vh $(LIBS_REF_DIR)/vh/hm_pg_$(TYPE)_$(WIDTH)x$(HEIGHT).vh

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)/gds
	rm -rf $(OUTPUT_DIR)/drc
	rm -rf $(OUTPUT_DIR)/json
	rm -rf $(OUTPUT_DIR)/spice
	rm -rf $(OUTPUT_DIR)/xschem
