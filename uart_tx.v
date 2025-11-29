module uart_tx #(parameter CLK_HZ = 100_000_000, parameter BAUD = 115200)(
    input wire clk,
    input wire send,
    input wire [7:0] data,
    output reg tx = 1,
    output reg busy = 0
);

    localparam CLKS_PER_BIT = CLK_HZ / BAUD;

    reg [15:0] clk_cnt = 0;
    reg [9:0] shift_reg = 10'b1111111111;

    always @(posedge clk) begin
        if (!busy) begin
            if (send) begin
                shift_reg <= {1'b1, data, 1'b0}; // stop, data, start
                busy <= 1;
                clk_cnt <= 0;
            end
        end else begin
            if (clk_cnt == CLKS_PER_BIT - 1) begin
                clk_cnt <= 0;
                shift_reg <= {1'b1, shift_reg[9:1]};
                if (shift_reg == 10'b1111111111)
                    busy <= 0;
            end else begin
                clk_cnt <= clk_cnt + 1;
            end
        end
    end
endmodule
