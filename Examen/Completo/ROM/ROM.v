module ROM #(parameter DATA_WIDTH = 16, ADDRESS_WIDTH = 8)(
    input clk,ce,rd_en,
    input [ADDRESS_WIDTH-1:0] address_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output [6:0] D1, D2, D3, D4
);

    reg [DATA_WIDTH-1:0] mem [0:2**ADDRESS_WIDTH-1];

    initial begin
        $readmemh("C:/Users/anarg/Downloads/Mem_hex.hex", mem);
    end

    always @(posedge clk) 
	 begin
        if (ce && !rd_en) 
            data_out <= mem[address_in];
    end

    top_10bits_7seg DISPLAY (
        .A(data_out),
        .D1(D1),
        .D2(D2),
        .D3(D3),
        .D4(D4)
    );

endmodule