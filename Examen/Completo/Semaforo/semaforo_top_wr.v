module semaforo_top_wr (
    input MAX10_CLK1_50,
	 input [1:0] KEY,
    input [9:0] SW,
	 output [9:0] LEDR,
    output [6:0] HEX4, HEX3, HEX2, HEX1, HEX0
);

	semaforo s_t_wr(
	.clk(MAX10_CLK1_50),
	.rst(KEY[0]),
   .sw(SW[9:0]),
	.button(KEY[1]),
	.states(LEDR[9:0]),
   .HEX4(HEX4[6:0]), 
	.HEX3(HEX3[6:0]), 
	.HEX2(HEX2[6:0]), 
	.HEX1(HEX1[6:0]), 
	.HEX0(HEX0[6:0])
	 );
	 
endmodule