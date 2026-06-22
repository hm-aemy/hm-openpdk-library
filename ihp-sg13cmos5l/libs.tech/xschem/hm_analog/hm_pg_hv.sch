v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -180 -50 -180 -20 {lab=ctrl_n}
N -180 -110 -160 -110 {lab=VPWR}
N -180 -150 -180 -140 {lab=VPWR}
N -180 50 -180 70 {lab=VGND}
N -180 10 -160 10 {lab=VGND}
N -160 10 -160 50 {lab=VGND}
N -180 50 -160 50 {lab=VGND}
N -180 40 -180 50 {lab=VGND}
N -160 -150 -160 -110 {lab=VPWR}
N -180 -150 -160 -150 {lab=VPWR}
N -180 -170 -180 -150 {lab=VPWR}
N -240 -110 -220 -110 {lab=ctrl}
N -240 10 -220 10 {lab=ctrl}
N -240 -50 -240 10 {lab=ctrl}
N -180 -50 -20 -50 {lab=ctrl_n}
N -180 -80 -180 -50 {lab=ctrl_n}
N -60 -170 -50 -170 {lab=VPWR}
N -20 -130 -20 -50 {lab=ctrl_n}
N 10 -170 300 -170 {lab=GPWR}
N -250 -50 -240 -50 {lab=ctrl}
N -240 -110 -240 -50 {lab=ctrl}
N -20 -190 -20 -170 {lab=VPWR}
N -60 -190 -20 -190 {lab=VPWR}
N -60 -190 -60 -170 {lab=VPWR}
N -180 -170 -60 -170 {lab=VPWR}
N 300 -170 300 -50 {lab=GPWR}
N 280 -50 300 -50 {lab=GPWR}
N 300 -170 330 -170 {lab=GPWR}
N 280 -30 300 -30 {lab=VGND}
N 300 -30 300 70 {lab=VGND}
N -180 70 300 70 {lab=VGND}
N -240 70 -180 70 {lab=VGND}
N -240 -170 -180 -170 {lab=VPWR}
C {ipin.sym} -250 -50 0 0 {name=p1 lab=ctrl}
C {iopin.sym} -240 -170 2 0 {name=p2 lab=VPWR}
C {iopin.sym} -240 70 2 0 {name=p3 lab=VGND}
C {iopin.sym} 330 -170 0 0 {name=p4 lab=GPWR}
C {lab_pin.sym} -20 -100 0 0 {name=p5 sig_type=std_logic lab=ctrl_n}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} -200 10 0 0 {name=M4
l=0.45u
w=2.6u
ng=1
m=1
mm_ok=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} -200 -110 0 0 {name=M5
l=0.45u
w=4.44u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} -20 -150 3 0 {name=M6
l=0.45u
w=2175u
 ng=290
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
