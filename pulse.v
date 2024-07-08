module pulse #(
    parameter   FREQUENCY = 500_000
)
(
    input       clk,
    output reg  out
);

    integer     cycles = 0;

    // execute logic every clock tick
    always @ (posedge clk) begin
        if (cycles >= FREQUENCY) begin
            cycles <= 0;
            out <= 1;
        end else begin
            out <= 0;
            cycles <= cycles + 1;
        end
    end

endmodule
