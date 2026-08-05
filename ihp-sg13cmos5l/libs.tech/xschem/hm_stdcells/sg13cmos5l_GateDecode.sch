v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 80 220 80 {lab=vss}
N 60 0 80 0 {lab=pgate}
N 260 -300 280 -300 {lab=ngate}
N 20 -60 220 -60 {lab=vdd}
N 20 -60 20 -40 {lab=vdd}
N 30 -80 30 -40 {lab=iovdd}
N 10 60 210 60 {lab=sub}
N 10 40 10 60 {lab=sub}
N 20 40 20 80 {lab=vss}
N 220 -360 220 -340 {lab=vdd}
N 230 -380 230 -340 {lab=iovdd}
N 210 -260 210 -240 {lab=sub}
N 220 -260 220 -220 {lab=vss}
N -200 60 -150 60 {lab=sub}
N -200 -380 230 -380 {lab=iovdd}
N -200 -220 -140 -220 {lab=vss}
N -200 -300 -180 -300 {lab=en}
N -200 -360 -140 -360 {lab=vdd}
N -140 -360 -140 -340 {lab=vdd}
N -190 -240 -150 -240 {lab=sub}
N -150 -260 -150 -240 {lab=sub}
N -140 -260 -140 -220 {lab=vss}
N 40 -360 220 -360 {lab=vdd}
N 30 -240 210 -240 {lab=sub}
N 40 -220 220 -220 {lab=vss}
N -190 -160 -170 -160 {lab=sub}
N -190 -240 -190 -160 {lab=sub}
N -200 -240 -190 -240 {lab=sub}
N 40 -360 40 -340 {lab=vdd}
N -140 -360 40 -360 {lab=vdd}
N 30 -260 30 -240 {lab=sub}
N -150 -240 30 -240 {lab=sub}
N 40 -260 40 -220 {lab=vss}
N -140 -220 40 -220 {lab=vss}
N -20 -310 -0 -310 {lab=core}
N -110 -300 -0 -300 {lab=#net1}
N 70 -300 180 -300 {lab=#net2}
N -140 -60 -140 -40 {lab=vdd}
N -150 40 -150 60 {lab=sub}
N -140 40 -140 80 {lab=vss}
N -200 0 -180 0 {lab=en}
N -140 -60 20 -60 {lab=vdd}
N -200 -80 30 -80 {lab=iovdd}
N -150 60 10 60 {lab=sub}
N -140 80 20 80 {lab=vss}
N -200 -60 -140 -60 {lab=vdd}
N -200 80 -140 80 {lab=vss}
N -110 -0 -20 0 {lab=#net3}
N 220 -60 220 -40 {lab=vdd}
N 210 40 210 60 {lab=sub}
N 220 40 220 80 {lab=vss}
N -200 -10 -180 -10 {lab=core}
C {iopin.sym} 80 0 0 0 {name=p2 lab=pgate
}
C {iopin.sym} 280 -300 0 0 {name=p7 lab=ngate
}
C {lab_pin.sym} -200 -10 0 0 {name=p8 sig_type=std_logic lab=core}
C {hm_stdcells/sg13g2_io_inv_x1_noptap.sym} -140 -300 0 0 {name=x3}
C {hm_stdcells/sg13g2_io_nand2_x1_noptap.sym} -140 0 0 0 {name=x4}
C {hm_stdcells/sg13g2_io_nor2_x1_noptap.sym} 40 -300 0 0 {name=x5}
C {hm_stdcells/sg13g2_io_tie_noptap.sym} 220 0 0 0 {name=x6}
C {iopin.sym} -200 -380 0 1 {name=p9 lab=iovdd
}
C {iopin.sym} -200 -220 0 1 {name=p10 lab=vss
}
C {iopin.sym} -200 -300 0 1 {name=p12 lab=en
}
C {iopin.sym} -200 -360 0 1 {name=p13 lab=vdd
}
C {iopin.sym} -200 -240 0 1 {name=p14 lab=sub
}
C {sg13g2_pr/ptap1.sym} -170 -190 0 0 {name=R2
model=ptap1
spiceprefix=X
w=1.54e-6
l=1.54e-6
lvs_format="tcleval(@name @pinlist @model A=4.3905p P=32.87u )"
}
C {lab_pin.sym} -200 -80 0 0 {name=p1 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -200 -60 0 0 {name=p3 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -200 60 0 0 {name=p4 sig_type=std_logic lab=sub}
C {lab_pin.sym} -200 80 0 0 {name=p5 sig_type=std_logic lab=vss}
C {iopin.sym} -20 -310 0 1 {name=p11 lab=core
}
C {lab_pin.sym} -200 0 0 0 {name=p15 sig_type=std_logic lab=en}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_LevelUp_noptap.sym} 220 -300 0 0 {name=x7}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_LevelUp_noptap.sym} 20 0 0 0 {name=x1}
