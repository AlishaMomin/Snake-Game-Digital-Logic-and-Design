//`include "vga_sync.v"
//`include "clk_div.v"
//`include "clockupdate.v"
//`include "Random.v"
//`include "Inputkey.v"
//`include "SSD_display.v" 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2020 12:08:29
// Design Name: 
// Module Name: snake
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


module snake(clk,reset,up,down,left,right,red,green,blue,h_sync,v_sync,seg,an);
    input clk;
    input reset;
    input up;
    input down;
    input left;
    input right;
  output [3:0] red;
  output [3:0] green;
  output [3:0] blue;
    output h_sync;
    output v_sync;
  reg [3:0] red;
  reg [3:0] blue;
  reg [3:0] green;
  
  output [3:0] an;
  output [7:0] seg;
  
  reg [3:0] an;
  reg [7:0] seg;
	
  reg apple,border,eat,snake,stop,inX,inY,snakeHead,snakeBody,head,gameOver,fail;
  wire clk_d,clk_update,video_on ;
  wire[10:0] h_count;
  wire [3:0] direction;
  wire [9:0] v_count,rX;
  wire [9:0] randomX;
  reg [9:0] appleX,appleY;
  reg [9:0] headX,headY;
  wire [8:0] rY;
  wire [8:0] randomY;
  wire R,G,B;
  //wire nonlethal; //
  //reg [6:0] size;//
  reg [9:0] snakeX[0:10];
  reg [8:0] snakeY[0:10];
  
  wire [7:0] temp_seg;
  wire [3:0] temp_an;
  
  
  clk_div c1(clk, clk_d);
  clockupdate T1(clk,clk_update);
  vga_sync V1(clk_d, h_count,v_count,video_on,h_sync,v_sync);
  Random R1(clk_d,rX,rY);
  Inputkey I1(clk,left,right,up,down,direction);
  ///////////
  Segment_display display(.clk(clk_d), .gameOver(gameOver), .an(temp_an), .seg(temp_seg));
  //Segment_display display(clk_d,gameOver,temp_an,temp_seg);
  
  assign randomX = rX;
  assign randomY = rY;
  
  always @(posedge clk_d) begin
    inX <= (h_count > appleX & h_count < (appleX + 10));
    inY <= (v_count > appleY & v_count < (appleY + 10));
    apple <= inX & inY;
  end
  always@(posedge clk_d) begin
    border <= (((h_count >= 0) & (h_count < 15) | (h_count >= 630) & (h_count < 641)) | ((v_count >= 0) & (v_count < 15) | (v_count >= 465) & (v_count < 481)));
  end
  
  always@(posedge clk_d) begin //Rest random assign
    if(reset) begin
      appleX = randomX % 500;
      appleY = randomY % 350;
    end 
    if(apple & head) begin //Random Assign after eating
      appleX <= randomX % 500;
      appleY <= randomY % 350;
    end
    
  end
  
  always@(posedge clk_update) begin
    snakeX[10] <= snakeX[9] <= snakeX[8]<= snakeX[7]<= snakeX[6]<= snakeX[5]<= snakeX[4]<= snakeX[3]<= snakeX[2]<= snakeX[1]<= snakeX[0];
    snakeY[10] <= snakeY[9]<= snakeY[8]<= snakeY[7]<= snakeY[6]<= snakeY[5]<= snakeY[4]<= snakeY[3]<= snakeY[2]<= snakeY[1]<= snakeY[0];
    case(direction)
      4'b0100:snakeX[0] = snakeX[0] - 7;//left
      4'b1000:snakeX[0] = snakeX[0] + 7;//right
      4'b0001:snakeY[0] = snakeY[0] - 7;//up
      4'b0010:snakeY[0] = snakeY[0] + 7;//down
    endcase 
  end 
  
  always@(posedge clk_d) begin
    snake = ((h_count > snakeX[1] & h_count < snakeX[10]+10) & (v_count > snakeY[1] & v_count < snakeY[10]+10));
  end
  always@(posedge clk_d) begin
    head  <= (h_count > snakeX[0] & h_count < (snakeX[0]+10)) & (v_count > snakeY[0] & v_count < (snakeY[0]+10));
  end
  always @(posedge clk_d) begin
    if((border & (snake|head)) | reset) gameOver<=1; 
    else gameOver=0;
  end
 
  
  assign R = (video_on & (apple | gameOver));
  assign G = (video_on & ( (snake|head) & ~gameOver));
  assign B = (video_on & (border & ~gameOver));
  always@(posedge clk_d) begin
    red = {4{R}};
    green = {4{G}};
    blue = {4{B}};
  end          
              
endmodule
