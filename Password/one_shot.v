module one_shot(
	input clk, botton_a,
	output reg oneshot_a

);

	//auxiliares
	reg delay_b;    
	
	always @(posedge clk)
		begin
			delay_b<=botton_a;
			
			if((botton_a != delay_b) && botton_a==1)
				oneshot_a<=1;
			else
				oneshot_a<=0;
		end
endmodule

// oneshot_a<=((delay:b^button_a)&bitton_a);