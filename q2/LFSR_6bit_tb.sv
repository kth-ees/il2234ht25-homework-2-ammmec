`timescale 1ns/1ns

module LFSR_6bit_tb;
  logic clk = 0;
  logic rst_n;
  logic sel;
  logic [5:0] parallel_in;
  logic [5:0] parallel_out;

  LFSR_6bit dut (
    .clk(clk),
    .rst_n(rst_n),
    .sel(sel),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out)
  );

    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        sel   = 0;
        parallel_in = '1;
        #2;
        rst_n = 1;
        #5;
        sel = 1;
        parallel_in = '0;
    end

endmodule