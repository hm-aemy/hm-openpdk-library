v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -140 0 -120 0 {
lab=vdd_in}
N -140 40 -140 60 {
lab=GND}
N -140 40 -120 40 {
lab=GND}
N -140 -30 -140 0 {
lab=vdd_in}
N -240 20 -120 20 {lab=ctrl}
N 180 20 210 20 {lab=vdd_sw}
N -180 230 -180 250 {lab=GND}
N -180 150 -180 170 {lab=vdd_in}
N -50 230 -50 250 {lab=GND}
N -50 150 -50 170 {lab=ctrl}
C {devices/code.sym} -250 -220 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code_shown.sym} -920 -330 0 0 {name=SIMULATION
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
C {devices/gnd.sym} -140 60 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 210 20 0 1 {name=p1 sig_type=std_logic lab=vdd_sw

}
C {devices/lab_pin.sym} -240 20 2 1 {name=p2 sig_type=std_logic lab=ctrl
}
C {hm_analog/hm_pg_lv.sym} 30 20 0 0 {name=x1}
C {devices/lab_pin.sym} -140 -30 2 1 {name=p3 sig_type=std_logic lab=vdd_in
}
C {vsource.sym} -180 200 0 0 {name=V1 value=\{VDD\} savecurrent=false}
C {devices/gnd.sym} -180 250 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -180 150 2 1 {name=p4 sig_type=std_logic lab=vdd_in
}
C {vsource.sym} -50 200 0 0 {name=V2 value=1.2 savecurrent=false}
C {devices/gnd.sym} -50 250 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -50 150 2 1 {name=p5 sig_type=std_logic lab=ctrl
}
