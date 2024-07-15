`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2021 19:06:57
// Design Name: 
// Module Name: stimulus_for_Crossbar4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 2.0 - correct test for arty as module probe
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stimulus_for_Crossbar4(

                                    input 	wire 					clk,
    (* mark_debug =	 "true" *)      output 	reg 	[3:0] 			req,
    
//    // uncomment next for simulation 	
//    (* mark_debug =	 "true" *)      output  wire 	[3:0] 			rreq,
//    (* mark_debug =	 "true" *)      output	wire 	[3:0] 			ack,
//    (* mark_debug =	 "true" *)		output  reg 	[3:0] 			aack,
//    (* mark_debug =	 "true" *)      output  reg 					reset,	
//    // thats all	
	                                
	                                input 	wire					hard_reset
    );
    
    //main
    (* mark_debug =	 "true" *)                          reg 					reset;    
    (* mark_debug =	 "true" *)                          wire 	[3:0] 			rreq;
	       	reg 	[(32*4-1):0] 	addr;	          	wire 	[(32*4-1):0]	aaddr;
	       	reg 	[3:0] 			cmd;	        	wire 	[3:0] 			ccmd;
	       	reg 	[(32*4-1):0] 	wdata;		     	wire 	[(32*4-1):0]	wwdata;
    (* mark_debug =	 "true" *) 	       	                wire 	[3:0] 			ack;                
    (* mark_debug =	 "true" *)                          reg 	[3:0] 			aack;
	    	wire	[(32*4-1):0] 	rdata;		     	reg 	[(32*4-1):0]	rrdata;
            //extra
    		reg 					State;
            reg     [3:0]           data0;
            wire                    out0;

    //shift for 1'b0
    
	shifttt zero_state(clk, reset, data0, out0, hard_reset);
	
	// State Mashine
	
	always @(posedge clk)
		begin
	
						
			if (hard_reset==1'b0) 
				begin
					reset <= 1'b0;
					req <= 4'b1111;
					addr[31:0]			<=	32'b00000000000000000000000000000000;
					addr[32*2-1-:32]	<=	32'b00000000000000000000000000000000;
					addr[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
					addr[32*4-1-:32]	<=	32'b00000000000000000000000000000000;
		
		 			cmd					<= 	4'b0000;
		
					wdata[32*1-1-:32]	<=	32'b00000000000000000000000000000000;
					wdata[32*2-1-:32]	<=	32'b00000000000000000000000000000000;
					wdata[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
					wdata[32*4-1-:32]	<=	32'b00000000000000000000000000000000;
					
					State <= 1'b0;
					
					rrdata[32*1-1-:32]	<=	32'b00000000000000000000000000000000;
					rrdata[32*2-1-:32]	<=	32'b00000000000000000000000000000000;
					rrdata[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
					rrdata[32*4-1-:32]	<=	32'b00000000000000000000000000000000;
					
					data0 <= 4'b0001;
					
				end
			else case (State)
			
			1'b0 : //start
				begin
					reset <= 1'b0;
					req <= 4'b1111;
					addr[31:0]			<=	32'b01000000000000000000000000000000;
					addr[32*2-1-:32]	<=	32'b01000000000000000000000000000000;
					addr[32*3-1-:32]	<=	32'b01000000000000000000000000000000;
					addr[32*4-1-:32]	<=	32'b01000000000000000000000000000000;
		
		 			cmd					<= 	4'b1001;
		
					wdata[32*1-1-:32]	<=	32'b10101000000000000000000000000000;
					wdata[32*2-1-:32]	<=	32'b00000000000000000000000000000000;
					wdata[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
					wdata[32*4-1-:32]	<=	32'b01010000000000000000000000000000;
						
					//analog of #40 State <= 1'b1;
					State <= out0;
					
				end
			1'b1 :
				begin
					reset <= 1'b1;
					rrdata[32*1-1-:32]	<=	32'b00000000000000000000000000000001;
					rrdata[32*2-1-:32]	<=	32'b00110000000000000000000000000000;
					rrdata[32*3-1-:32]	<=	32'b00000000000000000000000000000100;
					rrdata[32*4-1-:32]	<=	32'b00000000000000000000000000001000;
					
					
		if (ack[0]) req[0]<=1'b0;
		if (ack[1]) req[1]<=1'b0;
		if (ack[2]) req[2]<=1'b0;
		if (ack[3]) req[3]<=1'b0;
	
		if (rreq[0]==1'b1) aack[0]<=1'b1;
		if (rreq[1]==1'b1) aack[1]<=1'b1;
		if (rreq[2]==1'b1) aack[2]<=1'b1;
		if (rreq[3]==1'b1) aack[3]<=1'b1;

		if (rreq[0]==1'b0) aack[0]<=1'b0;
		if (rreq[1]==1'b0) aack[1]<=1'b0;
		if (rreq[2]==1'b0) aack[2]<=1'b0;
		if (rreq[3]==1'b0) aack[3]<=1'b0;
		
		          
		          //analog of #860
		          
		          if (req==4'b0000) State <=1'b0;
		          else State <= 1'b1;
		
				end
			
			endcase
			
		end
		
		main_module_of_Crossbar Crossbar4(	clk, 	reset,	
					req,	addr,	cmd,	wdata,	ack,	rdata,
					rreq,	aaddr,	ccmd,	wwdata,	aack,	rrdata
			);
    
endmodule
