v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 80 -0 100 {lab=!}
N 0 0 0 20 {lab=core}
N -0 -100 -0 -80 {lab=iovdd}
N 0 0 80 0 {lab=core}
N -0 -20 0 0 {lab=core}
N 140 -0 180 0 {lab=pad}
N 0 -100 180 -100 {lab=iovdd}
C {iopin.sym} 180 100 0 0 {name=p3 lab=iovss}
C {iopin.sym} 0 0 0 1 {name=p4 lab=core}
C {iopin.sym} 180 0 0 0 {name=p6 lab=pad}
C {iopin.sym} 180 -100 0 0 {name=p1 lab=iovdd}
C {sg13g2_pr/dpantenna.sym} 0 -50 0 0 {name=D1
model=dpantenna
l=4.98u
w=0.64u
spiceprefix=X
}
C {sg13g2_pr/dantenna.sym} 0 50 0 0 {name=D2
model=dantenna
l=3.1u
w=0.64u
spiceprefix=X
}
C {iopin.sym} -20 100 0 1 {name=p2 lab=!}
C {sg13g2_pr/rppd.sym} 110 0 3 0 {name=R1
w=1e-6
l=2e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
lvs_format="R@name @pinlist \\$SUB=@body \\$[@model\\\\] w=@w l=@l b=@b m=@m"
}
C {lab_pin.sym} 0 90 0 1 {name=p7 sig_type=std_logic lab=!}
