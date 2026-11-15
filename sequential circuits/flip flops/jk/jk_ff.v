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
    if(j == 1'b1) begin
      case (k)
        1'b0 : q<=1'b1;
        1'b1 : q<=~q;
      endcase
    end
    else begin
       case (k)
        1'b0 : q<=q;
        1'b1 : q<=1'b0;
      endcase
    end
    end
  end
  assign q_bar = ~q;

endmodule

      
      

      