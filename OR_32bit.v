module OR_32bit(or_32bit, data_operandA, data_operandB);

    output [31:0] or_32bit;
	 input [31:0] data_operandA, data_operandB;
	 genvar i;
	 generate
	     for(i=0;i<=31;i=i+1)
		  begin:start
		      or (or_32bit[i], data_operandA[i], data_operandB[i]);
		  end
	 endgenerate
	 
endmodule