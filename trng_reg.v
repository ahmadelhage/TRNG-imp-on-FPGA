module trng_reg (
    input  wire        S_AXI_ACLK,
    input  wire        S_AXI_ARESETN,
    input  wire [31:0] S_AXI_ARADDR,
    input  wire        S_AXI_ARVALID,
    output reg [31:0]  S_AXI_RDATA,
    output reg         S_AXI_RVALID,
    
    input  wire [7:0]  trng_byte   // TRNG byte from PL
);

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_RDATA  <= 32'd0;
            S_AXI_RVALID <= 1'b0;
        end else begin
            if (S_AXI_ARVALID) begin
                S_AXI_RDATA  <= {24'd0, trng_byte}; // place TRNG byte in lower 8 bits
                S_AXI_RVALID <= 1'b1;
            end else begin
                S_AXI_RVALID <= 1'b0;
            end
        end
    end

endmodule
