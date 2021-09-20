module csa_adder_16bit(
	input [15:0] A,
	input [15:0] B,
	input wire [4:0] cin,
	output wire cout,
	output [15:0] sum);
	
	wire clow;
	wire c1;
	wire c0;
	wire [7:0] s0;
	wire [7:0] s1;
	//assign cin = 0;
	
	//lower 8_bit CSA adder
	csa_adder_8bit f00(A[7:0], B[7:0], cin, clow, sum[7:0]);
	
	//higher 8_bit CSA adder
	//assume CI == 0 
	csa_adder_8bit f10(A[15:8], B[15:8], 5'd0, c0, s0);
	
	//assume CI == 1
	csa_adder_8bit f11(A[15:8], B[15:8], 5'd1, c1, s1);
	
	//2:1 muxes for higher 8_bit sum
	mux_2_1 m0(s0[0], s1[0], clow, sum[8]);
	mux_2_1 m1(s0[1], s1[1], clow, sum[9]);
	mux_2_1 m2(s0[2], s1[2], clow, sum[10]);
	mux_2_1 m3(s0[3], s1[3], clow, sum[11]);
	mux_2_1 m4(s0[4], s1[4], clow, sum[12]);
	mux_2_1 m5(s0[5], s1[5], clow, sum[13]);
	mux_2_1 m6(s0[6], s1[6], clow, sum[14]);
	mux_2_1 m7(s0[7], s1[7], clow, sum[15]);
	
	//2:1 mux for carry out
	mux_2_1 m8(c0, c1, clow, cout);
	
endmodule

	
	
	