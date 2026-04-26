v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -110 0 -0 0 {lab=cathode}
N 0 -20 0 -0 {lab=cathode}
N -0 60 0 80 {lab=anode2}
N 90 -20 90 0 {lab=guard}
N 90 60 90 80 {lab=sub}
N -110 60 -110 80 {lab=anode1}
C {sg13g2_pr/dpantenna.sym} -110 30 0 0 {name=D1
model=dpantenna
l=27.78u
w=1.26u
spiceprefix=X
}
C {iopin.sym} 0 80 0 1 {name=p1 lab=anode2}
C {iopin.sym} 0 -20 0 1 {name=p2 lab=cathode}
C {iopin.sym} 90 -20 0 0 {name=p3 lab=guard}
C {sg13g2_pr/dpantenna.sym} 0 30 0 0 {name=D2
model=dpantenna
l=27.78u
w=1.26u
spiceprefix=X
}
C {iopin.sym} -110 80 0 1 {name=p5 lab=anode1}
C {iopin.sym} 90 80 0 0 {name=p4 lab=sub}
