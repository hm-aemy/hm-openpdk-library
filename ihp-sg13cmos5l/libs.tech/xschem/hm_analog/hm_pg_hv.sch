v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 0 0 30 {lab=ctrl_n}
N 0 -60 20 -60 {lab=VAPWR}
N 0 -100 0 -90 {lab=VAPWR}
N 0 100 0 120 {lab=VGND}
N 0 60 20 60 {lab=VGND}
N 20 60 20 100 {lab=VGND}
N 0 100 20 100 {lab=VGND}
N 0 90 0 100 {lab=VGND}
N 20 -100 20 -60 {lab=VAPWR}
N 0 -100 20 -100 {lab=VAPWR}
N 0 -120 0 -100 {lab=VAPWR}
N -60 -60 -40 -60 {lab=H_crtl_p}
N -60 60 -40 60 {lab=H_crtl_p}
N -60 0 -60 60 {lab=H_crtl_p}
N 0 0 160 0 {lab=ctrl_n}
N 0 -30 0 0 {lab=ctrl_n}
N 120 -120 130 -120 {lab=VAPWR}
N 160 -80 160 0 {lab=ctrl_n}
N 190 -120 480 -120 {lab=GPWR}
N -60 -60 -60 0 {lab=H_crtl_p}
N 160 -140 160 -120 {lab=VAPWR}
N 120 -140 160 -140 {lab=VAPWR}
N 120 -140 120 -120 {lab=VAPWR}
N 0 -120 120 -120 {lab=VAPWR}
N 480 -120 480 0 {lab=GPWR}
N 460 0 480 0 {lab=GPWR}
N 480 -120 510 -120 {lab=GPWR}
N 460 20 480 20 {lab=VGND}
N 480 20 480 120 {lab=VGND}
N 0 120 480 120 {lab=VGND}
N -130 -0 -60 0 {lab=H_crtl_p}
N -460 20 -430 20 {lab=ctrl}
N -460 0 -430 0 {lab=VDPWR}
N -450 -120 0 -120 {lab=VAPWR}
N -450 -20 -430 -20 {lab=VAPWR}
N -450 -120 -450 -20 {lab=VAPWR}
N -460 -120 -450 -120 {lab=VAPWR}
N -450 120 0 120 {lab=VGND}
N -450 60 -430 60 {lab=VGND}
N -450 60 -450 120 {lab=VGND}
N -460 120 -450 120 {lab=VGND}
N -130 40 -100 40 {lab=H_crtl_n}
C {ipin.sym} -460 20 0 0 {name=p1 lab=ctrl}
C {iopin.sym} -460 -120 2 0 {name=p2 lab=VAPWR}
C {iopin.sym} -460 120 2 0 {name=p3 lab=VGND}
C {iopin.sym} 510 -120 0 0 {name=p4 lab=GPWR}
C {lab_pin.sym} 160 -50 0 0 {name=p5 sig_type=std_logic lab=ctrl_n}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/lv2hv.sym} -280 20 0 0 {name=x2}
C {iopin.sym} -460 0 2 0 {name=p6 lab=VDPWR}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} -20 60 0 0 {name=M4
l=0.45u
w=2.6u
ng=1
m=1
mm_ok=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} -20 -60 0 0 {name=M5
l=0.45u
w=4.44u
ng=1
m=1
mm_ok=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 160 -100 3 0 {name=M1
l=0.45u
w=1452u
ng=220
m=2
mm_ok=1
model=sg13_hv_pmos
spiceprefix=X
}
C {/foss/designs/hm-openpdk-library/ihp-sg13cmos5l/libs.tech/xschem/hm_analog/hv_dischg.sym} 310 10 0 0 {name=x3}
C {lab_pin.sym} -100 0 1 0 {name=p7 sig_type=std_logic lab=H_crtl_p}
C {lab_pin.sym} -100 40 3 0 {name=p8 sig_type=std_logic lab=H_crtl_n}
