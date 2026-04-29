v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 -40 0 0 {lab=inout1}
N 0 0 0 40 {lab=inout1}
N 0 -140 0 -100 {lab=#net1}
N 0 100 0 140 {lab=#net2}
N 0 -210 0 -200 {lab=iovdd}
N -60 170 -40 170 {lab=pd_en}
N 0 -0 60 0 {lab=inout1}
N 110 170 110 190 {lab=sub}
N -190 -170 -170 -170 {lab=pu_en}
N -120 -220 -120 -210 {lab=iovdd}
N -70 -170 -40 -170 {lab=#net3}
N -110 -130 -110 -120 {lab=sub}
N -130 -130 -130 -120 {lab=iovss}
N -0 -170 20 -170 {lab=iovdd}
N 20 -210 20 -170 {lab=iovdd}
N 0 -210 20 -210 {lab=iovdd}
N 0 -220 0 -210 {lab=iovdd}
N -0 170 110 170 {lab=sub}
N 0 200 0 220 {lab=iovss}
C {iopin.sym} 60 0 0 0 {name=p3 lab=inout1}
C {sg13g2_pr/rhigh.sym} 0 -70 0 0 {name=R3
w=0.5e-6
l=10e-6
model=rhigh
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rhigh.sym} 0 70 0 0 {name=R4
w=0.5e-6
l=10e-6
model=rhigh
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/sg13_hv_pmos.sym} -20 -170 0 0 {name=M1
l=0.5u
w=10u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -20 170 0 0 {name=M2
l=0.5u
w=10u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {iopin.sym} -190 -170 0 1 {name=p8 lab=pu_en
}
C {iopin.sym} -60 170 0 1 {name=p11 lab=pd_en
}
C {iopin.sym} 0 -220 0 0 {name=p2 lab=iovdd}
C {iopin.sym} 0 220 0 0 {name=p1 lab=iovss}
C {iopin.sym} 110 190 0 0 {name=p5 lab=sub}
C {/home/designer/shared/hm-openpdk-library/libs.tech/xschem/hm_stdcells/sg13g2_io_inv_hv_noptap.sym} -120 -170 0 0 {name=x1}
C {lab_pin.sym} -120 -220 0 0 {name=p6 sig_type=std_logic lab=iovdd}
C {lab_pin.sym} -110 -120 3 0 {name=p7 sig_type=std_logic lab=sub}
C {lab_pin.sym} -130 -120 3 0 {name=p9 sig_type=std_logic lab=iovss}
