`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2021 20:26:40
// Design Name: 
// Module Name: point_of_switch
// Project Name: Crossbar4
// Target Devices: Crossbar Switch 4
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 4.2 - always blocks corrected 
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////


module point(
							C,			Answer,		finished,	necessity,
							in_req,		in_addr,	in_cmd,		in_wdata,    	in_ack,			in_rdata,
							out_req,	out_addr,	out_cmd,	out_wdata,   	out_ack,    	out_rdata, 			
							clk, 					reset
							);
    
    input 	wire	C; 			input	wire			Answer;		input	wire	finished;	input	wire			necessity;
    input	wire	in_req;    	input 	wire	[31:0] 	in_addr;    input	wire	in_cmd;    	input 	wire	[31:0] 	in_wdata;     
    output 	wire	in_ack;    	output 	wire 	[31:0] 	in_rdata;
    
    output 	wire	out_req;    output 	wire	[31:0] 	out_addr;   output 	wire	out_cmd;    output 	wire	[31:0] 	out_wdata;    
    input 	wire	out_ack;    input 	wire	[31:0] 	out_rdata;	
    
    input 	wire	clk;											input	wire	reset;		
    
                                        reg		[2:0]	NState;
	
                                        reg 			GO; // for addr
                                        reg 			GO_req;
                                        reg 			GO_ack;
                                        reg 			GO_read;
                                        reg				GO_write;

	
	                                    reg             IN0;
	
	initial
		begin
			NState 		<=	3'b000;
			
			IN0 		<= 	1'b0;
			
			GO 			<= 	1'b0;
			GO_req 		<= 	1'b0;
			GO_ack 		<= 	1'b0;
			GO_read 	<= 	1'b0;
			GO_write	<=	1'b0;		
		end
		
		// Finite-state machine
			  	
always @(posedge clk)
  	begin	  
		
		if (reset==1'b0)
		begin
			NState 		<=	3'b000;
			
			IN0 		<= 	1'b0;
			
			GO 			<= 	1'b0;
			GO_req 		<= 	1'b0;
			GO_ack 		<= 	1'b0;
			GO_read 	<= 	1'b0;
			
			GO_write	<=	1'b0;
		end 
		
		if (C==1'b1) case(NState)
		
				  3'b001: //Arbitration state:
					begin
							GO 			<= 	1'b0;
							GO_req 		<= 	1'b0;
							GO_ack 		<= 	1'b0;
							GO_read 	<= 	1'b0;
							GO_write	<=	1'b0;
							
							if (Answer==1'b0 && C==1'b1)
							begin 
								if (finished==1'b1) NState <= 3'b010;
							end
					end
				  
				  3'b010: //Connection
					begin
							GO 			<= 	1'b1;
							GO_req 		<= 	1'b1;
							GO_ack 		<= 	1'b1;
							GO_read 	<= 	1'b0;
							
				if (in_cmd) GO_write	<=	1'b1;
				else 		GO_write	<=	1'b0;
				
				if (out_ack==1'b1) 		NState <= 3'b011; //to answer
				
					end
				  
				  3'b011: //Answer
					begin
							GO 			<= 	1'b0;
							GO_req 		<= 	1'b0;
							GO_ack 		<= 	1'b1;
							GO_read 	<= 	1'b0;
							
							GO_write	<=	1'b0;
							
							if (out_cmd==1'b0) 	NState <= 3'b100;//reading
					  		else 				NState <= 3'b101;
					end
				  
				  3'b100://Reading
					begin
							GO 			<= 	1'b0;
							GO_req 		<= 	1'b0;
							GO_ack 		<= 	1'b0;
							GO_read 	<= 	1'b1;
							GO_write	<=	1'b0;
							
							NState <= 3'b101; //end 
					end
		
				  3'b101: //end
					begin
							GO 			<= 	1'b0;
							GO_req 		<= 	1'b1;
							GO_ack 		<= 	1'b0;
							GO_read 	<= 	1'b0;
							GO_write	<=	1'b0;
							
					if (out_req==1'b0) 
					  	begin 
					  		NState <= 3'b000; //blocked
					  	end
			  	
					end
					
				  3'b000: //blocked:
					begin
							GO 			<= 	1'b0;
							GO_req 		<= 	1'b0;
							GO_ack 		<= 	1'b0;
							GO_read 	<= 	1'b0;
							
							GO_write	<=	1'b0;
							
							if (necessity) NState <= 3'b010;
					end
		
				  default: //lost my way~~ 
					begin
					  		GO 			<= 	1'b0;
							GO_req 		<= 	1'b0;
							GO_ack 		<= 	1'b0;
							GO_read 	<= 	1'b0;
							
							GO_write	<=	1'b0;
							
							NState <= 3'b000; 

            end
        endcase
        		
  		end
  		
  		//logic for accurate commutation

mux2_to_1 point_req(out_req, IN0, in_req, GO_req);

mux2_to_1 point_addr31(out_addr[31], IN0, in_addr[31], GO);
mux2_to_1 point_addr30(out_addr[30], IN0, in_addr[30], GO);
mux2_to_1 point_addr29(out_addr[29], IN0, in_addr[29], GO);
mux2_to_1 point_addr28(out_addr[28], IN0, in_addr[28], GO);

mux2_to_1 point_addr27(out_addr[27], IN0, in_addr[27], GO);
mux2_to_1 point_addr26(out_addr[26], IN0, in_addr[26], GO);
mux2_to_1 point_addr25(out_addr[25], IN0, in_addr[25], GO);
mux2_to_1 point_addr24(out_addr[24], IN0, in_addr[24], GO);

mux2_to_1 point_addr23(out_addr[23], IN0, in_addr[23], GO);
mux2_to_1 point_addr22(out_addr[22], IN0, in_addr[22], GO);
mux2_to_1 point_addr21(out_addr[21], IN0, in_addr[21], GO);
mux2_to_1 point_addr20(out_addr[20], IN0, in_addr[20], GO);

mux2_to_1 point_addr19(out_addr[19], IN0, in_addr[19], GO);
mux2_to_1 point_addr18(out_addr[18], IN0, in_addr[18], GO);
mux2_to_1 point_addr17(out_addr[17], IN0, in_addr[17], GO);
mux2_to_1 point_addr16(out_addr[16], IN0, in_addr[16], GO);

mux2_to_1 point_addr15(out_addr[15], IN0, in_addr[15], GO);
mux2_to_1 point_addr14(out_addr[14], IN0, in_addr[14], GO);
mux2_to_1 point_addr13(out_addr[13], IN0, in_addr[13], GO);
mux2_to_1 point_addr12(out_addr[12], IN0, in_addr[12], GO);

mux2_to_1 point_addr11(out_addr[11], IN0, in_addr[11], GO);
mux2_to_1 point_addr10(out_addr[10], IN0, in_addr[10], GO);
mux2_to_1 point_addr09(out_addr[9], IN0, in_addr[9], GO);
mux2_to_1 point_addr08(out_addr[8], IN0, in_addr[8], GO);

mux2_to_1 point_addr07(out_addr[7], IN0, in_addr[7], GO);
mux2_to_1 point_addr06(out_addr[6], IN0, in_addr[6], GO);
mux2_to_1 point_addr05(out_addr[5], IN0, in_addr[5], GO);
mux2_to_1 point_addr04(out_addr[4], IN0, in_addr[4], GO);

mux2_to_1 point_addr03(out_addr[3], IN0, in_addr[3], GO);
mux2_to_1 point_addr02(out_addr[2], IN0, in_addr[2], GO);
mux2_to_1 point_addr01(out_addr[1], IN0, in_addr[1], GO);
mux2_to_1 point_addr00(out_addr[0], IN0, in_addr[0], GO);

mux2_to_1 point_cmd(out_cmd, IN0, in_cmd, GO);

mux2_to_1 point_wdata31(out_wdata[31], IN0, in_wdata[31], GO_write);
mux2_to_1 point_wdata30(out_wdata[30], IN0, in_wdata[30], GO_write);
mux2_to_1 point_wdata29(out_wdata[29], IN0, in_wdata[29], GO_write);
mux2_to_1 point_wdata28(out_wdata[28], IN0, in_wdata[28], GO_write);

mux2_to_1 point_wdata27(out_wdata[27], IN0, in_wdata[27], GO_write);
mux2_to_1 point_wdata26(out_wdata[26], IN0, in_wdata[26], GO_write);
mux2_to_1 point_wdata25(out_wdata[25], IN0, in_wdata[25], GO_write);
mux2_to_1 point_wdata24(out_wdata[24], IN0, in_wdata[24], GO_write);

mux2_to_1 point_wdata23(out_wdata[23], IN0, in_wdata[23], GO_write);
mux2_to_1 point_wdata22(out_wdata[22], IN0, in_wdata[22], GO_write);
mux2_to_1 point_wdata21(out_wdata[21], IN0, in_wdata[21], GO_write);
mux2_to_1 point_wdata20(out_wdata[20], IN0, in_wdata[20], GO_write);

mux2_to_1 point_wdata19(out_wdata[19], IN0, in_wdata[19], GO_write);
mux2_to_1 point_wdata18(out_wdata[18], IN0, in_wdata[18], GO_write);
mux2_to_1 point_wdata17(out_wdata[17], IN0, in_wdata[17], GO_write);
mux2_to_1 point_wdata16(out_wdata[16], IN0, in_wdata[16], GO_write);

mux2_to_1 point_wdata15(out_wdata[15], IN0, in_wdata[15], GO_write);
mux2_to_1 point_wdata14(out_wdata[14], IN0, in_wdata[14], GO_write);
mux2_to_1 point_wdata13(out_wdata[13], IN0, in_wdata[13], GO_write);
mux2_to_1 point_wdata12(out_wdata[12], IN0, in_wdata[12], GO_write);

mux2_to_1 point_wdata11(out_wdata[11], IN0, in_wdata[11], GO_write);
mux2_to_1 point_wdata10(out_wdata[10], IN0, in_wdata[10], GO_write);
mux2_to_1 point_wdata09(out_wdata[9], IN0, in_wdata[9], GO_write);
mux2_to_1 point_wdata08(out_wdata[8], IN0, in_wdata[8], GO_write);

mux2_to_1 point_wdata07(out_wdata[7], IN0, in_wdata[7], GO_write);
mux2_to_1 point_wdata06(out_wdata[6], IN0, in_wdata[6], GO_write);
mux2_to_1 point_wdata05(out_wdata[5], IN0, in_wdata[5], GO_write);
mux2_to_1 point_wdata04(out_wdata[4], IN0, in_wdata[4], GO_write);

mux2_to_1 point_wdata03(out_wdata[3], IN0, in_wdata[3], GO_write);
mux2_to_1 point_wdata02(out_wdata[2], IN0, in_wdata[2], GO_write);
mux2_to_1 point_wdata01(out_wdata[1], IN0, in_wdata[1], GO_write);
mux2_to_1 point_wdata00(out_wdata[0], IN0, in_wdata[0], GO_write);

mux2_to_1 point_ack(in_ack, IN0, out_ack, GO_ack);

mux2_to_1 point_rdata31(in_rdata[31], IN0, out_rdata[31], GO_read);
mux2_to_1 point_rdata30(in_rdata[30], IN0, out_rdata[30], GO_read);
mux2_to_1 point_rdata29(in_rdata[29], IN0, out_rdata[29], GO_read);
mux2_to_1 point_rdata28(in_rdata[28], IN0, out_rdata[28], GO_read);

mux2_to_1 point_rdata27(in_rdata[27], IN0, out_rdata[27], GO_read);
mux2_to_1 point_rdata26(in_rdata[26], IN0, out_rdata[26], GO_read);
mux2_to_1 point_rdata25(in_rdata[25], IN0, out_rdata[25], GO_read);
mux2_to_1 point_rdata24(in_rdata[24], IN0, out_rdata[24], GO_read);

mux2_to_1 point_rdata23(in_rdata[23], IN0, out_rdata[23], GO_read);
mux2_to_1 point_rdata22(in_rdata[22], IN0, out_rdata[22], GO_read);
mux2_to_1 point_rdata21(in_rdata[21], IN0, out_rdata[21], GO_read);
mux2_to_1 point_rdata20(in_rdata[20], IN0, out_rdata[20], GO_read);

mux2_to_1 point_rdata19(in_rdata[19], IN0, out_rdata[19], GO_read);
mux2_to_1 point_rdata18(in_rdata[18], IN0, out_rdata[18], GO_read);
mux2_to_1 point_rdata17(in_rdata[17], IN0, out_rdata[17], GO_read);
mux2_to_1 point_rdata16(in_rdata[16], IN0, out_rdata[16], GO_read);

mux2_to_1 point_rdata15(in_rdata[15], IN0, out_rdata[15], GO_read);
mux2_to_1 point_rdata14(in_rdata[14], IN0, out_rdata[14], GO_read);
mux2_to_1 point_rdata13(in_rdata[13], IN0, out_rdata[13], GO_read);
mux2_to_1 point_rdata12(in_rdata[12], IN0, out_rdata[12], GO_read);

mux2_to_1 point_rdata11(in_rdata[11], IN0, out_rdata[11], GO_read);
mux2_to_1 point_rdata10(in_rdata[10], IN0, out_rdata[10], GO_read);
mux2_to_1 point_rdata09(in_rdata[9], IN0, out_rdata[9], GO_read);
mux2_to_1 point_rdata08(in_rdata[8], IN0, out_rdata[8], GO_read);

mux2_to_1 point_rdata07(in_rdata[7], IN0, out_rdata[7], GO_read);
mux2_to_1 point_rdata06(in_rdata[6], IN0, out_rdata[6], GO_read);
mux2_to_1 point_rdata05(in_rdata[5], IN0, out_rdata[5], GO_read);
mux2_to_1 point_rdata04(in_rdata[4], IN0, out_rdata[4], GO_read);

mux2_to_1 point_rdata03(in_rdata[3], IN0, out_rdata[3], GO_read);
mux2_to_1 point_rdata02(in_rdata[2], IN0, out_rdata[2], GO_read);
mux2_to_1 point_rdata01(in_rdata[1], IN0, out_rdata[1], GO_read);
mux2_to_1 point_rdata00(in_rdata[0], IN0, out_rdata[0], GO_read);
    
endmodule
