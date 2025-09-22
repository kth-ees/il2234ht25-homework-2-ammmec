`timescale 1ns/1ns
module shift_register_tb;

    localparam N = 4;

    logic clk = 0;
    logic rst_n;
    logic serial_parallel;
    logic load_enable;
    logic serial_in;
    logic [N-1:0] parallel_in;
    logic [N-1:0] parallel_out;
    logic serial_out;

    shift_register #(.N(N)) dut
                    (.clk(clk),
                     .rst_n(rst_n),
                     .serial_parallel(serial_parallel),
                     .load_enable(load_enable),
                     .serial_in(serial_in),
                     .parallel_in(parallel_in),
                     .parallel_out(parallel_out),
                     .serial_out(serial_out));
    

    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        load_enable = 1;
        serial_parallel = 1;
        parallel_in = 4'b1010;
        serial_in = 1;
        #5;
        rst_n = 1;
        #10;
        serial_parallel = 0;
        #20;
        load_enable = 0;
        #30;
        load_enable = 1;
        serial_in = 0;
        #20;
        parallel_in = '1;
        serial_parallel = 1;
    end

endmodule