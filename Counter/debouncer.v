module debouncer #(parameter N_MAX=5000)(
	input clk, rst_a_p, debouncer_in,
	
	output reg debouncer_out

);

//registros auxiliares
 wire [ceillog2(N_MAX)-1:0] counter_out;
 wire counter_match;
 
counter_debouncer #(.N_MAX(N_MAX)) CONTADOR_PARA_RATE(
	.clk(clk),
	.rst_a_p(rst_a_p),
	.counter_out(counter_out),
	.counter_match(counter_match)
);

always @(posedge counter_match or posedge rst_a_p)
begin
	if(rst_a_p)
	begin
		debouncer_out<=0;
	end
	else 
		debouncer_out<=debouncer_in;
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