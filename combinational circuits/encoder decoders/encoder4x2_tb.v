// Code your testbench here
// or browse Examples
module tb_4_2;
  reg [3:0] d;
  wire [1:0] q;
  encoder_4_2 uut(
    .d(d),
    .q(q)
  );
  initial begin 
  $monitor("Time=%0t | d=%b | q=%b", $time, d, q);
    d= 4'b0001; #10;
    d= 4'b0010; #10;
    d= 4'b0100; #10;
    d= 4'b1000; #10;
    $finish;
  end
endmodule

