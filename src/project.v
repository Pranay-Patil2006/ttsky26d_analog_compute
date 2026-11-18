/*
 * Copyright (c) 2024 Pranay Arvind Patil, Aditya Baderia, Nithin Purushothama, Madhav Pathak
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_ttsky26d_analog_compute (
    input  wire       VGND,     // Common ground rail
    input  wire       VDPWR,    // 1.8V digital/common power supply
    input  wire [7:0] ui_in,    // Dedicated inputs: ui_in[3:0]=code_a (linear gain IDAC), ui_in[7:4]=code_b (squarer bias IDAC)
    output wire [7:0] uo_out,   // Dedicated outputs: unused
    input  wire [7:0] uio_in,   // IOs: Input path: uio_in[3:0]=code_c (offset IDAC), uio_in[7:4]=unused
    output wire [7:0] uio_out,  // IOs: Output path: unused
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua,       // Analog pins (ua[5:0]): ua[0]=vdd, ua[1]=vdd_comp, ua[2]=out, ua[3]=in, ua[4]=gnd_comp, ua[5]=vt0
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock (unused in purely analog compute core)
    input  wire       rst_n     // reset_n (unused in purely analog compute core)
);

    // Safely drive unused digital outputs low and keep bidirectional pins as inputs
    assign uo_out  = 8'b0000_0000;
    assign uio_out = 8'b0000_0000;
    assign uio_oe  = 8'b0000_0000;

endmodule
