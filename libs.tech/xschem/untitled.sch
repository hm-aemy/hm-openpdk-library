v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -230 170 -230 190 {lab=GND}
N -160 170 -160 190 {lab=GND}
N -90 170 -90 190 {lab=GND}
N -10 170 -10 190 {lab=GND}
N -230 90 -230 110 {lab=vdd}
N -160 90 -160 110 {lab=vss}
N -90 90 -90 110 {lab=iovdd}
N -10 90 -10 110 {lab=iovss}
N -40 -70 -40 -60 {lab=vss}
N -30 -80 -30 -70 {lab=iovss}
N -30 -70 -20 -70 {lab=iovss}
N -20 -70 -20 -60 {lab=iovss}
N -50 -180 -50 -170 {lab=vdd}
N -50 -170 -40 -170 {lab=vdd}
N -40 -170 -40 -160 {lab=vdd}
N -30 -170 -30 -160 {lab=iovdd}
N -120 -120 -80 -120 {lab=c2p}
N -120 -100 -100 -100 {lab=c2p_en}
N -100 -110 -100 -100 {lab=c2p_en}
N -100 -110 -80 -110 {lab=c2p_en}
N 10 -120 100 -120 {lab=vout}
N -50 -80 -50 -70 {lab=vss}
N -50 -70 -40 -70 {lab=vss}
N -40 -80 -40 -70 {lab=vss}
N -30 -170 -20 -170 {lab=iovdd}
N -30 -180 -30 -170 {lab=iovdd}
N -20 -170 -20 -160 {lab=iovdd}
N 100 -120 100 -100 {lab=vout}
N 100 -40 100 -20 {lab=GND}
N -260 -50 -260 -30 {lab=GND}
N -260 -130 -260 -110 {lab=#net1}
N -260 -130 -80 -130 {lab=#net1}
C {vsource.sym} -230 140 0 0 {name=Vdd value=1.2 savecurrent=false}
C {gnd.sym} -230 190 0 0 {name=l1 lab=GND}
C {vsource.sym} -160 140 0 0 {name=Vss value=0 savecurrent=false}
C {gnd.sym} -160 190 0 0 {name=l2 lab=GND}
C {vsource.sym} -90 140 0 0 {name=iovdd value=3.3 savecurrent=false}
C {gnd.sym} -90 190 0 0 {name=l3 lab=GND}
C {vsource.sym} -10 140 0 0 {name=iovss value=0 savecurrent=false}
C {gnd.sym} -10 190 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -230 90 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -160 90 0 0 {name=p2 sig_type=std_logic lab=vss}
C {lab_pin.sym} -90 90 0 0 {name=p3 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -10 90 0 0 {name=p4 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -50 -180 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -40 -60 3 0 {name=p6 sig_type=std_logic lab=vss}
C {lab_pin.sym} -20 -60 3 0 {name=p7 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -30 -180 1 0 {name=p10 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -120 -120 0 0 {name=p11 sig_type=std_logic lab=c2p}
C {lab_pin.sym} -120 -100 0 0 {name=p12 sig_type=std_logic lab=c2p_en}
C {lab_pin.sym} 100 -120 2 0 {name=p14 sig_type=std_logic lab=vout}
C {code_shown.sym} 290 -220 0 0 {name=SPICE only_toplevel=false value="

Vc2p c2p 0 PULSE(0 3.3 20u 1u 1u 30u 100u)
Ven c2p_en 0 3.3
Votype otype 0 0

.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOShv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.include /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/diodes.lib 

.control
tran 1n 100u
plot c2p c2p_en otype
plot vout
.endc

"}
C {/home/designer/shared/openpdk-libraries/ihp-sg13g2/sg13g2_io/xschem/sg13g2_IOPadInOut30mA.sym} -30 -120 0 0 {name=x1}
C {res.sym} 100 -70 0 0 {name=R1
value=100000
footprint=1206
device=resistor
m=1}
C {gnd.sym} 100 -20 0 0 {name=l5 lab=GND}
C {res.sym} -260 -80 0 0 {name=R2
value=100000
footprint=1206
device=resistor
m=1}
C {gnd.sym} -260 -30 0 0 {name=l6 lab=GND}
