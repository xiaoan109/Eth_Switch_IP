`timescale 1ns / 1ps

//CROSSBAR test bench

module Crossbar_TB;

	// Inputs
	reg m_req1;
	reg [31:0] m_addr1;
	reg [31:0] m_wdata1;
	reg m_cmd1;
	reg m_req2;
	reg [31:0] m_addr2;
	reg [31:0] m_wdata2;
	reg m_cmd2;
	reg s_ack1;
	reg [31:0] s_rdata1;
	reg s_ack2;
	reg [31:0] s_rdata2;
	reg clk;
	reg reset;

	// Outputs
	wire s_req1;
	wire [31:0] s_addr1;
	wire [31:0] s_wdata1;
	wire s_cmd1;
	wire s_req2;
	wire [31:0] s_addr2;
	wire [31:0] s_wdata2;
	wire s_cmd2;
	wire m_ack1;
	wire [31:0] m_rdata1;
	wire m_ack2;
	wire [31:0] m_rdata2;

	// Instantiate the Unit Under Test (UUT)
	Crossbar uut (
		.m_req1(m_req1), 
		.m_addr1(m_addr1), 
		.m_wdata1(m_wdata1), 
		.m_cmd1(m_cmd1), 
		.m_req2(m_req2), 
		.m_addr2(m_addr2), 
		.m_wdata2(m_wdata2), 
		.m_cmd2(m_cmd2), 
		.s_ack1(s_ack1), 
		.s_rdata1(s_rdata1), 
		.s_ack2(s_ack2), 
		.s_rdata2(s_rdata2), 
		.clk(clk), 
		.reset(reset), 
		.s_req1(s_req1), 
		.s_addr1(s_addr1), 
		.s_wdata1(s_wdata1), 
		.s_cmd1(s_cmd1), 
		.s_req2(s_req2), 
		.s_addr2(s_addr2), 
		.s_wdata2(s_wdata2), 
		.s_cmd2(s_cmd2), 
		.m_ack1(m_ack1), 
		.m_rdata1(m_rdata1), 
		.m_ack2(m_ack2), 
		.m_rdata2(m_rdata2)
	);

//initialize input register
//    master_1: req = 0;
//              wdata = 1111;
// (master_1 -> slave_1) addr = 32'b1000_1000_1000_1000_1000_1000_1000_1000;

//    master_2: req = 0;
//              wdata = 2222;
// (master_2 -> slave_1) addr = 32'b1001_1001_1001_1001_1001_1001_1001_1001;

//    slave_1: ack = 0;
//             rdata = 1000;

//    slave_2: ack = 0;
//             rdata = 2000;

// reset -> 1;

	initial begin
		m_req1 = 0;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_wdata1 = 1111;
		m_cmd1 = 0;
		m_req2 = 0;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		m_wdata2 = 2222;
		m_cmd2 = 0;
		s_ack1 = 0;
		s_rdata1 = 1000;
		s_ack2 = 0;
		s_rdata2 = 2000;
		clk = 0;
		reset = 1;

// wait 100 tics and reset -> 0

		#100;
		reset = 0;
		
// wait 20 tics
//    master_1: req = 0;
//    master_2: req = 0;
		#20;
		m_req1 = 0;
		m_req2 = 0;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		
// wait 20 tics
//    master_1: req = 0;
//    master_2: req = 1;
// address  (master_2 -> slave_1)	
		#20;
		m_req1 = 0;
		m_req2 = 1;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		
// wait 20 tics
//    master_1: req = 0;
//    master_2: req = 1;
// address  (master_2 -> slave_2)	
		#20;
		m_req1 = 0;
		m_req2 = 1;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b0001_1001_1001_1001_1001_1001_1001_1001;	

// wait 20 tics
//    master_1: req = 1;
// address  (master_1 -> slave_1)
//    master_2: req = 0;
		#20;
		m_req1 = 1;
		m_req2 = 0;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		
// wait 20 tics
//    master_1: req = 1;
// address  (master_1 -> slave_1)
//    master_2: req = 1;
// address  (master_2 -> slave_1)	
		#20;
		m_req1 = 1;
		m_req2 = 1;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		
// wait 20 tics
//    master_1: req = 1;
// address  (master_1 -> slave_1)
//    master_2: req = 1;
// address  (master_2 -> slave_2)	
		#20;
		m_req1 = 1;
		m_req2 = 1;
		m_addr1 = 32'b1000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b0001_1001_1001_1001_1001_1001_1001_1001;	

// wait 20 tics
//    master_1: req = 1;
// address  (master_1 -> slave_2)
//    master_2: req = 0;
		#20;
		m_req1 = 1;
		m_req2 = 0;
		m_addr1 = 32'b0000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		
// wait 20 tics
//    master_1: req = 1;
// address  (master_1 -> slave_2)
//    master_2: req = 1;
// address  (master_2 -> slave_1)	
		#20;
		m_req1 = 1;
		m_req2 = 1;
		m_addr1 = 32'b0000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b1001_1001_1001_1001_1001_1001_1001_1001;
		
// wait 20 tics
//    master_1: req = 1;
// address  (master_1 -> slave_2)
//    master_2: req = 1;
// address  (master_2 -> slave_2)	
		#20;
		m_req1 = 1;
		m_req2 = 1;
		m_addr1 = 32'b0000_1000_1000_1000_1000_1000_1000_1000;
		m_addr2 = 32'b0001_1001_1001_1001_1001_1001_1001_1001;		

//wait 20 tics and finish
		#20 $finish;
	end
	initial forever 
	#1 clk =~clk;
	always @(posedge clk)
	$display("time=%d,reset=%d,m_req1=%d,m_req2=%d,m_addr1=%d,m_addr2=%d,m_wdata1=%d,m_wdata2=%d,s_req1=%d,s_req2=%d,s_addr1=%d,s_addr2=%d,s_wdata1=%d,s_wdata2=%d,s_rdata1=%d,s_rdata2=%d,m_rdata1=%d,m_rdata2=%d,",
	$time,reset,m_req1,m_req2,m_addr1,m_addr2,m_wdata1,m_wdata2,s_req1,s_req2,s_addr1,s_addr2,s_wdata1,s_wdata2,s_rdata1,s_rdata2,m_rdata1,m_rdata2);      
endmodule

