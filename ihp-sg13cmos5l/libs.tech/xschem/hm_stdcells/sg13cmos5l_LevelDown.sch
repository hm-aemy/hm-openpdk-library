v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 140 0 160 0 {lab=core}
N -40 0 -40 70 {lab=#net1}
N 0 -120 0 -70 {lab=vdd}
N 0 0 0 40 {lab=#net2}
N -130 -60 -110 -60 {lab=iovdd}
N 0 100 0 120 {lab=vss}
N 0 70 40 70 {lab=!}
N 140 -120 140 -70 {lab=vdd}
N 140 70 180 70 {lab=!}
N 140 100 140 120 {lab=vss}
N 0 120 140 120 {lab=vss}
N -160 0 -140 0 {lab=pad}
N 140 0 140 40 {lab=core}
N 100 0 100 70 {lab=#net2}
N -110 40 -110 60 {lab=iovss}
N -110 -60 -110 -40 {lab=iovdd}
N -160 120 0 120 {lab=vss}
N 40 70 40 180 {lab=!}
N -80 0 -40 0 {lab=#net1}
N -40 -70 -40 0 {lab=#net1}
N 0 -120 140 -120 {lab=vdd}
N -20 -120 -0 -120 {lab=vdd}
N 140 -40 140 0 {lab=core}
N 180 70 180 180 {lab=!}
N 0 0 100 0 {lab=#net2}
N 0 -40 0 0 {lab=#net2}
N 100 -70 100 0 {lab=#net2}
N -100 40 -100 80 {lab=!}
N -130 60 -110 60 {lab=iovss}
N 40 180 180 180 {lab=!}
C {iopin.sym} -130 -60 0 1 {name=p6 lab=iovdd
}
C {iopin.sym} -160 120 0 1 {name=p1 lab=vss
}
C {iopin.sym} 160 0 0 0 {name=p2 lab=core
}
C {iopin.sym} -160 0 0 1 {name=p3 lab=pad
}
C {sg13g2_pr/sg13_hv_pmos.sym} -20 -70 0 0 {name=M5
l=0.45u
w=4.65u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -20 70 0 0 {name=M6
l=0.45u
w=2.65u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 120 70 0 0 {name=M7
l=0.13u
w=2.75u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 120 -70 0 0 {name=M8
l=0.13u
w=4.75u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -20 -120 0 1 {name=p4 lab=vdd
}
C {hm_stdcells/sg13g2_SecondaryProtection_noptap.sym} -110 0 0 0 {name=x1}
C {iopin.sym} -130 60 0 1 {name=p7 lab=iovss
}
C {lab_pin.sym} -100 80 0 0 {name=p8 sig_type=std_logic lab=!}
C {iopin.sym} -160 180 0 1 {name=p5 lab=!
}
C {lab_pin.sym} 40 180 0 0 {name=p9 sig_type=std_logic lab=!}
