v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 200 80 200 {lab=VGND}
N 80 180 80 200 {lab=VGND}
N -100 180 -100 200 {lab=VGND}
N -100 -220 80 -220 {lab=GPWR}
N 20 150 40 150 {lab=gate}
N 20 70 20 150 {lab=gate}
N -160 -180 20 -180 {lab=gate}
N 20 -90 40 -90 {lab=gate}
N 20 -10 40 -10 {lab=gate}
N 20 70 40 70 {lab=gate}
N -160 150 -140 150 {lab=gate}
N -160 70 -160 150 {lab=gate}
N -160 -90 -140 -90 {lab=gate}
N -160 -10 -140 -10 {lab=gate}
N -160 70 -140 70 {lab=gate}
N -220 200 -100 200 {lab=VGND}
N -220 -220 -100 -220 {lab=GPWR}
N 20 -180 20 -90 {lab=gate}
N 20 -90 20 -10 {lab=gate}
N 20 -10 20 70 {lab=gate}
N -220 -180 -160 -180 {lab=gate}
N -160 -180 -160 -90 {lab=gate}
N -160 -90 -160 -10 {lab=gate}
N -160 -10 -160 70 {lab=gate}
N 80 -220 80 -120 {lab=GPWR}
N 80 -60 80 -40 {lab=#net1}
N 80 20 80 40 {lab=#net2}
N 80 100 80 120 {lab=#net3}
N -100 150 -80 150 {lab=VGND}
N -100 100 -100 120 {lab=#net4}
N -100 20 -100 40 {lab=#net5}
N -100 -220 -100 -120 {lab=GPWR}
N -100 -90 -80 -90 {lab=VGND}
N -80 150 -80 200 {lab=VGND}
N -80 70 -80 150 {lab=VGND}
N -100 200 -80 200 {lab=VGND}
N -100 70 -80 70 {lab=VGND}
N -80 -10 -80 70 {lab=VGND}
N -100 -10 -80 -10 {lab=VGND}
N -100 -60 -100 -40 {lab=#net6}
N -80 -90 -80 -10 {lab=VGND}
N 80 -90 100 -90 {lab=VGND}
N 100 150 100 200 {lab=VGND}
N 80 200 100 200 {lab=VGND}
N 80 150 100 150 {lab=VGND}
N 100 70 100 150 {lab=VGND}
N 80 70 100 70 {lab=VGND}
N 100 -10 100 70 {lab=VGND}
N 80 -10 100 -10 {lab=VGND}
N 100 -90 100 -10 {lab=VGND}
C {devices/iopin.sym} -220 -220 0 1 {name=p2 lab=GPWR sim_pinnumber=2}
C {devices/iopin.sym} -220 200 0 1 {name=p1 lab=VGND sim_pinnumber=1}
C {devices/ipin.sym} -220 -180 0 0 {name=p3 lab=gate sim_pinnumber=3}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} -120 -90 0 0 {name=M6
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} -120 -10 0 0 {name=M7
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} -120 70 0 0 {name=M8
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} -120 150 0 0 {name=M9
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 60 -90 0 0 {name=M1
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 60 -10 0 0 {name=M2
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 60 70 0 0 {name=M3
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 60 150 0 0 {name=M4
l=0.65u
w=0.5u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
