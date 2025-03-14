module oneshot(
    input clk, button_a, rst,
    output reg salida_xor_and
);
reg delay_b;
reg [3:0] count; // Contador para alargar el pulso

always @(posedge clk or negedge rst)
begin
    if (~rst) begin
        salida_xor_and <= 0;
        count <= 0;
    end else begin
        delay_b <= button_a;
        if ((button_a != delay_b) && button_a) begin
            salida_xor_and <= 1;
            count <= 5; // Mantener activo por 5 ciclos de clk
        end else if (count > 0) begin
            count <= count - 1;
            salida_xor_and <= 1;
        end else begin
            salida_xor_and <= 0;
        end
    end
end
endmodule



/*module oneshot(
	input clk, button_a, rst,
	output reg salida_xor_and
);

//señales auxiliares
reg delay_b;


always @(posedge clk or negedge rst)
	begin
		if (~rst)
			salida_xor_and <= 0;
		else
			begin
				delay_b <= button_a;
				if((button_a != delay_b) && button_a)
					salida_xor_and <= 1;
				else
					salida_xor_and <= 0;
			end
	end
endmodule
*/