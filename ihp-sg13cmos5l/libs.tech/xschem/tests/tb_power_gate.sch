v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -560 -240 -560 -230 {
lab=vdd}
N -560 -170 -560 -160 {
lab=GND}
N -150 -20 -130 -20 {
lab=vdd}
N -150 20 -150 40 {
lab=GND}
N -150 20 -130 20 {
lab=GND}
N -150 -50 -150 -20 {
lab=vdd}
N -270 0 -130 0 {
lab=ctrl}
N 250 80 250 100 {
lab=GND}
N 250 0 250 20 {
lab=vdd_dut}
N 230 0 250 0 {
lab=vdd_dut}
C {/home/designer/shared/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/power_gate.sym} 20 0 0 0 {name=x1}
C {devices/code.sym} -260 -240 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code.sym} -420 -240 0 0 {name=SIMULATION
only_toplevel=false 
value="
.param mc_mm_switch=0
.control
save all
tran 50p 5u
plot vdd_dut
plot vdd_dut x1.ctrl_n ctrl xlimit 50n 60n
*quit 0
.endc
.end
"}
C {devices/vsource.sym} -560 -200 0 0 {name=V1 value=1.2 savecurrent=true}
C {devices/gnd.sym} -560 -160 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -560 -240 2 1 {name=p8 sig_type=std_logic lab=vdd
}
C {devices/gnd.sym} -150 40 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -150 -50 2 1 {name=p4 sig_type=std_logic lab=vdd
}
C {devices/vsource.sym} -270 30 0 1 {name=V2 value="PULSE(0 1.8 50n 0.5n 0.5n 99.5n 4u)" savecurrent=false}
C {devices/gnd.sym} -270 60 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 250 100 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 250 0 0 1 {name=p1 sig_type=std_logic lab=vdd_dut

}
C {devices/capa.sym} 250 50 0 0 {name=C1
m=1
value=75p
footprint=1206
device="ceramic capacitor"}
C {devices/ammeter.sym} 200 0 3 0 {name=Vdut savecurrent=true spice_ignore=0 lvs_ignore=1}
C {devices/lab_pin.sym} -250 0 3 1 {name=p2 sig_type=std_logic lab=ctrl
}
