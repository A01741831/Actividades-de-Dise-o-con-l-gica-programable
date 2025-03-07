module top_counter_debouncer_clkdiv (
	input clk,rst,up_down,sw,
	input [3:0] data_in,
	//output [6:0] display
	output [6:0] Disp_un,
   output [6:0] Disp_dec,
   output [6:0] Disp_cent,
   output [6:0] Disp_mil

);

	
	wire clk_div;
	wire [3:0] count;
	wire debouncer_sw;
	
	clkdiv clkdiv_count(
		.clk(clk),
		.rst(rst),
		.clk_div(clk_div)
	);
	
	debouncer #(.N_MAX(5000)) debouncer_count(
		.clk(clk),
		.rst_a_p(rst),
		.debouncer_in(sw),
		.debouncer_out(debouncer_sw)
	);
	
	//counter counter_count(
		//.clk(clk_div),
		//.rst(rst),
		//.enable(debouncer_sw),
		//.count(count)
	//);
	
	//decoder_7_seg deco_cont(
		//.decoder_in(count),
		//.decoder_out(display)
	//);
	
	count_load count_top(
		.rst(rst),
		.up_down(sw),
		.load(up_down), //up_down
		.clk(clk_div),
		.data_in(data_in),
	   .count(count)
	);
	
	bcd bcd_top(
    .bcd_in_sw(count),
    .Disp_un(Disp_un),
    .Disp_dec(Disp_dec),
    .Disp_cent(Disp_cent),
    .Disp_mil(Disp_mil)
	);

endmodule