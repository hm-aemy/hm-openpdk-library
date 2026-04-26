v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -190 160 -170 160 {lab=!}
N 180 160 200 160 {lab=!}
N -170 40 -170 100 {lab=vss}
N 180 20 180 160 {lab=!}
N 200 60 200 100 {lab=iovss}
N 150 60 200 60 {lab=iovss}
N -210 40 -170 40 {lab=vss}
N -190 20 -190 160 {lab=!}
N -220 20 -190 20 {lab=!}
N 150 -20 150 60 {lab=iovss}
N 100 60 150 60 {lab=iovss}
N 140 -100 160 -100 {lab=#net1}
N 140 -140 160 -140 {lab=#net1}
N 150 -260 150 -220 {lab=iovdd}
N 50 -260 150 -260 {lab=iovdd}
N 140 -110 140 -100 {lab=#net1}
N 130 -120 140 -130 {lab=#net1}
N 140 -140 140 -130 {lab=#net1}
N 140 -110 150 -120 {lab=#net1}
N 190 -70 210 -70 {lab=iovdd}
N 210 -260 210 -70 {lab=iovdd}
N 190 -190 200 -190 {lab=!}
N 190 -50 200 -50 {lab=!}
N 200 -170 200 -50 {lab=!}
N 190 -170 200 -170 {lab=!}
N 200 -190 200 -170 {lab=!}
N 130 -120 150 -120 {lab=#net1}
N 200 -50 200 20 {lab=!}
N 180 20 200 20 {lab=!}
N 10 -190 10 -130 {lab=#net2}
N 10 -120 10 -40 {lab=#net3}
N 40 0 40 20 {lab=!}
N -140 20 40 20 {lab=!}
N 50 0 50 60 {lab=iovss}
N -120 60 50 60 {lab=iovss}
N 40 -150 40 -70 {lab=!}
N 40 -70 90 -70 {lab=!}
N 90 -70 90 20 {lab=!}
N 40 20 90 20 {lab=!}
N 50 -150 50 -80 {lab=iovss}
N 50 -80 100 -80 {lab=iovss}
N 100 -80 100 60 {lab=iovss}
N 50 60 100 60 {lab=iovss}
N 50 -260 50 -230 {lab=iovdd}
N 80 -120 130 -120 {lab=#net1}
N 150 -260 210 -260 {lab=iovdd}
N -220 -80 -220 20 {lab=!}
N -270 20 -220 20 {lab=!}
N -210 -80 -210 40 {lab=vss}
N -270 40 -210 40 {lab=vss}
N -210 -240 -210 -160 {lab=vdd}
N -270 -240 -210 -240 {lab=vdd}
N -200 -260 -200 -160 {lab=iovdd1}
N -270 -260 -200 -260 {lab=iovdd1}
N 90 20 180 20 {lab=!}
N -270 -130 -250 -130 {lab=c2p}
N -270 -120 -270 -110 {lab=c2p_en}
N -270 -120 -250 -120 {lab=c2p_en}
N -170 -130 10 -130 {lab=#net2}
N -170 -120 10 -120 {lab=#net3}
N 80 -120 80 -100 {lab=#net1}
N -90 -100 -90 -40 {lab=#net1}
N -90 -100 80 -100 {lab=#net1}
N -130 -240 -130 -80 {lab=vdd}
N -210 -240 -130 -240 {lab=vdd}
N -120 -260 -120 -80 {lab=iovdd1}
N -200 -260 -120 -260 {lab=iovdd1}
N -140 0 -140 20 {lab=!}
N -190 20 -140 20 {lab=!}
N -130 0 -130 40 {lab=vss}
N -170 40 -130 40 {lab=vss}
N -120 0 -120 60 {lab=iovss}
N -270 60 -120 60 {lab=iovss}
N -270 -40 -170 -40 {lab=p2c}
N 80 -180 80 -120 {lab=#net1}
N 80 -100 80 -50 {lab=#net1}
N -270 -80 -250 -80 {lab=otype}
N -250 -110 -250 -80 {lab=otype}
N 150 -120 340 -120 {lab=#net1}
N 440 -120 460 -120 {lab=pad}
N 210 -260 390 -260 {lab=iovdd}
N 200 20 400 20 {lab=!}
N 400 -80 400 20 {lab=!}
N 200 60 380 60 {lab=iovss}
N 380 -80 380 60 {lab=iovss}
N 300 -140 340 -140 {lab=pu_en}
N 300 -100 340 -100 {lab=pd_en}
N 390 -260 390 -160 {lab=iovdd}
C {iopin.sym} -270 -260 0 1 {name=p9 lab=iovdd1
}
C {iopin.sym} -270 40 0 1 {name=p10 lab=vss
}
C {iopin.sym} -270 -240 0 1 {name=p13 lab=vdd
}
C {iopin.sym} -270 20 0 1 {name=p14 lab=!
}
C {sg13g2_pr/ptap1.sym} -170 130 0 0 {name=R2
model=ptap1
spiceprefix=X
w=4.9e-6
l=4.9e-6
lvs_format="tcleval(@name @pinlist @model A=24p P=160.6u )"
}
C {iopin.sym} -270 60 0 1 {name=p1 lab=iovss
}
C {sg13g2_pr/ptap1.sym} 200 130 0 0 {name=R1
model=ptap1
spiceprefix=X
w=66.51e-6
l=66.51e-6
lvs_format="tcleval(@name @pinlist @model A=4422.9752p P=996.1u)"
}
C {iopin.sym} 50 -260 0 1 {name=p2 lab=iovdd
}
C {iopin.sym} 460 -120 0 0 {name=p3 lab=pad
}
C {iopin.sym} -270 -110 0 1 {name=p4 lab=c2p_en
}
C {hm_stdcells/sg13g2_DCPDiode_noptap.sym} 150 -180 0 0 {name=x2}
C {hm_stdcells/sg13g2_DCNDiode.sym} 150 -60 0 0 {name=x1}
C {hm_stdcells/sg13g2_Clamp_N15N15D.sym} 50 -40 0 1 {name=x4}
C {hm_stdcells/sg13g2_Clamp_P15N15D_noptap.sym} 50 -190 0 1 {name=x5}
C {iopin.sym} -270 -130 0 1 {name=p5 lab=c2p
}
C {hm_stdcells/sg13g2_LevelDown_noptap.sym} -130 -40 0 1 {name=x6}
C {iopin.sym} -270 -40 0 1 {name=p6 lab=p2c
}
C {iopin.sym} -270 -80 0 1 {name=p7 lab=otype
}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/hm_GateDecode_OpenDrain_noptap.sym} -210 -120 0 0 {name=x3}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/hm_PUPD_noptap.sym} 390 -120 0 0 {name=x7}
C {iopin.sym} 300 -140 0 1 {name=p8 lab=pu_en
}
C {iopin.sym} 300 -100 0 1 {name=p11 lab=pd_en
}
