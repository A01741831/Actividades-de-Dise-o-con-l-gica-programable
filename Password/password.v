module password(
    input clk, rst,
    input [9:0] sw,
    output reg [6:0] HEX4, HEX3, HEX2, HEX1, HEX0,
	 output reg [9:0] states,
    output reg password_out
);


    parameter error=0,idle=1,pri_dig=2,seg_dig=3,ter_dig=4,cuar_dig=5,done=6;
    
    reg [2:0] current_state;
    reg [2:0] next_state;


    always @(posedge clk or negedge rst) begin
        if (!rst)
            current_state <= idle;
        else
            current_state <= next_state;
    end

    always @(current_state,sw) begin
        case (current_state)
		  
				error:
                if (sw == 0)
                    next_state <= error;
                else
                    next_state <= idle;
						  
            idle:
                if (sw[0])
                    next_state<=pri_dig;
                else if (sw == 0)
                    next_state <= idle;
                else
                    next_state <= error;

            pri_dig:
                if (sw[1])
                    next_state <= seg_dig;
                else if (sw == 0)
                    next_state <= pri_dig;
                else
                    next_state <= error;

            seg_dig:
                if (sw[2])
                    next_state <= ter_dig;
                else if (sw == 0)
                    next_state <= seg_dig;
                else
                    next_state <= error;

            ter_dig:
                if (sw[3])
                    next_state <= cuar_dig;
                else if (sw == 0)
                    next_state <= ter_dig;
                else
                    next_state <= error;

            cuar_dig:
                if (sw == 0)
                    next_state <= done;
                else
                    next_state <= idle;
						 
				done:
                if (sw == 0)
                    next_state <= done;
                else
                    next_state <= idle;
            
        endcase
    end

    // Lógica de salida
    always @(current_state) begin
   
        case (current_state)
            idle:
				begin
				states=10'b0000000001;
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b1111111;
               HEX0 = 7'b1000000;
					password_out = 0;
				end

            pri_dig:
				begin
				states=10'b0000000011; 
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b1111111;
               HEX0 = 7'b0111111;
					password_out = 0;
				end

            seg_dig:
            begin
				states=10'b00_0000_0111;
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b0111111;
               HEX0 = 7'b0111111;
					password_out = 0;
				end

            ter_dig:
            begin
				states=10'b00_0000_1111;
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b0111111;
               HEX1 = 7'b0111111;
               HEX0 = 7'b0111111;
					password_out = 0;
				end

            cuar_dig:
            begin
				states=10'b00_0001_1111;
					HEX4 = 7'b1111111;
               HEX3 = 7'b0111111;
               HEX2 = 7'b0111111;
               HEX1 = 7'b0111111;
               HEX0 = 7'b0111111;
					password_out = 0;
				end

            done:
            begin
				states=10'b01_0000_0000;
                HEX4 = 7'b1111111;
                HEX3 = 7'b0100001;
                HEX2 = 7'b1000000;
                HEX1 = 7'b1001000;
                HEX0 = 7'b0000110;
                password_out = 1;
            end

            error:
            begin
				states=10'b10_0000_0000;
                HEX4 = 7'b0000110;
                HEX3 = 7'b0101111;
                HEX2 = 7'b0101111;
                HEX1 = 7'b0100011;
                HEX0 = 7'b0101111;
                password_out = 0;
            end
        endcase
    end

endmodule