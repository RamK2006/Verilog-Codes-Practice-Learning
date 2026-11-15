// Code your testbench here
// or browse Examples

module tb_jk_ff;
  reg clk;
  reg rst;
  reg j;
  reg k;
  wire q;
  wire q_bar;
  
  jk_ff uut(
    .clk(clk),
    .rst(rst),
    .j(j),
    .k(k),
    .q(q),
    .q_bar(q_bar)
  );
  
  always  #5 clk = ~ clk;
  initial begin 
    $monitor( "clk = %0t | j = %b | k = %b | rst = %b | Q = %b | Q bar = %b ", $time, j,k,rst,q,q_bar);
    clk =0;
    rst = 0;
    j =0;
    k=0;
     #10 rst =1;
    #6 j=1; k=0;
    #6 j=0; k=1;
    #6 j=1; k=1;
    #6 j=1; k=0;
    #6 j=0; k=0;
    #10 $finish;
  end
endmodule

