module sll(
	input [31:0] data_operandA, 
	input [4:0] shiftamt,
	input [4:0] ctrl_ALUopcode,
	output [31:0] result_sll
	);
	
	//choose between sll or sra
	wire base;
	mux_2_1 SLLorSRA(1'b0, data_operandA[0], ctrl_ALUopcode[0], base);      //For sra the input would be reversed, data_operandA[0] is the sign bit
	
	//for sll, we have five layers
	//first layer: shift by 1
	wire [31:0] a;          //intermediate output
	
	mux_2_1 m00(data_operandA[0], base, shiftamt[0], a[0]);
	generate
		genvar i;
		for(i=1; i<32; i=i+1) begin: layer0
			mux_2_1 m01(data_operandA[i], data_operandA[i-1], shiftamt[0], a[i]);
		end
	endgenerate
	
	
	//second layer: shift by 2
	wire [31:0] b;          				//intermediate output
	
	mux_2_1 m10(a[0], base, shiftamt[1], b[0]);
	mux_2_1 m11(a[1], base, shiftamt[1], b[1]);
	generate
		genvar j;
		for(j=2; j<32; j=j+1) begin: layer1
			mux_2_1 m12(a[j], a[j-2], shiftamt[1], b[j]);
		end
	endgenerate
	
	
	//third layer: shift by 4
	wire [31:0] c;          				//intermediate output
	
	generate
		genvar k;
		for(k=0; k<4; k=k+1) begin: layer2_0
			mux_2_1 m20(b[k], base, shiftamt[2], c[k]);
		end
	endgenerate
	
	generate
		genvar l;
		for(l=4; l<32; l=l+1) begin: layer2_1
			mux_2_1 m24(b[l], b[l-4], shiftamt[2], c[l]);
		end
	endgenerate
	
	
	//fourth layer: shift by 8
	wire [31:0] d;								//intermediate output
	
	generate
		genvar m;
		for(m=0; m<8; m=m+1) begin: layer3_0
			mux_2_1 m30(c[m], base, shiftamt[3], d[m]);
		end
	endgenerate
	
	generate
		genvar n;
		for(n=8; n<32; n=n+1) begin:layer3_1
			mux_2_1 m38(c[n], c[n-8], shiftamt[3], d[n]);
		end
	endgenerate
	
	//fifth layer: shift by 16
	generate
		genvar p;
		for(p=0; p<16; p=p+1) begin: layer4_0
			mux_2_1 m40(d[p], base, shiftamt[4], result_sll[p]);
		end
	endgenerate
	
	generate
		genvar q;
		for(q=16; q<32; q=q+1) begin: layer4_1
			mux_2_1 m416(d[q], d[q-16], shiftamt[4], result_sll[q]);
		end
	endgenerate
	
endmodule