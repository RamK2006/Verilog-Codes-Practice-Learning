// Code your design here
module jk_ff(
  input clk, 
  input rst,
  input j,
  input k, 
  output reg q, 
  output reg q_bar);
  
  always @(posedge clk) begin
    if(!rst) q<=1'b0;
    else begin
      q <= (j & ~q) | ( ~k & q);
    end
  end
        
  assign q_bar = ~q;

endmodule

      
      

      