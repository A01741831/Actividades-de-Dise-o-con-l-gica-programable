module Display_unidad (
	input [3:0] disp_in, 
	output [6:0] disp_out
	);
	decoder_7_seg decoder (
		.decoder_in(disp_in),
		.decoder_out(disp_out)
	);
		  
endmodule

module Display_decena (
	input [3:0] disp_in, 
	output [6:0] disp_out
	);
	decoder_7_seg decoder (
		.decoder_in(disp_in),
		.decoder_out(disp_out)
	);
endmodule

module Display_centena (
	input [3:0] disp_in, 
	output [6:0] disp_out
	);
	decoder_7_seg decoder (
		.decoder_in(disp_in),
		.decoder_out(disp_out)
	);	
endmodule

module Display_miles (
	input [3:0] disp_in, 
	output [6:0] disp_out
	);
	decoder_7_seg decoder (
		.decoder_in(disp_in),
		.decoder_out(disp_out)
	);
endmodule