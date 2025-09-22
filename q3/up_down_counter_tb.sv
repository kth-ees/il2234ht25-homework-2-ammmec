`timescale 1ns/1ns

module up_down_counter_tb;

    localparam N = 4;
    
    logic clk = 0;
    logic rst_n;
    logic up_down;
    logic load;
    logic [N-1:0] input_load;
    logic [N-1:0] count_out;
    logic carry_out;

    up_down_counter #(.N(N)) dut
                       (.clk(clk),
                        .rst_n(rst_n),
                        .up_down(up_down),
                        .load(load),
                        .input_load(input_load),
                        .count_out(count_out),
                        .carry_out(carry_out));

    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        load   = 1; 
        input_load = ($pow(N, 2))/2;
        up_down = 1;
        #2;
        rst_n = 1;
        #5;
        load = 0;
        #(($pow(N, 2)+2)*5); // Do all counting

        load = 1;
        input_load = ($pow(N, 2))/2;
        up_down = 0;
        #10;
        load = 0;
        #(($pow(N, 2)+3)*5); // Do all counting
        $stop;
    end


endmodule