v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 0 -0 30 {lab=ctrl_n}
N 0 -60 20 -60 {lab=VPWR}
N 0 -100 -0 -90 {lab=VPWR}
N 0 100 0 120 {lab=VGND}
N 0 60 20 60 {lab=VGND}
N 20 60 20 100 {lab=VGND}
N 0 100 20 100 {lab=VGND}
N -0 90 0 100 {lab=VGND}
N 20 -100 20 -60 {lab=VPWR}
N 0 -100 20 -100 {lab=VPWR}
N -0 -120 0 -100 {lab=VPWR}
N -60 -60 -40 -60 {lab=ctrl}
N -60 60 -40 60 {lab=ctrl}
N -60 -0 -60 60 {lab=ctrl}
N 0 0 160 -0 {lab=ctrl_n}
N 0 -30 0 0 {lab=ctrl_n}
N 120 -120 130 -120 {lab=VPWR}
N 160 -80 160 -0 {lab=ctrl_n}
N 190 -120 480 -120 {lab=GPWR}
N -70 -0 -60 -0 {lab=ctrl}
N -60 -60 -60 -0 {lab=ctrl}
N 160 -140 160 -120 {lab=VPWR}
N 120 -140 160 -140 {lab=VPWR}
N 120 -140 120 -120 {lab=VPWR}
N 0 -120 120 -120 {lab=VPWR}
N 480 -120 480 0 {lab=GPWR}
N 460 -0 480 0 {lab=GPWR}
N 480 -120 510 -120 {lab=GPWR}
N 460 20 480 20 {lab=VGND}
N 480 20 480 120 {lab=VGND}
N 0 120 480 120 {lab=VGND}
N -60 120 0 120 {lab=VGND}
N -60 -120 -0 -120 {lab=VPWR}
C {ipin.sym} -70 0 0 0 {name=p1 lab=ctrl}
C {iopin.sym} -60 -120 2 0 {name=p2 lab=VPWR}
C {iopin.sym} -60 120 2 0 {name=p3 lab=VGND}
C {iopin.sym} 510 -120 0 0 {name=p4 lab=GPWR}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -20 60 0 0 {name=M1
l=0.13u
w=2.6u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} -20 -60 0 0 {name=M2
l=0.13u
w=4.44u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 160 -100 3 0 {name=M3
l=0.13u
w=2618u
ng=374
m=2
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 160 -50 0 0 {name=p5 sig_type=std_logic lab=ctrl_n}
C {hm_analog/dischg.sym} 310 10 0 0 {name=x1}
