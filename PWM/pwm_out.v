module pwm_out(
input pb_1,pb_2,clk,rst,
output reg pwm_out
);

wire neg_pb_1=~pb_1;
wire neg_pb_2=~pb_2;

wire slow_clk;
wire debouncer_pb_1;
wire debouncer_pb_2;

parameter frecuencia_base='d50_000_000;
parameter frecuencia_final='d50;
parameter cuentas_por_periodo=frecuencia_base/frecuencia_final;
reg [31:0] DC=32'd25_000; 
reg [31:0] ctr;

//instanciacion de clock divader
clkdiv #(.FREQ(20)) u1(
	.clk(clk),
	.rst(rst),
	.clk_div(slow_clk)
	);

//instanciacion del bebouncer para el push button
debouncer2 d1(
	.pb1(neg_pb_1),
	.rst(rst),
	.pb_out(debouncer_pb_1),
	.clk(clk)
	);
	
debouncer2 d2(
	.pb1(neg_pb_2),
	.rst(rst),
	.pb_out(debouncer_pb_2),
	.clk(clk)
	);

//DUTY CYCLE ADJUSTMENT
always@(posedge slow_clk or posedge rst) //slow_clock
	if (rst)
		DC<=32'd25_000; //5% 50_000 10% 100_000
	else
		begin
			if (debouncer_pb_1 && DC < 32'd150_000) 
				DC <= DC + 32'd5000;
			else if (debouncer_pb_2 && DC > 32'd5000)
				DC <= DC - 32'd5000;
end

//GENERATE PMW  PERIODIC SIGNAL
always @(posedge clk)
begin
    if(ctr < cuentas_por_periodo - 1)
        ctr <= ctr + 32'd1;
    else
        ctr <= 0;

    if(ctr > DC)
        pwm_out <= 1'b0;
    else
        pwm_out <= 1'b1;
end
endmodule