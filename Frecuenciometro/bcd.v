module bcd (
    input [22:0] bcd_in_sw,
    output [6:0] UNI, DEC, CENT, MIL, DEC_MIL, CENT_MIL
);
    wire [3:0] Uni;
    wire [3:0] Dec;
    wire [3:0] Cent;
    wire [3:0] Mil;
    wire [3:0] Dec_mil;
    wire [3:0] Cent_mil;


    assign Uni=bcd_in_sw%10;
    assign Dec=(bcd_in_sw/10)%10;
    assign Cent=(bcd_in_sw/100)%10;
    assign Mil=(bcd_in_sw/1000)%10;
    assign Dec_mil=(bcd_in_sw/10000)%10;
    assign Cent_mil=bcd_in_sw/100000;

    decoder_7_seg DISPLAY_1 
	 (.decoder_in(Uni), 
	 .decoder_out(UNI)
	 );
	 
    decoder_7_seg DISPLAY_2 
	 (.decoder_in(Dec), 
	 .decoder_out(DEC)
	 );
	 
    decoder_7_seg DISPLAY_3 
	 (.decoder_in(Cent), 
	 .decoder_out(CENT)
	 );
    decoder_7_seg DISPLAY_4 
	 (.decoder_in(Mil), 
	 .decoder_out(MIL)
	 );
	 
    decoder_7_seg DISPLAY_5 
	 (.decoder_in(Dec_mil), 
	 .decoder_out(DEC_MIL)
	 );
	 
    decoder_7_seg DISPLAY_6 
	 (.decoder_in(Cent_mil), 
	 .decoder_out(CENT_MIL)
	 );

endmodule