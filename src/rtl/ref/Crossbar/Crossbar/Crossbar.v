`timescale 1ns / 1ps

// Crossbar module

module Crossbar(m_req1,m_addr1,m_wdata1,m_cmd1,
					 m_req2,m_addr2,m_wdata2,m_cmd2,
					 s_ack1,s_rdata1, s_ack2,s_rdata2,
					 clk,reset,
					 s_req1, s_addr1, s_wdata1,s_cmd1,
					 s_req2, s_addr2, s_wdata2,s_cmd2,
					 m_ack1, m_rdata1, m_ack2, m_rdata2
    );

// input wires declaration
	 
	input wire clk, reset;
	input wire m_req1, m_cmd1, m_req2, m_cmd2, s_ack1, s_ack2;
	input wire [31:0] m_addr1, m_addr2, m_wdata1, m_wdata2,s_rdata1,s_rdata2;

// output wires declaration

   output wire s_req1, s_cmd1, s_req2, s_cmd2, m_ack1, m_ack2;
	output wire [31:0] s_addr1, s_addr2, s_wdata1, s_wdata2,m_rdata1,m_rdata2;

// inherit wires declaration
	
	wire [1:0] ctr1,ctr2,comb_out1,comb_out2;
	wire m_naddr1,m_naddr2;	
	wire [65:0] m_in1,m_in2,m_out_mux1,m_out_mux2;
	wire [32:0] s_in1,s_in2,s_out_mux1,s_out_mux2;
	
// crossbar input wires to muxes input buses assignment	

	assign m_in1 = {m_req1,m_cmd1,m_addr1,m_wdata1};
	assign m_in2 = {m_req2,m_cmd2,m_addr2,m_wdata2};
	assign s_in1 = {s_ack1,s_rdata1};
	assign s_in2 = {s_ack2,s_rdata2};

// second arboter control wires assignment
	
	assign m_naddr1 = ~m_addr1[31];
	assign m_naddr2 = ~m_addr2[31];
	
// instantiations of Arbiter (ARRB), Muxes (MUX_41) 
// and combinational logic blocks (COMB_1 and COMB_2) modules
	
	ARRB arbiter_1(m_req1,m_req2,m_addr1[31],m_addr2[31],clk,reset,ctr1);
	ARRB arbiter_2(m_req1,m_req2,m_naddr1,m_naddr2,clk,reset,ctr2);
	COMB_1 combination1(ctr2,ctr1,comb_out1);
	COMB_2 combination2(ctr2,ctr1,comb_out2);
	MUX_41 #(66) m_mux1(m_in1,m_in2,66'd0,66'd0,m_out_mux1,ctr1);
	MUX_41 #(66) m_mux2(m_in1,m_in2,66'd0,66'd0,m_out_mux2,ctr2);
	MUX_41 #(33) s_mux1(s_in1,s_in2,33'd0,33'd0,s_out_mux1,comb_out1);
	MUX_41 #(33) s_mux2(s_in1,s_in2,33'd0,33'd0,s_out_mux2,comb_out2);
	
// output muxes buses to output crossbar wires assignment
	
	assign s_req1 = {m_out_mux1[65]};
	assign s_cmd1 = {m_out_mux1[64]};
	assign s_addr1 = {m_out_mux1[63:32]};
	assign s_wdata1 = {m_out_mux1[31:0]};
	
	assign s_req2 = {m_out_mux2[65]};
	assign s_cmd2 = {m_out_mux2[64]};
	assign s_addr2 = {m_out_mux2[63:32]};
	assign s_wdata2 = {m_out_mux2[31:0]};
	
	assign m_ack1 = {s_out_mux1[32]};
	assign m_rdata1 = {s_out_mux1[31:0]};
	
	assign m_ack2 = {s_out_mux2[32]};
	assign m_rdata2 = {s_out_mux2[31:0]};


endmodule

// combination logic module which configure control signal 
// for MUX to master_1 [(slave_1 ack and rdata to master_1) 
// or (slave_2 ack and rdata to master_1) 

module COMB_1(ctr2,ctr1,out
    );
	 input wire [1:0] ctr2, ctr1;
	 output [1:0] out;
	 
	 wire y1,y2;
	 
	 assign y1 = ctr1[0] && ~ctr1[1];
	 assign y2 = ~ctr2[1] &&ctr2[0] &&(ctr1[1] || ~ctr1[0]);
	 assign out[0] = {y1};
	 assign out[1] = {y2};
endmodule

// combination logic module which configure control signal 
// for MUX to master_2 [(slave_1 ack and rdata to master_2) 
// or (slave_2 ack and rdata to master_2) 

module COMB_2(ctr2,ctr1,out
    );
	 input wire [1:0] ctr2, ctr1;
	 output [1:0] out;
	 
	 wire y1,y2;
	 
	 assign y1 = ctr1[1] && ~ctr1[0];
	 assign y2 = ~ctr2[0] &&ctr2[1] &&(ctr1[0] || ~ctr1[1]);
	 assign out[0] = {y1};
	 assign out[1] = {y2};
endmodule

// MUX four to one module (parameter define width of input and output buses)

module MUX_41(in1,in2,in3,in4,out,select 
    );
	 parameter N = 44;
	 
	 input [N-1:0] in1, in2, in3, in4;
	 input [1:0] select;
	 output [N-1:0] out;
	 
	 assign out = select[1]?(select[0]?in3:in2):(select[0]?in1:in4);
endmodule

// arrbiter module witch define control signals
// for MUX to slave_1 [(master_1 to slave_1) or (master_2  to slave_1)
// and for MUX to slave_2 [(master_1 to slave_2) or (master_2  to slave_2)
// preforms round-robin arbitration

module ARRB(req1,req2,addr1,addr2,clk,reset,ctr
    );
	 
	 input req1, req2, addr1, addr2,clk,reset;
	 output reg [1:0] ctr;
	 
	 localparam [1:0] _idle = 2'b00, _a = 2'b01, _b = 2'b10, _err = 2'b11;
	 
	 reg [1:0] state, next;
	 wire [3:0] status;
	 assign status= {req1,req2,addr1,addr2};
	 
	 
always@(state or status) begin
	case(state)
		_idle: begin
			casex (status)
				(4'b00??):next = _idle;
				(4'b1?1?):next = _a;
				(4'b01?1):next = _b;
				(4'b1101):next = _b;
				default:next = _err;
			endcase
			end
		_a: begin
			casex (status)
				(4'b00??):next = _idle;
				(4'b1?1?):next = _a;
				(4'b01?1):next = _b;
				(4'b1101):next = _b;
				default:next = _err;
			endcase
			end
		_b: begin
			casex (status)
				(4'b00??):next = _idle;
				(4'b?1?1):next = _b;
				(4'b101?):next = _a;
				(4'b1110):next = _a;
				default:next = _err;
			endcase
			end
		_err: begin
			casex (status)
				(4'b00??):next = _idle;
				(4'b01?1):next = _b;
				(4'b1101):next = _b;
				(4'b101?):next = _a;
				(4'b1110):next = _a;
				default:next = _err;
			endcase
			end
		endcase
	end
	
always @ (posedge clk or posedge reset) begin
		if (reset == 1) state <= _idle;
		else state <= next;
end

always @ (*) begin
	case (state)
		_idle: ctr = 2'b11;
		_a: ctr = 2'b01;
		_b: ctr = 2'b10;
		_err: ctr = 2'b00;
		endcase
	end
endmodule

