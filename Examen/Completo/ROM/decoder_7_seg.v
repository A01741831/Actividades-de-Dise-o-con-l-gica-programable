module decoder_7_seg(
    input [3:0] decoder_in,
    output reg [6:0] decoder_out
);

    always @(*) begin
        case (decoder_in)
            0: decoder_out = 7'b1000000;
            1: decoder_out = 7'b1111001;
            2: decoder_out = 7'b0100100;
            3: decoder_out = 7'b0110000;
            4: decoder_out = 7'b0011001;
            5: decoder_out = 7'b0010010;
            6: decoder_out = 7'b0000010;
            7: decoder_out = 7'b1111000;
            8: decoder_out = 7'b0000000;
            9: decoder_out = 7'b0010000;
            10: decoder_out = 7'b0001000;
            11: decoder_out = 7'b0000011;
            12: decoder_out = 7'b1000110;
            13: decoder_out = 7'b0100001;
            14: decoder_out = 7'b0000110;
            15: decoder_out = 7'b0001110;
            default: decoder_out = 7'b1111111;
        endcase
    end

endmodule