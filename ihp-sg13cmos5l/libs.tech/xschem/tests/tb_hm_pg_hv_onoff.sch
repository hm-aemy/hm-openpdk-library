v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -150 40 -140 {
lab=vdd_d}
N 40 -80 40 -70 {
lab=GND}
N -60 100 -60 120 {
lab=GND}
N -60 100 -40 100 {
lab=GND}
N -90 30 -90 60 {
lab=vdd_d}
N 340 160 340 170 {
lab=GND}
N 340 70 340 90 {
lab=vdd_dut}
N 320 70 340 70 {
lab=vdd_dut}
N 340 160 440 160 {lab=GND}
N 340 150 340 160 {
lab=GND}
N 440 70 440 90 {lab=vdd_dut}
N 340 70 440 70 {lab=vdd_dut}
N 440 150 440 160 {lab=GND}
N -90 60 -40 60 {lab=vdd_d}
N -60 10 -60 40 {
lab=vdd_a}
N -60 40 -40 40 {lab=vdd_a}
N 160 -150 160 -140 {
lab=vdd_a}
N 160 -80 160 -70 {
lab=GND}
N -180 80 -40 80 {
lab=ctrl}
C {devices/code.sym} -170 -160 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOShv.lib mos_tt
.lib cornerMOSlv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code.sym} -310 -160 0 0 {name=SIMULATION
only_toplevel=false 
value="

.control
save all

tran 10n 50u

plot vdd_dut
plot ctrl x1.h_crtl_p

.endc
"}
C {devices/vsource.sym} 40 -110 0 0 {name=V1 value=1.2 savecurrent=true}
C {devices/gnd.sym} 40 -70 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 40 -150 2 1 {name=p8 sig_type=std_logic lab=vdd_d
}
C {devices/gnd.sym} -60 120 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -90 30 2 1 {name=p4 sig_type=std_logic lab=vdd_d
}
C {devices/gnd.sym} 340 170 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 440 70 0 1 {name=p1 sig_type=std_logic lab=vdd_dut

}
C {devices/capa.sym} 340 120 0 0 {name=C1
m=1
value=75p
footprint=1206
device="ceramic capacitor"}
C {devices/ammeter.sym} 290 70 3 0 {name=Vdut savecurrent=true spice_ignore=0 lvs_ignore=1}
C {res.sym} 440 120 0 0 {name=R1
value=1000
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} -60 10 2 1 {name=p3 sig_type=std_logic lab=vdd_a
}
C {devices/vsource.sym} 160 -110 0 0 {name=V3 value=3.3 savecurrent=true}
C {devices/gnd.sym} 160 -70 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 160 -150 2 1 {name=p5 sig_type=std_logic lab=vdd_a
}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/hm_pg_hv.sym} 110 70 0 0 {name=x1}
C {devices/vsource.sym} -180 110 0 1 {name=V2 value="PULSE(1.2 0 0 1n 1n 10u 20u)" savecurrent=false}
C {devices/gnd.sym} -180 140 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -160 80 3 1 {name=p2 sig_type=std_logic lab=ctrl
}
