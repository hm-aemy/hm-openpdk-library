HEIGHT = 200
WIDTH = 17

OUTPUT_DIR = ./hm_pg/hm_pg_lv/output/

.PHONY: layout
layout:
	python hm_pg/hm_pg_lv/pcell/hm_pg_lv_v2.py --width 17 --height 200 --output $(OUTPUT_DIR)

.PHONY: spice
spice:
	python helpers/generate_netlist.py --template ./hm_pg/hm_pg_lv/spice/hm_pg_lv_template.spice --params ./hm_pg/hm_pg_lv/output/json/params_17x200.json --output ./hm_pg/hm_pg_lv/output/spice/hm_pg_lv_17x200.spice
