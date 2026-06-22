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
N 250 90 250 100 {
lab=GND}
N 250 0 250 20 {
lab=vdd_dut}
N 230 0 250 0 {
lab=vdd_dut}
N 250 90 350 90 {lab=GND}
N 250 80 250 90 {
lab=GND}
N 350 0 350 20 {lab=vdd_dut}
N 250 0 350 0 {lab=vdd_dut}
N 350 80 350 90 {lab=GND}
C {devices/code.sym} -260 -240 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code.sym} -440 -250 0 0 {name=SIMULATION
only_toplevel=false 
value="
.param Rload=1000

.control

let npoints = 8
let rvec = vector(npoints)
let ivec = vector(npoints)
let vdrop_vec = vector(npoints)
let ron_vec = vector(npoints)

let vdd_dutvec = vector(npoints)

let idx=0

foreach r 10000 5000 2000 1000 500 200 100 10
  alterparam Rload=$r
  reset
  save all
  op

  let iload = i(vdut)
  let vdrop = v(vdd) - v(vdd_dut)
  let ron = vdrop/iload

  let rvec[idx] = $r
  let ivec[idx] = iload
  let vdrop_vec[idx] = vdrop
  let ron_vec[idx] = ron

  let vdd_dutvec[idx] = vdd_dut

  echo -------------------------
  echo Rload = $r
  print iload vdrop ron

  let idx = idx + 1
end

plot ron_vec vs ivec
plot vdd_dutvec vs ivec

.endc
"}
C {devices/vsource.sym} -560 -200 0 0 {name=V1 value=1.2 savecurrent=true}
C {devices/gnd.sym} -560 -160 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -560 -240 2 1 {name=p8 sig_type=std_logic lab=vdd
}
C {devices/gnd.sym} -150 40 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -150 -50 2 1 {name=p4 sig_type=std_logic lab=vdd
}
C {devices/vsource.sym} -270 30 0 1 {name=V2 value=1.2 savecurrent=false}
C {devices/gnd.sym} -270 60 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 250 100 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 350 0 0 1 {name=p1 sig_type=std_logic lab=vdd_dut

}
C {devices/capa.sym} 250 50 0 0 {name=C1
m=1
value=75p
footprint=1206
device="ceramic capacitor"}
C {devices/ammeter.sym} 200 0 3 0 {name=Vdut savecurrent=true spice_ignore=0 lvs_ignore=1}
C {devices/lab_pin.sym} -250 0 3 1 {name=p2 sig_type=std_logic lab=ctrl
}
C {res.sym} 350 50 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1}
C {/home/designer/shared/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/hm_pg_lv.sym} 20 0 0 0 {name=x1}
