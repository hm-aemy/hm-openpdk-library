v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -240 -320 -240 -300 {lab=vdd}
N -200 -310 -200 -300 {lab=iovdd}
N -220 -310 -220 -300 {lab=iovdd}
N -220 -310 -200 -310 {lab=iovdd}
N -200 -320 -200 -310 {lab=iovdd}
N -240 -170 -240 -160 {lab=vss}
N -240 -170 -220 -170 {lab=vss}
N -240 -180 -240 -170 {lab=vss}
N -220 -180 -220 -170 {lab=vss}
N -200 -180 -200 -160 {lab=iovss}
N -340 -260 -320 -260 {lab=c2p}
N -320 -260 -320 -250 {lab=c2p}
N -320 -250 -280 -250 {lab=c2p}
N -340 -240 -280 -240 {lab=c2p_en}
N -340 -220 -320 -220 {lab=otype}
N -320 -230 -320 -220 {lab=otype}
N -320 -230 -280 -230 {lab=otype}
N -340 -200 -310 -200 {lab=pu}
N -310 -220 -310 -200 {lab=pu}
N -310 -220 -280 -220 {lab=pu}
N -340 -180 -300 -180 {lab=pd}
N -300 -210 -300 -180 {lab=pd}
N -300 -210 -280 -210 {lab=pd}
N -340 -280 -310 -280 {lab=p2c}
N -310 -280 -310 -260 {lab=p2c}
N -310 -260 -280 -260 {lab=p2c}
N -160 -240 -120 -240 {lab=vout}
C {lab_pin.sym} -240 -320 1 0 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -240 -160 3 0 {name=p6 sig_type=std_logic lab=vss}
C {lab_pin.sym} -200 -160 3 0 {name=p7 sig_type=std_logic lab=iovss}
C {lab_pin.sym} -200 -320 1 0 {name=p10 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -340 -260 0 0 {name=p11 sig_type=std_logic lab=c2p}
C {lab_pin.sym} -340 -240 0 0 {name=p12 sig_type=std_logic lab=c2p_en}
C {lab_pin.sym} -340 -220 0 0 {name=p13 sig_type=std_logic lab=otype}
C {lab_pin.sym} -120 -240 2 0 {name=p14 sig_type=std_logic lab=vout}
C {code_shown.sym} 40 -750 0 0 {name=SPICE only_toplevel=false value="

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
C {lab_pin.sym} -340 -200 0 0 {name=p8 sig_type=std_logic lab=pu}
C {lab_pin.sym} -340 -180 0 0 {name=p9 sig_type=std_logic lab=pd}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_io/hm_IOPadInOut30mA_OpenDrain_PUPD.sym} -220 -240 0 0 {name=x1}
C {lab_pin.sym} -340 -280 0 0 {name=p15 sig_type=std_logic lab=p2c}
