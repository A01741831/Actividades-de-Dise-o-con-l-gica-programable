module bcd_tb #(parameter N=10, iteraciones=10)();

	reg [N-1:0] bcd_in_sw;
	
	wire[6:0] Display_un;
	wire[6:0] Display_dec;
	wire[6:0] Display_cent;
	wire[6:0] Display_mil;
	
	bcd DUT(
	.bcd_in_sw(bcd_in_sw),
	.Disp_un(Display_un),
	.Disp_dec(Display_dec),
	.Disp_cent(Display_cent),
	.Disp_mil(Display_mil)
	);
	
	task set_input();
		bcd_in_sw=$urandom_range(0,2**N-1);
		$display("Valor a probar = %d", bcd_in_sw);
		#10;
	endtask
	
	integer i;
	
	initial
		begin
			for(i=0; i<iteraciones;i=i+1)
				begin
					set_input();
				end
		end
 
endmodule