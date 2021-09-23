module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire [31:0] not_B;
	wire [31:0] comp_B;
	wire cout;
	wire sum_last;
	wire cin_last;
	wire [31:0] ADDSUB_result, AND_result, OR_result, SLL_result, SRA_result, equal;
	wire [15:0] equal16;
	wire [7:0] equal8;
	wire [3:0] equal4;
	wire [1:0] equal2;
	not_32bit n0(data_operandB, not_B);
	mux_32bit m0(data_operandB, not_B, ctrl_ALUopcode, comp_B);
	
	csa_adder_32bit a0(data_operandA, comp_B, ctrl_ALUopcode, cout, ADDSUB_result);
	
	//compute cin of last bit, if cin == 1, last bit of result must be different from A[31] xor B[31]
	xor(sum_last, data_operandA[31], comp_B[31]);
	xor(cin_last, sum_last, ADDSUB_result[31]);
	//determine overflow by cin xor cout
	xor(overflow, cin_last, cout);
	 AND_32bit and32(AND_result[31:0], data_operandA[31:0], data_operandB[31:0]);
	 OR_32bit or32(OR_result[31:0], data_operandA[31:0], data_operandB[31:0]);
	 
	 sll sll32(data_operandA[31:0], ctrl_shiftamt[4:0], ctrl_ALUopcode[4:0], SLL_result[31:0]);
	 sra sra32(data_operandA[31:0], ctrl_shiftamt[4:0], ctrl_ALUopcode[4:0], SRA_result[31:0]);
	 
	 //determine isnotequal
		//compare each bits of dataA and dataB
	 generate
	 genvar t;
	     for(t=0;t<32;t=t+1)
		  begin: comparion
            xor xor1(equal[t], data_operandA[t], data_operandB[t]);
	     end
	 endgenerate
		//reduce to 16 bits
	 generate
	 genvar a;
	     for(a=0;a<16;a=a+1)
		  begin: to16
            or or33(equal16[a], equal[2*a], equal[2*a +1]);
	     end
	 endgenerate
	 //reduced to 8 bits
	 generate
	 genvar b;
	     for(b=0;b<8;b=b+1)
		  begin: to8
            or or34(equal8[b], equal16[2*b], equal16[2*b +1]);
	     end
	 endgenerate
	 // reduce to 4 bits
	 generate
	 genvar c;
	     for(c=0;c<4;c=c+1)
		  begin: to4
            or or35(equal4[c], equal8[2*c], equal8[2*c +1]);
	     end
	 endgenerate
	 // reduce to 2 bits
	 generate
	 genvar d;
	     for(d=0;d<2;d=d+1)
		  begin: to2
            or or36(equal2[d], equal4[2*d], equal4[2*d +1]);
	     end
	 endgenerate
	 // determine isnotequal
	 or or37(isNotEqual, equal2[0],equal2[1]);
	 //determine islessthan
	 xor xor_islessthan(isLessThan, ADDSUB_result[31], overflow);
	 //output data_result

	 
	 generate
	 genvar i;
	     for(i=0;i<32;i=i+1)
		  begin: start
	         MUX_8bit mux32(ADDSUB_result[i],ADDSUB_result[i],AND_result[i],OR_result[i],
				SLL_result[i],SRA_result[i],1'b0,1'b0,ctrl_ALUopcode[2:0],data_result[i]);
		  end
	 endgenerate
	 
//	 //after subtract operation, output isnotequal and islessthan 
//	 MUX_8bit mux_isnotequal(1'b0,SUB_isnoteuqal,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0, ctrl_ALUopcode[2:0],isNotEqual);
//	 MUX_8bit mux_islessthan(1'b0,SUB_islessthan,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0, ctrl_ALUopcode[2:0],isLessThan);
	 //after add and subtract operation, output overflow
//	 MUX_8bit mux_overflow(ADDSUB_overflow,ADDSUB_overflow,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0, ctrl_ALUopcode[2:0],overflow);
	 
endmodule
