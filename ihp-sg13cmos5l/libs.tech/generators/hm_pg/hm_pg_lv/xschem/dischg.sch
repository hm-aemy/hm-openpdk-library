v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 180 -80 200 {lab=#net1}
N -80 500 -80 520 {lab=VGND}
N -140 150 -120 150 {lab=gate}
N -140 70 -140 150 {lab=gate}
N -140 -90 -120 -90 {lab=gate}
N -140 -10 -120 -10 {lab=gate}
N -140 70 -120 70 {lab=gate}
N -140 470 -120 470 {lab=gate}
N -140 390 -140 470 {lab=gate}
N -140 230 -120 230 {lab=gate}
N -140 310 -120 310 {lab=gate}
N -140 390 -120 390 {lab=gate}
N -140 -180 -140 -90 {lab=gate}
N -140 -90 -140 -10 {lab=gate}
N -140 -10 -140 70 {lab=gate}
N -140 230 -140 310 {lab=gate}
N -140 310 -140 390 {lab=gate}
N -80 -220 -80 -120 {lab=GPWR}
N -80 -60 -80 -40 {lab=#net2}
N -80 20 -80 40 {lab=#net3}
N -80 100 -80 120 {lab=#net4}
N -80 470 -60 470 {lab=VGND}
N -80 420 -80 440 {lab=#net5}
N -80 340 -80 360 {lab=#net6}
N -80 230 -60 230 {lab=VGND}
N -60 470 -60 520 {lab=VGND}
N -60 390 -60 470 {lab=VGND}
N -80 390 -60 390 {lab=VGND}
N -60 310 -60 390 {lab=VGND}
N -80 310 -60 310 {lab=VGND}
N -80 260 -80 280 {lab=#net7}
N -60 230 -60 310 {lab=VGND}
N -80 -90 -60 -90 {lab=VGND}
N -60 150 -60 230 {lab=VGND}
N -80 150 -60 150 {lab=VGND}
N -60 70 -60 150 {lab=VGND}
N -80 70 -60 70 {lab=VGND}
N -60 -10 -60 70 {lab=VGND}
N -80 -10 -60 -10 {lab=VGND}
N -60 -90 -60 -10 {lab=VGND}
N -190 -180 -140 -180 {lab=gate}
N -190 -220 -80 -220 {lab=GPWR}
N -190 520 -80 520 {lab=VGND}
N -80 520 -60 520 {lab=VGND}
N -140 150 -140 230 {lab=gate}
N 80 180 80 200 {lab=#net8}
N 80 500 80 520 {lab=VGND}
N 20 150 40 150 {lab=gate}
N 20 70 20 150 {lab=gate}
N 20 -90 40 -90 {lab=gate}
N 20 -10 40 -10 {lab=gate}
N 20 70 40 70 {lab=gate}
N 20 470 40 470 {lab=gate}
N 20 390 20 470 {lab=gate}
N 20 230 40 230 {lab=gate}
N 20 310 40 310 {lab=gate}
N 20 390 40 390 {lab=gate}
N 20 -90 20 -10 {lab=gate}
N 20 -10 20 70 {lab=gate}
N 20 230 20 310 {lab=gate}
N 20 310 20 390 {lab=gate}
N 80 -60 80 -40 {lab=#net9}
N 80 20 80 40 {lab=#net10}
N 80 100 80 120 {lab=#net11}
N 80 470 100 470 {lab=VGND}
N 80 420 80 440 {lab=#net12}
N 80 340 80 360 {lab=#net13}
N 80 230 100 230 {lab=VGND}
N 100 470 100 520 {lab=VGND}
N 100 390 100 470 {lab=VGND}
N 80 390 100 390 {lab=VGND}
N 100 310 100 390 {lab=VGND}
N 80 310 100 310 {lab=VGND}
N 80 260 80 280 {lab=#net14}
N 100 230 100 310 {lab=VGND}
N 80 -90 100 -90 {lab=VGND}
N 100 150 100 230 {lab=VGND}
N 80 150 100 150 {lab=VGND}
N 100 70 100 150 {lab=VGND}
N 80 70 100 70 {lab=VGND}
N 100 -10 100 70 {lab=VGND}
N 80 -10 100 -10 {lab=VGND}
N 100 -90 100 -10 {lab=VGND}
N 20 150 20 230 {lab=gate}
N -60 520 80 520 {lab=VGND}
N 80 520 100 520 {lab=VGND}
N 80 -220 80 -120 {lab=GPWR}
N -80 -220 80 -220 {lab=GPWR}
N 20 -180 20 -90 {lab=gate}
N -140 -180 20 -180 {lab=gate}
C {devices/iopin.sym} -190 -220 0 1 {name=p2 lab=GPWR sim_pinnumber=2}
C {devices/iopin.sym} -190 520 0 1 {name=p1 lab=VGND sim_pinnumber=1}
C {devices/ipin.sym} -190 -180 0 0 {name=p3 lab=gate sim_pinnumber=3}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 -90 0 0 {name=M1
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 -10 0 0 {name=M2
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 70 0 0 {name=M3
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 150 0 0 {name=M4
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 230 0 0 {name=M5
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 310 0 0 {name=M6
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 390 0 0 {name=M7
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 470 0 0 {name=M8
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 -90 0 0 {name=M9
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 -10 0 0 {name=M10
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 70 0 0 {name=M11
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 150 0 0 {name=M12
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 230 0 0 {name=M13
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 310 0 0 {name=M14
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 390 0 0 {name=M15
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 60 470 0 0 {name=M16
l={{dischL}}u
w={{dischW}}u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
