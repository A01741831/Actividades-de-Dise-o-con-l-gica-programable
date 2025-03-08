module frecuenciometro_wr (
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [27:0] GPIO,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    frecuenciometro  wr (
        .clk(MAX10_CLK1_50),
        .rst(KEY[0]),
        .signal(GPIO[27]),
        .disp1(HEX0),
        .disp2(HEX1),
        .disp3(HEX2),
        .disp4(HEX3),
        .disp5(HEX4),
        .disp6(HEX5),
    );

endmodule