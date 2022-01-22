//////////////////////////////////////////////////////////////////////////////////

module Inputkey(clk,up,down,left,right,direction);
  input up;
  input down;
  input left;
  input right;
  input clk;
  output [5:0] direction;
  reg [5:0] direction;
  
    always@(posedge clk) begin
    if(left == 1) begin
      direction <= 6'b000001; //left
	        end 
	        else if(right == 1) begin 
	            direction <= 6'b000010; //right
	        end 
	        else if(up == 1) begin 
	            direction <= 6'b000100; //up
	        end 
	        else if(down == 1) begin 
	            direction <=6'b001000; //down
	        end 
	        else begin 
	            direction <= direction; 
	        end 
	    end
endmodule
