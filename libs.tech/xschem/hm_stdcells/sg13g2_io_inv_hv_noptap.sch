v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 0 0 40 {lab=out}
N 0 -120 0 -100 {lab=iovdd}
N 0 100 0 120 {lab=iovss}
N -70 130 -70 150 {lab=sub}
N -60 0 -60 70 {lab=in}
N -80 0 -60 0 {lab=in}
N -60 -70 -60 0 {lab=in}
N -60 -70 -40 -70 {lab=in}
N -60 70 -40 70 {lab=in}
N 0 0 40 0 {lab=out}
N 0 -40 0 0 {lab=out}
C {iopin.sym} 40 0 0 0 {name=p3 lab=out}
C {sg13g2_pr/sg13_hv_pmos.sym} -20 -70 0 0 {name=M1
l=0.5u
w=10u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -20 70 0 0 {name=M2
l=0.5u
w=10u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {iopin.sym} 0 -120 0 0 {name=p2 lab=iovdd}
C {iopin.sym} 0 120 0 0 {name=p1 lab=iovss}
C {iopin.sym} -70 150 0 0 {name=p5 lab=sub}
C {iopin.sym} -80 0 0 1 {name=p6 lab=in}
