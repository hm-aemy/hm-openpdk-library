v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 80 -180 80 -170 {
lab=vdd_d}
N 80 -110 80 -100 {
lab=GND}
N -20 70 -20 90 {
lab=GND}
N -20 70 0 70 {
lab=GND}
N -50 0 -50 30 {
lab=vdd_d}
N -140 50 0 50 {
lab=ctrl}
N 380 130 380 140 {
lab=GND}
N 380 40 380 60 {
lab=vdd_dut}
N 360 40 380 40 {
lab=vdd_dut}
N 380 130 480 130 {lab=GND}
N 380 120 380 130 {
lab=GND}
N 480 40 480 60 {lab=vdd_dut}
N 380 40 480 40 {lab=vdd_dut}
N 480 120 480 130 {lab=GND}
N -50 30 0 30 {lab=vdd_d}
N -20 -20 -20 10 {
lab=vdd_a}
N -20 10 -0 10 {lab=vdd_a}
N 200 -180 200 -170 {
lab=vdd_a}
N 200 -110 200 -100 {
lab=GND}
C {devices/code.sym} -130 -190 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOShv.lib mos_tt
.lib cornerMOSlv.lib mos_tt
*.lib cornerCAP.lib cap_typ
"
spice_ignore=false}
C {devices/code.sym} -270 -190 0 0 {name=SIMULATION
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
  let vdrop = v(vdd_a) - v(vdd_dut)
  let ron = vdrop/iload

  let rvec[idx] = $r
  let ivec[idx] = iload
  let vdrop_vec[idx] = vdrop
  let ron_vec[idx] = ron

  let vdd_dutvec[idx] = vdd_dut

  echo -------------------------
  echo Rload = $r
  print iload vdrop ron
  print x1.H_crtl_p

  let idx = idx + 1
end

plot ron_vec vs ivec
plot vdd_dutvec vs ivec

.endc
"}
C {devices/vsource.sym} 80 -140 0 0 {name=V1 value=1.2 savecurrent=true}
C {devices/gnd.sym} 80 -100 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 80 -180 2 1 {name=p8 sig_type=std_logic lab=vdd_d
}
C {devices/gnd.sym} -20 90 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -50 0 2 1 {name=p4 sig_type=std_logic lab=vdd_d
}
C {devices/vsource.sym} -140 80 0 1 {name=V2 value=1.2 savecurrent=false}
C {devices/gnd.sym} -140 110 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 380 140 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 480 40 0 1 {name=p1 sig_type=std_logic lab=vdd_dut

}
C {devices/capa.sym} 380 90 0 0 {name=C1
m=1
value=75p
footprint=1206
device="ceramic capacitor"}
C {devices/ammeter.sym} 330 40 3 0 {name=Vdut savecurrent=true spice_ignore=0 lvs_ignore=1}
C {devices/lab_pin.sym} -120 50 3 1 {name=p2 sig_type=std_logic lab=ctrl
}
C {res.sym} 480 90 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/hm_pg_hv.sym} 150 40 0 0 {name=x1}
C {devices/lab_pin.sym} -20 -20 2 1 {name=p3 sig_type=std_logic lab=vdd_a
}
C {devices/vsource.sym} 200 -140 0 0 {name=V3 value=3.3 savecurrent=true}
C {devices/gnd.sym} 200 -100 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 200 -180 2 1 {name=p5 sig_type=std_logic lab=vdd_a
}
