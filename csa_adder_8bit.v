module csa_adder_8bit(
	input [7:0] A,
	input [7:0] B,
	input wire [4:0] cin,
	output wire cout,
	output [7:0] sum
	);
	
	//output wire cin_last
	wire [3:0] c0;
	wire [3:0] c1;
	wire [3:0] s0;
	wire [3:0] s1;
	wire [3:0] cout_low;
	//wire cin;
	//assign cin = 0;
	
	//lower 4-bit RCA adder
	full_adder f00(A[0], B[0], cin[0], cout_low[0], sum[0]);
	full_adder f01(A[1], B[1], cout_low[0], cout_low[1], sum[1]);
	full_adder f02(A[2], B[2], cout_low[1], cout_low[2], sum[2]);
	full_adder f03(A[3], B[3], cout_low[2], cout_low[3], sum[3]);
	
	
	//higher 4-bit RCA adder
	//assume CI == 0
	full_adder f10(A[4], B[4], 1'b0, c0[0], s0[0]);
	full_adder f11(A[5], B[5], c0[0], c0[1], s0[1]);
	full_adder f12(A[6], B[6], c0[1], c0[2], s0[2]);
	full_adder f13(A[7], B[7], c0[2], c0[3], s0[3]);

	//assume CI == 1
	full_adder f14(A[4], B[4], 1'b1, c1[0], s1[0]);
	full_adder f15(A[5], B[5], c1[0], c1[1], s1[1]);
	full_adder f16(A[6], B[6], c1[1], c1[2], s1[2]);
	full_adder f17(A[7], B[7], c1[2], c1[3], s1[3]);

	
	//2:1 muxes for higher 4-bit sum
	mux_2_1 m0(s0[0], s1[0], cout_low[3], sum[4]);
	mux_2_1 m1(s0[1], s1[1], cout_low[3], sum[5]);
	mux_2_1 m2(s0[2], s1[2], cout_low[3], sum[6]);
	mux_2_1 m3(s0[3], s1[3], cout_low[3], sum[7]);
	
	//2:1 mux for carry out
	mux_2_1 m4(c0[3], c1[3], cout_low[3], cout);

endmodule
