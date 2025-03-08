module pw_tb();

    reg clk;
    reg rst;
    reg [9:0] sw;

    wire [9:0] states;
    wire [6:0] HEX4, HEX3, HEX2, HEX1, HEX0;


    pw DUT (
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .states(states),
        .HEX4(HEX4),
        .HEX3(HEX3),
        .HEX2(HEX2),
        .HEX1(HEX1),
        .HEX0(HEX0)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        rst = 1;
        sw = 10'b0000000000;


        #20 rst = 0;

        #10 sw[0]=1;
        #20 sw[1]=1;
        #20 sw[2]=1;
        #20 sw[3]=1;
        #20 sw=0;

        #50;

        #10 sw[0]=1;
        #20 sw[2]=1;
        #20 sw=0;

        #50;

        #10 sw[0]=1;
        #20 sw[1]=1;
        #20 rst=1;
        #10 rst=0;
        #20 sw=0;

        #50;

        $stop;
    end

endmodule