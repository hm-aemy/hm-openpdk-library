v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -190 280 -190 300 {lab=GND}
N -120 280 -120 300 {lab=GND}
N -50 280 -50 300 {lab=GND}
N 30 280 30 300 {lab=GND}
N -190 200 -190 220 {lab=vdd}
N -120 200 -120 220 {lab=vss}
N -50 200 -50 220 {lab=iovdd}
N 30 200 30 220 {lab=iovss}
N -0 50 0 60 {lab=vss}
N 10 40 10 50 {lab=iovss}
N 10 50 20 50 {lab=iovss}
N 20 50 20 60 {lab=iovss}
N -10 -70 -10 -60 {lab=vdd}
N -10 -60 -0 -60 {lab=vdd}
N -0 -60 -0 -50 {lab=vdd}
N 10 -60 10 -50 {lab=iovdd}
N -80 -10 -40 -10 {lab=c2p}
N -80 10 -60 10 {lab=c2p_en}
N -60 0 -60 10 {lab=c2p_en}
N -60 -0 -40 -0 {lab=c2p_en}
N -80 30 -50 30 {lab=otype}
N -50 10 -50 30 {lab=otype}
N -50 10 -40 10 {lab=otype}
N 100 -10 140 -10 {lab=vout}
N -10 40 -10 50 {lab=vss}
N -10 50 -0 50 {lab=vss}
N 0 40 -0 50 {lab=vss}
N 10 -60 20 -60 {lab=iovdd}
N 10 -70 10 -60 {lab=iovdd}
N 20 -60 20 -50 {lab=iovdd}
N 100 -20 100 -10 {lab=vout}
N 50 -10 100 -10 {lab=vout}
N 100 -100 100 -80 {lab=iovdd}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_io/hm_IOPadInOut30mA_OpenDrain.sym} 10 -10 0 0 {name=x1}
C {vsource.sym} -190 250 0 0 {name=Vdd value=1.2 savecurrent=false}
C {gnd.sym} -190 300 0 0 {name=l1 lab=GND}
C {vsource.sym} -120 250 0 0 {name=Vss value=0 savecurrent=false}
C {gnd.sym} -120 300 0 0 {name=l2 lab=GND}
C {vsource.sym} -50 250 0 0 {name=Viovdd value=3.3 savecurrent=false}
C {gnd.sym} -50 300 0 0 {name=l3 lab=GND}
C {vsource.sym} 30 250 0 0 {name=Viovss value=0 savecurrent=false}
C {gnd.sym} 30 300 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -190 200 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -120 200 0 0 {name=p2 sig_type=std_logic lab=vss}
C {lab_pin.sym} -50 200 0 0 {name=p3 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} 30 200 0 0 {name=p4 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -10 -70 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 0 60 3 0 {name=p6 sig_type=std_logic lab=vss}
C {lab_pin.sym} 20 60 3 0 {name=p7 sig_type=std_logic lab=iovss}
C {lab_pin.sym} 10 -70 1 0 {name=p10 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -80 -10 0 0 {name=p11 sig_type=std_logic lab=c2p}
C {lab_pin.sym} -80 10 0 0 {name=p12 sig_type=std_logic lab=c2p_en}
C {lab_pin.sym} -80 30 0 0 {name=p13 sig_type=std_logic lab=otype}
C {lab_pin.sym} 140 -10 2 0 {name=p14 sig_type=std_logic lab=vout}
C {code_shown.sym} 330 -110 0 0 {name=SPICE only_toplevel=false value="

Vc2p c2p 0 PULSE(0 3.3 10u 1u 1u 10u 100u)
Ven c2p_en 0 3.3
Votype otype 0 3.3

.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOShv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.include /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/diodes.lib 

.control
tran 10n 100u
plot c2p c2p_en otype
plot vout
.endc

"}
C {res.sym} 100 -50 0 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 100 -100 1 0 {name=p8 sig_type=std_logic lab=iovdd}
