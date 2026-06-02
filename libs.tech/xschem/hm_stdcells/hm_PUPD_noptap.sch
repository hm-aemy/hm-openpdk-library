v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 -40 0 0 {lab=pad}
N 0 0 0 40 {lab=pad}
N 0 -140 0 -100 {lab=pu_mid}
N 0 100 0 140 {lab=pd_mid}
N 0 -210 0 -200 {lab=iovdd}
N -60 170 -40 170 {lab=pd_en}
N 0 -0 60 0 {lab=pad}
N 110 170 110 190 {lab=!}
N -70 -170 -40 -170 {lab=pu_en}
N -0 -170 20 -170 {lab=iovdd}
N 20 -210 20 -170 {lab=iovdd}
N 0 -210 20 -210 {lab=iovdd}
N 0 -220 0 -210 {lab=iovdd}
N -0 170 110 170 {lab=!}
N 0 200 0 220 {lab=vss}
N 230 170 260 170 {lab=vss}
N 230 230 260 230 {lab=!}
C {iopin.sym} 60 0 0 0 {name=p3 lab=pad}
C {sg13g2_pr/sg13_hv_pmos.sym} -20 -170 0 0 {name=M1
l=0.45u
w=3.9u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -20 170 0 0 {name=M2
l=0.45u
w=1.9u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {iopin.sym} -70 -170 0 1 {name=p8 lab=pu_en
}
C {iopin.sym} -60 170 0 1 {name=p11 lab=pd_en
}
C {iopin.sym} 0 -220 0 0 {name=p2 lab=iovdd}
C {iopin.sym} 110 190 0 0 {name=p5 lab=!}
C {lab_pin.sym} 0 -120 2 0 {name=p4 sig_type=std_logic lab=pu_mid}
C {sg13g2_pr/rppd.sym} 0 -70 0 0 {name=R1
w=0.5e-6
l=4.135e-6
model=rppd
body=sub!
spiceprefix=X
b=21
m=1
ps=0.18e-6
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
lvs_format="R@name @pinlist \\$SUB=@body \\$[@model\\\\] w=@w l=@l ps=@ps b=@b m=@m"}
C {sg13g2_pr/rppd.sym} 0 70 0 0 {name=R2
w=0.5e-6
l=4.135e-6
model=rppd
body=sub!
spiceprefix=X
b=21
m=1
ps=0.18e-6
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
lvs_format="R@name @pinlist \\$SUB=@body \\$[@model\\\\] w=@w l=@l ps=@ps b=@b m=@m"}
C {iopin.sym} 0 220 2 0 {name=p1 lab=vss}
C {lab_pin.sym} 0 130 2 0 {name=p10 sig_type=std_logic lab=pd_mid}
C {sg13g2_pr/ptap1.sym} 260 200 0 0 {name=R3
model=ptap1
spiceprefix=X
w=1.54e-6
l=1.54e-6
lvs_format="tcleval(@name @pinlist @model A=0.804p P=5.96u )"
}
C {lab_pin.sym} 230 170 0 0 {name=p9 sig_type=std_logic lab=vss}
C {lab_pin.sym} 230 230 0 0 {name=p6 sig_type=std_logic lab=!}
