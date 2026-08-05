v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 40 -100 40 {lab=!}
N 250 40 270 40 {lab=!}
N -100 -80 -100 -20 {lab=vss}
N 250 -100 250 40 {lab=!}
N 270 -60 270 -20 {lab=iovss}
N 220 -60 270 -60 {lab=iovss}
N -140 -80 -100 -80 {lab=vss}
N -120 -100 -120 40 {lab=!}
N -150 -100 -120 -100 {lab=!}
N 220 -140 220 -60 {lab=iovss}
N 170 -60 220 -60 {lab=iovss}
N 210 -220 230 -220 {lab=pad}
N 210 -260 230 -260 {lab=pad}
N 220 -380 220 -340 {lab=iovdd}
N 120 -380 220 -380 {lab=iovdd}
N 210 -230 210 -220 {lab=pad}
N 200 -240 210 -250 {lab=pad}
N 210 -260 210 -250 {lab=pad}
N 210 -230 220 -240 {lab=pad}
N 260 -190 280 -190 {lab=iovdd}
N 280 -380 280 -190 {lab=iovdd}
N 260 -310 270 -310 {lab=!}
N 260 -170 270 -170 {lab=!}
N 270 -290 270 -170 {lab=!}
N 260 -290 270 -290 {lab=!}
N 270 -310 270 -290 {lab=!}
N 200 -240 220 -240 {lab=pad}
N 270 -170 270 -100 {lab=!}
N 250 -100 270 -100 {lab=!}
N 80 -310 80 -250 {lab=#net1}
N 80 -240 80 -160 {lab=#net2}
N 110 -120 110 -100 {lab=!}
N -70 -100 110 -100 {lab=!}
N 120 -120 120 -60 {lab=iovss}
N -50 -60 120 -60 {lab=iovss}
N 110 -270 110 -190 {lab=!}
N 110 -190 160 -190 {lab=!}
N 160 -190 160 -100 {lab=!}
N 110 -100 160 -100 {lab=!}
N 120 -270 120 -200 {lab=iovss}
N 120 -200 170 -200 {lab=iovss}
N 170 -200 170 -60 {lab=iovss}
N 120 -60 170 -60 {lab=iovss}
N 120 -380 120 -350 {lab=iovdd}
N 220 -240 300 -240 {lab=pad}
N 150 -240 200 -240 {lab=pad}
N 220 -380 280 -380 {lab=iovdd}
N -150 -200 -150 -100 {lab=!}
N -200 -100 -150 -100 {lab=!}
N -140 -200 -140 -80 {lab=vss}
N -200 -80 -140 -80 {lab=vss}
N -140 -360 -140 -280 {lab=vdd}
N -200 -360 -140 -360 {lab=vdd}
N -130 -380 -130 -280 {lab=iovdd1}
N -200 -380 -130 -380 {lab=iovdd1}
N 160 -100 250 -100 {lab=!}
N -200 -250 -180 -250 {lab=c2p}
N -200 -240 -200 -230 {lab=c2p_en}
N -200 -240 -180 -240 {lab=c2p_en}
N -100 -250 80 -250 {lab=#net1}
N -100 -240 80 -240 {lab=#net2}
N 150 -240 150 -220 {lab=pad}
N -20 -220 -20 -160 {lab=pad}
N -20 -220 150 -220 {lab=pad}
N -60 -360 -60 -200 {lab=vdd}
N -140 -360 -60 -360 {lab=vdd}
N -50 -380 -50 -200 {lab=iovdd1}
N -130 -380 -50 -380 {lab=iovdd1}
N -70 -120 -70 -100 {lab=!}
N -120 -100 -70 -100 {lab=!}
N -60 -120 -60 -80 {lab=vss}
N -100 -80 -60 -80 {lab=vss}
N -50 -120 -50 -60 {lab=iovss}
N -200 -60 -50 -60 {lab=iovss}
N -200 -160 -100 -160 {lab=p2c}
N 150 -300 150 -240 {lab=pad}
N 150 -220 150 -170 {lab=pad}
C {iopin.sym} -200 -380 0 1 {name=p9 lab=iovdd1
}
C {iopin.sym} -200 -80 0 1 {name=p10 lab=vss
}
C {iopin.sym} -200 -360 0 1 {name=p13 lab=vdd
}
C {iopin.sym} -200 -100 0 1 {name=p14 lab=!
}
C {sg13g2_pr/ptap1.sym} -100 10 0 0 {name=R2
model=ptap1
spiceprefix=X
w=4.9e-6
l=4.9e-6
lvs_format="tcleval(@name @pinlist @model A=21.972p P=144.68u )"
}
C {iopin.sym} -200 -60 0 1 {name=p1 lab=iovss
}
C {sg13g2_pr/ptap1.sym} 270 10 0 0 {name=R1
model=ptap1
spiceprefix=X
w=66.51e-6
l=66.51e-6
lvs_format="tcleval(@name @pinlist @model A=4422.9752p P=996.1u)"
}
C {iopin.sym} 120 -380 0 1 {name=p2 lab=iovdd
}
C {iopin.sym} 300 -240 0 0 {name=p3 lab=pad
}
C {iopin.sym} -200 -230 0 1 {name=p4 lab=c2p_en
}
C {iopin.sym} -200 -250 0 1 {name=p5 lab=c2p
}
C {iopin.sym} -200 -160 0 1 {name=p6 lab=p2c
}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_GateDecode.sym} -140 -240 0 0 {name=x7}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_LevelDown.sym} -60 -160 0 1 {name=x3}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_Clamp_P15N15D.sym} 120 -310 0 1 {name=x5}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_DCPDiode.sym} 220 -300 0 0 {name=x6}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_DCNDiode.sym} 220 -180 0 0 {name=x2}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_Clamp_N15N15D.sym} 120 -160 0 1 {name=x1}
