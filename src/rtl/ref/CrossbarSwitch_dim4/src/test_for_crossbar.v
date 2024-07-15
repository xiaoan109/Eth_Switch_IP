`timescale 1ns / 1ps

module test();

reg 					clk;			reg 					reset;

wire 	[3:0] 			req;			wire 	[3:0] 			rreq;
reg 	[(32*4-1):0] 	addr;			wire 	[(32*4-1):0]	aaddr;
reg 	[3:0] 			cmd;			wire 	[3:0] 			ccmd;
reg 	[(32*4-1):0] 	wdata;			wire 	[(32*4-1):0]	wwdata;
wire 	[3:0] 			ack;			wire 	[3:0] 			aack;
wire	[(32*4-1):0] 	rdata;			reg 	[(32*4-1):0]	rrdata;

reg		[3:0]			reqq;
reg		[3:0]			ackk;

// create clock
    
    initial 					clk 	= 	1'b0;
	always 		#5 			    clk 	= 	~clk;
	
//masters

always @(posedge clk)
	begin	
		if (ack[0]) reqq[0]<=1'b0;
		if (ack[1]) reqq[1]<=1'b0;
		if (ack[2]) reqq[2]<=1'b0;
		if (ack[3]) reqq[3]<=1'b0;
	end

//slaves

always @(posedge clk)
	begin
		if (rreq[0]==1'b1) ackk[0]<=1'b1;
		if (rreq[1]==1'b1) ackk[1]<=1'b1;
		if (rreq[2]==1'b1) ackk[2]<=1'b1;
		if (rreq[3]==1'b1) ackk[3]<=1'b1;

		if (rreq[0]==1'b0) ackk[0]<=1'b0;
		if (rreq[1]==1'b0) ackk[1]<=1'b0;
		if (rreq[2]==1'b0) ackk[2]<=1'b0;
		if (rreq[3]==1'b0) ackk[3]<=1'b0;
	end
	
//crossbar
	
main_module_of_Crossbar top_module(	clk, 	reset,
					
					req,	addr,	cmd,	wdata,	
					ack,	rdata,
					
					rreq,	aaddr,	ccmd,	wwdata,	
					aack,	rrdata
				);
		
		assign req = reqq;
		assign aack = ackk; 
				
//sim
always @(posedge clk)
	begin
	

//STEP 1 : all want out1
				reset 				<=	1'b0;

		 		reqq				<= 	4'b1111;
		
				addr[31:0]			<=	32'b01000000000000000000000000000000;
				addr[32*2-1-:32]	<=	32'b01000000000000000000000000000000;
				addr[32*3-1-:32]	<=	32'b01000000000000000000000000000000;
				addr[32*4-1-:32]	<=	32'b01000000000000000000000000000000;
		
		 		cmd					<= 	4'b1001;
		
				wdata[32*1-1-:32]	<=	32'b10101000000000000000000000000000;
//				wdata[32*2-1-:32]	<=	32'b00000000000000000000000000000000;
//				wdata[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
				wdata[32*4-1-:32]	<=	32'b01010000000000000000000000000000;
				
				#40		reset 				<=	1'b1;
		
				rrdata[32*1-1-:32]	<=	32'b00000000000000000000000000000001;
				rrdata[32*2-1-:32]	<=	32'b00110000000000000000000000000000;
				rrdata[32*3-1-:32]	<=	32'b00000000000000000000000000000100;
				rrdata[32*4-1-:32]	<=	32'b00000000000000000000000000001000;
						
//STEP 2 : in2,3 want out0, in1 wants out2, in0 - depressed T_T

// This part may be displayed in case @1 : 
//				clk toggles every #5 (now is #10) and with #800 & #220 dalays to start 2nd and 3rd parts
//				but with this value it's necc to correct delays in body and arbiter

		#500	reqq				<= 	4'b1110; 								
		
//				addr[32*1-1-:32]	<=	32'b00000000000000000000000000000000;
				addr[32*2-1-:32]	<=	32'b10000000000000000000000000000000;
				addr[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
				addr[32*4-1-:32]	<=	32'b00000000000000000000000000000000;
		
//				cmd[0]				<= 	1'b1;
				cmd[1]				<= 	1'b1; 
				cmd[2]				<=	1'b1; 
				cmd[3]				<=	1'b0; 
		
//				wdata[32*1-1-:32]	<=	32'b00000000000000000000000000000000;
				wdata[32*2-1-:32]	<=	32'b11111111111111111111111111111111;
				wdata[32*3-1-:32]	<=	32'b11110000000000000000000000000000;
//				wdata[32*4-1-:32]	<=	32'b00000000000000000000000000000000;
		
		//ack???		
		
		#20		rrdata[32*1-1-:32]	<=	32'b00010001000000000000000000000000;
//				rrdata[32*2-1-:32]	<=	32'b00000000000000000000000000000000;
//				rrdata[32*3-1-:32]	<=	32'b00000000000000000000000000000000;
//				rrdata[32*4-1-:32]	<=	32'b00000000000000000000000000000000;

//STEP 3 : in0 wants out2

		#220 	reqq[0]				<= 	1'b1;									//@1 #220
				addr[32*1-1-:32]	<=	32'b10000000000000000000000000000000;
				cmd[0]				<= 	1'b0;
//				wdata[32*1-1-:32]	<=	32'b00000000000000000000000000000000;

//ack?

		#20		rrdata[32*3-1-:32]	<=	32'b00001111111111111111111111111111;

//STEP 4 : rESET

		#150	reset 				<= 1'b0;
		#10		reset 				<= 1'b1;

	end



endmodule