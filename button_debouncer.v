module button_debouncer  (
        input  wire clk,                 /* 100MHz clock */
        input  wire button,              /* Input button from constraints */
        output reg  debounced_button=1'd0
    );
    

    /* History of sampled input button */
    reg [19:0] history=20'd0;

    always @ (posedge clk) begin
        /* Move history back one sample and insert new sample */
        history <= {  history[18:0],button };
        
        /* Assert debounced button if it has been in a consistent state throughout history */
        debounced_button <= (history == 1023) ? 1'b1 : 1'b0;
    end
    
endmodule

