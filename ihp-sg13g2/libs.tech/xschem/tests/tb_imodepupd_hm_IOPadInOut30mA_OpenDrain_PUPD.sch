v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -240 -210 -240 -190 {lab=vdd}
N -200 -200 -200 -190 {lab=iovdd}
N -220 -200 -220 -190 {lab=iovdd}
N -220 -200 -200 -200 {lab=iovdd}
N -200 -210 -200 -200 {lab=iovdd}
N -240 -60 -240 -50 {lab=vss}
N -240 -60 -220 -60 {lab=vss}
N -240 -70 -240 -60 {lab=vss}
N -220 -70 -220 -60 {lab=vss}
N -200 -70 -200 -50 {lab=iovss}
N -340 -150 -320 -150 {lab=c2p}
N -320 -150 -320 -140 {lab=c2p}
N -320 -140 -280 -140 {lab=c2p}
N -340 -130 -280 -130 {lab=c2p_en}
N -340 -110 -320 -110 {lab=otype}
N -320 -120 -320 -110 {lab=otype}
N -320 -120 -280 -120 {lab=otype}
N -340 -90 -310 -90 {lab=pu}
N -310 -110 -310 -90 {lab=pu}
N -310 -110 -280 -110 {lab=pu}
N -340 -70 -300 -70 {lab=pd}
N -300 -100 -300 -70 {lab=pd}
N -300 -100 -280 -100 {lab=pd}
N -340 -170 -310 -170 {lab=p2c}
N -310 -170 -310 -150 {lab=p2c}
N -310 -150 -280 -150 {lab=p2c}
N -160 -130 -120 -130 {lab=vout}
C {lab_pin.sym} -240 -210 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -240 -50 3 0 {name=p6 sig_type=std_logic lab=vss}
C {lab_pin.sym} -200 -50 3 0 {name=p7 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -200 -210 1 0 {name=p10 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -340 -150 0 0 {name=p11 sig_type=std_logic lab=c2p}
C {lab_pin.sym} -340 -130 0 0 {name=p12 sig_type=std_logic lab=c2p_en}
C {lab_pin.sym} -340 -110 0 0 {name=p13 sig_type=std_logic lab=otype}
C {lab_pin.sym} -120 -130 2 0 {name=p14 sig_type=std_logic lab=vout}
C {code_shown.sym} 70 -600 0 0 {name=SPICE only_toplevel=false value="

.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOShv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.include /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/diodes.lib 

* ============================================================
* tb_input_pupd_functional.spice
* Functional PU/PD tests with floating pad
* ============================================================

.param VDDVAL=1.2
.param IOVDDVAL=3.3

* Supplies
VDD     vdd     0 \{VDDVAL\}
VSS     vss     0 0
VIOVDD  iovdd   0 \{IOVDDVAL\}
VIOVSS  iovss   0 0

* Control/data signals
Vc2p     c2p     0 0
Vc2p_en  c2p_en  0 0
Votype   otype   0 0
Vpu      pu      0 1
Vpd      pd      0 0

Vout vout 0 0

Cload vout iovss 10p

.control
save all
dc vout 0 3.3 0.1

write input_02_pu.raw
wrdata input_02_pu.txt v(vout) v(p2c)

plot v(vout) pu pd v(p2c)

let pu_mid = v(x1.x7.pu_mid)
plot pu_mid

.endc
.end


"}
C {lab_pin.sym} -340 -90 0 0 {name=p8 sig_type=std_logic lab=pu}
C {lab_pin.sym} -340 -70 0 0 {name=p9 sig_type=std_logic lab=pd}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_io/hm_IOPadInOut30mA_OpenDrain_PUPD.sym} -220 -130 0 0 {name=x1}
C {lab_pin.sym} -340 -170 0 0 {name=p15 sig_type=std_logic lab=p2c}
