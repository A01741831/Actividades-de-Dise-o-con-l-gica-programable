module UART_tx (
    input clk,
    input rst,
    input send_data,
    input [7:0] data,
    output reg serial_out
);

localparam BASE_FREQ = 50_000_000;
localparam BAUD_RATE = 115_200;
localparam COUNTS_PER_BIT = BASE_FREQ / BAUD_RATE;

localparam TX_IDLE = 3'b000;
localparam TX_START = 3'b001;
localparam TX_DATA = 3'b010;
localparam TX_PARITY = 3'b011;
localparam TX_STOP = 3'b100;

reg [2:0] state = TX_IDLE;
reg [31:0] count = 0;
reg [2:0] bit_index = 0;
reg parity_bit;
reg [7:0] data_buffer;
reg send_data_buffer;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_buffer <= 8'b0;
        send_data_buffer <= 1'b0;
    end else begin
        if (send_data && state == TX_IDLE) begin
            data_buffer <= data_in;  // Almacena el nuevo dato
            send_data_buffer <= 1'b1;  // Activa send_data
        end else if (state != TX_IDLE) begin
            send_data_buffer <= 1'b0;  // Desactiva send_data durante la transmisión
        end
    end
end

always @(posedge clk or posedge rst) 
begin
    if (rst) 
		 begin
			  state <= TX_IDLE;
			  serial_out <= 1;
			  count <= 0;
			  bit_index <= 0;
			  parity_bit <= 0;
		 end 
	 else 
		 begin
			  case (state)
					TX_IDLE: 
						begin
							 serial_out <= 1;
							 if (send_data) 
								 begin
									  state <= TX_START;
									  count <= 0;
									  parity_bit <= ^data;
								 end
						end

					TX_START: 
						begin
							 serial_out <= 0; 
							 if (count < COUNTS_PER_BIT - 1) 
								 begin
									  count <= count + 1;
								 end 
							 else 
								 begin
									  count <= 0;
									  state <= TX_DATA;
								 end
						end

					TX_DATA: 
						begin
							 serial_out <= data[bit_index];
							 if (count < COUNTS_PER_BIT - 1) 
								 begin
									  count <= count + 1;
								 end 
							 else 
								 begin
									  count <= 0;
									  if (bit_index < 7) 
										  begin
												bit_index <= bit_index + 1;
										  end 
									  else 
										  begin
												bit_index <= 0;
												state <= TX_PARITY;
										  end
								 end
						end

					TX_PARITY: 
						begin
							 serial_out <= parity_bit;
							 if (count < COUNTS_PER_BIT - 1) 
								 begin
									  count <= count + 1;
								 end 
							 else 
								 begin
									  count <= 0;
									  state <= TX_STOP;
								 end
						end

					TX_STOP: 
						begin
							 serial_out <= 1;
							 if (count < COUNTS_PER_BIT - 1) 
								 begin
									  count <= count + 1;
								 end 
							 else
								 begin
									  count <= 0;
									  state <= TX_IDLE;
								 end
						end
			endcase
		end
end

endmodule