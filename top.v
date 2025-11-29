`timescale 1ns / 1ps

module top(
    input  wire clk,        // 125 MHz clock
    output wire uart_tx     // UART transmit
);

    wire random_bit;

    // --- TRNG module ---
    dh_trng u_trng (
        .clk(clk),
        .en(1'b1),
        .out(random_bit)
    );

    // --- Byte packing ---
    reg [7:0] shift_reg = 8'd0;
    reg [2:0] bit_cnt = 3'd0;
    reg byte_ready = 0;

    always @(posedge clk) begin
        shift_reg <= {shift_reg[6:0], random_bit};
        bit_cnt <= bit_cnt + 1;

        if (bit_cnt == 3'd7)
            byte_ready <= 1;
        else
            byte_ready <= 0;
    end

    // --- UART module ---
    wire uart_busy;

    uart_tx #(
        .CLK_HZ(125_000_000),
        .BAUD(115200)
    ) uart_inst (
        .clk(clk),
        .send(byte_ready & ~uart_busy),
        .data(shift_reg),
        .tx(uart_tx),
        .busy(uart_busy)
    );

endmodule
