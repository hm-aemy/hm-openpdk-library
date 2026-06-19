v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -170 -130 -140 -130 {lab=pu_neg}
N -290 220 -260 220 {lab=pd}
N -190 220 -170 220 {lab=pd_neg}
N -160 -110 -140 -110 {lab=pd_neg}
N -160 40 -140 40 {lab=pd_neg}
N -290 -130 -260 -130 {lab=pu}
N 180 50 220 50 {lab=#net1}
N 290 50 310 50 {lab=#net2}
N -60 40 -30 40 {lab=xor_output}
N -60 -120 -30 -120 {lab=xor_output}
N 180 -110 210 -110 {lab=#net3}
N 150 0 150 10 {lab=vdd}
N 150 0 260 0 {lab=vdd}
N 260 0 260 10 {lab=vdd}
N 150 90 150 100 {lab=vss}
N 150 100 260 100 {lab=vss}
N 260 90 260 100 {lab=vss}
N 140 90 140 120 {lab=sub}
N 250 90 250 120 {lab=sub}
N -220 -180 -220 -170 {lab=vdd}
N -100 -180 150 -180 {lab=vdd}
N 150 -180 150 -150 {lab=vdd}
N -100 -180 -100 -150 {lab=vdd}
N -220 -180 -100 -180 {lab=vdd}
N 150 -180 250 -180 {lab=vdd}
N 250 -180 250 -150 {lab=vdd}
N 260 -200 260 -150 {lab=iovdd}
N 260 0 350 0 {lab=vdd}
N 350 0 350 10 {lab=vdd}
N 360 -20 360 10 {lab=iovdd}
N 260 100 350 100 {lab=vss}
N 350 90 350 100 {lab=vss}
N 340 90 340 120 {lab=sub}
N 390 50 410 50 {lab=pd_en}
N 290 -110 310 -110 {lab=pu_en}
N 250 -70 250 -60 {lab=vss}
N 150 -60 250 -60 {lab=vss}
N 150 -70 150 -60 {lab=vss}
N -110 -60 150 -60 {lab=vss}
N -220 -90 -220 -60 {lab=vss}
N 240 -70 240 -40 {lab=sub}
N 140 -70 140 -40 {lab=sub}
N -240 -60 -220 -60 {lab=vss}
N -100 0 150 0 {lab=vdd}
N -100 0 -100 10 {lab=vdd}
N 30 -110 30 50 {lab=xor_output}
N -30 -120 30 -120 {lab=xor_output}
N -30 -120 -30 40 {lab=xor_output}
N -160 -110 -160 40 {lab=pd_neg}
N -240 -200 260 -200 {lab=iovdd}
N -240 -180 -220 -180 {lab=vdd}
N -240 -0 -100 0 {lab=vdd}
N -240 -20 360 -20 {lab=iovdd}
N 140 -40 240 -40 {lab=sub}
N -230 -90 -230 -40 {lab=sub}
N -240 -40 -230 -40 {lab=sub}
N -90 -40 140 -40 {lab=sub}
N -110 100 150 100 {lab=vss}
N 250 120 340 120 {lab=sub}
N 140 120 250 120 {lab=sub}
N -90 120 140 120 {lab=sub}
N -240 40 -160 40 {lab=pd_neg}
N -240 20 -230 20 {lab=pu}
N -230 20 -230 30 {lab=pu}
N -230 30 -140 30 {lab=pu}
N -170 50 -140 50 {lab=pd}
N -230 50 -230 60 {lab=pd}
N -240 60 -230 60 {lab=pd}
N -240 170 -220 170 {lab=vdd}
N -220 170 -220 180 {lab=vdd}
N -240 280 -220 280 {lab=vss}
N -220 260 -220 280 {lab=vss}
N -240 300 -230 300 {lab=sub}
N -230 260 -230 300 {lab=sub}
N -170 -120 -140 -120 {lab=pd}
N -170 -120 -170 50 {lab=pd}
N -230 50 -170 50 {lab=pd}
N -30 -140 -30 -120 {lab=xor_output}
N 350 0 540 0 {lab=vdd}
N 540 0 540 10 {lab=vdd}
N 340 120 530 120 {lab=sub}
N 530 90 530 120 {lab=sub}
N 350 100 540 100 {lab=vss}
N 540 90 540 100 {lab=vss}
N 80 190 110 190 {lab=vss}
N 80 250 110 250 {lab=sub}
N -90 -90 -90 -40 {lab=sub}
N -230 -40 -90 -40 {lab=sub}
N -90 70 -90 120 {lab=sub}
N -240 120 -90 120 {lab=sub}
N -110 70 -110 100 {lab=vss}
N -240 100 -110 100 {lab=vss}
N -110 -90 -110 -60 {lab=vss}
N -220 -60 -110 -60 {lab=vss}
N -170 -150 -170 -130 {lab=pu_neg}
N -190 -130 -170 -130 {lab=pu_neg}
N 30 -110 110 -110 {lab=xor_output}
N 30 -120 30 -110 {lab=xor_output}
N 90 -120 110 -120 {lab=pu}
N 30 50 110 50 {lab=xor_output}
N 90 40 110 40 {lab=pd}
C {hm_stdcells/sg13g2_io_inv_x1_noptap.sym} -220 -130 0 0 {name=x9}
C {hm_stdcells/sg13g2_io_nand2_x1_noptap.sym} 150 -110 0 0 {name=x10}
C {hm_stdcells/sg13g2_io_nand2_x1_noptap.sym} 150 50 0 0 {name=x11}
C {iopin.sym} -290 -130 0 1 {name=p12 lab=pu
}
C {iopin.sym} -290 220 0 1 {name=p15 lab=pd
}
C {hm_stdcells/sg13g2_io_inv_x1_noptap.sym} -220 220 0 0 {name=x12}
C {lab_pin.sym} -170 220 2 0 {name=p8 sig_type=std_logic lab=pd_neg}
C {lab_pin.sym} -240 60 0 0 {name=p11 sig_type=std_logic lab=pd}
C {lab_pin.sym} -240 40 0 0 {name=p16 sig_type=std_logic lab=pd_neg}
C {lab_pin.sym} 90 40 0 0 {name=p17 sig_type=std_logic lab=pd}
C {lab_pin.sym} 90 -120 0 0 {name=p18 sig_type=std_logic lab=pu}
C {hm_stdcells/sg13g2_io_inv_x1_noptap.sym} 260 50 0 0 {name=x14}
C {lab_pin.sym} -240 170 0 0 {name=p22 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -240 100 0 0 {name=p25 sig_type=std_logic lab=vss}
C {lab_pin.sym} -240 120 0 0 {name=p26 sig_type=std_logic lab=sub}
C {lab_pin.sym} -240 0 0 0 {name=p27 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -240 280 0 0 {name=p28 sig_type=std_logic lab=vss}
C {lab_pin.sym} -240 300 0 0 {name=p29 sig_type=std_logic lab=sub}
C {hm_stdcells/sg13g2_LevelUp_noptap.sym} 250 -110 0 0 {name=x15}
C {hm_stdcells/sg13g2_LevelUp_noptap.sym} 350 50 0 0 {name=x16}
C {lab_pin.sym} -240 -20 0 0 {name=p36 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -240 20 0 0 {name=p1 sig_type=std_logic lab=pu}
C {iopin.sym} -240 -200 0 1 {name=p2 lab=iovdd
}
C {iopin.sym} -240 -180 0 1 {name=p3 lab=vdd
}
C {iopin.sym} -240 -60 0 1 {name=p4 lab=vss
}
C {iopin.sym} -240 -40 0 1 {name=p5 lab=sub
}
C {iopin.sym} 310 -110 2 1 {name=p6 lab=pu_en
}
C {iopin.sym} 410 50 2 1 {name=p7 lab=pd_en
}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/sg13g2_io_tie_noptap.sym} 540 50 0 0 {name=x1}
C {sg13g2_pr/ptap1.sym} 110 220 0 0 {name=R2
model=ptap1
spiceprefix=X
w=1.54e-6
l=1.54e-6
lvs_format="tcleval(@name @pinlist @model A=3.8115p P=29.01u )"
}
C {lab_pin.sym} 80 190 0 0 {name=p9 sig_type=std_logic lab=vss}
C {lab_pin.sym} 80 250 0 0 {name=p10 sig_type=std_logic lab=sub}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/hm_Tgate_noptap.sym} -100 -120 0 0 {name=x2}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/hm_Tgate_noptap.sym} -100 40 0 0 {name=x3}
C {lab_pin.sym} -30 -140 2 0 {name=p13 sig_type=std_logic lab=xor_output}
C {lab_pin.sym} -170 -150 2 0 {name=p14 sig_type=std_logic lab=pu_neg}
