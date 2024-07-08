


module binarytoBCD(
    input [5:0] mins, 
    input [4:0] hours, 
    output reg [3:0] hours_LSB=4'd0,
    output reg [3:0] mins_LSB=4'd0,
    output reg [3:0] hours_MSB=4'd0,
    output reg [3:0] mins_MSB=4'd0
    );
    


	
    always @(*) 
    begin

	 hours_MSB<=hours/10; // getting tenth digit of hour
	 mins_MSB<=mins/10;   // getting tenth digit of min

	 hours_LSB<=hours%10;   // getting unith digit of hour
	 mins_LSB<=mins%10;      // getting unith digit of min
	 end
    endmodule
