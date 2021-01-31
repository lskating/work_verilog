module halfsub(x,y,sout,diff);
  input x,y;
  output diff,sout;
	assign diff = x^y;
	assign sout = (~x)&y;
endmodule

module fullsub_1(sub_in,x,y,diff,sub_out);
	input x,y,sub_in;
	output diff,sub_out;
	wire s_out1,s_out2;
	// instance
	halfsub hs_1(x,y,sout_1,diff_1);
	halfsub hs_2(diff_1,sub_in,sout_2,diff);
	assign sub_out = sout_2|sout_1; 
endmodule

module fullsub_2(sub_in,x,y,diff,sub_out);
	input sub_in;
	input x;
	input y;
	output diff;
	output sub_out;
	assign diff = x^y^sub_in;
	assign sub_out = (~x&(y^sub_in))|(y&sub_in);
endmodule

module fullsub_3(sub_in,x,y,diff,sub_out);
	input sub_in;
	input x;
	input y;
	output reg diff;
	output reg sub_out;
	always@(*) begin
		diff = x^y^sub_in;
		sub_out = (~x&(y^sub_in))|(y&sub_in);
	end
endmodule


module fullsub_4(sub_in,x,y,diff,sub_out);
	input sub_in;
	input x;
	input y;
	output diff;
	output sub_out;
	assign diff = x - y - sub_in;
	assign sub_out = (~x&(y^sub_in))|(y&sub_in);
endmodule

module fullsub_5(sub_in,x,y,diff,sub_out);
	input sub_in;
	input x;
	input y;
	output diff;
	output sub_out;
	reg out;
	assign {diff,sub_out} = out;
	always@(*)
	  case ({sub_in,x,y})
	  3'b000: out = 2'b00;
	  3'b001: out = 2'b10;
	  3'b010: out = 2'b11;
		3'b011: out = 2'b00;
		3'b100: out = 2'b11;
		3'b101: out = 2'b00;
		3'b110: out = 2'b01;
		3'b111: out = 2'b11;
	endcase
endmodule

module fullsub_6(sub_in,x,y,diff,sub_out);
	input sub_in;
	input x;
	input y;
	output reg diff;
	output reg sub_out;
	always@(*) begin
	if(sub_in) begin diff = ~(x^y); sub_out = x|(~y);end
	  else begin  diff = (x^y);sub_out = x&(~y);end
	end
endmodule


// ripple fullsub for 8-bit
module FS_8(sub_in,x,y,diff,sub_out);
	input [7:0]x,y;
	input sub_in;
	output sub_out;
	output [7:0]diff;
	wire [7:1]sub_o;
	fullsub_2 FS7(sub_in,x[7],y[7],diff[7],sub_o[7]);
	fullsub_2 FS6(sub_o[7],x[6],y[6],diff[6],sub_o[6]);
	fullsub_2 FS5(sub_o[6],x[5],y[5],diff[5],sub_o[5]);
	fullsub_2 FS4(sub_o[5],x[4],y[4],diff[4],sub_o[4]);

	fullsub_2 FS3(sub_o[4],x[3],y[3],diff[3],sub_o[3]);
	fullsub_2 FS2(sub_o[3],x[2],y[2],diff[2],sub_o[2]);
	fullsub_2 FS1(sub_o[2],x[1],y[1],diff[1],sub_o[1]);
	fullsub_2 FS0(sub_o[1],x[0],y[0],diff[0],sub_out);
endmodule
