module counter_16b (
    input  logic clk, rst_n,
    input  logic ld_en,
    input  logic cnt_en,
    input  logic [15:0] load_value,
    input  logic carry_in,
    output logic [15:0] counter_out,
    output logic carry_out
);

    logic cin1, cin2, cin3;

    // Least significant bits
    counter_4b c0 (
        .clk(clk), 
        .rst_n(rst_n),
        .ld_en(ld_en),
        .cnt_en(cnt_en),
        .load_value(load_value[3:0]),
        .carry_in(carry_in),
        .counter_out(counter_out[3:0]),
        .carry_out(cin1)
    );

    counter_4b c1 (
        .clk(clk), 
        .rst_n(rst_n),
        .ld_en(ld_en),
        .cnt_en(cnt_en),
        .load_value(load_value[7:4]),
        .carry_in(cin1),
        .counter_out(counter_out[7:4]),
        .carry_out(cin2)
    );

    counter_4b c2 (
        .clk(clk), 
        .rst_n(rst_n),
        .ld_en(ld_en),
        .cnt_en(cnt_en),
        .load_value(load_value[11:8]),
        .carry_in(cin2),
        .counter_out(counter_out[11:8]),
        .carry_out(cin3)
    );

    // Most significant bits
    counter_4b c3 (
        .clk(clk), 
        .rst_n(rst_n),
        .ld_en(ld_en),
        .cnt_en(cnt_en),
        .load_value(load_value[15:12]),
        .carry_in(cin3),
        .counter_out(counter_out[15:12]),
        .carry_out(carry_out)
    );

endmodule