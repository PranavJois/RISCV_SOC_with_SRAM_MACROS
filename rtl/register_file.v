`default_nettype none

module register_file #(
    parameter REGISTER_DEPTH = 32
) (
`ifdef USE_POWER_PINS
    inout wire vccd1,
    inout wire vssd1,
`endif
    input  wire        clk,
    input  wire        we,
    input  wire [4:0]  A1,
    input  wire [4:0]  A2,
    input  wire [4:0]  A3,
    input  wire [31:0] wd,
    output wire [31:0] rd1,
    output wire [31:0] rd2
);

  wire write_en = we && (A3 != 5'd0);

  wire csb0  = 1'b0;
  wire web0  = ~write_en;

  wire csb1a = 1'b0;
  wire csb1b = 1'b0;

  wire [31:0] dout0_unused_a;
  wire [31:0] dout0_unused_b;

  wire [31:0] sram_rd1;
  wire [31:0] sram_rd2;

  // ---------------- Bank A ----------------
  sram_macro bank_a (
`ifdef USE_POWER_PINS
      .vccd1 (vccd1),
      .vssd1 (vssd1),
`endif
      .clk0   (clk),
      .csb0   (csb0),
      .web0   (web0),
      .wmask0 (4'b1111),
      .addr0  ({4'b0000, A3}),
      .din0   (wd),
      .dout0  (dout0_unused_a),

      .clk1   (clk),
      .csb1   (csb1a),
      .addr1  ({4'b0000, A1}),
      .dout1  (sram_rd1)
  );

  // ---------------- Bank B ----------------
  sram_macro bank_b (
`ifdef USE_POWER_PINS
      .vccd1 (vccd1),
      .vssd1 (vssd1),
`endif
      .clk0   (clk),
      .csb0   (csb0),
      .web0   (web0),
      .wmask0 (4'b1111),
      .addr0  ({4'b0000, A3}),
      .din0   (wd),
      .dout0  (dout0_unused_b),

      .clk1   (clk),
      .csb1   (csb1b),
      .addr1  ({4'b0000, A2}),
      .dout1  (sram_rd2)
  );

  assign rd1 = (A1 == 5'd0) ? 32'b0 : sram_rd1;
  assign rd2 = (A2 == 5'd0) ? 32'b0 : sram_rd2;

endmodule

`default_nettype wire
