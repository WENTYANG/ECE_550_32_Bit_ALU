module csa_adder_32bit(
	input [31:0] A,
	input [31:0] B,
	input wire [4:0] cin,
	output wire cout,
	output [31:0] sum);
	
	wire clow;
	wire c1;
	wire c0;
	wire [15:0] s0;
	wire [15:0] s1;
	//assign cin = 0;
	
	//lower 16_bit CSA adder
	csa_adder_16bit f00(A[15:0], B[15:0], cin, clow, sum[15:0]);
	
	//higher 16_bit CSA adder
	//assume CI == 0 
	csa_adder_16bit f10(A[31:16], B[31:16], 5'd0, c0, s0);
	
	//assume CI == 1
	csa_adder_16bit f11(A[31:16], B[31:16], 5'd1, c1, s1);
	
	//2:1 muxes for higher 16_bit sum
	mux_2_1 m0(s0[0], s1[0], clow, sum[16]);
	mux_2_1 m1(s0[1], s1[1], clow, sum[17]);
	mux_2_1 m2(s0[2], s1[2], clow, sum[18]);
	mux_2_1 m3(s0[3], s1[3], clow, sum[19]);
	mux_2_1 m4(s0[4], s1[4], clow, sum[20]);
	mux_2_1 m5(s0[5], s1[5], clow, sum[21]);
	mux_2_1 m6(s0[6], s1[6], clow, sum[22]);
	mux_2_1 m7(s0[7], s1[7], clow, sum[23]);
	mux_2_1 m8(s0[8], s1[8], clow, sum[24]);
	mux_2_1 m9(s0[9], s1[9], clow, sum[25]);
	mux_2_1 m10(s0[10], s1[10], clow, sum[26]);
	mux_2_1 m11(s0[11], s1[11], clow, sum[27]);
	mux_2_1 m12(s0[12], s1[12], clow, sum[28]);
	mux_2_1 m13(s0[13], s1[13], clow, sum[29]);
	mux_2_1 m14(s0[14], s1[14], clow, sum[30]);
	mux_2_1 m15(s0[15], s1[15], clow, sum[31]);
	
	//2:1 mux for carry out
	mux_2_1 m16(c0, c1, clow, cout);
	
endmodule
