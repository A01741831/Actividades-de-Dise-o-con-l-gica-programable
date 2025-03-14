module counter_debouncer(
    input clk, rst_a_p,
    output reg [15:0] counter_out,  
    output reg counter_match
);

always @(posedge clk or posedge rst_a_p) 
begin
    if (rst_a_p) begin
        counter_out <= 0;
        counter_match <= 0;
    end 
    else if (counter_out >= 50000) 
	 begin  
        counter_match <= 1;
        counter_out <= 0;
    end 
    else begin
        counter_out <= counter_out + 1;
        counter_match <= 0;
    end
end
endmodule