module ROM_wr #(parameter DATA_WIDTH = 16, ADDRESS_WIDTH = 8)(
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [9:0] SW,
    output [6:0] HEX0, HEX1, HEX2, HEX3
);

    wire [DATA_WIDTH-1:0] data_out;

    ROM #(.DATA_WIDTH(DATA_WIDTH), .ADDRESS_WIDTH(ADDRESS_WIDTH)) ROM_inst (
        .clk(MAX10_CLK1_50),
        .ce(1'b1),
        .rd_en(KEY[0]),
        .address_in(SW[ADDRESS_WIDTH-1:0]),
        .data_out(data_out),
        .D1(HEX3),
        .D2(HEX2),
        .D3(HEX1),
        .D4(HEX0)
    );

endmodule