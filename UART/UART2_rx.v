module UART2_rx (
    input clk,
    input rst,
    input serial_in,
    output reg [9:0] data_out,
    output reg data_valid,
    output reg parity_error
);

localparam BASE_FREQ = 50_000_000;
localparam BAUD_RATE = 115_200;
localparam COUNTS_PER_BIT = BASE_FREQ / BAUD_RATE;

localparam RX_IDLE = 3'b000;
localparam RX_START = 3'b001;
localparam RX_DATA = 3'b010;
localparam RX_PARITY = 3'b011;
localparam RX_STOP = 3'b100;

reg [2:0] state = RX_IDLE;
reg [31:0] count = 0;
reg [2:0] bit_index = 0;
reg [7:0] data_buffer = 0;
reg received_parity;
reg calculated_parity;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= RX_IDLE;
        data_out <= 0;
        //data_valid <= 0;
        //parity_error <= 0;
        count <= 0;
        bit_index <= 0;
        data_buffer <= 0;
        received_parity <= 0;
        calculated_parity <= 0;
    end else begin
        case (state)
		  
            RX_IDLE: 
				begin
                data_valid <= 0;
                parity_error <= 0;
                if (!serial_in) 
					 begin
                    state <= RX_START;
                    count <= 0;
                end
            end

            RX_START: 
				begin
                if (count < (COUNTS_PER_BIT / 2) - 1) 
					 begin
                    count <= count + 1;
                end 
					 else 
					 begin
                    count <= 0;
                    state <= RX_DATA;
                end
            end

            RX_DATA: 
				begin
                if (count < COUNTS_PER_BIT - 1) 
					 begin
                    count <= count + 1;
                end 
					 else 
					 begin
                    count <= 0;
                    data_buffer[bit_index] <= serial_in;
                    if (bit_index < 7) 
						  begin
                        bit_index <= bit_index + 1;
                    end 
						  else 
						  begin
                        bit_index <= 0;
                        state <= RX_PARITY;
                    end
                end
            end

            RX_PARITY: 
				begin
                if (count < COUNTS_PER_BIT - 1) 
					 begin
                    count <= count + 1;
                end 
					 else 
					 begin
                    count <= 0;
                    received_parity <= serial_in;
                    calculated_parity <= ^data_buffer;
                    state <= RX_STOP;
                end
            end

            RX_STOP: 
				begin
                if (count < COUNTS_PER_BIT - 1) 
					 begin
                    count <= count + 1;
                end 
					 else
					 begin
                    count <= 0;
                    data_out <= data_buffer;
                    data_valid <= 1;
                    parity_error <= (received_parity != calculated_parity);
                    state <= RX_IDLE;
                end
            end
        endcase
    end
end

endmodule