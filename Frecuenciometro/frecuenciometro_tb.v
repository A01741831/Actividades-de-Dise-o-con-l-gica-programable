module frecuenciometro_tb();
    reg clk;
    reg rst;
    reg signal;
    wire [6:0] disp1;
    wire [6:0] disp2;
    wire [6:0] disp3;
    wire [6:0] disp4;
    wire [6:0] disp5;
    wire [6:0] disp6;

    frecuenciometro DUT (
        .clk(clk),
        .rst(rst),
        .signal(signal),
        .disp1(disp1),
        .disp2(disp2),
        .disp3(disp3),
        .disp4(disp4),
        .disp5(disp5),
        .disp6(disp6)
    );


    always #10 clk=~clk;

    integer i;
    initial 
		begin
        clk=0;
        rst=0;
        signal=0;

        #10 rst=1;

        for (i=0;i<500;i=i+1) 
			begin
            signal=~signal;
            #5_000;
        end

        $stop;
    end
endmodule
