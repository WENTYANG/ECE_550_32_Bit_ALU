module MUX_8bit(in0,in1,in2,in3,in4,in5,in6,in7, sel, out);
	input in0,in1,in2,in3,in4,in5,in6,in7;
	input [2:0]sel;
	output out;
	wire out0,out1,out2, out3;
	MUX_4bit mux_4bit1(in0,in1,in2,in3, sel[1:0], out2);
	MUX_4bit mux_4bit2(in4,in5,in6,in7, sel[1:0], out3);
	mux_2_1 mux_2bit(out2, out3, sel[2], out);
	
endmodule

module MUX_4bit(in0,in1,in2,in3, sel, out);
	input in0,in1,in2,in3;
	input [1:0] sel;
	output out;
	wire out0,out1;
	mux_2_1 mux1(in0, in1, sel[0], out0);
	mux_2_1 mux2(in2, in3, sel[0], out1);
	mux_2_1 mux3(out0, out1, sel[1], out);
endmodule