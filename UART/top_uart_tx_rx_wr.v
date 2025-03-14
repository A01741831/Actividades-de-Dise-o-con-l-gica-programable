module top_uart_tx_rx_wr (
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [9:0] SW,
    output [9:0] LEDR
);

wire serial_tx;
wire serial_rx; 

assign serial_rx = serial_tx;

top_uart_tx_rx MODULO_ASIGNACION (
    .clk(MAX10_CLK1_50),
    .rst(~KEY[0]),
    .send_data(~KEY[1]),
    .data_in(SW[7:0]),
    .data_out(LEDR[7:0]),
    .data_valid(LEDR[9]),
    .parity_error(LEDR[8]),
    .serial_in(serial_rx),
    .serial_out(serial_tx)
);

endmodule