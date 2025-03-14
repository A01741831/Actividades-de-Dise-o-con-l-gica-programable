module top_uart_tx_rx (
    input clk, rst,
    input send_data,
    input [7:0] data_in,
    output [7:0] data_out,
    output data_valid,
    output parity_error,
    input serial_in,
    output serial_out
);
	

	
UART_tx uart_tx_inst (
    .clk(clk),
    .rst(rst),
    .send_data(send_data),
    .data(data_in),
    .serial_out(serial_out)
);

UART2_rx uart_rx_inst (
    .clk(clk),
    .rst(rst),
    .serial_in(serial_in),
    .data_out(data_out),
    .data_valid(data_valid),
    .parity_error(parity_error)
);

endmodule