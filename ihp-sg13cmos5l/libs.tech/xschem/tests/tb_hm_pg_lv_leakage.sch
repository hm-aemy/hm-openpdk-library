v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 130 -20 150 -20 {
lab=vdd_in}
N 130 20 130 40 {
lab=GND}
N 130 20 150 20 {
lab=GND}
N 130 -50 130 -20 {
lab=vdd_in}
N 30 0 150 0 {lab=ctrl}
N 450 0 480 0 {lab=vdd_sw}
N 90 210 90 230 {lab=GND}
N 90 130 90 150 {lab=vdd_in}
N 220 210 220 230 {lab=GND}
N 220 130 220 150 {lab=ctrl}
C {devices/code.sym} 20 -240 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code_shown.sym} -650 -350 0 0 {name=SIMULATION
only_toplevel=false 
value="

.param VDD=1.2
.param IMAX=50m
.param ISTEP=100u
.param DCMAX=\{IMAX + 0.5*ISTEP\}
.param I1=5m
.param I2=10m

Iload vdd_sw 0 0

.meas dc vin_at_max  FIND v(vdd_in) AT=\{IMAX\}
.meas dc vout_at_max FIND v(vdd_sw) AT=\{IMAX\}
.meas dc vdrop_max PARAM='vin_at_max-vout_at_max'
.meas dc ron_at_max PARAM='vdrop_max/IMAX'
.meas dc pcond_max PARAM='vdrop_max*IMAX'

* Caída de tensión en dos puntos
.meas dc vin_i1  FIND v(vdd_in) AT=\{I1\}
.meas dc vout_i1 FIND v(vdd_sw) AT=\{I1\}
.meas dc vdrop_i1 PARAM='vin_i1-vout_i1'

.meas dc vin_i2  FIND v(vdd_in) AT=\{I2\}
.meas dc vout_i2 FIND v(vdd_sw) AT=\{I2\}
.meas dc vdrop_i2 PARAM='vin_i2-vout_i2'

* Resistencia incremental entre I1 e I2
.meas dc ron_incremental PARAM='(vdrop_i2-vdrop_i1)/(I2-I1)'

.dc Iload 0 \{DCMAX\} 100u

.control
run
*write tb_pg_dc.raw v(vdd_in) v(vdd_sw) i(VDD_SRC)
plot vdd_in-vdd_sw
.endc
.end
"}
C {devices/gnd.sym} 130 40 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 480 0 0 1 {name=p1 sig_type=std_logic lab=vdd_sw

}
C {devices/lab_pin.sym} 30 0 2 1 {name=p2 sig_type=std_logic lab=ctrl
}
C {hm_analog/hm_pg_lv.sym} 300 0 0 0 {name=x1}
C {devices/lab_pin.sym} 130 -50 2 1 {name=p3 sig_type=std_logic lab=vdd_in
}
C {vsource.sym} 90 180 0 0 {name=V1 value=\{VDD\} savecurrent=false}
C {devices/gnd.sym} 90 230 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 90 130 2 1 {name=p4 sig_type=std_logic lab=vdd_in
}
C {vsource.sym} 220 180 0 0 {name=V2 value=0 savecurrent=false}
C {devices/gnd.sym} 220 230 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 220 130 2 1 {name=p5 sig_type=std_logic lab=ctrl
}
