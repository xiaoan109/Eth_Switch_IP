module lzc (
	in_i,
	cnt_o,
	empty_o
);
	reg _sv2v_0;
	// Trace: src/src/rtl/design/svsrc/lzc.sv:27:13
	parameter [31:0] WIDTH = 2;
	// Trace: src/src/rtl/design/svsrc/lzc.sv:29:13
	parameter [0:0] MODE = 1'b0;
	// Trace: src/src/rtl/design/svsrc/lzc.sv:33:13
	parameter [31:0] CNT_WIDTH = (WIDTH > 32'd1 ? $unsigned($clog2(WIDTH)) : 32'd1);
	// Trace: src/src/rtl/design/svsrc/lzc.sv:36:3
	input wire [WIDTH - 1:0] in_i;
	// Trace: src/src/rtl/design/svsrc/lzc.sv:38:3
	output wire [CNT_WIDTH - 1:0] cnt_o;
	// Trace: src/src/rtl/design/svsrc/lzc.sv:40:3
	output wire empty_o;
	// Trace: src/src/rtl/design/svsrc/lzc.sv:43:3
	generate
		if (WIDTH == 1) begin : gen_degenerate_lzc
			// Trace: src/src/rtl/design/svsrc/lzc.sv:45:5
			assign cnt_o[0] = !in_i[0];
			// Trace: src/src/rtl/design/svsrc/lzc.sv:46:5
			assign empty_o = !in_i[0];
		end
		else begin : gen_lzc
			// Trace: src/src/rtl/design/svsrc/lzc.sv:50:5
			localparam [31:0] NumLevels = $clog2(WIDTH);
			// Trace: src/src/rtl/design/svsrc/lzc.sv:53:5
			// Trace: src/src/rtl/design/svsrc/lzc.sv:58:5
			wire [(WIDTH * NumLevels) - 1:0] index_lut;
			// Trace: src/src/rtl/design/svsrc/lzc.sv:59:5
			wire [(2 ** NumLevels) - 1:0] sel_nodes;
			// Trace: src/src/rtl/design/svsrc/lzc.sv:60:5
			wire [((2 ** NumLevels) * NumLevels) - 1:0] index_nodes;
			// Trace: src/src/rtl/design/svsrc/lzc.sv:62:5
			reg [WIDTH - 1:0] in_tmp;
			// Trace: src/src/rtl/design/svsrc/lzc.sv:65:5
			always @(*) begin : flip_vector
				if (_sv2v_0)
					;
				// Trace: src/src/rtl/design/svsrc/lzc.sv:66:7
				begin : sv2v_autoblock_1
					// Trace: src/src/rtl/design/svsrc/lzc.sv:66:12
					reg [31:0] i;
					// Trace: src/src/rtl/design/svsrc/lzc.sv:66:12
					for (i = 0; i < WIDTH; i = i + 1)
						begin
							// Trace: src/src/rtl/design/svsrc/lzc.sv:67:9
							in_tmp[i] = (MODE ? in_i[(WIDTH - 1) - i] : in_i[i]);
						end
				end
			end
			genvar _gv_j_2;
				function automatic signed [NumLevels - 1:0] sv2v_cast_677FF_signed;
					input reg signed [NumLevels - 1:0] inp;
					sv2v_cast_677FF_signed = inp;
				endfunction
			for (_gv_j_2 = 0; $unsigned(_gv_j_2) < WIDTH; _gv_j_2 = _gv_j_2 + 1) begin : g_index_lut
				localparam j = _gv_j_2;
				// Trace: src/src/rtl/design/svsrc/lzc.sv:72:7

				assign index_lut[j * NumLevels+:NumLevels] = sv2v_cast_677FF_signed(j);
			end
			genvar _gv_level_1;
			for (_gv_level_1 = 0; $unsigned(_gv_level_1) < NumLevels; _gv_level_1 = _gv_level_1 + 1) begin : g_levels
				localparam level = _gv_level_1;
				if ($unsigned(level) == (NumLevels - 1)) begin : g_last_level
					genvar _gv_k_1;
					for (_gv_k_1 = 0; _gv_k_1 < (2 ** level); _gv_k_1 = _gv_k_1 + 1) begin : g_level
						localparam k = _gv_k_1;
						if (($unsigned(k) * 2) < (WIDTH - 1)) begin : g_reduce
							// Trace: src/src/rtl/design/svsrc/lzc.sv:80:13
							assign sel_nodes[((2 ** level) - 1) + k] = in_tmp[k * 2] | in_tmp[(k * 2) + 1];
							// Trace: src/src/rtl/design/svsrc/lzc.sv:81:13
							assign index_nodes[(((2 ** level) - 1) + k) * NumLevels+:NumLevels] = (in_tmp[k * 2] == 1'b1 ? index_lut[(k * 2) * NumLevels+:NumLevels] : index_lut[((k * 2) + 1) * NumLevels+:NumLevels]);
						end
						if (($unsigned(k) * 2) == (WIDTH - 1)) begin : g_base
							// Trace: src/src/rtl/design/svsrc/lzc.sv:87:13
							assign sel_nodes[((2 ** level) - 1) + k] = in_tmp[k * 2];
							// Trace: src/src/rtl/design/svsrc/lzc.sv:88:13
							assign index_nodes[(((2 ** level) - 1) + k) * NumLevels+:NumLevels] = index_lut[(k * 2) * NumLevels+:NumLevels];
						end
						if (($unsigned(k) * 2) > (WIDTH - 1)) begin : g_out_of_range
							// Trace: src/src/rtl/design/svsrc/lzc.sv:92:13
							assign sel_nodes[((2 ** level) - 1) + k] = 1'b0;
							// Trace: src/src/rtl/design/svsrc/lzc.sv:93:13
							assign index_nodes[(((2 ** level) - 1) + k) * NumLevels+:NumLevels] = 1'sb0;
						end
					end
				end
				else begin : g_not_last_level
					genvar _gv_l_1;
					for (_gv_l_1 = 0; _gv_l_1 < (2 ** level); _gv_l_1 = _gv_l_1 + 1) begin : g_level
						localparam l = _gv_l_1;
						// Trace: src/src/rtl/design/svsrc/lzc.sv:98:11
						assign sel_nodes[((2 ** level) - 1) + l] = sel_nodes[((2 ** (level + 1)) - 1) + (l * 2)] | sel_nodes[(((2 ** (level + 1)) - 1) + (l * 2)) + 1];
						// Trace: src/src/rtl/design/svsrc/lzc.sv:100:11
						assign index_nodes[(((2 ** level) - 1) + l) * NumLevels+:NumLevels] = (sel_nodes[((2 ** (level + 1)) - 1) + (l * 2)] == 1'b1 ? index_nodes[(((2 ** (level + 1)) - 1) + (l * 2)) * NumLevels+:NumLevels] : index_nodes[((((2 ** (level + 1)) - 1) + (l * 2)) + 1) * NumLevels+:NumLevels]);
					end
				end
			end
			// Trace: src/src/rtl/design/svsrc/lzc.sv:107:5
			assign cnt_o = (NumLevels > $unsigned(0) ? index_nodes[0+:NumLevels] : {$clog2(WIDTH) {1'b0}});
			// Trace: src/src/rtl/design/svsrc/lzc.sv:108:5
			assign empty_o = (NumLevels > $unsigned(0) ? ~sel_nodes[0] : ~(|in_i));
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
