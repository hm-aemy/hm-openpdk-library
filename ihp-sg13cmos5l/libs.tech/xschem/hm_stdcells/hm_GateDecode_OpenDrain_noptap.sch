v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 210 360 210 {lab=vss}
N 200 130 220 130 {lab=pgate}
N 240 -160 260 -160 {lab=ngate}
N 160 70 360 70 {lab=vdd}
N 160 70 160 90 {lab=vdd}
N 170 50 170 90 {lab=iovdd}
N 150 190 350 190 {lab=sub}
N 150 170 150 190 {lab=sub}
N 160 170 160 210 {lab=vss}
N 200 -220 200 -200 {lab=vdd}
N 210 -240 210 -200 {lab=iovdd}
N 190 -120 190 -100 {lab=sub}
N 200 -120 200 -80 {lab=vss}
N -160 190 -10 190 {lab=sub}
N -220 -240 210 -240 {lab=iovdd}
N -220 -80 -160 -80 {lab=vss}
N -220 -160 -200 -160 {lab=en}
N -220 -220 -160 -220 {lab=vdd}
N -160 -220 -160 -200 {lab=vdd}
N -210 -100 -170 -100 {lab=sub}
N -170 -120 -170 -100 {lab=sub}
N -160 -120 -160 -80 {lab=vss}
N 20 -220 200 -220 {lab=vdd}
N 10 -100 190 -100 {lab=sub}
N 20 -80 200 -80 {lab=vss}
N -210 -20 -190 -20 {lab=sub}
N -210 -100 -210 -20 {lab=sub}
N -220 -100 -210 -100 {lab=sub}
N 20 -220 20 -200 {lab=vdd}
N -160 -220 20 -220 {lab=vdd}
N 10 -120 10 -100 {lab=sub}
N -170 -100 10 -100 {lab=sub}
N 20 -120 20 -80 {lab=vss}
N -160 -80 20 -80 {lab=vss}
N -40 -170 -20 -170 {lab=core}
N -110 -160 -20 -160 {lab=en_neg}
N 50 -160 160 -160 {lab=#net1}
N 0 70 0 90 {lab=vdd}
N -10 170 -10 190 {lab=sub}
N 0 170 0 210 {lab=vss}
N 0 70 160 70 {lab=vdd}
N -10 190 150 190 {lab=sub}
N 0 210 160 210 {lab=vss}
N 30 130 120 130 {lab=#net2}
N 360 70 360 90 {lab=vdd}
N 350 170 350 190 {lab=sub}
N 360 170 360 210 {lab=vss}
N -60 120 -40 120 {lab=core}
N -150 70 0 70 {lab=vdd}
N -220 50 170 50 {lab=iovdd}
N -150 70 -150 90 {lab=vdd}
N -220 70 -150 70 {lab=vdd}
N -150 210 0 210 {lab=vss}
N -160 170 -160 190 {lab=sub}
N -220 190 -160 190 {lab=sub}
N -150 170 -150 210 {lab=vss}
N -220 210 -150 210 {lab=vss}
N -120 130 -40 130 {lab=#net3}
N -220 120 -190 120 {lab=otype}
N -110 -190 -110 -160 {lab=en_neg}
N -130 -160 -110 -160 {lab=en_neg}
N -220 140 -210 140 {lab=en_neg}
N -210 130 -210 140 {lab=en_neg}
N -210 130 -190 130 {lab=en_neg}
C {iopin.sym} 220 130 0 0 {name=p2 lab=pgate
}
C {hm_stdcells/sg13cmos5l_LevelUp_noptap.sym} 160 130 0 0 {name=x1}
C {hm_stdcells/sg13cmos5l_LevelUp_noptap.sym} 200 -160 0 0 {name=x2}
C {iopin.sym} 260 -160 0 0 {name=p7 lab=ngate
}
C {lab_pin.sym} -60 120 0 0 {name=p8 sig_type=std_logic lab=core}
C {hm_stdcells/sg13g2_io_inv_x1_noptap.sym} -160 -160 0 0 {name=x3}
C {hm_stdcells/sg13g2_io_nand2_x1_noptap.sym} 0 130 0 0 {name=x4}
C {hm_stdcells/sg13g2_io_nor2_x1_noptap.sym} 20 -160 0 0 {name=x5}
C {hm_stdcells/sg13g2_io_tie_noptap.sym} 360 130 0 0 {name=x6}
C {iopin.sym} -220 -240 0 1 {name=p9 lab=iovdd
}
C {iopin.sym} -220 -80 0 1 {name=p10 lab=vss
}
C {iopin.sym} -220 -160 0 1 {name=p12 lab=en
}
C {iopin.sym} -220 -220 0 1 {name=p13 lab=vdd
}
C {iopin.sym} -220 -100 0 1 {name=p14 lab=sub
}
C {sg13g2_pr/ptap1.sym} -190 -50 0 0 {name=R2
model=ptap1
spiceprefix=X
w=1.54e-6
l=1.54e-6
lvs_format="tcleval(@name @pinlist @model A=3.0195p P=21.93u )"
}
C {lab_pin.sym} -220 50 0 0 {name=p1 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -220 70 0 0 {name=p3 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -220 190 0 0 {name=p4 sig_type=std_logic lab=sub}
C {lab_pin.sym} -220 210 0 0 {name=p5 sig_type=std_logic lab=vss}
C {iopin.sym} -40 -170 0 1 {name=p11 lab=core
}
C {lab_pin.sym} -220 140 0 0 {name=p15 sig_type=std_logic lab=en_neg}
C {iopin.sym} -220 120 0 1 {name=p6 lab=otype
}
C {hm_stdcells/sg13g2_io_nor2_x1_noptap.sym} -150 130 0 0 {name=x7}
C {lab_pin.sym} -110 -190 2 0 {name=p16 sig_type=std_logic lab=en_neg}
