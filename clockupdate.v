
module clockupdate(clk,clk_update);
  input clk;
  output clk_update;
  reg clk_update;
  reg [21:0] check;
    
    always @ (posedge clk) 
      begin
        if(check < 4000000) begin
            check <= check + 1;
            clk_update <= 0;
        end
        else begin 
            check <= 0;
            clk_update <= 1;
        end
    end 
endmodule
