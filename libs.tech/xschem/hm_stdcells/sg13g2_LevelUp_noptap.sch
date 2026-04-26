v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 360 0 380 0 {lab=out}
N 80 -120 80 -70 {lab=iovdd}
N 80 -120 200 -120 {lab=iovdd}
N 200 -120 200 -70 {lab=iovdd}
N 120 -30 160 -70 {lab=#net1}
N 80 -30 120 -30 {lab=#net1}
N 120 -70 160 -30 {lab=#net2}
N 160 -30 200 -30 {lab=#net2}
N 200 -30 200 0 {lab=#net2}
N 200 -40 200 -30 {lab=#net2}
N 200 0 320 0 {lab=#net2}
N 320 -70 320 0 {lab=#net2}
N 360 -120 360 -70 {lab=iovdd}
N 200 -120 360 -120 {lab=iovdd}
N 360 -40 360 0 {lab=out}
N 80 -30 80 40 {lab=#net1}
N 80 -40 80 -30 {lab=#net1}
N 60 -120 80 -120 {lab=iovdd}
N 80 100 80 120 {lab=vss}
N 360 100 360 120 {lab=vss}
N 200 120 360 120 {lab=vss}
N 200 100 200 120 {lab=vss}
N 80 120 200 120 {lab=vss}
N 360 0 360 40 {lab=out}
N 320 0 320 70 {lab=#net2}
N 360 70 400 70 {lab=sub}
N 400 70 400 180 {lab=sub}
N 200 70 240 70 {lab=sub}
N 240 70 240 180 {lab=sub}
N 80 70 120 70 {lab=sub}
N 120 70 120 180 {lab=sub}
N 200 0 200 40 {lab=#net2}
N -100 -120 -100 -70 {lab=vdd}
N -100 -20 -100 40 {lab=#net3}
N -100 70 -60 70 {lab=sub}
N -60 70 -60 180 {lab=sub}
N -100 100 -100 120 {lab=vss}
N -100 120 80 120 {lab=vss}
N -140 20 -140 70 {lab=in}
N 240 180 400 180 {lab=sub}
N 120 180 240 180 {lab=sub}
N -60 180 120 180 {lab=sub}
N -160 180 -60 180 {lab=sub}
N -160 120 -100 120 {lab=vss}
N -160 0 -140 0 {lab=in}
N -140 -70 -140 0 {lab=in}
N 160 20 160 70 {lab=in}
N -140 20 160 20 {lab=in}
N -140 0 -140 20 {lab=in}
N 40 -20 40 70 {lab=#net3}
N -100 -20 40 -20 {lab=#net3}
N -100 -40 -100 -20 {lab=#net3}
C {iopin.sym} 60 -120 0 1 {name=p6 lab=iovdd
}
C {iopin.sym} -160 120 0 1 {name=p1 lab=vss
}
C {iopin.sym} 380 0 0 0 {name=p2 lab=out
}
C {iopin.sym} -160 0 0 1 {name=p3 lab=in
}
C {sg13g2_pr/sg13_hv_nmos.sym} 60 70 0 0 {name=M1
l=0.45u
w=1.9u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 100 -70 0 1 {name=M3
l=0.45u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 180 -70 0 0 {name=M4
l=0.45u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 340 -70 0 0 {name=M5
l=0.45u
w=3.9u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 180 70 0 0 {name=M2
l=0.45u
w=1.9u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 340 70 0 0 {name=M6
l=0.45u
w=1.9u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -120 70 0 0 {name=M7
l=0.13u
w=2.75u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -120 -70 0 0 {name=M8
l=0.13u
w=4.75u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -100 -120 0 1 {name=p4 lab=vdd
}
C {iopin.sym} -160 180 0 1 {name=p5 lab=sub
}
