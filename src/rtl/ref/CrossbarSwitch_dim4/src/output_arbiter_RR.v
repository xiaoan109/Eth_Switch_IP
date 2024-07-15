`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2021 20:35:58
// Design Name: 
// Module Name: out_arbiter
// Project Name: 
// Target Devices: Round Robin Arbiter (for Crossbar Switch 4)
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 1.1 - solved problem at FPGA
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module out_arbiter	(
		
						out, requests, address, arbiter_answer, ArbR, STATE, clk, reset
    
    					);
    					
    input 	wire [1:0]	out;			
    input 	wire [3:0] 	requests;
    input 	wire [7:0] 	address;
    output 	reg  [2:0]	arbiter_answer;			
    output 	reg 		ArbR; 	//Arbiter gives Answer		
    input	wire [2:0]	STATE; //state on State Mash on output
    input	wire		clk;
    input	wire		reset;
    
            reg [2:0]   Previous;
    
    
    initial
    	begin
    		Previous <= 3'b011;
    		ArbR <= 1'b0;
    		arbiter_answer <= 3'b100;
    	end
    	
    	
    always @(posedge clk)
    	begin
    	
    	if (STATE==3'b000) 
            begin
                arbiter_answer <= 3'b100;
                ArbR <= 1'b0;
            end
    	
    	if (reset==1'b0)
		   begin
                arbiter_answer <= 3'b100;
                Previous <= 3'b011;
                ArbR <= 1'b0;
		   end 
    
		else	
		
		begin
		      
		      if (STATE==3'b001 && ArbR==1'b0)
						
				case (Previous) 
					3'b011 : 		
							begin
								if (address[1:0] == out && requests[0]==1) 
									begin
										arbiter_answer <= 3'b000;
										ArbR <= 1'b1;
									end
								Previous <= 3'b000;
							end
					3'b000 :				
							begin
								if (address[3:2] == out && requests[1]==1) 
									begin
										arbiter_answer <= 3'b001;
										ArbR <= 1'b1;
									end
								Previous <= 3'b001;
							end
					3'b001 :					
							begin
								if (address[5:4] == out && requests[2]==1) 
									begin
										arbiter_answer <= 3'b010;
										ArbR <= 1'b1;
									end
								Previous <= 3'b010;
							end
					3'b010 :						
							begin
								if (address[7:6] == out && requests[3]==1) 
									begin
										arbiter_answer <= 3'b011;
										ArbR <= 1'b1;
									end
								Previous <= 3'b011;		
							end
					endcase
				
			
			end
			
		end


    
endmodule