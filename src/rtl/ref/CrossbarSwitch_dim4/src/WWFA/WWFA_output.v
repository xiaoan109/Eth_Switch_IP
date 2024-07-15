`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2021 19:39:05
// Design Name: 
// Module Name: WF_ouput
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


module WF_output_module(
					reset, clk, out, req, addr0, addr1, addr2, addr3,free_line,new_free_line,
					Answer, ArbR, data0,data1,data2,data3, WORK
				);
    input 	wire			reset;
    input 	wire			clk;
    
    input 	wire	[1:0] 	out;
    input	wire	[3:0]	req;
    input 	wire	[1:0] 	addr0;
    input 	wire	[1:0] 	addr1;
    input 	wire	[1:0] 	addr2;
    input 	wire	[1:0] 	addr3;
		reg 			out_blocked;
    input	wire	[3:0]	free_line;
    		wire	[3:0]	free_column;
    output	wire	[3:0]	new_free_line;
    output	reg		[2:0]	Answer;
    output	reg				ArbR;
   		reg		[3:0]	Previous;
			wire	[3:0]	result;
    		wire	[3:0]	not_result;
    	
    input	wire	[3:0]	data0;
    input	wire	[3:0]	data1;
    input	wire	[3:0]	data2;
    input	wire	[3:0]	data3;
    input	wire			WORK;
   		wire	[3:0]	sign;
			wire 	[3:0] send;		
			
	 
        
    // POINTS

    WF_Point_module WF_point0(
   					reset, clk, req[0], addr0, out, out_blocked, free_line[0], free_column[0], result[0], 
    				not_result[0], new_free_line[0], free_column[1],
    				Previous[0], sign[0], send[1], send[3], data0, WORK
    );
    WF_Point_module WF_point1(
    				reset, clk, req[1], addr1, out, out_blocked, free_line[1], free_column[1], result[1], 
    				not_result[1], new_free_line[1], free_column[2],
    				Previous[1], sign[1], send[2], send[0], data1, WORK
    );
    WF_Point_module WF_point2(
   					reset, clk, req[2], addr2, out, out_blocked, free_line[2], free_column[2], result[2], 
    				not_result[2], new_free_line[2], free_column[3],
    				Previous[2], sign[2], send[3], send[1], data2, WORK
    );
    WF_Point_module WF_point3(
    				reset, clk, req[3], addr3, out, out_blocked, free_line[3], free_column[3], result[3], 
    				not_result[3], new_free_line[3], free_column[0],
    				Previous[3], sign[3], send[0], send[2], data3, WORK
    );
    
       //count OUT_BLOCKED
    
  wire	i0,i1,i2,i3;
    		
    and(i0, result[0], req[0]);
    and(i1, result[1], req[1]);
    and(i2, result[2], req[2]);
    and(i3, result[3], req[3]);
    
    //Answer
    always @(posedge clk)
    		begin
    		
    			if (reset==1'b0) out_blocked <=1'b0;
    			else
    				begin
    					out_blocked <= i0||i1||i2||i3;
    				end
    			 
				if (reset==1'b0) Previous = 1'b0;
					else begin if (WORK == 1'b1) Previous <= result; end
    			
    			if (reset==1'b0) Answer <= 3'b100;
    			else 
    			begin
    				if (WORK == 1'b1)
    				begin
    					Answer[2] <= (not_result[0]||result[1]||result[2]||result[3])&&(result[0]||not_result[1]||result[2]||result[3])&&(result[0]||result[1]||not_result[2]||result[3])&&(result[0]||result[1]||result[2]||not_result[3]);
    					Answer[1] <= result[2] || result[3];
    					Answer[0] <= result[1] || result[3];
    				end
    			end
    			
    			if (reset==1'b0) ArbR <= 1'b0;
    			else
    				begin
    					if (Answer[2]==1'b0) ArbR <= 1'b1;
    					else ArbR <= 1'b0; // ?
    				end
    		
    		end
    
endmodule
