v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -260 240 -240 240 {lab=!}
N 110 240 130 240 {lab=!}
N -240 120 -240 180 {lab=vss}
N 110 100 110 240 {lab=!}
N 130 140 130 180 {lab=iovss}
N 80 140 130 140 {lab=iovss}
N -280 120 -240 120 {lab=vss}
N -260 100 -260 240 {lab=!}
N -290 100 -260 100 {lab=!}
N 80 60 80 140 {lab=iovss}
N 30 140 80 140 {lab=iovss}
N 70 -20 90 -20 {lab=pad}
N 70 -60 90 -60 {lab=pad}
N 80 -180 80 -140 {lab=iovdd}
N -20 -180 80 -180 {lab=iovdd}
N 70 -30 70 -20 {lab=pad}
N 60 -40 70 -50 {lab=pad}
N 70 -60 70 -50 {lab=pad}
N 70 -30 80 -40 {lab=pad}
N 120 10 140 10 {lab=iovdd}
N 140 -180 140 10 {lab=iovdd}
N 120 -110 130 -110 {lab=!}
N 120 30 130 30 {lab=!}
N 130 -90 130 30 {lab=!}
N 120 -90 130 -90 {lab=!}
N 130 -110 130 -90 {lab=!}
N 60 -40 80 -40 {lab=pad}
N 130 30 130 100 {lab=!}
N 110 100 130 100 {lab=!}
N -60 -110 -60 -50 {lab=#net1}
N -60 -40 -60 40 {lab=#net2}
N -30 80 -30 100 {lab=!}
N -210 100 -30 100 {lab=!}
N -20 80 -20 140 {lab=iovss}
N -190 140 -20 140 {lab=iovss}
N -30 -70 -30 10 {lab=!}
N -30 10 20 10 {lab=!}
N 20 10 20 100 {lab=!}
N -30 100 20 100 {lab=!}
N -20 -70 -20 0 {lab=iovss}
N -20 0 30 0 {lab=iovss}
N 30 0 30 140 {lab=iovss}
N -20 140 30 140 {lab=iovss}
N -20 -180 -20 -150 {lab=iovdd}
N 10 -40 60 -40 {lab=pad}
N 80 -180 140 -180 {lab=iovdd}
N -290 0 -290 100 {lab=!}
N -340 100 -290 100 {lab=!}
N -280 0 -280 120 {lab=vss}
N -340 120 -280 120 {lab=vss}
N -280 -160 -280 -80 {lab=vdd}
N -340 -160 -280 -160 {lab=vdd}
N -270 -180 -270 -80 {lab=iovdd1}
N -340 -180 -270 -180 {lab=iovdd1}
N 20 100 110 100 {lab=!}
N -340 -50 -320 -50 {lab=c2p}
N -340 -40 -340 -30 {lab=c2p_en}
N -340 -40 -320 -40 {lab=c2p_en}
N -240 -50 -60 -50 {lab=#net1}
N -240 -40 -60 -40 {lab=#net2}
N 10 -40 10 -20 {lab=pad}
N -160 -20 -160 40 {lab=pad}
N -160 -20 10 -20 {lab=pad}
N -200 -160 -200 0 {lab=vdd}
N -280 -160 -200 -160 {lab=vdd}
N -190 -180 -190 0 {lab=iovdd1}
N -270 -180 -190 -180 {lab=iovdd1}
N -210 80 -210 100 {lab=!}
N -260 100 -210 100 {lab=!}
N -200 80 -200 120 {lab=vss}
N -240 120 -200 120 {lab=vss}
N -190 80 -190 140 {lab=iovss}
N -340 140 -190 140 {lab=iovss}
N -340 40 -240 40 {lab=p2c}
N 10 -100 10 -40 {lab=pad}
N 10 -20 10 30 {lab=pad}
N -340 0 -320 0 {lab=otype}
N -320 -30 -320 0 {lab=otype}
N 380 -40 390 -40 {lab=pad}
N 140 -180 320 -180 {lab=iovdd}
N 130 100 330 100 {lab=!}
N 330 0 330 100 {lab=!}
N 130 140 310 140 {lab=iovss}
N 310 0 310 140 {lab=iovss}
N 230 -60 270 -60 {lab=pu_en}
N 230 -20 270 -20 {lab=pd_en}
N 320 -180 320 -80 {lab=iovdd}
N 80 -40 250 -40 {lab=pad}
N 250 -40 250 30 {lab=pad}
N 250 30 380 30 {lab=pad}
N 380 -40 380 30 {lab=pad}
N 370 -40 380 -40 {lab=pad}
C {iopin.sym} -340 -180 0 1 {name=p9 lab=iovdd1
}
C {iopin.sym} -340 120 0 1 {name=p10 lab=vss
}
C {iopin.sym} -340 -160 0 1 {name=p13 lab=vdd
}
C {iopin.sym} -340 100 0 1 {name=p14 lab=!
}
C {sg13g2_pr/ptap1.sym} -240 210 0 0 {name=R2
model=ptap1
spiceprefix=X
w=4.9e-6
l=4.9e-6
lvs_format="tcleval(@name @pinlist @model A=24p P=160.6u )"
}
C {iopin.sym} -340 140 0 1 {name=p1 lab=iovss
}
C {sg13g2_pr/ptap1.sym} 130 210 0 0 {name=R1
model=ptap1
spiceprefix=X
w=66.51e-6
l=66.51e-6
lvs_format="tcleval(@name @pinlist @model A=4422.9752p P=996.1u)"
}
C {iopin.sym} -20 -180 0 1 {name=p2 lab=iovdd
}
C {iopin.sym} 390 -40 0 0 {name=p3 lab=pad
}
C {iopin.sym} -340 -30 0 1 {name=p4 lab=c2p_en
}
C {hm_stdcells/sg13g2_DCPDiode_noptap.sym} 80 -100 0 0 {name=x2}
C {hm_stdcells/sg13g2_DCNDiode.sym} 80 20 0 0 {name=x1}
C {hm_stdcells/sg13g2_Clamp_N15N15D.sym} -20 40 0 1 {name=x4}
C {hm_stdcells/sg13g2_Clamp_P15N15D_noptap.sym} -20 -110 0 1 {name=x5}
C {iopin.sym} -340 -50 0 1 {name=p5 lab=c2p
}
C {hm_stdcells/sg13g2_LevelDown_noptap.sym} -200 40 0 1 {name=x6}
C {iopin.sym} -340 40 0 1 {name=p6 lab=p2c
}
C {iopin.sym} -340 0 0 1 {name=p7 lab=otype
}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/hm_GateDecode_OpenDrain_noptap.sym} -280 -40 0 0 {name=x3}
C {iopin.sym} 230 -60 0 1 {name=p8 lab=pu_en
}
C {iopin.sym} 230 -20 0 1 {name=p11 lab=pd_en
}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/hm_PUPD_noptap.sym} 320 -40 0 0 {name=x7}
