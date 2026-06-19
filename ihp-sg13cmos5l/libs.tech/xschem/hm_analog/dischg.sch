v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -70 200 110 200 {lab=VGND}
N 110 180 110 200 {lab=VGND}
N -70 180 -70 200 {lab=VGND}
N -70 110 -70 120 {lab=#net1}
N -70 30 -70 40 {lab=#net2}
N -70 -50 -70 -40 {lab=#net3}
N -70 -220 110 -220 {lab=GPWR}
N 110 -130 110 -120 {lab=GPWR}
N -70 -130 -70 -120 {lab=GPWR}
N 110 110 110 120 {lab=#net4}
N 110 30 110 40 {lab=#net5}
N 110 -50 110 -40 {lab=#net6}
N 50 150 70 150 {lab=gate}
N 50 70 50 150 {lab=gate}
N -130 -180 50 -180 {lab=gate}
N 50 -90 70 -90 {lab=gate}
N 50 -10 70 -10 {lab=gate}
N 50 70 70 70 {lab=gate}
N -130 150 -110 150 {lab=gate}
N -130 70 -130 150 {lab=gate}
N -130 -90 -110 -90 {lab=gate}
N -130 -10 -110 -10 {lab=gate}
N -130 70 -110 70 {lab=gate}
N -190 200 -70 200 {lab=VGND}
N -190 -220 -70 -220 {lab=GPWR}
N 50 -180 50 -90 {lab=gate}
N 50 -90 50 -10 {lab=gate}
N 50 -10 50 70 {lab=gate}
N -190 -180 -130 -180 {lab=gate}
N -130 -180 -130 -90 {lab=gate}
N -130 -90 -130 -10 {lab=gate}
N -130 -10 -130 70 {lab=gate}
N 110 -90 130 -90 {lab=GPWR}
N 130 -130 130 -90 {lab=GPWR}
N 110 -130 130 -130 {lab=GPWR}
N 110 -220 110 -130 {lab=GPWR}
N 110 -10 130 -10 {lab=#net6}
N 130 -50 130 -10 {lab=#net6}
N 110 -50 130 -50 {lab=#net6}
N 110 -60 110 -50 {lab=#net6}
N 110 70 130 70 {lab=#net5}
N 130 30 130 70 {lab=#net5}
N 110 30 130 30 {lab=#net5}
N 110 20 110 30 {lab=#net5}
N 110 150 130 150 {lab=#net4}
N 130 110 130 150 {lab=#net4}
N 110 110 130 110 {lab=#net4}
N 110 100 110 110 {lab=#net4}
N -70 150 -50 150 {lab=#net1}
N -50 110 -50 150 {lab=#net1}
N -70 110 -50 110 {lab=#net1}
N -70 100 -70 110 {lab=#net1}
N -70 70 -50 70 {lab=#net2}
N -50 30 -50 70 {lab=#net2}
N -70 30 -50 30 {lab=#net2}
N -70 20 -70 30 {lab=#net2}
N -70 -10 -50 -10 {lab=#net3}
N -50 -50 -50 -10 {lab=#net3}
N -70 -50 -50 -50 {lab=#net3}
N -70 -60 -70 -50 {lab=#net3}
N -70 -90 -50 -90 {lab=GPWR}
N -50 -130 -50 -90 {lab=GPWR}
N -70 -130 -50 -130 {lab=GPWR}
N -70 -220 -70 -130 {lab=GPWR}
C {devices/iopin.sym} -190 -220 0 1 {name=p2 lab=GPWR sim_pinnumber=2}
C {devices/iopin.sym} -190 200 0 1 {name=p1 lab=VGND sim_pinnumber=1}
C {devices/ipin.sym} -190 -180 0 0 {name=p3 lab=gate sim_pinnumber=3}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 90 -90 0 0 {name=M1
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 90 -10 0 0 {name=M2
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 90 70 0 0 {name=M3
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 90 150 0 0 {name=M4
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -90 -90 0 0 {name=M5
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -90 -10 0 0 {name=M6
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -90 70 0 0 {name=M7
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -90 150 0 0 {name=M8
l=0.65u
w=0.50u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
