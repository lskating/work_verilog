module shifter(clk,shift,cin,indata,outdata,cout);
	input clk,cin;
	input [2:0]shift;
	input [15:0]indata;
	output reg cout;
	output reg [15:0]outdata;
	wire [15:0]left,right;
	assign left = outdata << 1;
	assign left_o = outdata[15];
	assign right = outdata >> 1;
	assign right_o = outdata[0];
	always@(posedge clk) begin
		case(shift)
			3'd0: begin outdata <= {left[15:1],outdata[15]};cout <= left_o;	end		 	//(1)
			3'd1: begin outdata <= {left[15:1],cin};cout <= left_o;	end					//(2)
			3'd2: begin outdata <= {outdata[0],right[14:0]};cout <= right_o;end 		//(3)
			3'd3: begin outdata <= {cin,right[14:0]};cout <= right_o;end				//(4)
			3'd4: begin outdata <= indata; cout<= 1'b0;end								//(5)
			default: begin outdata <= outdata; cout<= cout; end
		endcase
	end
endmodule


module shifter2(clk,shift,cin,indata,outdata,cout);
	input clk,cin;
	input [2:0]shift;
	input [15:0]indata;
	output reg cout;
	output reg [15:0]outdata;
	wire [15:0]left,right;
	assign left = outdata << 1;
	assign left_o = outdata[15];
	assign right = outdata >> 1;
	assign right_o = outdata[0];
	always@(posedge clk) begin
		if (shift==3'd0) {outdata,cout} <= {{left[15:1],outdata[15]},left_o};		 	//(1)
		else if(shift==3'd1) {outdata,cout} <= {{left[15:1],cin},left_o};				//(2)
		else if(shift==3'd2) {outdata,cout} <= {{outdata[0],right[14:0]},right_o}; 		//(3)
		else if(shift==3'd3) {outdata,cout} <= {{cin,right[14:0]},right_o};				//(4)
		else if(shift==3'd4) {outdata,cout} <= {indata,1'b0};							//(5)
		else {outdata,cout} <= {outdata,cout};
	end
endmodule