v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -540 -240 -540 -230 {
lab=vdd}
N -540 -170 -540 -160 {
lab=GND}
N -130 -20 -110 -20 {
lab=vdd}
N -130 20 -130 40 {
lab=GND}
N -130 20 -110 20 {
lab=GND}
N -130 -50 -130 -20 {
lab=vdd}
N -250 0 -110 0 {
lab=ctrl}
N 270 90 270 100 {
lab=GND}
N 270 0 270 20 {
lab=vdd_dut}
N 250 0 270 0 {
lab=vdd_dut}
N 270 90 370 90 {lab=GND}
N 270 80 270 90 {
lab=GND}
N 370 0 370 20 {lab=vdd_dut}
N 270 0 370 0 {lab=vdd_dut}
N 370 80 370 90 {lab=GND}
C {devices/code.sym} -240 -240 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOShv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code.sym} -400 -240 0 0 {name=SIMULATION
only_toplevel=false 
value="
.param mc_mm_switch=0
.control
save all
tran 50p 5u
plot vdd_dut ctrl
plot vdd_dut x1.ctrl_n ctrl xlimit 50n 58n
*quit 0
.endc
.end
"}
C {devices/vsource.sym} -540 -200 0 0 {name=V1 value=3.3 savecurrent=true}
C {devices/gnd.sym} -540 -160 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -540 -240 2 1 {name=p8 sig_type=std_logic lab=vdd
}
C {devices/gnd.sym} -130 40 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -130 -50 2 1 {name=p4 sig_type=std_logic lab=vdd
}
C {devices/vsource.sym} -250 30 0 1 {name=V2 value="PULSE(0 3.3 50n 0.5n 0.5n 99.5n 4u)" savecurrent=false}
C {devices/gnd.sym} -250 60 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 270 100 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 370 0 0 1 {name=p1 sig_type=std_logic lab=vdd_dut

}
C {devices/capa.sym} 270 50 0 0 {name=C1
m=1
value=75p
footprint=1206
device="ceramic capacitor"}
C {devices/ammeter.sym} 220 0 3 0 {name=Vdut savecurrent=true spice_ignore=0 lvs_ignore=1}
C {devices/lab_pin.sym} -230 0 3 1 {name=p2 sig_type=std_logic lab=ctrl
}
C {res.sym} 370 50 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {/home/designer/shared/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/hm_pg_hv.sym} 40 0 0 0 {name=x1}
