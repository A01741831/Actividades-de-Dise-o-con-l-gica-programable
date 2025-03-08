 module pw (
    input clk, rst,
    input [9:0] sw,
	 output [9:0] states,
    output [6:0] HEX4, HEX3, HEX2, HEX1, HEX0
);

    wire clk_div;
	 wire [9:0] sw_clear;
	 wire password_out;
	 
    clkdiv#(.FREQ(10)) clk_pw(
        .clk(clk),
        .rst(rst),
        .clk_div(clk_div)
    );
	
	genvar i;
    generate
        for (i=0;i<10;i=i+1) 
			begin : one_shot_gen
            one_shot one_pw(
                .clk(clk_div),
                .botton_a(sw[i]),
                .oneshot_a(sw_clear[i])
            );
        end
    endgenerate


    password password_pw(
        .clk(clk_div),
        .rst(rst),
        .sw(sw_clear),
		  .states(states),
		  .password_out(password_out),
        .HEX4(HEX4), 
        .HEX3(HEX3), 
        .HEX2(HEX2), 
        .HEX1(HEX1), 
        .HEX0(HEX0)
    );

endmodule