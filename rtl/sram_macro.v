`default_nettype none
module sram_macro (
`ifdef USE_POWER_PINS
    inout  wire vccd1,
    inout  wire vssd1,
`endif
    input  wire        clk0,
    input  wire        csb0,
    input  wire        web0,
    input  wire [3:0]  wmask0,
    input  wire [8:0]  addr0,
    input  wire [31:0] din0,
    output wire [31:0] dout0,
    input  wire        clk1,
    input  wire        csb1,
    input  wire [8:0]  addr1,
    output wire [31:0] dout1
);
  sky130_sram_2kbyte_1rw1r_32x512_8 sram_inst (
      .clk0  (clk0),
      .csb0  (csb0),
      .web0  (web0),
      .wmask0(wmask0),
      .addr0 (addr0),
      .din0  (din0),
      .dout0 (dout0),
      .clk1  (clk1),
      .csb1  (csb1),
      .addr1 (addr1),
      .dout1 (dout1)
  );
endmodule
`default_nettype wire
