module contador (
	input clk_c, rst_c,debouncer_in,
	output [6:0] Disp_un, Disp_dec, Disp_cent, Disp_mil

);

	reg clkdiv;
	wire clk_div;
	
	clkdiv clkdiv_count(
		.clk(clk_c),
		.rst(rst_c),
		.clk_div()
	);
	
	debouncer debouncer_count(
		.clk(clk_c),
		.rst_a_p(rst_c),
		.debouncer_in(debouncer_in),
		.debouncer_out()
	);
	
	counter counter_count(
		.clk(clk_div),
		.rst(rst_c),
		.enable(),
		.count()
	);
	
	bcd bcd_cont(
		.Disp_un(Disp_un),
		.Disp_dec(Disp_dec),
		.Disp_cent(Disp_cent),
		.Disp_mil(Disp_mil)
		
	);

endmodule