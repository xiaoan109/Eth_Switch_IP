`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2021 19:39:05
// Design Name: 
// Module Name: WF_main
// Project Name: 
// Target Devices: Crossbar4
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 1.00
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module WF_main_module(
    req, addr, Answer, ArbR, State, clk, reset
    );
    
    input	wire 	[3:0] 		req;
    input	wire 	[32*4-1:0] 	addr;
    output	wire 	[11:0] 		Answer;
    output	wire 	[3:0] 		ArbR;
    input	wire 	[11:0] 		State;
    input	wire 				clk;
    input	wire 				reset;
    
    		wire				WORK;

    	 	wire	[3:0]		free_line0, free_line1, free_line2, free_line3;

    		
    wire z0, z1, z2, z3;
    
    assign z0 = (State[2:0]==3'b001) ? 1'b1 : 1'b0;
    assign z1 = (State[5:3]==3'b001) ? 1'b1 : 1'b0;
    assign z2 = (State[8:6]==3'b001) ? 1'b1 : 1'b0;
    assign z3 = (State[11:9]==3'b001) ? 1'b1 : 1'b0;
    
    or(WORK, z0, z1, z2, z3);
    
    //outputs
    
    WF_output_module WFOUT0(
					reset, clk, 2'b00, req, addr[31:30], addr[63:62], addr[95:94], addr[127:126], 
					free_line0, free_line1,
					 Answer[2:0], ArbR[0], 4'b0001, 4'b0010,4'b0100,4'b1000,WORK);
					 
	WF_output_module WFOUT1(
					reset, clk, 2'b01, req, addr[31:30], addr[63:62], addr[95:94], addr[127:126],
					free_line1, free_line2,
					 Answer[5:3], ArbR[1], 4'b0010,4'b0100,4'b1000,4'b0001,WORK);
					 
    WF_output_module WFOUT2(
					reset, clk, 2'b10, req, addr[31:30], addr[63:62], addr[95:94], addr[127:126], 
					free_line2, free_line3,
					 Answer[8:6], ArbR[2], 4'b0100,4'b1000,4'b0001,4'b0010,WORK);
					 
    WF_output_module WFOUT3(
					reset, clk, 2'b11, req, addr[31:30], addr[63:62], addr[95:94], addr[127:126],  
					free_line3, free_line0,
					 Answer[11:9], ArbR[3], 4'b1000,4'b0001,4'b0010,4'b0100, WORK);
    
endmodule
