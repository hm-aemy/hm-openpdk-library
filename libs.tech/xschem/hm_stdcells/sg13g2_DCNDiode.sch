v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -110 60 90 60 {lab=sub}
N 0 -20 0 0 {lab=cathode2}
N 90 -20 90 0 {lab=anode}
N -110 -20 -110 0 {lab=cathode1}
N 0 90 20 90 {lab=guard}
N 90 60 90 80 {lab=sub}
C {sg13g2_pr/ptap1.sym} 90 30 0 0 {name=R1
model=ptap1
spiceprefix=X
w=11.9e-6
l=11.9e-6
lvs_format="tcleval(@name @pinlist @model A=141.2964p P=221.76u )"
}
C {iopin.sym} 0 -20 0 1 {name=p1 lab=cathode2}
C {iopin.sym} 0 90 0 1 {name=p2 lab=guard}
C {iopin.sym} 90 -20 0 0 {name=p3 lab=anode}
C {iopin.sym} -110 -20 0 1 {name=p5 lab=cathode1}
C {sg13g2_pr/dantenna.sym} -110 30 0 0 {name=D1
model=dantenna
l=27.78u
w=1.26u
spiceprefix=X
}
C {noconn.sym} 20 90 0 1 {name=l1}
C {sg13g2_pr/dantenna.sym} 0 30 0 0 {name=D2
model=dantenna
l=27.78u
w=1.26u
spiceprefix=X
}
C {iopin.sym} 90 80 0 0 {name=p4 lab=sub}
