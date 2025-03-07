module counter_debouncer #(parameter N_MAX =5000)(
	input  clk, rst_a_p, //Reset asincrono, flanco positivo
	
	output reg [ceillog2(N_MAX)-1:0] counter_out,
	output reg counter_match    
 );
 
 always @(posedge clk or posedge rst_a_p) //Depende de los flancos de subida del reloj
 begin
	if(rst_a_p)
	begin
		counter_out<=0;
		counter_match<=0;
	end
	else
		begin
			if(counter_out>=N_MAX-1) //Checar que el contador no pase de 5000
				begin
					counter_out<=0;
					counter_match<=1;
				end
			else
				begin
					counter_out<=counter_out+1;
					counter_match<=0;
				end
		end
 end
 
//log function
 
	function integer ceillog2;
		input integer data;
		integer i,result;
		begin
		result=0;
			for(i=0; 2**i<data; i=i+1)
				result=i+1;
			ceillog2=result;
		end
	endfunction

endmodule