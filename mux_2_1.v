module mux_2_1(A, B, S, out);
	input A, B, S;
	output out;
	
	wire ASn;
	wire BS;
	wire Sn;
	
	not(Sn, S);
	and(ASn, A, Sn);
	and(BS, B, S);
	or(out, ASn, BS);
endmodule
