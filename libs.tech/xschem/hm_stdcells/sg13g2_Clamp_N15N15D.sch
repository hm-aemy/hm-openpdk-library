v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 220 60 220 80 {lab=#net1}
N 0 60 0 80 {lab=#net1}
N 0 80 220 80 {lab=#net1}
N 40 -40 220 -40 {lab=iovss}
N 40 -70 100 -70 {lab=sub}
N 220 -40 220 0 {lab=iovss}
N 0 -20 0 0 {lab=gate}
N 180 -70 180 -20 {lab=gate}
N 0 -20 180 -20 {lab=gate}
N 0 -70 0 -20 {lab=gate}
N 40 -120 40 -100 {lab=pad[0]}
N 220 -70 280 -70 {lab=sub}
N 220 -120 220 -100 {lab=pad[1]}
N 380 -70 440 -70 {lab=sub}
N 380 -120 380 -100 {lab=pad[2]}
N 540 -70 600 -70 {lab=sub}
N 540 -120 540 -100 {lab=pad[3]}
N 220 -40 1180 -40 {lab=iovss}
N 180 -20 340 -20 {lab=gate}
N 340 -70 340 -20 {lab=gate}
N 340 -20 500 -20 {lab=gate}
N 500 -70 500 -20 {lab=gate}
N 700 -70 760 -70 {lab=sub}
N 700 -120 700 -100 {lab=pad[4]}
N 860 -70 920 -70 {lab=sub}
N 860 -120 860 -100 {lab=pad[5]}
N 500 -20 660 -20 {lab=gate}
N 660 -70 660 -20 {lab=gate}
N 660 -20 820 -20 {lab=gate}
N 820 -70 820 -20 {lab=gate}
N 1020 -70 1080 -70 {lab=sub}
N 1020 -120 1020 -100 {lab=pad[6]}
N 1180 -70 1240 -70 {lab=sub}
N 1180 -120 1180 -100 {lab=pad[7]}
N 820 -20 980 -20 {lab=gate}
N 980 -70 980 -20 {lab=gate}
N 980 -20 1140 -20 {lab=gate}
N 1140 -70 1140 -20 {lab=gate}
C {iopin.sym} 220 -10 0 0 {name=p3 lab=iovss}
C {iopin.sym} 0 -40 0 1 {name=p4 lab=gate}
C {iopin.sym} 40 -160 0 0 {name=p6 lab=pad[7:0]}
C {sg13g2_pr/ptap1.sym} 220 30 0 0 {name=R1
model=ptap1
spiceprefix=X
w=7.47e-6
l=7.47e-6
lvs_format="tcleval(@name @pinlist @model A=55.7736p P=328.08u )"
}
C {sg13g2_pr/dantenna.sym} 0 30 0 0 {name=D1
model=dantenna
l=0.78u
w=0.78u
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 20 -70 0 0 {name=M1
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 100 -70 0 1 {name=p1 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 200 -70 0 0 {name=M2
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 280 -70 0 1 {name=p7 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 360 -70 0 0 {name=M3
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 440 -70 0 1 {name=p9 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 520 -70 0 0 {name=M4
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 600 -70 0 1 {name=p11 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 680 -70 0 0 {name=M5
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 760 -70 0 1 {name=p13 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 840 -70 0 0 {name=M6
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 920 -70 0 1 {name=p15 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 1000 -70 0 0 {name=M7
l=0.6u
w=8.8u
ng=2
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1080 -70 0 1 {name=p17 sig_type=std_logic lab=sub}
C {sg13g2_pr/sg13_hv_nmos.sym} 1160 -70 0 0 {name=M8
l=0.6u
w=4.4u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1240 -70 0 1 {name=p19 sig_type=std_logic lab=sub}
C {lab_pin.sym} 40 -120 0 1 {name=p2 sig_type=std_logic lab=pad[0]}
C {lab_pin.sym} 220 -120 0 1 {name=p8 sig_type=std_logic lab=pad[1]}
C {lab_pin.sym} 380 -120 0 1 {name=p10 sig_type=std_logic lab=pad[2]}
C {lab_pin.sym} 540 -120 0 1 {name=p12 sig_type=std_logic lab=pad[3]}
C {lab_pin.sym} 700 -120 0 1 {name=p14 sig_type=std_logic lab=pad[4]}
C {lab_pin.sym} 860 -120 0 1 {name=p16 sig_type=std_logic lab=pad[5]}
C {lab_pin.sym} 1020 -120 0 1 {name=p18 sig_type=std_logic lab=pad[6]}
C {lab_pin.sym} 1180 -120 0 1 {name=p20 sig_type=std_logic lab=pad[7]}
C {iopin.sym} 220 80 0 0 {name=p5 lab=sub}
