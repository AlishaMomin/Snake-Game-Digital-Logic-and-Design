// Code your design here
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2021 07:43:21 PM
// Design Name: 
// Module Name: snake_dld
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pixel_geb (clk_d, pixel_x, pixel_y, video_on, red, green, blue);
input clk_d; 
input [9:0] pixel_x;
input [9:0] pixel_y;
input video_on; 
output [3:0] red;
output [3:0] green; 
output [3:0] blue;

reg [3:0] red; 
reg [3:0] green;
reg [3:0] blue; 
initial
begin 
red=0;
green=0; 
blue=0;
end

always @(posedge clk_d) begin

if ((pixel_y ==0) || (pixel_y==480) || (pixel_x==0) || (pixel_x==640)) begin

red <= 4'h0;
green <= 4'h0; 
blue <= 4'h0;

end

else if ((pixel_y<250)&(pixel_y>230)) begin 
red <= video_on?(((pixel_x <200) & (pixel_x >100))? 4'hF:4'h0): (4'h0); 
green <= video_on?(((pixel_x <200)&(pixel_x >100))? 4'hF:4 'h0): (4'h0); 
blue <= video_on?(((pixel_x <200) & (pixel_x >100))? 4'hF:4 'h0): (4'h0);

end

else if ((pixel_y<=230)&(pixel_y>210)) begin 
red <= video_on?(((pixel_x <250) & (pixel_x >180))? 4'hF:4'h0): (4'h0);
green <= video_on?(((pixel_x <250)&(pixel_x >180))? 4'hF:4 'h0): (4'h0);
blue <= video_on? (((pixel_x <250)&(pixel_x >180))? 4'hF:4 'h0): (4'h0);

end

else if ((pixel_y<=100) & (pixel_y>90)) begin

red <= video_on?(((pixel_x <450)&(pixel_x >440))? 4 'hF:4'h0): (4'h0);
green <= 4'h0; 
blue <= 4'h0;

end else begin

blue <= 4'h0; 
green <= 4'h0;

red <= 4'h0;

end

end

endmodule
//////////////////////////////////////////////////////////////////////////
