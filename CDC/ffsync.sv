module ffsync #(
    parameter int DELAY = 2
) (
    input  logic              clk,
    input  logic              reset, 
    input  logic              signal,
    output logic              signal_synced
); 

    logic [DELAY-1:0] signal_pipe;

    always_ff @(posedge clk) begin
        if (!reset) begin
            signal_pipe <= { signal_pipe, signal };
        end
    end
    
    always_comb signal_synced = signal_pipe[DELAY-1];
endmodule
