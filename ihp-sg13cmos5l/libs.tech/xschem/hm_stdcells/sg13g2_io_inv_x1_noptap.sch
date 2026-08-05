v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 0 20 0 {lab=nq}
N 0 -120 0 -70 {lab=vdd}
N 0 100 0 120 {lab=vss}
N 0 70 40 70 {lab=sub}
N -60 0 -40 0 {lab=i}
N 40 70 40 180 {lab=sub}
N -40 0 -40 70 {lab=i}
N -20 -120 -0 -120 {lab=vdd}
N 0 0 0 40 {lab=nq}
N 0 -40 0 0 {lab=nq}
N -40 -70 -40 0 {lab=i}
N -20 120 -0 120 {lab=vss}
N -20 180 40 180 {lab=sub}
C {iopin.sym} -20 120 0 1 {name=p1 lab=vss
}
C {iopin.sym} 20 0 0 0 {name=p2 lab=nq
}
C {iopin.sym} -60 0 0 1 {name=p3 lab=i
}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 70 0 0 {name=M7
l=0.13u
w=3.93u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -70 0 0 {name=M8
l=0.13u
w=4.41u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -20 -120 0 1 {name=p4 lab=vdd
}
C {iopin.sym} -20 180 0 1 {name=p5 lab=sub
}
