module top_uart_tx_rx_wr_tarjeta1 (
    input MAX10_CLK1_50,
    input [1:0] KEY,
    inout [1:0] GPIO,
	 input [9:0] SW,
    output [9:0] LEDR
);


top_uart_tx_rx MODULO_ASIGNACION (
    .clk(MAX10_CLK1_50),
    .rst(~KEY[0]),
    .send_data(~KEY[1]),
    .data_in(SW[7:0]),
    .data_out(LEDR[7:0]),
    .data_valid(LEDR[9]),
    .parity_error(LEDR[8]),
    .serial_in(GPIO[1]),
    .serial_out(GPIO[0])
);

endmodule