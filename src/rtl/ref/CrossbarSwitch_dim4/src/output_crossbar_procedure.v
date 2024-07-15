`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2021 21:40:36
// Design Name: 
// Module Name: out_procedure
// Project Name: Crossbar4
// Target Devices: Crossbar Switch dim. 4
// Tool Versions: 
// Description: procedure for correct commutation inputs to one of the outputs
// 
// Dependencies: 
// 
// Revision:
// Revision 4.1 (arbiter cutted from this module)
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module procedure(

    req,			addr,			cmd,			wdata,
    input_ack,		input_rdata,
    output_req,		output_addr,	output_cmd,		output_wdata,
    out_ack,		out_rdata,

	clk,			State,
	reset,			necessity, 		Answer,			arbiter_finished, 		C
    
    );
    //to master
    input	wire 	[(4-1):0]	req;    	input 	wire	[(32*4-1):0] 	addr;    	input	wire	[(4-1):0] 	cmd;    	input	wire	[(32*4-1):0] 	wdata;    
    output	reg		[(4-1):0]	input_ack;	output	reg		[(32*4-1):0] 	input_rdata;
    //to slave
    output	reg					output_req; output 	reg		[31:0] 			output_addr; output 	reg			output_cmd;    	output 	reg		[31:0] 			output_wdata;
    input	wire				out_ack;	input	wire	[31:0]			out_rdata;
    //main things
    input	wire				clk;        input	wire				    reset;
    // extra		
    (* mark_debug =	 "true" *)              output  reg		[2:0]		    State;	
    input	wire				necessity;	input  	wire 	[2:0]	 		Answer;     
    output 	reg 	[(4-1):0] 	C;          input 	wire                    arbiter_finished;
    

            wire                    out_req;
            wire	[31:0]			out_addr;
            wire					out_cmd;
            wire	[31:0]			out_wdata;    
            wire 	[(4-1):0]		oreq;
            wire	[(32*4-1):0] 	oaddr;
            wire	[(4-1):0] 		ocmd;
            wire	[(32*4-1):0] 	owdata;   
            
            wire	[(4-1):0]		ack;
            wire	[(32*4-1):0]	rdata;
            
   //logic for commutation data from points to slaves
    
   mux4_to_1 o_req(out_req, oreq[0], oreq[1], oreq[2], oreq[3], Answer[1], Answer[0]);
   
   mux4_to_1 o_addr31(out_addr[31], oaddr[31], oaddr[63], oaddr[95], oaddr[127], Answer[1], Answer[0]);
   mux4_to_1 o_addr30(out_addr[30], oaddr[30], oaddr[62], oaddr[94], oaddr[126], Answer[1], Answer[0]);
   mux4_to_1 o_addr29(out_addr[29], oaddr[29], oaddr[61], oaddr[93], oaddr[125], Answer[1], Answer[0]);
   mux4_to_1 o_addr28(out_addr[28], oaddr[28], oaddr[60], oaddr[92], oaddr[124], Answer[1], Answer[0]);

   mux4_to_1 o_addr27(out_addr[27], oaddr[27], oaddr[59], oaddr[91], oaddr[123], Answer[1], Answer[0]);
   mux4_to_1 o_addr26(out_addr[26], oaddr[26], oaddr[58], oaddr[90], oaddr[122], Answer[1], Answer[0]);
   mux4_to_1 o_addr25(out_addr[25], oaddr[25], oaddr[57], oaddr[89], oaddr[121], Answer[1], Answer[0]);
   mux4_to_1 o_addr24(out_addr[24], oaddr[24], oaddr[56], oaddr[88], oaddr[120], Answer[1], Answer[0]);

   mux4_to_1 o_addr23(out_addr[23], oaddr[23], oaddr[55], oaddr[87], oaddr[119], Answer[1], Answer[0]);
   mux4_to_1 o_addr22(out_addr[22], oaddr[22], oaddr[54], oaddr[86], oaddr[118], Answer[1], Answer[0]);
   mux4_to_1 o_addr21(out_addr[21], oaddr[21], oaddr[53], oaddr[85], oaddr[117], Answer[1], Answer[0]);
   mux4_to_1 o_addr20(out_addr[20], oaddr[20], oaddr[52], oaddr[84], oaddr[116], Answer[1], Answer[0]);

   mux4_to_1 o_addr19(out_addr[19], oaddr[19], oaddr[51], oaddr[83], oaddr[115], Answer[1], Answer[0]);
   mux4_to_1 o_addr18(out_addr[18], oaddr[18], oaddr[50], oaddr[82], oaddr[114], Answer[1], Answer[0]);
   mux4_to_1 o_addr17(out_addr[17], oaddr[17], oaddr[49], oaddr[81], oaddr[113], Answer[1], Answer[0]);
   mux4_to_1 o_addr16(out_addr[16], oaddr[16], oaddr[48], oaddr[80], oaddr[112], Answer[1], Answer[0]);
   
   mux4_to_1 o_addr15(out_addr[15], oaddr[15], oaddr[47], oaddr[79], oaddr[111], Answer[1], Answer[0]);
   mux4_to_1 o_addr14(out_addr[14], oaddr[14], oaddr[46], oaddr[78], oaddr[110], Answer[1], Answer[0]);
   mux4_to_1 o_addr13(out_addr[13], oaddr[13], oaddr[45], oaddr[77], oaddr[109], Answer[1], Answer[0]);
   mux4_to_1 o_addr12(out_addr[12], oaddr[12], oaddr[44], oaddr[76], oaddr[108], Answer[1], Answer[0]);
   
   mux4_to_1 o_addr11(out_addr[11], oaddr[11], oaddr[43], oaddr[75], oaddr[107], Answer[1], Answer[0]);
   mux4_to_1 o_addr10(out_addr[10], oaddr[10], oaddr[42], oaddr[74], oaddr[106], Answer[1], Answer[0]);
   mux4_to_1 o_addr09(out_addr[9], oaddr[9], oaddr[41], oaddr[73], oaddr[105], Answer[1], Answer[0]);
   mux4_to_1 o_addr08(out_addr[8], oaddr[8], oaddr[40], oaddr[72], oaddr[104], Answer[1], Answer[0]);

   mux4_to_1 o_addr07(out_addr[7], oaddr[7], oaddr[39], oaddr[71], oaddr[103], Answer[1], Answer[0]);
   mux4_to_1 o_addr06(out_addr[6], oaddr[6], oaddr[38], oaddr[70], oaddr[102], Answer[1], Answer[0]);
   mux4_to_1 o_addr05(out_addr[5], oaddr[5], oaddr[37], oaddr[69], oaddr[101], Answer[1], Answer[0]);
   mux4_to_1 o_addr04(out_addr[4], oaddr[4], oaddr[36], oaddr[68], oaddr[100], Answer[1], Answer[0]);
   
   mux4_to_1 o_addr03(out_addr[3], oaddr[3], oaddr[35], oaddr[67], oaddr[99], Answer[1], Answer[0]);
   mux4_to_1 o_addr02(out_addr[2], oaddr[2], oaddr[34], oaddr[66], oaddr[98], Answer[1], Answer[0]);
   mux4_to_1 o_addr01(out_addr[1], oaddr[1], oaddr[33], oaddr[65], oaddr[97], Answer[1], Answer[0]);
   mux4_to_1 o_addr00(out_addr[0], oaddr[0], oaddr[32], oaddr[64], oaddr[96], Answer[1], Answer[0]);

   mux4_to_1 o_cmd(out_cmd, ocmd[0], ocmd[1], ocmd[2], ocmd[3], Answer[1], Answer[0]);
   
   mux4_to_1 o_wdata31(out_wdata[31], owdata[31], owdata[63], owdata[95], owdata[127], Answer[1], Answer[0]);
   mux4_to_1 o_wdata30(out_wdata[30], owdata[30], owdata[62], owdata[94], owdata[126], Answer[1], Answer[0]);
   mux4_to_1 o_wdata29(out_wdata[29], owdata[29], owdata[61], owdata[93], owdata[125], Answer[1], Answer[0]);
   mux4_to_1 o_wdata28(out_wdata[28], owdata[28], owdata[60], owdata[92], owdata[124], Answer[1], Answer[0]);

   mux4_to_1 o_wdata27(out_wdata[27], owdata[27], owdata[59], owdata[91], owdata[123], Answer[1], Answer[0]);
   mux4_to_1 o_wdata26(out_wdata[26], owdata[26], owdata[58], owdata[90], owdata[122], Answer[1], Answer[0]);
   mux4_to_1 o_wdata25(out_wdata[25], owdata[25], owdata[57], owdata[89], owdata[121], Answer[1], Answer[0]);
   mux4_to_1 o_wdata24(out_wdata[24], owdata[24], owdata[56], owdata[88], owdata[120], Answer[1], Answer[0]);

   mux4_to_1 o_wdata23(out_wdata[23], owdata[23], owdata[55], owdata[87], owdata[119], Answer[1], Answer[0]);
   mux4_to_1 o_wdata22(out_wdata[22], owdata[22], owdata[54], owdata[86], owdata[118], Answer[1], Answer[0]);
   mux4_to_1 o_wdata21(out_wdata[21], owdata[21], owdata[53], owdata[85], owdata[117], Answer[1], Answer[0]);
   mux4_to_1 o_wdata20(out_wdata[20], owdata[20], owdata[52], owdata[84], owdata[116], Answer[1], Answer[0]);

   mux4_to_1 o_wdata19(out_wdata[19], owdata[19], owdata[51], owdata[83], owdata[115], Answer[1], Answer[0]);
   mux4_to_1 o_wdata18(out_wdata[18], owdata[18], owdata[50], owdata[82], owdata[114], Answer[1], Answer[0]);
   mux4_to_1 o_wdata17(out_wdata[17], owdata[17], owdata[49], owdata[81], owdata[113], Answer[1], Answer[0]);
   mux4_to_1 o_wdata16(out_wdata[16], owdata[16], owdata[48], owdata[80], owdata[112], Answer[1], Answer[0]);
   
   mux4_to_1 o_wdata15(out_wdata[15], owdata[15], owdata[47], owdata[79], owdata[111], Answer[1], Answer[0]);
   mux4_to_1 o_wdata14(out_wdata[14], owdata[14], owdata[46], owdata[78], owdata[110], Answer[1], Answer[0]);
   mux4_to_1 o_wdata13(out_wdata[13], owdata[13], owdata[45], owdata[77], owdata[109], Answer[1], Answer[0]);
   mux4_to_1 o_wdata12(out_wdata[12], owdata[12], owdata[44], owdata[76], owdata[108], Answer[1], Answer[0]);
   
   mux4_to_1 o_wdata11(out_wdata[11], owdata[11], owdata[43], owdata[75], owdata[107], Answer[1], Answer[0]);
   mux4_to_1 o_wdata10(out_wdata[10], owdata[10], owdata[42], owdata[74], owdata[106], Answer[1], Answer[0]);
   mux4_to_1 o_wdata09(out_wdata[9], owdata[9], owdata[41], owdata[73], owdata[105], Answer[1], Answer[0]);
   mux4_to_1 o_wdata08(out_wdata[8], owdata[8], owdata[40], owdata[72], owdata[104], Answer[1], Answer[0]);

   mux4_to_1 o_wdata07(out_wdata[7], owdata[7], owdata[39], owdata[71], owdata[103], Answer[1], Answer[0]);
   mux4_to_1 o_wdata06(out_wdata[6], owdata[6], owdata[38], owdata[70], owdata[102], Answer[1], Answer[0]);
   mux4_to_1 o_wdata05(out_wdata[5], owdata[5], owdata[37], owdata[69], owdata[101], Answer[1], Answer[0]);
   mux4_to_1 o_wdata04(out_wdata[4], owdata[4], owdata[36], owdata[68], owdata[100], Answer[1], Answer[0]);
   
   mux4_to_1 o_wdata03(out_wdata[3], owdata[3], owdata[35], owdata[67], owdata[99], Answer[1], Answer[0]);
   mux4_to_1 o_wdata02(out_wdata[2], owdata[2], owdata[34], owdata[66], owdata[98], Answer[1], Answer[0]);
   mux4_to_1 o_wdata01(out_wdata[1], owdata[1], owdata[33], owdata[65], owdata[97], Answer[1], Answer[0]);
   mux4_to_1 o_wdata00(out_wdata[0], owdata[0], owdata[32], owdata[64], owdata[96], Answer[1], Answer[0]);

// commutation points

point P0(
							C[0],		Answer[2],				arbiter_finished,		necessity,
							req[0],		addr[(1*32-1)-:32],		cmd[0],			wdata[(1*32-1)-:32],    	ack[0],			rdata[(1*32-1)-:32],
							oreq[0],	oaddr[(1*32-1)-:32],	ocmd[0],		owdata[(1*32-1)-:32],   	out_ack,    	out_rdata, 			
							clk, 		reset
							);
point P1(
							C[1],		Answer[2],				arbiter_finished,		necessity,
							req[1],		addr[(2*32-1)-:32],		cmd[1],			wdata[(2*32-1)-:32],    	ack[1],			rdata[(2*32-1)-:32],
							oreq[1],	oaddr[(2*32-1)-:32],	ocmd[1],		owdata[(2*32-1)-:32],   	out_ack,    	out_rdata, 			
							clk, 		reset
							);
point P2(
							C[2],		Answer[2],				arbiter_finished,		necessity,
							req[2],		addr[(3*32-1)-:32],		cmd[2],			wdata[(3*32-1)-:32],    	ack[2],			rdata[(3*32-1)-:32],
							oreq[2],	oaddr[(3*32-1)-:32],	ocmd[2],		owdata[(3*32-1)-:32],   	out_ack,    	out_rdata, 			
							clk, 		reset
							);														
point P3(
							C[3],		Answer[2],				arbiter_finished,		necessity,
							req[3],		addr[(4*32-1)-:32],		cmd[3],			wdata[(4*32-1)-:32],    	ack[3],			rdata[(4*32-1)-:32],
							oreq[3],	oaddr[(4*32-1)-:32],	ocmd[3],		owdata[(4*32-1)-:32],		out_ack,    	out_rdata, 			
							clk, 		reset
							);	
							   
    initial
    	begin
    		C[0] <= 0;
    		C[1] <= 0;
    		C[2] <= 0;
    		C[3] <= 0;	
    	end

//State Mashine for one of outputs

always @(posedge clk)
  		begin
  		
			if (reset==1'b0)
				begin
					State <= 3'b000;
					
					C[0] <= 0;
					C[1] <= 0;
					C[2] <= 0;
					C[3] <= 0;
					
					input_ack <= 4'b0000;
					input_rdata <= 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
					output_req <=1'b0;
					output_addr <= 32'b00000000000000000000000000000000;
					output_cmd<=1'b0;
					output_wdata <= 32'b00000000000000000000000000000000;
					
      			end

			else if (reset==1'b1)
			  begin

				case(State)
		
				  3'b001: //Arbitration state:
					begin

						if (Answer[2]== 0)
							begin 
								C[Answer[1]*2+Answer[0]] <= 1'b1;
								State <= 3'b010;
							end
					end
				  3'b010: //Connection
					begin
						output_req <= out_req;
						output_addr <= out_addr;
						output_cmd <= out_cmd;
						output_wdata <= out_wdata;


					  	if (out_ack) 		State <= 3'b011; //to answer
					end
				  
				  3'b011: //Answer
					begin

					  	input_ack <= ack;
					  	
					  	if (output_cmd==1'b0) 		State <= 3'b100;//reading
					  	if (output_cmd==1'b1) 		State <= 3'b101;
					  	
					end
				  
				  3'b100://Reading
					begin
						input_rdata <= rdata;
						
					  	State <= 3'b110; //end
					end
		
				  3'b101: //end
					begin
						
					  if (out_req==0) 
					  	begin 
					  		State <= 3'b110; //blocked
					  	end
					end
				    
				 3'b110: //end
					begin
						C[0] <= 0;
						C[1] <= 0;
						C[2] <= 0;
						C[3] <= 0; 
						output_req <= out_req;
					  if (out_req==0) 
					  	begin 
					  		State <= 3'b000; //blocked
					  	end
					end
					
				  3'b000: //blocked:
					begin
					  if (necessity) State <= 3'b001;
					  	C[0] <= 0;
						C[1] <= 0;
						C[2] <= 0;
						C[3] <= 0; 
						
					end
		
				  default: //lost my way~~ 
					begin
					  State <= 3'b000; 
					  	C[0] <= 0;
						C[1] <= 0;
						C[2] <= 0;
						C[3] <= 0;

            end
        endcase
      			end
  		end

endmodule