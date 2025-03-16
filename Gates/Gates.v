module Gates(

	input a,b,
	output reg [7:0] z,
	output temp

);

always @(*)
begin
	z[0] = !a;
	z[1] = !b;
	z[2] = a&b;
	z[3] = a|b;
	z[4] = a^b;
	z[5] = !(a&b);
	z[6] = !(a|b);
	z[7] = !(a^b);
	
end

assign temp = a&b;


endmodule
