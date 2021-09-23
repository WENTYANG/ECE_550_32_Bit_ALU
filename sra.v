module sra(
	input [31:0] data_operandA, 
	input [4:0] shiftamt,
	input [4:0] ctrl_ALUopcode,
	output [31:0] result_sra
	);
	
	//for sra, we first reverse the bitwise order of the input, then put it into sll, then reverse the result
	
	//negate the input
	wire [31:0] reverse_A;
	wire [31:0] reverse_result;
	
	generate
		genvar i;
		for(i=0; i<32; i=i+1) begin: reverse0
			assign reverse_A[i] = data_operandA[31-i];
		end
	endgenerate
	
	sll helper_sll(reverse_A[31:0], shiftamt, ctrl_ALUopcode, reverse_result[31:0]);
	
	generate
		genvar j;
		for(j=0; j<32; j=j+1) begin: reverse1
			assign result_sra[j] = reverse_result[31-j];
		end
	endgenerate
endmodule
	