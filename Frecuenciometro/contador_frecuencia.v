module contador_frecuencia(
    input clk, rst, signal,
    output reg [22:0] count_value
);
    reg [22:0] count;
    reg signal_prev;
    reg [25:0] timer;

    always @(posedge clk or negedge rst) begin
        if (!rst) 
			begin
            count<=0;
            count_value<=0;
            signal_prev<=0;
            timer<=0;
        end 
		  
		  else 
			begin
            signal_prev<=signal;
            if (signal&&!signal_prev) 
					begin
                count<=count+1;
					end

            if (timer==50_000_000) 
					begin
                count_value<=count;
                count<=0;
                timer<=0;
					end 
				else 
					begin
                timer<=timer+1;
					end
			end
    end
endmodule