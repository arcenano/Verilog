
`timescale 1ns/1ps

// Randomize clock

module handshake_test;

  localparam int WIDTH = 7;
  localparam int NUM_DATA = 100;

  logic             clk_s;
  logic             clk_d;
  logic             reset_s;
  logic             reset_d;
  logic [WIDTH-1:0] data_in_s;
  logic [WIDTH-1:0] data_out_d;
  logic             send_s;
  logic             capture_d;
  logic             new_data_s;

  handshake #(
    .WIDTH(WIDTH)
  ) dut_i (
    .clk_s,    // in 
    .clk_d,    // in
    .reset_s,  // in
    .reset_d,  // in
    .new_data_s, // in
    .data_in_s,  // in
    .send_s,     // out
    .capture_d,  // out
    .data_out_d  // out
  );

  int cnt = 0;
  int read_data; // Last data
  int read_data_new; // New Data
  int read_data_old; // Old Data
  int first_s = 1'b1; // First read_data
  int first_d = 1'b1; // First data_eval

  //int speed1 = $urandom_range(50_000_000,300_000_000);
  //int speed2 = $urandom_range(50_000_000,300_000_000);

  clk_reset_gen #(
    .CLK_RATE(100_000_000)
  ) clk_gen_s (
    .clk  (clk_s),
    .reset(reset_s)
  );

   clk_reset_gen #(
    .CLK_RATE(200_000_000)
   ) clk_gen_r (
    .clk  (clk_d),
    .reset(reset_d)
  );

  initial begin
    $display("Starting testbench");
    reset_d <= 1'b1;
    reset_s <= 1'b1;
    #5
    reset_d <= 1'b0;
    reset_s <= 1'b0;
    $display("Test started");

  fork
    // Thread #1
    begin
      while (cnt <= NUM_DATA) begin
        @(posedge clk_s);
        if(!reset_s) begin
          if (send_s) begin
            data_in_s <= cnt;
            cnt <= cnt + 1;
            new_data_s <= 1'b1;
            read_data_new <= cnt;
            $display($sformatf("sending"),(cnt));
            if (first_s) begin
              read_data <= cnt;
              first_s <= 1'b0;
            end
          end else begin
            new_data_s <= 1'b0;
            cnt <= cnt + 1;
          end
        end
      end  
    end
    
    // Thread #2
    begin
      while (cnt <= NUM_DATA) begin
      @(posedge clk_d);
        if(!reset_d) begin
          if (capture_d) begin
            if (first_d == 1) begin
              $display($sformatf("success reading"),(read_data));
              assert (data_out_d == (read_data)) else `error($sformatf("error at data in = %d, data out = %d",(read_data),data_out_d));
              first_d <= 1'b0;
            end else begin
              $display($sformatf("success reading"),(read_data));
              assert (data_out_d == (read_data)) else `error($sformatf("error at data in = %d, data out = %d",(read_data),data_out_d));
              assert (data_out_d !== (read_data_old)) else `error($sformatf("error at data in %d, duplicate data",(read_data_old)));
            end
              read_data <= read_data_new;
              read_data_old <= read_data;
          end
        end
      end
        $finish();
    end

    begin
      #100
      $display("resetting");
      reset_d <= 1'b1;
      reset_s <= 1'b1;
      #10
      reset_d <= 1'b0;
      reset_s <= 1'b0;
    end
  join
end
  
endmodule
