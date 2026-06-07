`timescale 1ns/10ps
`celldefine
module hm_IOPadInOut30mA_OpenDrain_PUPD (iovdd, iovss, vdd, vss, pad, c2p, c2p_en, p2c, otype, pu, pd);
	inout iovdd;
	inout iovss;
	inout vdd;
	inout vss;
	inout pad;
	input c2p;
	input c2p_en;
	input otype;
	input pu;
	input pd;
	output p2c;

	// Function
	assign pad = (c2p_en) ? c2p : 1'bz;
	assign p2c = pad;

	// Timing
	specify
		if (c2p_en == 1'b1)
			(c2p => pad) = 0;
		(pad => p2c) = 0;
	endspecify
endmodule
`endcelldefine
