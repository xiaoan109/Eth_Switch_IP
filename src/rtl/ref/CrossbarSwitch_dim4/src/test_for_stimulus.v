`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2021 12:46:41
// Design Name: 
// Module Name: test_for_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 1.0 - first correct vers.
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_for_test(    );
    
            reg 					clk;
	    	reg					    hard_reset;
	    	wire 	[3:0] 			req;
	    	
//	    	wire 	[3:0] 			rreq;
//	    	wire 	[3:0] 			ack;
//	    	wire 	[3:0] 			aack;
//	    	wire					reset;

stimulus_for_Crossbar4 TOP(clk, req, 
                                    //rreq, ack, aack, reset,
                                                                hard_reset 
						);

//create clk

    initial 					clk 	= 	1'b0;
	always 		#5 			    clk 	= 	~clk;
	
	always @(posedge clk)
	   begin
	       hard_reset <= 1'b0;
	       #40 hard_reset <= 1'b1;
	       #900 hard_reset <= 1'b0;
	   end
    
endmodule