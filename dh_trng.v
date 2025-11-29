`timescale 1ns/1ps

module dh_trng (
    input  wire clk,
    input  wire en,
    output wire out
);

    wire [11:0] ro_bits;

    // ------------------------------
    // Instantiate RO block 0
    // ------------------------------
    RO RO0 (
        .RO_en(en),
        .Q1(1'b0),
        .clk(clk),
        .RO_out1(ro_bits[0]),
        .RO_out2(ro_bits[1]),
        .RO_out3(ro_bits[2]),
        .RO_out4(ro_bits[3]),
        .RO_out5(ro_bits[4]),
        .RO_out6(ro_bits[5])
    );

    // ------------------------------
    // Instantiate RO block 1
    // ------------------------------
    RO RO1 (
        .RO_en(en),
        .Q1(1'b1),
        .clk(clk),
        .RO_out1(ro_bits[6]),
        .RO_out2(ro_bits[7]),
        .RO_out3(ro_bits[8]),
        .RO_out4(ro_bits[9]),
        .RO_out5(ro_bits[10]),
        .RO_out6(ro_bits[11])
    );

    // -------------------------------------
    // XOR all 12 RO outputs into 1 TRNG bit
    // -------------------------------------
    assign out = ^ro_bits;

endmodule
