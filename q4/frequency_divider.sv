module frequency_divider (input logic clk,
                          input logic rst_n,
                          output logic divider_out);
  
  // Alternate between   18    &  866    (max value = 65535)
  //    -> start values 65517  & 64669

    typedef enum logic[1:0] {LOAD18, COUNT18, LOAD866, COUNT866} state_t;
    state_t p_state, n_state;

    logic signal_count;
    logic load;
    logic en;
    logic [15:0] load_value;
    logic [15:0] counter_out;

    counter_16b counter (
        .clk(clk),
        .rst_n(rst_n),
        .ld_en(load),
        .cnt_en(en),
        .load_value(load_value),
        .carry_in(en),
        .counter_out(counter_out),
        .carry_out(signal_count)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p_state <= LOAD18;
            divider_out <= 0;
        end
        else begin
            p_state <= n_state;
            if (signal_count) divider_out <= ~divider_out; // For 50% duty cycle, change when signal_count
        end
    end

    
    always_comb begin : state_machine
        n_state = LOAD18; load = 0; en = 1;
        load_value = '0;

        case (p_state)
            LOAD18 : begin
                        n_state = COUNT18;
                        load = 1; en = 1; load_value = 16'd65519; // +1 to counter to account for load cycle
                     end
            COUNT18: begin // This will be done twice, so the frequency gets divided by 18 in the rising and falling edges
                        if (signal_count && divider_out) n_state = LOAD866;
                        else if (signal_count) n_state = LOAD18;
                        else n_state = COUNT18;
                        load = 0; en = 1;
                     end
            LOAD866: begin
                        n_state = COUNT866;
                        load = 1; en = 1; load_value = 16'd64670;
                     end
            COUNT866:begin
                        if (signal_count && divider_out) n_state = LOAD18;
                        else if (signal_count) n_state = LOAD866;
                        else n_state = COUNT866;
                     end
            default: begin
                        n_state = LOAD18; load = 0; en = 1;
                        load_value = '0;
                      end
        endcase
    end

  endmodule