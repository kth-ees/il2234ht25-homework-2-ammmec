module up_down_counter #(parameter N = 4)
                       (input  logic clk,
                        input  logic rst_n,
                        // up_down 1->+1  0->-1
                        input  logic up_down,
                        input  logic load, // Load initial value
                        input  logic [N-1:0] input_load, // Initial value
                        output logic [N-1:0] count_out,
                        output logic carry_out);
  
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count_out <= '0;
      carry_out <= '0;
    end else begin
      carry_out <= 0;
      if (load) begin
        count_out <= input_load;
      end else begin
        if (up_down) begin
          count_out <= count_out + 1;
          carry_out <= count_out == '1; // If count_out is all 1s
        end else begin
          count_out <= count_out - 1;
          carry_out <= count_out == '0; // If count_out is all 0s
        end
      end
    end
  end

endmodule