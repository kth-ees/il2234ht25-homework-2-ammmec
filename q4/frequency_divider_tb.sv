`timescale 1ns/1ns

module frequency_divider_tb;

    logic clk = 0;
    logic rst_n;
    logic divider_out;

    int cycles;

    frequency_divider dut (.clk(clk),
                           .rst_n(rst_n),
                           .divider_out(divider_out));
    
    always begin
        #5 clk = ~clk;
        if (clk) cycles = cycles+1;
    end

    initial begin
        $monitor("Clock cycles: %d", cycles);
        rst_n = 0;
        #25;
        rst_n = 1;
        #1;
        cycles = 0;
    end
endmodule