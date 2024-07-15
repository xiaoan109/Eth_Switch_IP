`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2021 23:12:16
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: Crossbar Switch dim. 4
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 4.0 - rewrited again
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module 		main_module_of_Crossbar(	clk, 	reset,	

					req,	addr,	cmd,	wdata,	ack,	rdata,
					rreq,	aaddr,	ccmd,	wwdata,	aack,	rrdata
			);

input 	wire			clk; 			input 	wire						reset;



//master pins
input 	wire	[3:0] 	req;			input	wire	[(32*4-1):0]		addr;
input 	wire	[3:0] 	cmd;			input	wire	[(32*4-1):0]		wdata;
output 	wire	[3:0] 	ack;			output	wire	[(32*4-1):0]		rdata;
//slave pins (doubled first letter)
output 	wire	[3:0] 	rreq;			output	wire	[(32*4-1):0]		aaddr;
output 	wire	[3:0] 	ccmd;			output	wire	[(32*4-1):0]		wwdata;
input 	wire	[3:0] 	aack;			input	wire	[(32*4-1):0]		rrdata;
//for slaves-to-masters connection
		wire 	[3:0]	ack0;					wire 	[(32*4-1):0]        rdata0;
		wire 	[3:0] 	ack1;					wire 	[(32*4-1):0]        rdata1;						
		wire 	[3:0]  	ack2;					wire 	[(32*4-1):0]        rdata2;	
		wire 	[3:0]  	ack3;					wire 	[(32*4-1):0]        rdata3;	
//extra var for this purpose
		reg		[2:0] 	A0, A1, A2, A3;
		
		// extra var for next modules
	 		 	                wire 			necessity;
		// output states at SM
			                    wire	[11:0]	state;
		// Arbiter var	                    
(* mark_debug =	 "true" *) 	    wire	[11:0]	answer;
(* mark_debug =	 "true" *) 	    wire	[3:0]	ArbR;
(* mark_debug =	 "true" *)      wire	[15:0]	C;

	assign necessity = (req[3] || req[2] || req[1] || req[0]); 
	
	// proc for outputs:

procedure out0(

    req,			addr,						cmd,			wdata,
    ack0,			rdata0,
    rreq[0],		aaddr[(1*32-1)-:32],		ccmd[0],		wwdata[(1*32-1)-:32],
    aack[0],		rrdata[(1*32-1)-:32],
    
	/*2'b00,	*/		clk,		
	state[2:0],		reset,						necessity,		answer[2:0],		ArbR[0], C[3:0]
    );

procedure out1(

    req,			addr,						cmd,			wdata,
    ack1,			rdata1,
    rreq[1],		aaddr[(2*32-1)-:32],		ccmd[1],		wwdata[(2*32-1)-:32],
    aack[1],		rrdata[(2*32-1)-:32],
    
	/*2'b01,	*/		clk,		
	state[5:3],		reset,						necessity,		answer[5:3],		ArbR[1], C[7:4]
    );
    
procedure out2(

    req,			addr,						cmd,			wdata,
    ack2,			rdata2,
    rreq[2],		aaddr[(3*32-1)-:32],		ccmd[2],		wwdata[(3*32-1)-:32],
    aack[2],		rrdata[(3*32-1)-:32],
    
	/*2'b10,*/			clk,		
	state[8:6],		reset,						necessity,		answer[8:6],		ArbR[2], C[11:8]
    );
    
procedure out3(

    req,			addr,						cmd,			wdata,
    ack3,			rdata3,
    rreq[3],		aaddr[(4*32-1)-:32],		ccmd[3],		wwdata[(4*32-1)-:32],
    aack[3],		rrdata[(4*32-1)-:32],
    
	/*2'b11,	*/		clk,		
	state[11:9],	reset,						necessity,		answer[11:9],		ArbR[3], C[15:12]
    );
    
    // next - alw block that gives correct answer to output by mux
    
    always @(posedge clk)
		begin
		
			if (reset==1'b0)
				begin
			
					A0 <= 3'b100;
					A1 <= 3'b100;
					A2 <= 3'b100;
					A3 <= 3'b100;
					
				end
		
			if 		(C[0]==1'b1) 	A0 <= 3'b000;
			else if (C[4]==1'b1) 	A0 <= 3'b001;
			else if (C[8]==1'b1) 	A0 <= 3'b010;
			else if (C[12]==1'b1) 	A0 <= 3'b011;
			else 					A0 <= 3'b100;
			
			if 		(C[1]==1'b1) 	A1<= 3'b000;
			else if (C[5]==1'b1) 	A1<= 3'b001;
			else if (C[9]==1'b1) 	A1<= 3'b010;
			else if (C[13]==1'b1) 	A1<= 3'b011;
			else 					A1<= 3'b100;
			
			if 		(C[2]==1'b1) 	A2 <=3'b000;
			else if (C[6]==1'b1) 	A2 <=3'b001;
			else if (C[10]==1'b1) 	A2 <=3'b010;
			else if (C[14]==1'b1) 	A2 <=3'b011;
			else 					A2 <= 3'b100;
			
			if 		(C[3]==1'b1) 	A3 <=3'b000;
			else if (C[7]==1'b1) 	A3 <=3'b001;
			else if (C[11]==1'b1) 	A3 <=3'b010;
			else if (C[15]==1'b1) 	A3 <=3'b011;
			else 					A3 <= 3'b100;
			
		end

//connection in i(); - consists of mux for connecting data from slaves to masters

connection in0(clk, reset, ack0[0], ack1[0], ack2[0], ack3[0], rdata0[31:0], 	rdata1[31:0], 	rdata2[31:0], 	rdata3[31:0], 			ack[0], rdata[31:0], 	A0);
connection in1(clk, reset, ack0[1], ack1[1], ack2[1], ack3[1], rdata0[63:32], 	rdata1[63:32], 	rdata2[63:32], 	rdata3[63:32], 			ack[1], rdata[63:32], 	A1);
connection in2(clk, reset, ack0[2], ack1[2], ack2[2], ack3[2], rdata0[95:64], 	rdata1[95:64], 	rdata2[95:64], 	rdata3[95:64], 			ack[2], rdata[95:64], 	A2);
connection in3(clk, reset, ack0[3], ack1[3], ack2[3], ack3[3], rdata0[127:96], 	rdata1[127:96], rdata2[127:96], rdata3[127:96], 		ack[3], rdata[127:96], 	A3);

// choose 'ur fighter

round_robin_module	RR_Arbiter_unit(req, addr, answer, ArbR, state, clk, reset);
//wavefront_module WF_Arbiter_unit(req, addr, answer, ArbR, state, clk, reset);

endmodule