


module Decoder_7_segment(
    input [3:0] in, //4 bits going into the segment
    output reg [6:0] seg //display the the BCD number on a 7-segment
    );
    
    always @(in)
    begin
    case(in)
				4'b0000: seg=7'b1000000;//active low logic here, this displays zero on the seven segment
				4'b0001: seg=7'b1111001;//"1"
				4'b0010: seg=7'b0100100;//"2"
				4'b0011: seg=7'b0110000;//3
				4'b0100: seg=7'b0011001;//4
				4'b0101: seg=7'b0010010;//5
				4'b0110: seg=7'b0000010;//6
				4'b0111: seg=7'b1111000;//7
				4'b1000: seg=7'b0000000;//8
				4'b1001: seg=7'b0011000;//9
				4'b1010: seg=7'b1011010;//A
				4'b1011: seg=7'b1110001;//B
				4'b1100: seg=7'b1111111;//C
				4'b1101: seg=7'b1111111;//D
				4'b1110: seg=7'b1111111;//E
				4'b1111: seg=7'b1111111;//F
       endcase
     end
                    
     
endmodule
