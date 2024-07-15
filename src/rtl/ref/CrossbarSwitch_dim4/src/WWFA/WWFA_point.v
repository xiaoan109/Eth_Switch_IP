`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2021 17:41:59
// Design Name: 
// Module Name: WF_Point
// Project Name: 
// Target Devices:  Crossbar4
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


module WF_Point_module(
    				reset, clk, req,addr,out, out_blocked,free_line,free_column, result, 
    				not_result, new_free_line,new_free_column,
    				Previous, sign, send, ex, data, WORK
    );
    
    input	wire			reset;
    input 	wire			clk;
    input 	wire			req;
    input 	wire	[1:0] 	addr;
    input 	wire 	[1:0] 	out;
    		wire			X1, X0;
    		wire			necessity;
    		wire			opportunity;
      		wire			order;
    
    input 	wire			out_blocked;
    input 	wire 			free_line;
    input 	wire 			free_column;
    
    output 	wire			result;
    output	wire			not_result;
    output 	wire 			new_free_line;
    output 	wire			new_free_column;

    
    input 	wire			Previous;

    output	wire			sign;
    output	wire			send;
    input	wire			ex;
    input	wire	[3:0]	data;
    input	wire			WORK;
    
    shifttt memory_shift_reg(clk, reset, data, sign, WORK);
    assign order = (sign==1'b1) ? 1'b1 : ex;
    
    assign X1 = (addr[1]==out[1]) ? 1'b1 : 1'b0;
    assign X0 = (addr[0]==out[0]) ? 1'b1 : 1'b0;
    
    and(necessity, req, X1, X0);
    wire rezz;
    assign rezz = (out_blocked==1'b1) ? 1'b0 : 1'b1;
    wire res_free_line, res_free_column;
    // äâà àññèãíà íèæå ñäåëàòü ÷åðåç ðåãèñòðû
    assign res_free_line = (sign==1'b1) ? rezz : free_line;
    assign res_free_column = (sign==1'b1) ? rezz : free_column;
//output reg res_free_line, res_free_column;
//    always @(posedge clk)
//        begin
//            if (sign==1'b1) res_free_line <= rezz;
//            else res_free_line <= free_line;
//            if (sign==1'b1) res_free_column <= rezz;
//            else res_free_column <= free_line;
//        end
    and(opportunity, res_free_line, res_free_column);

    wire rez;
    and(rez, necessity, opportunity, order);
    
    assign result = 			(Previous == 1'b0) ? rez : necessity;
    assign send = result||order;
    
    wire res1, res2;
    not(not_result, result);
    and(res1, res_free_line, 	not_result);
    and(res2, res_free_column, 	not_result);
    
    assign new_free_line = 		(out_blocked==1'b1) ? 1'b0 : res1;
    assign new_free_column = 	(out_blocked==1'b1) ? 1'b0 : res2;
        
endmodule
