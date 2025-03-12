`timescale 1ns/1ps

module pw_tb();

	reg clk=1;
	reg rst=1;
	reg [9:0] sw=0;
	wire [6:0] HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [9:0] states;

	pw DUT (
		.clk(clk),
		.rst(rst),
		.sw(sw),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.states(states)
	);
	
	always #10 clk=~clk;
	
	initial
	begin
		rst=0;
		#10;
		rst=1;
		#10;
		rst=0;
		#10;
		rst=1;
		
		#30;
		sw=10'b0000000001;
		#30;	sw=0;
		#30;
		sw=10'b0000000010;
		#30;	sw=0;
		#30;
		sw=10'b0000000100;
		#30;	sw=0;
		#30;
		sw=10'b000001000;
		#30;	sw=0;
		#30;
		$stop;
	end
	
endmodule