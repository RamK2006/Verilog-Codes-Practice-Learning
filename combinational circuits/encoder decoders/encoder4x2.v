// Code your design here
module encoder_4_2( 
  input [3:0] d,
  output reg [1:0] q); 
  always @(*) begin
    case (1'b1) 
      d[0] : q=2'b00;
      d[1] : q=2'b01;
      d[2] : q=2'b10;
      d[3] : q=2'b11;
      default : q= 2'b00;
    endcase
  end
  endmodule

      