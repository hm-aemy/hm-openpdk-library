v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 -200 0 -150 {lab=vdd}
N 0 100 0 120 {lab=vss}
N 0 70 40 70 {lab=sub}
N 40 70 40 180 {lab=sub}
N -20 -200 0 -200 {lab=vdd}
N 0 0 0 40 {lab=nq}
N -20 120 -0 120 {lab=vss}
N -20 180 40 180 {lab=sub}
N 120 100 120 120 {lab=vss}
N 0 120 120 120 {lab=vss}
N 120 70 160 70 {lab=sub}
N 160 70 160 180 {lab=sub}
N 40 180 160 180 {lab=sub}
N 120 0 140 0 {lab=nq}
N 0 -120 0 -90 {lab=#net1}
N -0 -60 60 -60 {lab=vdd}
N 60 -200 60 -60 {lab=vdd}
N 0 -200 60 -200 {lab=vdd}
N 0 -40 0 0 {lab=nq}
N 120 0 120 40 {lab=nq}
N 0 0 120 0 {lab=nq}
N -70 -150 -40 -150 {lab=i0}
N -60 -60 -40 -60 {lab=i1}
N 80 20 80 70 {lab=i1}
N -60 20 80 20 {lab=i1}
N -60 -60 -60 20 {lab=i1}
N -80 -60 -60 -60 {lab=i1}
N -70 -150 -70 70 {lab=i0}
N -80 -150 -70 -150 {lab=i0}
N -70 70 -40 70 {lab=i0}
C {iopin.sym} -20 120 0 1 {name=p1 lab=vss
}
C {iopin.sym} 140 0 0 0 {name=p2 lab=nq
}
C {iopin.sym} -80 -150 0 1 {name=p3 lab=i0
}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 70 0 0 {name=M7
l=0.13u
w=3.93u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -150 0 0 {name=M8
l=0.13u
w=4.41u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -20 -200 0 1 {name=p4 lab=vdd
}
C {iopin.sym} -20 180 0 1 {name=p5 lab=sub
}
C {sg13g2_pr/sg13_lv_nmos.sym} 100 70 0 0 {name=M1
l=0.13u
w=3.93u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -60 0 0 {name=M2
l=0.13u
w=4.41u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -80 -60 0 1 {name=p6 lab=i1
}
