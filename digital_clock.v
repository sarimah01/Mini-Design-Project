


module digital_clock(
			input clk,
			input Sw, //sw0
			input  hour_up, //pb0 
			input  min_up, //b1
			output reg alarm=1'd0,
			output [6:0] HEX0,
			output [6:0] HEX1,
			output [6:0] HEX2,
			output [6:0] HEX3,
			output [6:0] HEX4,
			output [6:0] HEX5
    );


	 
	  reg [3:0] secs_LSB=4'd0;
	  reg [3:0] hours_LSB=4'd0;
	  reg [3:0] mins_LSB=4'd0;
	  reg [3:0] secs_MSB=4'd0;
	  reg [3:0] hours_MSB=4'd0;
	  reg [3:0] mins_MSB=4'd0;
	  

	  reg [3:0] mins_LSB_alarm=4'd0;
	  reg [3:0] mins_MSB_alarm=4'd0;
	  reg [3:0] hours_LSB_alarm=4'd0;
	  reg [3:0] hours_MSB_alarm=4'd0;
	  

   wire [5:0] secs_SSD_LSB ;
	wire [5:0] secs_SSD_MSB ;
	wire [5:0] mins_SSD_LSB ;
	wire [5:0] mins_SSD_MSB ;
	wire [4:0] hours_SSD_LSB;
	wire [4:0] hours_SSD_MSB;

parameter sec_delay=50_000_000;
	 
	 reg clock=0; 
	 
    reg [26:0]  sec_count=27'd0;
	 	 
		
always@(posedge clk)
begin
if (Sw)
sec_count<=0;
else
begin
if(sec_count==sec_delay-1) // if sec complete clock set to 1
	begin
	sec_count<=0;
	clock<=1;
	end
else 
begin       // else if sec not complete then clock set to 0
clock<=0;
sec_count<=sec_count+1'b1;
end
end
end	 


	 reg [3:0] hr_register= 4'hF;
	 	 reg [3:0] min_register= 4'hF;

always @ (posedge clk)
begin

	 hr_register={hr_register[2:0],hour_up};
	 
	 min_register={min_register[2:0],min_up};
if(Sw) // sw0 is high for setting alarm time
begin
		if (hr_register==4'h3 ) 
		begin
		if (hours_LSB_alarm==3 && hours_MSB_alarm==2) begin
		hours_LSB_alarm<=0;
		hours_MSB_alarm<=0; end
		else if (hours_LSB_alarm==9) begin hours_LSB_alarm<=0; 
					hours_MSB_alarm<=hours_MSB_alarm+1'b1; end
		else hours_LSB_alarm<=hours_LSB_alarm +1'b1;
		end
		
		if (min_register==4'h3)  
		begin
		if (mins_LSB_alarm==9 && mins_MSB_alarm==5) begin
		mins_LSB_alarm<=0;
		mins_MSB_alarm<=0; end
		else if (mins_LSB_alarm==9) begin mins_LSB_alarm<=0; 
					mins_MSB_alarm<=mins_MSB_alarm+1'b1; end
		else mins_LSB_alarm<=mins_LSB_alarm +1'b1;
		end
		
end
		

else if(~Sw & clock)  // if sw0 is low and sec complete then
	begin

	  
		if (secs_LSB==9 && secs_MSB==5)
			begin
			secs_LSB<=0;
			secs_MSB<=0;
				if (mins_LSB==9 && mins_MSB==5)
					begin
					mins_LSB<=0;
					mins_MSB<=0;
							if (hours_LSB==3 && hours_MSB==2)
								begin
								hours_LSB<=0;
								hours_MSB<=0;
					
								end
								else if (hours_LSB==9 ) begin hours_LSB<=0;  hours_MSB<=hours_MSB +1'b1; end
		
								else hours_LSB<=hours_LSB +1'b1;
					
					
					end
					else if (mins_LSB==9 ) begin mins_LSB<=0;  mins_MSB<=mins_MSB +1'b1; end
		
					else mins_LSB<=mins_LSB +1'b1;
					
			
			
			end
		else if (secs_LSB==9 ) begin secs_LSB<=0;  secs_MSB<=secs_MSB +1'b1; end
		
		else secs_LSB<=secs_LSB +1'b1;
		
		
		
	end
		
	alarm<= (mins_LSB_alarm==mins_LSB && mins_MSB_alarm==mins_MSB && hours_LSB_alarm==hours_LSB && hours_MSB_alarm==hours_MSB)	? 1'b1: 1'b0;  // alarm led glows for a minute... if alarm time is equal to time

end  

    
   //instantiating the binarytoBCD module here to convert the numbers and display the on the 7-segment
assign	mins_SSD_LSB=Sw? mins_LSB_alarm:mins_LSB;
assign	mins_SSD_MSB=Sw? mins_MSB_alarm:mins_MSB;
assign	hours_SSD_LSB=Sw? hours_LSB_alarm:hours_LSB;
assign	hours_SSD_MSB=Sw? hours_MSB_alarm:hours_MSB;
assign	secs_SSD_LSB=Sw? 4'hF:secs_LSB;
assign	secs_SSD_MSB=Sw? 4'hF:secs_MSB;

	 
	
sevenseg_driver sevenseg_driver (
	 .secs_LSB(secs_SSD_LSB), 
	 .secs_MSB(secs_SSD_MSB),
    .hr_MSB(hours_SSD_MSB), 
    .hr_LSB(hours_SSD_LSB), 
    .min_MSB(mins_SSD_MSB), 
    .min_LSB(mins_SSD_LSB), 
    .seg0(HEX0), 
    .seg1(HEX1), 
	  
    .seg2(HEX2), 
    .seg3(HEX3),
    .seg4(HEX4), 
    .seg5(HEX5)
    );

    
endmodule
