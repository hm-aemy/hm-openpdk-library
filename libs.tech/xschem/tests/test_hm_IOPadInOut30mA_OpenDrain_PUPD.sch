v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -360 170 -360 190 {lab=GND}
N -290 170 -290 190 {lab=GND}
N -220 170 -220 190 {lab=GND}
N -140 170 -140 190 {lab=GND}
N -360 90 -360 110 {lab=vdd}
N -290 90 -290 110 {lab=vss}
N -220 90 -220 110 {lab=iovdd}
N -140 90 -140 110 {lab=iovss}
N -120 -120 -30 -120 {lab=vout}
N -200 -200 -200 -180 {lab=vdd}
N -160 -190 -160 -180 {lab=iovdd}
N -180 -190 -180 -180 {lab=iovdd}
N -180 -190 -160 -190 {lab=iovdd}
N -160 -200 -160 -190 {lab=iovdd}
N -200 -50 -200 -40 {lab=vss}
N -200 -50 -180 -50 {lab=vss}
N -200 -60 -200 -50 {lab=vss}
N -180 -60 -180 -50 {lab=vss}
N -160 -60 -160 -40 {lab=iovss}
N -300 -140 -280 -140 {lab=c2p}
N -280 -140 -280 -130 {lab=c2p}
N -280 -130 -240 -130 {lab=c2p}
N -300 -120 -240 -120 {lab=c2p_en}
N -300 -100 -280 -100 {lab=otype}
N -280 -110 -280 -100 {lab=otype}
N -280 -110 -240 -110 {lab=otype}
N -300 -80 -270 -80 {lab=pu_en}
N -270 -100 -270 -80 {lab=pu_en}
N -270 -100 -240 -100 {lab=pu_en}
N -300 -60 -260 -60 {lab=pd_en}
N -260 -90 -260 -60 {lab=pd_en}
N -260 -90 -240 -90 {lab=pd_en}
N -30 -120 -30 -100 {lab=vout}
N -30 -40 -30 -20 {lab=vss}
C {vsource.sym} -360 140 0 0 {name=Vdd value=1.2 savecurrent=false}
C {gnd.sym} -360 190 0 0 {name=l1 lab=GND}
C {vsource.sym} -290 140 0 0 {name=Vss value=0 savecurrent=false}
C {gnd.sym} -290 190 0 0 {name=l2 lab=GND}
C {vsource.sym} -220 140 0 0 {name=Viovdd value=3.3 savecurrent=false}
C {gnd.sym} -220 190 0 0 {name=l3 lab=GND}
C {vsource.sym} -140 140 0 0 {name=Viovss value=0 savecurrent=false}
C {gnd.sym} -140 190 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -360 90 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -290 90 0 0 {name=p2 sig_type=std_logic lab=vss}
C {lab_pin.sym} -220 90 0 0 {name=p3 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -140 90 0 0 {name=p4 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -200 -200 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -200 -40 3 0 {name=p6 sig_type=std_logic lab=vss}
C {lab_pin.sym} -160 -40 3 0 {name=p7 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -160 -200 1 0 {name=p10 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -300 -140 0 0 {name=p11 sig_type=std_logic lab=c2p}
C {lab_pin.sym} -300 -120 0 0 {name=p12 sig_type=std_logic lab=c2p_en}
C {lab_pin.sym} -300 -100 0 0 {name=p13 sig_type=std_logic lab=otype}
C {lab_pin.sym} -30 -120 2 0 {name=p14 sig_type=std_logic lab=vout}
C {code_shown.sym} 160 -220 0 0 {name=SPICE only_toplevel=false value="

Vc2p c2p 0 PULSE(0 3.3 10u 1u 1u 10u 20u)
Vpuen pu_en 0 PULSE(0 3.3 45u 1u 1u 10u 100u)
Vpden pd_en 0 0
Ven c2p_en 0 3.3
Votype otype 0 PULSE(0 3.3 25u 1u 1u 100u 100u)

.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOShv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.include /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/diodes.lib 

.control
tran 10n 100u
plot c2p c2p_en otype pu_en
plot vout
.endc

"}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_io/hm_IOPadInOut30mA_OpenDrain_PUPD.sym} -180 -120 0 0 {name=x1}
C {lab_pin.sym} -300 -80 0 0 {name=p8 sig_type=std_logic lab=pu_en}
C {lab_pin.sym} -300 -60 0 0 {name=p9 sig_type=std_logic lab=pd_en}
C {capa.sym} -30 -70 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} -30 -20 3 0 {name=p15 sig_type=std_logic lab=vss}
