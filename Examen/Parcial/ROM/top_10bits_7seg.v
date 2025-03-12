module top_10bits_7seg #(parameter N=5)(
	input [N-1:0] A, //input número binario
	output [0:6] D1,D2,D3,D4
);
	wire [9:0] unidades;
	wire [9:0] decenas;
	wire [9:0] centenas;
	wire [9:0] millar;

//Separar las decenas y las unidades para el display
assign unidades=A%10; //D1
assign decenas=A%100/10; //D2
assign centenas=A%1000/100; //D3
assign millar=A/1000; //D4

//D1
	decoder_7_seg DISPLAY_1 (
	.decoder_in(unidades),
	.decoder_out(D1)
	);

//D2
	decoder_7_seg DISPLAY_2 (
	.decoder_in(decenas),
	.decoder_out(D2)
	);

//D3
	decoder_7_seg DISPLAY_3 (
	.decoder_in(centenas),
	.decoder_out(D3)
	);

//D4
	decoder_7_seg DISPLAY_4 (
	.decoder_in(millar),
	.decoder_out(D4)
	);

endmodule