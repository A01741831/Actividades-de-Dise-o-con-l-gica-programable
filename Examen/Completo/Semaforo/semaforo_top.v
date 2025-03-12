module semaforo_top (
    input clk, rst,
    input [9:0] sw,
	 input button,
    output [9:0] states,
    output [6:0] HEX4, HEX3, HEX2, HEX1, HEX0
);

    wire clk_div;
    
    clkdiv #(.FREQ(1)) clk_pw(
        .clk(clk),
        .rst(rst),
        .clk_div(clk_div)
    );
    
    semaforo s_t(
        .clk(clk_div),
        .rst(rst),
        .sw(sw),
		  .button(button),
        .states(states),
        .HEX4(HEX4), 
        .HEX3(HEX3), 
        .HEX2(HEX2), 
        .HEX1(HEX1), 
        .HEX0(HEX0)
    );

endmodule