`timescale 1ns / 1ps

module round_robin_module(req, addr, Answer, ArbR, State, clk, reset);

input	wire	[3:0]		req;
input 	wire	[32*4-1:0]	addr;
output	wire	[11:0]		Answer;
output	wire	[3:0]		ArbR;
input	wire	[11:0]		State;
input	wire				clk;
input 	wire				reset;

// cut addr bus for outputs 		
		
		reg		[7:0]		addr_cut;

	always @(posedge clk)
		begin
		
		if (reset==1'b0) addr_cut <= 8'b00000000;
		 else
		  begin
		
			addr_cut[7] <= addr [32*4-1];
			addr_cut[6] <= addr [32*4-2];
			
			addr_cut[5] <= addr [32*3-1];
			addr_cut[4] <= addr [32*3-2];
			
			addr_cut[3] <= addr [32*2-1];
			addr_cut[2] <= addr [32*2-2];
			
			addr_cut[1] <= addr [32*1-1];
			addr_cut[0] <= addr [32*1-2];
		  end
		end
		
		//output arbiters
   					
out_arbiter RR0(2'b00, req, addr_cut, Answer[2:0], 	ArbR[0], State[2:0], 	clk, reset); 
out_arbiter RR1(2'b01, req, addr_cut, Answer[5:3], 	ArbR[1], State[5:3], 	clk, reset); 
out_arbiter RR2(2'b10, req, addr_cut, Answer[8:6], 	ArbR[2], State[8:6], 	clk, reset); 
out_arbiter RR3(2'b11, req, addr_cut, Answer[11:9], ArbR[3], State[11:9], 	clk, reset); 

endmodule