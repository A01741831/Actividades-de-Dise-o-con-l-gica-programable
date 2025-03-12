module semaforo (
    input clk, rst,
    input [9:0] sw,
    input button,
    output reg [6:0] HEX4, HEX3, HEX2, HEX1, HEX0,
    output reg [9:0] states
);

    parameter IDLE=0,ARROW=1,GREEN=2,YELLOW=3,RED=4;

    reg [3:0] tiempo_arrow;
    reg [3:0] tiempo_green;
    reg [3:0] tiempo_yellow;
    reg [3:0] tiempo_red;

    reg [2:0] current_state;
    reg [2:0] next_state;
    reg [31:0] counter;

    reg button_prev;
    wire button_pressed;
	 
    always @(posedge clk or negedge rst) 
	 begin
        if (!rst) 
            button_prev <= 0;
		  else
            button_prev <= button;
    end
    assign button_pressed = button && !button_prev;

    always @(posedge clk or negedge rst) 
	 begin
        if (!rst) 
		  begin
            tiempo_arrow<=1;
            tiempo_green<=1;
            tiempo_yellow<=1;
            tiempo_red<=1;
        end 
		  else if (button_pressed) 
		  begin
            if (sw[4]) tiempo_arrow<= sw[3:0];
            if (sw[5]) tiempo_green<= sw[3:0];
            if (sw[6]) tiempo_yellow<= sw[3:0];
            if (sw[7]) tiempo_red<= sw[3:0];
        end
    end

    always @(posedge clk or negedge rst) 
	 begin
        if (!rst) 
		  begin
            current_state <= IDLE;
            counter <= 0;
        end 
		  else 
		  begin
            if (counter == tiempo_espera * 50000000) 
				begin
                current_state <= next_state;
                counter <= 0;
            end 
				else
                counter <= counter + 1;
        end
    end

    always @(*) 
	 begin
        case (current_state)
            IDLE:
					next_state = ARROW;
            ARROW:
					next_state = GREEN;
            GREEN:
					next_state = YELLOW;
            YELLOW:
					next_state = RED;
            RED:
					next_state = ARROW;
        endcase
    end

    reg [3:0] tiempo_espera;
    always @(*) 
	 begin
        case (current_state)
            ARROW:
					tiempo_espera = tiempo_arrow;
            GREEN:
					tiempo_espera = tiempo_green;
            YELLOW:
					tiempo_espera = tiempo_yellow;
            RED:
					tiempo_espera = tiempo_red;
        endcase
    end

    always @(*) 
	 begin
        case (current_state)
            IDLE:
				begin
                states = 10'b0000000001;
                HEX4 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX2 = 7'b1111111;
                HEX1 = 7'b1111111;
                HEX0 = 7'b1111111;
            end
				
            ARROW:
				begin
                states = 10'b0000000010;
                HEX4 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX2 = 7'b1111111;
                HEX1 = 7'b0010000;
                HEX0 = 7'b0001000;
            end
				
            GREEN: 
				begin
                states = 10'b0000000100;
                HEX4 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX2 = 7'b1111111;
                HEX1 = 7'b1111111;
                HEX0 = 7'b0010000;
            end
				
            YELLOW: 
				begin
                states = 10'b0000001000;
                HEX4 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX2 = 7'b1111111;
                HEX1 = 7'b1111111;
                HEX0 = 7'b0010001;
            end
            RED: begin
                states = 10'b0000010000;
                HEX4 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX2 = 7'b1111111;
                HEX1 = 7'b1111111;
                HEX0 = 7'b0101111;
            end
        endcase
    end

endmodule