v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 280 -90 280 {lab=!}
N 260 280 280 280 {lab=!}
N -90 160 -90 220 {lab=vss}
N 260 140 260 280 {lab=!}
N 280 180 280 220 {lab=iovss}
N 230 180 280 180 {lab=iovss}
N -130 160 -90 160 {lab=vss}
N -110 140 -110 280 {lab=!}
N -140 140 -110 140 {lab=!}
N 230 100 230 180 {lab=iovss}
N 180 180 230 180 {lab=iovss}
N 220 20 240 20 {lab=pad}
N 220 -20 240 -20 {lab=pad}
N 230 -140 230 -100 {lab=iovdd}
N 130 -140 230 -140 {lab=iovdd}
N 220 10 220 20 {lab=pad}
N 210 0 220 -10 {lab=pad}
N 220 -20 220 -10 {lab=pad}
N 220 10 230 0 {lab=pad}
N 270 50 290 50 {lab=iovdd}
N 290 -140 290 50 {lab=iovdd}
N 270 -70 280 -70 {lab=!}
N 270 70 280 70 {lab=!}
N 280 -50 280 70 {lab=!}
N 270 -50 280 -50 {lab=!}
N 280 -70 280 -50 {lab=!}
N 210 0 230 0 {lab=pad}
N 280 70 280 140 {lab=!}
N 260 140 280 140 {lab=!}
N 90 -70 90 -10 {lab=#net1}
N 90 0 90 80 {lab=#net2}
N 120 120 120 140 {lab=!}
N -60 140 120 140 {lab=!}
N 130 120 130 180 {lab=iovss}
N -40 180 130 180 {lab=iovss}
N 120 -30 120 50 {lab=!}
N 120 50 170 50 {lab=!}
N 170 50 170 140 {lab=!}
N 120 140 170 140 {lab=!}
N 130 -30 130 40 {lab=iovss}
N 130 40 180 40 {lab=iovss}
N 180 40 180 180 {lab=iovss}
N 130 180 180 180 {lab=iovss}
N 130 -140 130 -110 {lab=iovdd}
N 230 0 340 -0 {lab=pad}
N 160 0 210 0 {lab=pad}
N 230 -140 290 -140 {lab=iovdd}
N -140 40 -140 140 {lab=!}
N -190 140 -140 140 {lab=!}
N -130 40 -130 160 {lab=vss}
N -190 160 -130 160 {lab=vss}
N -130 -120 -130 -40 {lab=vdd}
N -190 -120 -130 -120 {lab=vdd}
N -120 -140 -120 -40 {lab=iovdd1}
N -190 -140 -120 -140 {lab=iovdd1}
N 170 140 260 140 {lab=!}
N -190 -10 -170 -10 {lab=c2p}
N -190 0 -190 10 {lab=c2p_en}
N -190 0 -170 0 {lab=c2p_en}
N -90 -10 90 -10 {lab=#net1}
N -90 0 90 0 {lab=#net2}
N 160 0 160 20 {lab=pad}
N -10 20 -10 80 {lab=pad}
N -10 20 160 20 {lab=pad}
N -50 -120 -50 40 {lab=vdd}
N -130 -120 -50 -120 {lab=vdd}
N -40 -140 -40 40 {lab=iovdd1}
N -120 -140 -40 -140 {lab=iovdd1}
N -60 120 -60 140 {lab=!}
N -110 140 -60 140 {lab=!}
N -50 120 -50 160 {lab=vss}
N -90 160 -50 160 {lab=vss}
N -40 120 -40 180 {lab=iovss}
N -190 180 -40 180 {lab=iovss}
N -190 80 -90 80 {lab=p2c}
N 160 -60 160 0 {lab=pad}
N 160 20 160 70 {lab=pad}
N -190 30 -180 30 {lab=otype}
N -180 10 -180 30 {lab=otype}
N -180 10 -170 10 {lab=otype}
N 420 -20 440 -20 {lab=PU}
N 420 20 440 20 {lab=PD}
N -50 -120 480 -120 {lab=vdd}
N 480 -120 480 -60 {lab=vdd}
N -50 160 480 160 {lab=vss}
N 480 60 480 160 {lab=vss}
N 280 140 520 140 {lab=!}
N 520 60 520 140 {lab=!}
N 560 -20 600 -20 {lab=pu_en}
N 560 20 600 20 {lab=pd_en}
N -40 -160 -40 -140 {lab=iovdd1}
N -40 -160 520 -160 {lab=iovdd1}
N 520 -160 520 -60 {lab=iovdd1}
N 650 -160 650 -40 {lab=iovdd1}
N 520 -160 650 -160 {lab=iovdd1}
N 520 140 650 140 {lab=!}
N 650 40 650 140 {lab=!}
N 480 160 670 160 {lab=vss}
N 670 40 670 160 {lab=vss}
N 740 0 760 0 {lab=pad}
N 340 -0 340 90 {lab=pad}
N 340 90 740 90 {lab=pad}
N 740 0 740 90 {lab=pad}
N 700 0 740 0 {lab=pad}
C {iopin.sym} -190 -140 0 1 {name=p9 lab=iovdd1
}
C {iopin.sym} -190 160 0 1 {name=p10 lab=vss
}
C {iopin.sym} -190 -120 0 1 {name=p13 lab=vdd
}
C {iopin.sym} -190 140 0 1 {name=p14 lab=!
}
C {sg13g2_pr/ptap1.sym} -90 250 0 0 {name=R2
model=ptap1
spiceprefix=X
w=4.9e-6
l=4.9e-6
lvs_format="tcleval(@name @pinlist @model A=21.972p P=144.68u )"
}
C {iopin.sym} -190 180 0 1 {name=p1 lab=iovss
}
C {sg13g2_pr/ptap1.sym} 280 250 0 0 {name=R1
model=ptap1
spiceprefix=X
w=66.51e-6
l=66.51e-6
lvs_format="tcleval(@name @pinlist @model A=4422.9752p P=996.1u)"
}
C {iopin.sym} 130 -140 0 1 {name=p2 lab=iovdd
}
C {iopin.sym} 760 0 0 0 {name=p3 lab=pad
}
C {iopin.sym} -190 10 0 1 {name=p4 lab=c2p_en
}
C {iopin.sym} -190 -10 0 1 {name=p5 lab=c2p
}
C {iopin.sym} -190 80 0 1 {name=p6 lab=p2c
}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_LevelDown.sym} -50 80 0 1 {name=x3}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_Clamp_P15N15D.sym} 130 -70 0 1 {name=x5}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_DCPDiode.sym} 230 -60 0 0 {name=x6}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_DCNDiode.sym} 230 60 0 0 {name=x2}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/sg13cmos5l_Clamp_N15N15D.sym} 130 80 0 1 {name=x1}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/hm_GateDecode_OpenDrain_noptap.sym} -130 0 0 0 {name=x4}
C {iopin.sym} -190 30 0 1 {name=p7 lab=otype
}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/hm_PUPD_decoder.sym} 500 0 0 0 {name=x7}
C {iopin.sym} 420 -20 0 1 {name=p8 lab=PU
}
C {iopin.sym} 420 20 0 1 {name=p11 lab=PD
}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_stdcells/hm_PUPD_noptap.sym} 650 0 0 0 {name=x8}
C {lab_pin.sym} 580 -20 1 0 {name=p30 sig_type=std_logic lab=pu_en}
C {lab_pin.sym} 580 20 3 0 {name=p12 sig_type=std_logic lab=pd_en}
