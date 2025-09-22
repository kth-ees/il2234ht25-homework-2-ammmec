module counter_4b (
    input  logic clk, rst_n,
    input  logic ld_en,
    input  logic cnt_en,
    input  logic [3:0] load_value,
    input  logic carry_in,
    output logic [3:0] counter_out,
    output logic carry_out
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter_out <= '0;
        end else begin
            counter_out <= counter_out;
            if (ld_en) begin
                counter_out <= load_value;
            end else if (cnt_en) begin
                counter_out <= carry_in ? counter_out + 1 : counter_out;
            end 
        end
    end

    assign carry_out = cnt_en ? &{counter_out, carry_in} : 1'b0;

endmodule