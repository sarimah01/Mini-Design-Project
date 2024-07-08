
module stopwatch(

    input       clk,
    input       lap,
    input       ssr,
    input       view,
    output reg  [6:0] HEX0,
    output reg  [6:0] HEX1,
    output reg  [6:0] HEX2,
    output reg  [6:0] HEX3,
    output reg  [6:0] HEX4,
    output reg  [6:0] HEX5
);

    localparam  PULSES_PER_SECOND = 100;
    localparam  THRESHOLD = 5;

    reg         [3:0] digit0=4'd0;
	 reg         [3:0] digit1=4'd0;
	 reg         [3:0] digit2=4'd0;
	 reg         [3:0] digit3=4'd0;
	  reg         [3:0] digit4=4'd0;
	  reg         [3:0] digit5=4'd0;
	 
    reg         pause = 0;
    wire        [6:0] HEX [0:5];
	 reg [3:0] lap_register= 4'hF;
	 	 reg [3:0] ssr_register= 4'hF;

	 
    wire        pulse;
    integer     i;
    integer     pulses = 0;

    // pulse on every hundreth of second
    pulse(clk, pulse);

    // perform logical operations on every pulse tick
    always @ (posedge clk) begin
	 lap_register={lap_register[2:0],lap};
	 pause<=(lap_register==4'h3)? ~pause:pause;
	 
	 ssr_register={ssr_register[2:0],ssr};
	 
	 if (ssr_register==4'h3)
	 begin
	 digit0<=0;
	 digit1<=0;
	 digit2<=0;
	 digit3<=0;
	 digit4<=0;
	 digit5<=0;
	 
	 end
    else if (~pause && pulse)
	 begin
        if (digit0==9) begin
			digit0<=0;
			if (digit1==9)begin
				digit1<=0;
					if(digit2==9) begin
						digit2<=0;
							if (digit3==5) begin
								digit3<=0;
									if (digit4==9) begin
										digit4 <= 0;
										
										if (digit5==5) begin
												  digit5 <= 0;
												  end
												  else
												  digit5 <=digit5 + 1'b1;
										 end
												  
									else
											digit4 <= digit4 + 1'b1;
									 end
								else
								digit3<=digit3+ 1'b1; end
						else
						digit2<=digit2+ 1'b1; end
			else
			digit1<=digit1 + 1'b1; end
		else
			digit0<=digit0 + 1'b1; end
        
	 end

    seven_segment_converter(digit0, HEX[0]);
    seven_segment_converter(digit1, HEX[1]);
    seven_segment_converter(digit2, HEX[2]);
    seven_segment_converter(digit3, HEX[3]);
    seven_segment_converter(digit4, HEX[4]);
    seven_segment_converter(digit5, HEX[5]);

    always @ (HEX) begin
        HEX0 = HEX[0];
        HEX1 = HEX[1];
        HEX2 = HEX[2];
        HEX3 = HEX[3];
        HEX4 = HEX[4];
        HEX5 = HEX[5];
    end

endmodule
