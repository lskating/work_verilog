`timescale 1ns/1ns
`define clock_period 20

module fullsub_tb;
  reg  x,y,cout;
  wire cin; 
  wire d;
  reg clk;

  fullsub_1 my_fs(
				.sub_in(cout),
				.x(x),
				.y(y),
				.diff(d),
				.sub_out(cin));

  initial clk = 0;
 	always #(`clock_period/2) clk = ~clk;

  initial begin
     x = 0;
     repeat(20)
	    #(`clock_period) x = $random;

  end

  initial begin
     y = 0;
     repeat(20)
	    #(`clock_period) y = $random;

  end

   initial begin
     cout = 0;
     repeat(20)
	    #(`clock_period) cout = $random;
  end

  initial begin
     #(`clock_period*20)
	  $stop;
  end
endmodule