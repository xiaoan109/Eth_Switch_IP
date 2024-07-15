module fifo_v3_7703C (
	clk_i,
	rst_ni,
	flush_i,
	testmode_i,
	full_o,
	empty_o,
	usage_o,
	data_i,
	push_i,
	data_o,
	pop_i
);
	reg _sv2v_0;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:14:15
	parameter [0:0] FALL_THROUGH = 1'b0;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:15:15
	parameter [31:0] DATA_WIDTH = 32;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:16:15
	parameter [31:0] DEPTH = 8;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:17:20
	// removed localparam type dtype
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:19:15
	parameter [31:0] ADDR_DEPTH = (DEPTH > 1 ? $clog2(DEPTH) : 1);
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:21:5
	input wire clk_i;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:22:5
	input wire rst_ni;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:23:5
	input wire flush_i;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:24:5
	input wire testmode_i;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:26:5
	output wire full_o;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:27:5
	output wire empty_o;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:28:5
	output wire [ADDR_DEPTH - 1:0] usage_o;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:30:5
	input wire [19:0] data_i;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:31:5
	input wire push_i;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:33:5
	output reg [19:0] data_o;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:34:5
	input wire pop_i;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:38:5
	localparam [31:0] FifoDepth = (DEPTH > 0 ? DEPTH : 1);
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:40:5
	reg gate_clock;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:42:5
	reg [ADDR_DEPTH - 1:0] read_pointer_n;
	reg [ADDR_DEPTH - 1:0] read_pointer_q;
	reg [ADDR_DEPTH - 1:0] write_pointer_n;
	reg [ADDR_DEPTH - 1:0] write_pointer_q;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:45:5
	reg [ADDR_DEPTH:0] status_cnt_n;
	reg [ADDR_DEPTH:0] status_cnt_q;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:47:5
	reg [(FifoDepth * 20) - 1:0] mem_n;
	reg [(FifoDepth * 20) - 1:0] mem_q;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:49:5
	assign usage_o = status_cnt_q[ADDR_DEPTH - 1:0];
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:51:5
	generate
		if (DEPTH == 0) begin : gen_pass_through
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:52:9
			assign empty_o = ~push_i;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:53:9
			assign full_o = ~pop_i;
		end
		else begin : gen_fifo
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:55:9
			assign full_o = status_cnt_q == FifoDepth[ADDR_DEPTH:0];
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:56:9
			assign empty_o = (status_cnt_q == 0) & ~(FALL_THROUGH & push_i);
		end
	endgenerate
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:61:5
	always @(*) begin : read_write_comb
		if (_sv2v_0)
			;
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:63:9
		read_pointer_n = read_pointer_q;
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:64:9
		write_pointer_n = write_pointer_q;
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:65:9
		status_cnt_n = status_cnt_q;
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:66:9
		data_o = (DEPTH == 0 ? data_i : mem_q[read_pointer_q * 20+:20]);
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:67:9
		mem_n = mem_q;
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:68:9
		gate_clock = 1'b1;
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:71:9
		if (push_i && ~full_o) begin
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:73:13
			mem_n[write_pointer_q * 20+:20] = data_i;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:75:13
			gate_clock = 1'b0;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:77:13
			if (write_pointer_q == (FifoDepth[ADDR_DEPTH - 1:0] - 1))
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:78:17
				write_pointer_n = 1'sb0;
			else
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:80:17
				write_pointer_n = write_pointer_q + 1;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:82:13
			status_cnt_n = status_cnt_q + 1;
		end
		if (pop_i && ~empty_o) begin
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:88:13
			if (read_pointer_n == (FifoDepth[ADDR_DEPTH - 1:0] - 1))
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:89:17
				read_pointer_n = 1'sb0;
			else
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:91:17
				read_pointer_n = read_pointer_q + 1;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:93:13
			status_cnt_n = status_cnt_q - 1;
		end
		if (((push_i && pop_i) && ~full_o) && ~empty_o)
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:98:13
			status_cnt_n = status_cnt_q;
		if ((FALL_THROUGH && (status_cnt_q == 0)) && push_i) begin
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:102:13
			data_o = data_i;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:103:13
			if (pop_i) begin
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:104:17
				status_cnt_n = status_cnt_q;
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:105:17
				read_pointer_n = read_pointer_q;
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:106:17
				write_pointer_n = write_pointer_q;
			end
		end
	end
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:112:5
	always @(posedge clk_i or negedge rst_ni)
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:113:9
		if (~rst_ni) begin
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:114:13
			read_pointer_q <= 1'sb0;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:115:13
			write_pointer_q <= 1'sb0;
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:116:13
			status_cnt_q <= 1'sb0;
		end
		else
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:118:13
			if (flush_i) begin
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:119:17
				read_pointer_q <= 1'sb0;
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:120:17
				write_pointer_q <= 1'sb0;
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:121:17
				status_cnt_q <= 1'sb0;
			end
			else begin
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:123:17
				read_pointer_q <= read_pointer_n;
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:124:17
				write_pointer_q <= write_pointer_n;
				// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:125:17
				status_cnt_q <= status_cnt_n;
			end
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:130:5
	always @(posedge clk_i or negedge rst_ni)
		// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:131:9
		if (~rst_ni)
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:132:13
			mem_q <= 1'sb0;
		else if (!gate_clock)
			// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:134:13
			mem_q <= mem_n;
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:140:5
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:144:5
	// removed an assertion item
	// full_write : assert property (@(posedge clk_i) disable iff (~rst_ni)
	// 	(full_o |-> ~push_i)
	// ) else begin
	// 	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:146:14
	// 	$fatal(1, "Trying to push new data although the FIFO is full.");
	// end
	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:148:5
	// removed an assertion item
	// empty_read : assert property (@(posedge clk_i) disable iff (~rst_ni)
	// 	(empty_o |-> ~pop_i)
	// ) else begin
	// 	// Trace: src/src/rtl/design/svsrc/fifo_v3.sv:150:14
	// 	$fatal(1, "Trying to pop data although the FIFO is empty.");
	// end
	initial _sv2v_0 = 0;
endmodule
