module vga_sync(vga_clk,h_count,v_count,video_on,h_sync,v_sync);
  input vga_clk;
  output [9:0] h_count;
  output [9:0] v_count;
  output video_on;
  output h_sync;
  output v_sync;
  reg [9:0] h_count;
  reg [9:0] v_count;
  reg video_on,h_sync,v_sync;
  
  parameter HD = 640; 
  parameter HF = HD+16; //656
  parameter HR = HF+96; //752
  parameter HB = HR+48; //800
  //vertical 
  parameter VD = 480; 
  parameter VF = VD+10; //490
  parameter VR = VF+2; //492
  parameter VB = VR+33; //525 
  
  always@(posedge vga_clk)
    begin
      if(h_count == HB)
        h_count <= 0;
      else
        h_count <= h_count + 2'b01;
    end
  always@(posedge vga_clk)
    begin
      if(h_count == HB)
        begin
          if(v_count == VB)
            v_count <= 0;
          else
            v_count <= v_count + 2'b01;
        end
    end
  always@(posedge vga_clk)
    begin
      video_on <= ((h_count < HD) && (v_count < VD));
    end
  always@(posedge vga_clk)
    begin
      v_sync = ~((v_count >= VF) && (v_count < VR)); 
      h_sync = ~((h_count >= HF) && (h_count < HR));
    end 
endmodule
