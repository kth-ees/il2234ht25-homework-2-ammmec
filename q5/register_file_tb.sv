`timescale 1ns/1ns
module registerfile_tb;

    logic clk = 0;
    logic rst_n;
    logic write_en;
    logic [3:0] write_addr, read_addr1, read_addr2;
    logic [7:0] data_in, data_out1, data_out2;

    registerfile dut (  .clk(clk),
                        .rst_n(rst_n),
                        .write_en(write_en),
                        .write_addr(write_addr),
                        .data_in(data_in),
                        .read_addr1(read_addr1),
                        .read_addr2(read_addr2),
                        .data_out1(data_out1),
                        .data_out2(data_out2)
                );
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        write_en = 1;
        data_in = '1;
        write_addr = 4'd3;
        read_addr1 = 4'd3;
        read_addr2 = 4'd1;
        #10;
        rst_n = 1;
        
        for (int i = 0; i < 16; i++) begin
            write_addr = $random;
            read_addr1 = $random;
            read_addr2 = $random;
            data_in = $random;
            write_en = $random;
            #5;
        end

        rst_n = 0;
        #5;
    end
endmodule