v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -60 -80 -30 -80 {lab=in}
N -60 -0 -60 80 {lab=in}
N -60 80 -30 80 {lab=in}
N 30 -80 60 -80 {lab=out}
N 60 0 60 80 {lab=out}
N 30 80 60 80 {lab=out}
N 40 110 50 110 {lab=vdd}
N 40 60 40 110 {lab=vdd}
N 0 60 40 60 {lab=vdd}
N 0 60 0 80 {lab=vdd}
N 0 -80 0 -60 {lab=sub}
N 0 -60 40 -60 {lab=sub}
N 40 -110 40 -60 {lab=sub}
N 40 -110 50 -110 {lab=sub}
N 0 -140 0 -120 {lab=en}
N -100 0 -60 -0 {lab=in}
N -60 -80 -60 -0 {lab=in}
N 60 0 100 0 {lab=out}
N 60 -80 60 0 {lab=out}
N -0 120 0 140 {lab=en_neg}
N -140 170 -110 170 {lab=vss}
N -140 230 -110 230 {lab=sub}
C {sg13g2_pr/sg13_lv_nmos.sym} 0 -100 1 0 {name=M7
l=0.13u
w=3.93u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 0 100 3 0 {name=M8
l=0.13u
w=4.41u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 50 -110 2 1 {name=p18 lab=sub
}
C {iopin.sym} 50 110 2 1 {name=p12 lab=vdd
}
C {iopin.sym} 0 -140 1 1 {name=p1 lab=en
}
C {iopin.sym} -100 0 0 1 {name=p2 lab=in
}
C {iopin.sym} 100 0 2 1 {name=p3 lab=out
}
C {iopin.sym} 0 140 3 1 {name=p4 lab=en_neg
}
C {iopin.sym} -140 170 0 1 {name=p6 lab=vss
}
C {sg13g2_pr/ptap1.sym} -110 200 0 0 {name=R2
model=ptap1
spiceprefix=X
w=1.54e-6
l=1.54e-6
lvs_format="tcleval(@name @pinlist @model A=0.624p P=4.76u )"
}
C {lab_pin.sym} -140 230 0 0 {name=p10 sig_type=std_logic lab=sub}
