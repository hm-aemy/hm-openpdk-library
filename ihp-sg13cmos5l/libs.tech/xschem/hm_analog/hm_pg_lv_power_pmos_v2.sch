v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -70 -0 -70 {lab=VPWR}
N 0 -50 0 -30 {lab=VPWR}
N -70 0 -40 -0 {lab=ctrl}
N 0 30 0 70 {lab=GPWR}
N 0 -0 20 -0 {lab=VPWR}
N 20 -50 20 -0 {lab=VPWR}
N 0 -50 20 -50 {lab=VPWR}
N 0 -70 0 -50 {lab=VPWR}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} -20 0 0 0 {name=M3
l=0.13u
w=2618u
ng=374
m=2
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -10 -70 2 0 {name=p2 lab=VPWR}
C {iopin.sym} 0 70 0 0 {name=p4 lab=GPWR}
C {iopin.sym} -70 0 2 0 {name=p1 lab=ctrl}
