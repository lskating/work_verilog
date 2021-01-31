`timescale 1ns/1ns
`define clock_period 20

module shift_tb;
	reg clk,cin;
	reg [2:0]shift;
	reg [15:0]indata;
	wire cout;
	wire [15:0]outdata;
	shifter my_shifter(clk,shift,cin,indata,outdata,cout);

	initial clk = 0;
	always #(`clock_period/2) clk = ~clk;

	initial begin
		//0
		shift = 3'd0;
		indata = 16'h1111;
		cin = 1'b1;
		//1
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h0111;
		cin = 1'b1;
		//2
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h1FF1;
		cin = 1'b1;
		//3
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h1111;
		cin = 1'b1;
		//4
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h1111;
		cin = 1'b1;
		//5
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h1101;
		cin = 1'b1;
		//6
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h1001;
		cin = 1'b1;
		//7
		#(`clock_period*20) shift = shift + 1'b1;
		indata = 16'h10F1;
		cin = 1'b1;
		#(`clock_period*20) $stop();
	end
endmodule