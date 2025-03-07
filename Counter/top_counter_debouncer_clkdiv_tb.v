module top_counter_debouncer_clkdiv_tb();
	reg clk, rst,up_down,sw;
	//wire [6:0] display;
	reg [3:0] data_in;
	wire [6:0] Disp_un;
   wire [6:0] Disp_dec;
   wire [6:0] Disp_cent;
   wire [6:0] Disp_mil;


	
	top_counter_debouncer_clkdiv DUT (
		.clk(clk),
		.rst(rst),
		.up_down(up_down),
		.sw(sw),
		.data_in(data_in),
		//.display(display)
		.Disp_un(Disp_un),
      .Disp_dec(Disp_dec),
      .Disp_cent(Disp_cent),
      .Disp_mil(Disp_mil)
	);
	
	always begin
		#5 clk=~clk;
		end
		

	initial 
		begin
		clk = 0;
		rst = 1;
		up_down = 0; 
		
		#20 rst = 0;
		#10 up_down = 1;
		#50 up_down = 0;
		#50 rst = 1;
		#10 rst = 0;
		#10 data_in = 4'b1001;
		#10 sw = 1;
		#10 up_down = 1;
		
		end
endmodule