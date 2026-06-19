v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 220 120 220 140 {lab=sub}
N 220 -20 330 -20 {lab=gate}
N 0 -100 0 -20 {lab=gate}
N 220 40 220 60 {lab=iovss}
N 260 -160 370 -160 {lab=iovdd}
N 40 -160 40 -70 {lab=iovdd}
N 0 -160 40 -160 {lab=iovdd}
N 40 -40 40 -0 {lab=pad[0]}
N 150 -40 150 0 {lab=pad[1]}
N 260 -40 260 0 {lab=pad[2]}
N 370 -40 370 0 {lab=pad[3]}
N 370 -160 370 -70 {lab=iovdd}
N 260 -160 260 -70 {lab=iovdd}
N 150 -160 260 -160 {lab=iovdd}
N 150 -160 150 -70 {lab=iovdd}
N 40 -160 150 -160 {lab=iovdd}
N 330 -70 330 -20 {lab=gate}
N 220 -70 220 -20 {lab=gate}
N 110 -20 220 -20 {lab=gate}
N 110 -70 110 -20 {lab=gate}
N 0 -20 110 -20 {lab=gate}
N 720 -20 830 -20 {lab=gate}
N 760 -160 870 -160 {lab=iovdd}
N 540 -160 540 -70 {lab=iovdd}
N 540 -40 540 0 {lab=pad[4]}
N 650 -40 650 0 {lab=pad[5]}
N 760 -40 760 0 {lab=pad[6]}
N 870 -40 870 0 {lab=pad[7]}
N 870 -160 870 -70 {lab=iovdd}
N 760 -160 760 -70 {lab=iovdd}
N 650 -160 760 -160 {lab=iovdd}
N 650 -160 650 -70 {lab=iovdd}
N 540 -160 650 -160 {lab=iovdd}
N 830 -70 830 -20 {lab=gate}
N 720 -70 720 -20 {lab=gate}
N 610 -20 720 -20 {lab=gate}
N 610 -70 610 -20 {lab=gate}
N 500 -70 500 -20 {lab=gate}
N 500 -20 610 -20 {lab=gate}
N 330 -20 500 -20 {lab=gate}
N 370 -160 540 -160 {lab=iovdd}
C {iopin.sym} 220 40 0 0 {name=p3 lab=iovss}
C {iopin.sym} 0 -40 0 1 {name=p4 lab=gate}
C {sg13g2_pr/sg13_hv_pmos.sym} 20 -70 0 0 {name=M1
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/dpantenna.sym} 0 -130 0 0 {name=D1
model=dpantenna
l=0.78u
w=0.78u
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 130 -70 0 0 {name=M2
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 240 -70 0 0 {name=M3
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 350 -70 0 0 {name=M4
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 520 -70 0 0 {name=M5
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {iopin.sym} 870 -160 0 0 {name=p11 lab=iovdd}
C {sg13g2_pr/sg13_hv_pmos.sym} 630 -70 0 0 {name=M6
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 740 -70 0 0 {name=M7
l=0.6u
w=26.64u
ng=4
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 850 -70 0 0 {name=M8
l=0.6u
w=13.32u
ng=2
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {iopin.sym} 40 40 0 0 {name=p1 lab=pad[7:0]}
C {lab_pin.sym} 40 0 0 1 {name=p2 sig_type=std_logic lab=pad[0]}
C {lab_pin.sym} 150 0 0 1 {name=p6 sig_type=std_logic lab=pad[1]}
C {lab_pin.sym} 260 0 0 1 {name=p7 sig_type=std_logic lab=pad[2]}
C {lab_pin.sym} 370 0 0 1 {name=p8 sig_type=std_logic lab=pad[3]}
C {lab_pin.sym} 540 0 0 1 {name=p9 sig_type=std_logic lab=pad[4]}
C {lab_pin.sym} 650 0 0 1 {name=p10 sig_type=std_logic lab=pad[5]}
C {lab_pin.sym} 760 0 0 1 {name=p12 sig_type=std_logic lab=pad[6]}
C {lab_pin.sym} 870 0 0 1 {name=p13 sig_type=std_logic lab=pad[7]}
C {iopin.sym} 220 140 0 0 {name=p5 lab=sub}
