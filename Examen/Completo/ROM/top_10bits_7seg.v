module top_10bits_7seg #(parameter N = 16)(
    input [N-1:0] A,
    output [6:0] D1,D2,D3,D4
);

    wire [3:0] hex1;
    wire [3:0] hex2;
    wire [3:0] hex3;
    wire [3:0] hex4;

    assign hex1 = A[15:12];
    assign hex2 = A[11:8];
    assign hex3 = A[7:4];
    assign hex4 = A[3:0];

    decoder_7_seg DISPLAY_1 (
        .decoder_in(hex1),
        .decoder_out(D1)
    );

    decoder_7_seg DISPLAY_2 (
        .decoder_in(hex2),
        .decoder_out(D2)
    );

    decoder_7_seg DISPLAY_3 (
        .decoder_in(hex3),
        .decoder_out(D3)
    );

    decoder_7_seg DISPLAY_4 (
        .decoder_in(hex4),
        .decoder_out(D4)
    );

endmodule