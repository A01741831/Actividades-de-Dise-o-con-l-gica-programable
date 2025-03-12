module semaforo (
	input clk,rst,
	input [9:0] sw,
	output reg [6:0] HEX4, HEX3, HEX2, HEX1, HEX0,
	output reg [9:0] states
);
	
	parameter IDLE=0,ARROW=1,GREEN=2,YELLOW=3,RED=4,STOP=5;
	
	reg [2:0] current_state;
	reg [2:0] next_state;
	reg [31:0] tiempo_completo;
	
	counter c_s(
	.clk(clk),
	.rst(rst), 
	.enable(sw),
	.count(count)
	);
	
	always @(posedge clk or negedge rst)
		begin
			if(!rst)
				current_state<=IDLE;
			else
				current_state<=next_state;
		end
	
	
	always @(current_state,sw)
		begin
			case(current_state)
			
				IDLE:
					begin
						if(sw[0]==0)
							next_state=IDLE;
						else
							next_state=ARROW;
					end
					
				ARROW:
					begin
						if(sw[0]==1)
							next_state=GREEN;
							
						else
							next_state=ARROW;
					end
					
				GREEN:
					begin
						if(sw[0]==1)
							next_state=YELLOW;
							
						else
							next_state=GREEN;
					end
					
				YELLOW:
					begin
						if(sw[0]==1)
							next_state=RED;
							
						else
							next_state=YELLOW;
					end
					
				RED:
					begin
						if(sw[0]==1)
							next_state=IDLE;
							
						else
							next_state=RED;
					end
			endcase
		end

		
		always @(current_state,sw)
			begin
				case(current_state)
					IDLE:
					begin
					states=10'b0000000001;
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b1111111;
               HEX0 = 7'b1111111;
					tiempo_completo=0;
					end
					
					ARROW:
					begin
					states=10'b0000000010;
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b0010000;
               HEX0 = 7'b0001000;
					tiempo_completo=1;
					end
					
					GREEN:
					begin
					states=10'b0000000100;
					HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b1111111;
               HEX0 = 7'b0010000;
					tiempo_completo=2;
					end
					
					RED:
					begin
					states=10'b00_0000_1000;
               HEX4 = 7'b1111111;
               HEX3 = 7'b1111111;
               HEX2 = 7'b1111111;
               HEX1 = 7'b1111111;
               HEX0 = 7'b0101111;
					tiempo_completo=3;
					end
					
				endcase
			end 


endmodule