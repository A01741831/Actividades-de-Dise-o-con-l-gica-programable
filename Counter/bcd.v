module bcd #(parameter N = 10)(

    input [N-1:0] bcd_in_sw,
    output [6:0] Disp_un,
    output [6:0] Disp_dec,
    output [6:0] Disp_cent,
    output [6:0] Disp_mil

);

    wire [3:0] un;
    wire [3:0] dec;
    wire [3:0] cent;
    wire [3:0] mil;

    assign un=bcd_in_sw%10;             // Unidad
    assign dec=bcd_in_sw % 100/10;    // Decena
    assign cent=bcd_in_sw % 1000/100; // Centena
    assign mil=bcd_in_sw/1000;          // Miles

    Display_unidad UN(
        .disp_in(un),
        .disp_out(Disp_un)
    );

    Display_decena DEC(
        .disp_in(dec),
        .disp_out(Disp_dec)
    );

    Display_centena CENT(
        .disp_in(cent),
        .disp_out(Disp_cent)
    );

    Display_miles MIL(
        .disp_in(mil),
        .disp_out(Disp_mil)
    );
endmodule