v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
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
N -300 -80 -270 -80 {lab=pu}
N -270 -100 -270 -80 {lab=pu}
N -270 -100 -240 -100 {lab=pu}
N -300 -60 -260 -60 {lab=pd}
N -260 -90 -260 -60 {lab=pd}
N -260 -90 -240 -90 {lab=pd}
N -300 -160 -270 -160 {lab=p2c}
N -270 -160 -270 -140 {lab=p2c}
N -270 -140 -240 -140 {lab=p2c}
N -120 -120 -80 -120 {lab=vout}
C {lab_pin.sym} -200 -200 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -200 -40 3 0 {name=p6 sig_type=std_logic lab=vss}
C {lab_pin.sym} -160 -40 3 0 {name=p7 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -160 -200 1 0 {name=p10 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -300 -140 0 0 {name=p11 sig_type=std_logic lab=c2p}
C {lab_pin.sym} -300 -120 0 0 {name=p12 sig_type=std_logic lab=c2p_en}
C {lab_pin.sym} -300 -100 0 0 {name=p13 sig_type=std_logic lab=otype}
C {lab_pin.sym} -80 -120 2 0 {name=p14 sig_type=std_logic lab=vout}
C {code_shown.sym} 60 -260 0 0 {name=SPICE only_toplevel=false value="

.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOShv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.include /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/diodes.lib 

* ============================================================
* tb_input_functional.spice
* Functional input tests for hm_IOPadInOut30mA_OpenDrain_PUPD
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
Vpu      pu      0 0
Vpd      pd      0 0

* External stimulus directly connected to pad
* Only used for input test case.
Vext vout iovss PULSE(0 \{IOVDDVAL\} 10n 1n 1n 40n 100n)

* Pad load
Cload vout iovss 20p

.control
set filetype=ascii

* ============================================================
* CASE 1: pure input mode
* vout is driven externally from 0 to IOVDD.
* p2c should follow as 0 to VDD.
* ============================================================

alter Vc2p     = 0
alter Vc2p_en  = 0
alter Votype   = 0
alter Vpu      = 0
alter Vpd      = 0

reset

tran 100p 300n

write input_01_ext_drive.raw
wrdata input_01_ext_drive.txt time v(vout) v(p2c)

plot v(vout) v(p2c)

* Expected:
* vout = 0       -> p2c = 0
* vout = 3.3 V   -> p2c = 1.2 V

.endc

.end


"}
C {lab_pin.sym} -300 -80 0 0 {name=p8 sig_type=std_logic lab=pu}
C {lab_pin.sym} -300 -60 0 0 {name=p9 sig_type=std_logic lab=pd}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_io/hm_IOPadInOut30mA_OpenDrain_PUPD.sym} -180 -120 0 0 {name=x1}
C {lab_pin.sym} -300 -160 0 0 {name=p15 sig_type=std_logic lab=p2c}
