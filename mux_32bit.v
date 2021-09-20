module mux_32bit(
	input [31:0] in1,
	input [31:0] in2,
	input s,
	output [31:0] out);
	
	mux_2_1 m0(in1[0],in2[0],s,out[0]);
	mux_2_1 m1(in1[1],in2[1],s,out[1]);
	mux_2_1 m2(in1[2],in2[2],s,out[2]);
	mux_2_1 m3(in1[3],in2[3],s,out[3]);
	mux_2_1 m4(in1[4],in2[4],s,out[4]);
	mux_2_1 m5(in1[5],in2[5],s,out[5]);
	mux_2_1 m6(in1[6],in2[6],s,out[6]);
	mux_2_1 m7(in1[7],in2[7],s,out[7]);
	mux_2_1 m8(in1[8],in2[8],s,out[8]);
	mux_2_1 m9(in1[9],in2[9],s,out[9]);
	mux_2_1 m10(in1[10],in2[10],s,out[10]);
	mux_2_1 m11(in1[11],in2[11],s,out[11]);
	mux_2_1 m12(in1[12],in2[12],s,out[12]);
	mux_2_1 m13(in1[13],in2[13],s,out[13]);
	mux_2_1 m14(in1[14],in2[14],s,out[14]);
	mux_2_1 m15(in1[15],in2[15],s,out[15]);
	mux_2_1 m16(in1[16],in2[16],s,out[16]);
	mux_2_1 m17(in1[17],in2[17],s,out[17]);
	mux_2_1 m18(in1[18],in2[18],s,out[18]);
	mux_2_1 m19(in1[19],in2[19],s,out[19]);
	mux_2_1 m20(in1[20],in2[20],s,out[20]);
	mux_2_1 m21(in1[21],in2[21],s,out[21]);
	mux_2_1 m22(in1[22],in2[22],s,out[22]);
	mux_2_1 m23(in1[23],in2[23],s,out[23]);
	mux_2_1 m24(in1[24],in2[24],s,out[24]);
	mux_2_1 m25(in1[25],in2[25],s,out[25]);
	mux_2_1 m26(in1[26],in2[26],s,out[26]);
	mux_2_1 m27(in1[27],in2[27],s,out[27]);
	mux_2_1 m28(in1[28],in2[28],s,out[28]);
	mux_2_1 m29(in1[29],in2[29],s,out[29]);
	mux_2_1 m30(in1[30],in2[30],s,out[30]);
	mux_2_1 m31(in1[31],in2[31],s,out[31]);
	
endmodule
