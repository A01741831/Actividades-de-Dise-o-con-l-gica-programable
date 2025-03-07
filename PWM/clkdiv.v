module clkdiv #(parameter FREQ=1)(
	input clk,
	input rst,
	output reg clk_div
	);
	
	localparam CLK_FREQ=50_000_000;
	localparam COUNT_MAX=(CLK_FREQ/(2*FREQ));
	
		reg [31:0] count;
		//reg[ceilog(COUNT_MAX):0] count;
	
	always @(posedge clk or posedge rst)
		if (rst)
			count<=32'b0;	
		else if(count==COUNT_MAX-1)
			count<=32'b0;
		else
			count<=count+1;
			
	
	always @(posedge clk or posedge rst)
		begin
			if(rst==1)
				clk_div<=1'b0;
			else if(count==COUNT_MAX-1)
				clk_div<= ~clk_div;
			else
				clk_div<=clk_div;
		end

endmodule