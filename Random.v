module Random(VGAclk,rX,rY);
  input VGAclk;
  output [9:0] rX;  //rX=randX
  output [9:0] rY;
  reg [9:0] rX;
  reg [9:0] rY;
  reg [5:0] pX, pY = 10; //pX=pointX
  
    always @(posedge VGAclk)
        pX <= pX + 3'b011;
    always @(posedge VGAclk)
        pY <= pY + 1'b1;
    always @(posedge VGAclk)
        begin
            if(pX> 6'b111110) //pX>62
                rX <= 620;
            else if (pX<2'b10)
                rX <= 5'b10100; //20;
            else 
                rX <= (pX * 4'b1010); //pX*1
            end
    always @(posedge VGAclk)
        begin 
           if(pY>469)//changed to 469
                rY <= 460;
           else if (pY<2'b10)
                rY <= 5'b10100; //20;
           else 
               rY <= (pY * 4'b1010); //pX*10
           end
endmodule
