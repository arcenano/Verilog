module handshake #(
    parameter int WIDTH = 7
) (
    // Source domain
    input  logic             clk_s,
    input  logic             reset_s,    
    input  logic             new_data_s, // Flag that new data has been loaded
    input  logic [WIDTH-1:0] data_in_s,  // Input data from sender
    output logic             send_s,     // Flag to send in new data

    // Destination domain
    input  logic             clk_d,
    input  logic             reset_d,
    output logic [WIDTH-1:0] data_out_d, // Data output in receiever clock
    output logic             capture_d   // Flag to capture_d data
); 
    // Source domain
    logic ack_synced_s, ack_delayed_s, valid_s, enable_s, new_data_latch_s;
    logic req_s = 1'b0;
    logic start_s = 1'b1;
    logic [WIDTH-1:0] send_buffer;

    // Destination domain
    logic ack_d = 1'b0;
    logic req_delayed_d = 1'b0;
    logic req_synced_d, enable_d;

    always_ff @(posedge clk_s) begin
        if (reset_s) begin
            // reset
            if (start_s)begin // If we don't have new data ask for some (will need it on next cycle)
                send_s <= 1'b1;
            end 

        end else begin
            if (enable_s) begin // Ready to send
                send_buffer <= data_in_s;
                req_s <= 1'b1;
                send_s <= 1'b1;
                start_s <= 1'b0;
                new_data_latch_s <= 0;
            end else begin
                send_s <= 1'b0;
                if (new_data_s) begin
                    new_data_latch_s <= 1; // New data is ready to be buffered
                end
            end
            if (ack_synced_s) begin // Reading, lower request flag
                req_s <= 1'b0;
            end
            ack_delayed_s <= ack_synced_s;
        end 
    end

    always_comb enable_s = new_data_latch_s && (valid_s || start_s);
    always_comb valid_s  = !ack_synced_s && ack_delayed_s;           // Ack is put down (old data has been read)

    always_ff @(posedge clk_d) begin
        if (!reset_d) begin
            if (enable_d) begin // Incoming Request: Read Data
                data_out_d <= send_buffer;
                ack_d <= 1'b1;
                capture_d <= 1'b1; // Capture on net clock tick
            end else begin
                capture_d <= 1'b0; // Don't capture
            end 
            if (!req_synced_d) begin  // No New Request (Not reading data)
                ack_d <= 1'b0;
            end
            req_delayed_d <= req_synced_d; // Delay req flag
        end
    end

        always_comb enable_d =  req_synced_d && !req_delayed_d; // Request rising edge
  
    // Source Delays
    
    ffsync #(
        .DELAY(2)
    ) ack_pipe (
        .clk           (clk_s),
        .reset         (reset_s),
        .signal        (ack_d),
        .signal_synced (ack_synced_s)
    ); 

    // Destination Delays
    
    ffsync #(
        .DELAY(2)
    ) req_pipe (
        .clk           (clk_d),
        .reset         (reset_d),
        .signal        (req_s),
        .signal_synced (req_synced_d)
    ); 

endmodule