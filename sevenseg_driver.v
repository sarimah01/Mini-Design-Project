


module sevenseg_driver(      
    input [3:0] hr_MSB,		
    input [3:0] hr_LSB,	
		
    input [3:0] secs_MSB,		
    input [3:0] secs_LSB,	 
    input [3:0] min_MSB,		
    input [3:0] min_LSB,		
    output [6:0] seg0,
    output [6:0] seg1,
    output [6:0] seg2,
    output [6:0] seg3,
    output [6:0] seg4,
    output [6:0] seg5

    );
    
	 
    //instantiating the seven segment decoder four times
	 
     Decoder_7_segment disp0(secs_LSB,seg0);
     Decoder_7_segment disp1(secs_MSB,seg1);
     Decoder_7_segment disp2(min_LSB,seg2);
     Decoder_7_segment disp3(min_MSB,seg3);
     Decoder_7_segment disp4(hr_LSB,seg4);
     Decoder_7_segment disp5(hr_MSB,seg5);
 
endmodule
