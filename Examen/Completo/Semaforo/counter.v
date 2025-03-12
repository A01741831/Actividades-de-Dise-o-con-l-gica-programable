module counter (clk, rst, enable, count);
	input clk, rst, enable;
	output reg [3:0] count;
	
	//always @(posedge clk)
	always @(posedge clk or posedge rst)
	begin
		if (rst)
		count<=4'b0000;
		else if(enable)
		count<=count+1;
	end
endmodule