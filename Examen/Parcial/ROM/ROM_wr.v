module ROM_wr #(parameter DATA_WIDTH = 16, ADDRESS_WIDTH = 8)(
	input MAX10_CLK1_50, 
	input [1:0] KEY, 
	input [9:0] SW,
	output [ADDRESS_WIDTH - 1:0] data_out,
	output [0:6] HEX0,
   output [0:6] HEX1,
   output [0:6] HEX2,
   output [0:6] HEX3
);

ROM #(.DATA_WIDTH(16), .ADDRESS_WIDTH(8)) ASIGNACION(
.clk(MAX10_CLK1_50), 
	.ce(1'b1), 
	.rd_en(KEY[0]),
	.address_in(SW[9:5]),
	.data_out(data_out),
	.D1(HEX0),
	.D2(HEX1),
	.D3(HEX2),
	.D4(HEX3) 
);

endmodule