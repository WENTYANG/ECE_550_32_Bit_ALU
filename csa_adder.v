module csa_adder_4bit(
	input [3:0] A,
	input [3:0] B,
	output wire carry_out,
	output [3:0] sum);
	
	wire [1:0] cout0;
	wire [1:0] cout1;
	wire [1:0] sum0;
	wire [1:0] sum1;
	wire [1:0] s;
	wire cout_low0, cout_low1;
	wire cin;
	assign cin = 0;
	
	//lower 2-bit adder
	full_adder f00(A[0], B[0], 0, cout_low0, sum[0]);
	full_adder f01(A[1], B[1], cout_low0, cout_low1, sum[1]);
	
	//higher 2-bit adder
	full_adder f02(A[2], B[2], 0, cout0[0], sum0[0]);
	full_adder f03(A[3], B[3], cout0[0], cout0[1], sum0[1]);
	
	full_adder f12(A[2], B[2], 1, cout1[0], sum1[0]);
	full_adder f13(A[3], B[3], cout1[0], cout1[1], sum1[1]);
	
	//2:1 mux for higher 2-bit sum
	mux_2_1 m0(sum0[0], sum1[0], cout_low1, sum[2]);
	mux_2_1 m1(sum0[1], sum1[1], cout_low1, sum[3]);
	//2:1 mux for carry out
	mux_2_1 m2(cout0[1], cout1[1], cout_low1, carry_out);

endmodule