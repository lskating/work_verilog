`timescale 1ns/1ns
`define clock_period 20

module rc8_tb;
  reg clk;
  reg sub_in;
  reg [7:0] x,y;
  wire [7:0] diff;
  wire sub_out;  
  FS_8 my_fs8(sub_in,x,y,diff,sub_out);
  initial clk = 0;
 	always #(`clock_period/2) clk = ~clk;

  initial begin
    sub_in = 0;
    x = 8'hFF;
    y = 8'h00;
    
    #(`clock_period)
    sub_in = 0;
    x = 8'hFF;
    y = 8'hFF;    
    
    #(`clock_period)
    sub_in = 0;
    x = 8'hFF;
    y = 8'hA2;
    #(`clock_period)
    sub_in = 0;
    x = 8'hF1;
    y = 8'h11;
    #(`clock_period)
    sub_in = 0;
    x = 8'hFF;
    y = 8'hBC;
    #(`clock_period)
    sub_in = 0;
    x = 8'h11;
    y = 8'hFF;
    #(`clock_period)
    sub_in = 0;
    x = 8'h00;
    y = 8'hFF;
    #(`clock_period)
    sub_in = 0;
    x = 8'h0F;
    y = 8'hF1;
  end
  
  
endmodule