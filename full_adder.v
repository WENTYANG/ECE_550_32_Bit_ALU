module full_adder(A, B, cin, cout, sum);

	input A, B, cin;
	output sum, cout;
	
	wire AxB, Ac, Bc, ABorAc, AB;

	xor(AxB, A, B);
	xor(sum, AxB, cin);
	
	and(AB, A, B);
	and(Ac, A, cin);
	and(Bc, B, cin);
	
	or(ABorAc, AB, Ac);
	or(cout, ABorAc, Bc);
	
endmodule
