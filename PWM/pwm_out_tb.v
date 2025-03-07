module pwm_out_tb ();
	
	reg pb_1;
	reg pb_2;
	reg clk=0;
	reg rst=1;
	wire pwm_out;

	pwm_out DUT(
	.pb_1(pb_1),
	.pb_2(pb_2),
	.clk(clk),
	.rst(rst),
	.pwm_out(pwm_out)
	);
	
	always #10 clk<=~clk;
	
	initial
		begin
			rst=0;
			#500;
			rst=1;
			#500;
			pb_1=0;
			#5000;
			pb_1=1;
			#5000;
			pb_2=0;
			#5000;
			pb_2=1;
			#5000;
		end	
		
endmodule