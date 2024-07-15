`timescale 1ns / 1ps

module connection
    (clk, reset, ack0, ack1, ack2, ack3, rdata0, rdata1, rdata2, rdata3, result_ack, result_rdata, Answer);

input   wire            clk;
input   wire            reset;
input   wire 			ack0;
input   wire 			ack1;
input   wire 			ack2;
input   wire 			ack3;

input   wire    [31:0] 	rdata0;
input   wire    [31:0] 	rdata1;
input   wire	[31:0] 	rdata2;
input   wire	[31:0] 	rdata3;

       	wire            ack;
output  reg             result_ack;
        wire    [31:0]	rdata;
output  reg     [31:0]  result_rdata;

input   wire    [2:0]	Answer;


	mux4_to_1 o_ack(ack, ack0, ack1, ack2, ack3, Answer[1], Answer[0]);
   
   	mux4_to_1 o_rdata31(rdata[31], rdata0[31], rdata1[31], rdata2[31], rdata3[31], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata30(rdata[30], rdata0[30], rdata1[30], rdata2[30], rdata3[30], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata29(rdata[29], rdata0[29], rdata1[29], rdata2[29], rdata3[29], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata28(rdata[28], rdata0[28], rdata1[28], rdata2[28], rdata3[28], Answer[1], Answer[0]);

   	mux4_to_1 o_rdata27(rdata[27], rdata0[27], rdata1[27], rdata2[27], rdata3[27], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata26(rdata[26], rdata0[26], rdata1[26], rdata2[26], rdata3[26], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata25(rdata[25], rdata0[25], rdata1[25], rdata2[25], rdata3[25], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata24(rdata[24], rdata0[24], rdata1[24], rdata2[24], rdata3[24], Answer[1], Answer[0]);

   	mux4_to_1 o_rdata23(rdata[23], rdata0[23], rdata1[23], rdata2[23], rdata3[23], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata22(rdata[22], rdata0[22], rdata1[22], rdata2[22], rdata3[22], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata21(rdata[21], rdata0[21], rdata1[21], rdata2[21], rdata3[21], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata20(rdata[20], rdata0[20], rdata1[20], rdata2[20], rdata3[20], Answer[1], Answer[0]);

   	mux4_to_1 o_rdata19(rdata[19], rdata0[19], rdata1[19], rdata2[19], rdata3[19], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata18(rdata[18], rdata0[18], rdata1[18], rdata2[18], rdata3[18], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata17(rdata[17], rdata0[17], rdata1[17], rdata2[17], rdata3[17], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata16(rdata[16], rdata0[16], rdata1[16], rdata2[16], rdata3[16], Answer[1], Answer[0]);
   
   	mux4_to_1 o_rdata15(rdata[15], rdata0[15], rdata1[15], rdata2[15], rdata3[15], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata14(rdata[14], rdata0[14], rdata1[14], rdata2[14], rdata3[14], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata13(rdata[13], rdata0[13], rdata1[13], rdata2[13], rdata3[13], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata12(rdata[12], rdata0[12], rdata1[12], rdata2[12], rdata3[12], Answer[1], Answer[0]);
   
   	mux4_to_1 o_rdata11(rdata[11], rdata0[11], rdata1[11], rdata2[11], rdata3[11], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata10(rdata[10], rdata0[10], rdata1[10], rdata2[10], rdata3[10], Answer[1], Answer[0]);
   	
   	mux4_to_1 o_rdata09(rdata[9], rdata0[9], rdata1[9], rdata2[9], rdata3[9], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata08(rdata[8], rdata0[8], rdata1[8], rdata2[8], rdata3[8], Answer[1], Answer[0]);

   	mux4_to_1 o_rdata07(rdata[7], rdata0[7], rdata1[7], rdata2[7], rdata3[7], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata06(rdata[6], rdata0[6], rdata1[6], rdata2[6], rdata3[6], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata05(rdata[5], rdata0[5], rdata1[5], rdata2[5], rdata3[5], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata04(rdata[4], rdata0[4], rdata1[4], rdata2[4], rdata3[4], Answer[1], Answer[0]);
   
   	mux4_to_1 o_rdata03(rdata[3], rdata0[3], rdata1[3], rdata2[3], rdata3[3], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata02(rdata[2], rdata0[2], rdata1[2], rdata2[2], rdata3[2], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata01(rdata[1], rdata0[1], rdata1[1], rdata2[1], rdata3[1], Answer[1], Answer[0]);
   	mux4_to_1 o_rdata00(rdata[0], rdata0[0], rdata1[0], rdata2[0], rdata3[0], Answer[1], Answer[0]);
   	
   	//writes result from mux to reg
   	
   	always @(posedge clk)
   	if (reset==1'b0)
   	    begin
   	        result_ack <= 1'b0;
   	        result_rdata <= 32'b00000000000000000000000000000000;
   	    end
   	else    
   	    begin
   	        result_ack <= ack;
   	        result_rdata <= rdata;
   	    end
   
   endmodule