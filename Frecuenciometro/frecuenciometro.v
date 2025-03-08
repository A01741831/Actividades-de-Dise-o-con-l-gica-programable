module frecuenciometro(
    input clk,        
    input rst,        
    input signal,  
    output [6:0] disp1,  
    output [6:0] disp2, 
    output [6:0] disp3,  
    output [6:0] disp4,  
    output [6:0] disp5, 
    output [6:0] disp6   
);
    wire [22:0] pulse_count;
    reg [22:0] pulse_freq;

    reg sync;
    always @(posedge clk or negedge rst) 
		begin
        if (!rst) 
			begin
            sync<=0;
        end 
			else 
				begin
            sync<=signal;
			end
		end

    always @(posedge clk or negedge rst) 
		begin
        if (!rst) 
			begin
            pulse_freq<=0;
        end 
			else 
				begin
					pulse_freq<=pulse_count;
				end
		end

    contador_frecuencia frec_cont (
        .clk(clk),
        .rst(rst),
        .signal(sync),
        .count_value(pulse_count)
    );

    bcd frec_bcd (
        .bcd_in_sw(pulse_freq),   
        .UNI(disp1),    
        .DEC(disp2),    
        .CENT(disp3),    
        .MIL(disp4),    
        .DEC_MIL(disp5),    
        .CENT_MIL(disp6)    
    );

endmodule