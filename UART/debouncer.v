module debouncer(	
	input clk, rst_a_p, debouncer_in,
	output reg debouncer_out
);

//Señales auxiliares
wire [15:0] counter_out; //50000
wire counter_match;	

//Instancia
counter_debouncer CONTADOR_PARA_RATE (.clk(clk),.rst_a_p(rst_a_p),.counter_out(counter_out),.counter_match(counter_match));

reg debouncer_state;

always@(posedge clk or posedge rst_a_p)
begin
    if (rst_a_p) begin
        debouncer_out <= 0;
        debouncer_state <= 0;
    end 
    else if (counter_match) begin
        debouncer_state <= debouncer_in;
		  debouncer_out <= debouncer_state;
    end
end
endmodule