module shift_register #(parameter N=4)
                      (input logic clk,
                       input logic rst_n,
                       input logic serial_parallel,
                       input logic load_enable,
                       input logic serial_in,
                       input logic [N-1:0] parallel_in,
                       output logic [N-1:0] parallel_out,
                       output logic serial_out);
    
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            parallel_out <= '0;
        end else begin
            parallel_out <= parallel_in; // Output rule

            if (load_enable) begin // If load is not enabled, the regs don't load
                if (serial_parallel) begin // Load parallel
                    parallel_out <= parallel_in;
                end else begin
                    parallel_out <= (serial_in<<(N-1)) | (parallel_out>>1);
                end
            end
        end
    end

    assign serial_out = parallel_out[0];

endmodule
