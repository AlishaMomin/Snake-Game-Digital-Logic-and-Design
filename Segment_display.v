//////////////////////////////////////////////////////////////////////////
module Segment_display(clk, gameOver, an, seg);
	
	input clk;
	// is blue dead? is red dead?
	input gameOver;
	output [7:0] seg;
	output [3:0] an;
	
	reg [7:0] segments;
	reg [3:0] anodes;
	
	reg [1:0] count;
	
	always @ (posedge clk) begin
      if (gameOver) begin
			case (count)
				0:begin
					anodes <= 4'b1010;
					segments <= 8'b10001000; // 't'
				end
				1:begin
					anodes <= 4'b1011;
					segments <= 8'b10000011; // 'i'
				end
				2:begin
					anodes <= 4'b1100;
					segments <= 8'b01000110; // 'e'
				end
				3:begin
					anodes <= 4'b1101;
					segments <= 8'b00100001; // empty
				end
			endcase
		end 
		else begin
			case (count)
				0:begin
					anodes <= 4'b1101;
					segments <= 8'b00100001; // '-' segments <= 8'b10111111;
				end
				1:begin
					anodes <= 4'b1010;
					segments <= 8'b00001000; // '-'
				end
				2:begin
					anodes <= 4'b1110;
					segments <= 8'b10000110; // '-'
				end
				3:begin
					anodes <= 4'b1101;
					segments <= 8'b10100001; //  '-'
				end
			endcase
		end
		
		count <= count + 1;
	end
	
	assign an = anodes;
	assign seg = segments;
	
endmodule
// Segment_display
//////////////////////////////////////////////////////////////////////////////////
