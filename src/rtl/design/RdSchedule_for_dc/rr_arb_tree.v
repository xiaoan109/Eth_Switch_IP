module rr_arb_tree (
	clk_i,
	rst_ni,
	flush_i,
	rr_i,
	req_i,
	gnt_o,
	data_i,
	req_o,
	gnt_i,
	data_o,
	idx_o
);
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:49:13
	parameter [31:0] NumIn = 64;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:51:13
	parameter [31:0] DataWidth = 32;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:53:26
	// removed localparam type DataType
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:60:13
	parameter [0:0] ExtPrio = 1'b0;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:67:13
	parameter [0:0] AxiVldRdy = 1'b0;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:74:13
	parameter [0:0] LockIn = 1'b0;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:78:13
	parameter [0:0] FairArb = 1'b1;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:81:13
	parameter [31:0] IdxWidth = (NumIn > 32'd1 ? $unsigned($clog2(NumIn)) : 32'd1);
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:84:26
	// removed localparam type idx_t
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:87:3
	input wire clk_i;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:89:3
	input wire rst_ni;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:91:3
	input wire flush_i;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:93:3
	input wire [IdxWidth - 1:0] rr_i;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:95:3
	input wire [NumIn - 1:0] req_i;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:98:3
	output wire [NumIn - 1:0] gnt_o;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:101:3
	input wire [(NumIn * DataWidth) - 1:0] data_i;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:103:3
	output wire req_o;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:105:3
	input wire gnt_i;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:107:3
	output wire [DataWidth - 1:0] data_o;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:109:3
	output wire [IdxWidth - 1:0] idx_o;
	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:122:3
	function automatic [IdxWidth - 1:0] sv2v_cast_5FDFE;
		input reg [IdxWidth - 1:0] inp;
		sv2v_cast_5FDFE = inp;
	endfunction
	function automatic [DataWidth - 1:0] sv2v_cast_8536A;
		input reg [DataWidth - 1:0] inp;
		sv2v_cast_8536A = inp;
	endfunction
	generate
		if (NumIn == $unsigned(1)) begin : gen_pass_through
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:123:5
			assign req_o = req_i[0];
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:124:5
			assign gnt_o[0] = gnt_i;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:125:5
			assign data_o = data_i[0+:DataWidth];
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:126:5
			assign idx_o = 1'sb0;
		end
		else begin : gen_arbiter
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:129:5
			localparam [31:0] NumLevels = $unsigned($clog2(NumIn));
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:132:5
			wire [(((2 ** NumLevels) - 2) >= 0 ? (((2 ** NumLevels) - 1) * IdxWidth) - 1 : ((3 - (2 ** NumLevels)) * IdxWidth) + ((((2 ** NumLevels) - 2) * IdxWidth) - 1)):(((2 ** NumLevels) - 2) >= 0 ? 0 : ((2 ** NumLevels) - 2) * IdxWidth)] index_nodes;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:133:5
			wire [(((2 ** NumLevels) - 2) >= 0 ? (((2 ** NumLevels) - 1) * DataWidth) - 1 : ((3 - (2 ** NumLevels)) * DataWidth) + ((((2 ** NumLevels) - 2) * DataWidth) - 1)):(((2 ** NumLevels) - 2) >= 0 ? 0 : ((2 ** NumLevels) - 2) * DataWidth)] data_nodes;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:134:5
			wire [(2 ** NumLevels) - 2:0] gnt_nodes;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:135:5
			wire [(2 ** NumLevels) - 2:0] req_nodes;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:137:5
			reg [IdxWidth - 1:0] rr_q;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:138:5
			wire [NumIn - 1:0] req_d;
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:141:5
			assign req_o = req_nodes[0];
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:142:5
			assign data_o = data_nodes[(((2 ** NumLevels) - 2) >= 0 ? 0 : (2 ** NumLevels) - 2) * DataWidth+:DataWidth];
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:143:5
			assign idx_o = index_nodes[(((2 ** NumLevels) - 2) >= 0 ? 0 : (2 ** NumLevels) - 2) * IdxWidth+:IdxWidth];
			if (ExtPrio) begin : gen_ext_rr
				// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:146:7
				wire [IdxWidth:1] sv2v_tmp_0900B;
				assign sv2v_tmp_0900B = rr_i;
				always @(*) rr_q = sv2v_tmp_0900B;
				// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:147:7
				assign req_d = req_i;
			end
			else begin : gen_int_rr
				// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:149:7
				wire [IdxWidth - 1:0] rr_d;
				if (LockIn) begin : gen_lock
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:153:9
					wire lock_d;
					reg lock_q;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:154:9
					reg [NumIn - 1:0] req_q;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:156:9
					assign lock_d = req_o & ~gnt_i;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:157:9
					assign req_d = (lock_q ? req_q : req_i);
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:159:9
					always @(posedge clk_i or negedge rst_ni) begin : p_lock_reg
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:160:11
						if (!rst_ni)
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:161:13
							lock_q <= 1'sb0;
						else
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:163:13
							if (flush_i)
								// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:164:15
								lock_q <= 1'sb0;
							else
								// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:166:15
								lock_q <= lock_d;
					end
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:173:11
					// removed an assertion item
					// lock : assert property (@(posedge clk_i) 
					// 	(LockIn |-> (req_o && (!gnt_i && !flush_i) |=> idx_o == $past(idx_o)))
					// ) else begin
					// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:176:17
					// 	$fatal(1, "Lock implies same arbiter decision in next cycle if output is not                             ready.");
					// end
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:179:11
					wire [NumIn - 1:0] req_tmp;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:180:11
					assign req_tmp = req_q & req_i;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:181:11
					// removed an assertion item
					// lock_req : assume property (@(posedge clk_i) 
					// 	(LockIn |-> (lock_d |=> req_tmp == req_q))
					// ) else begin
					// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:183:17
					// 	$fatal(1, "It is disallowed to deassert unserved request signals when LockIn is                             enabled.");
					// end
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:188:9
					always @(posedge clk_i or negedge rst_ni) begin : p_req_regs
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:189:11
						if (!rst_ni)
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:190:13
							req_q <= 1'sb0;
						else
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:192:13
							if (flush_i)
								// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:193:15
								req_q <= 1'sb0;
							else
								// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:195:15
								req_q <= req_d;
					end
				end
				else begin : gen_no_lock
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:200:9
					assign req_d = req_i;
				end
				if (FairArb) begin : gen_fair_arb
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:204:9
					wire [NumIn - 1:0] upper_mask;
					wire [NumIn - 1:0] lower_mask;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:205:9
					wire [IdxWidth - 1:0] upper_idx;
					wire [IdxWidth - 1:0] lower_idx;
					wire [IdxWidth - 1:0] next_idx;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:206:9
					wire upper_empty;
					wire lower_empty;
					genvar _gv_i_10;
					for (_gv_i_10 = 0; _gv_i_10 < NumIn; _gv_i_10 = _gv_i_10 + 1) begin : gen_mask
						localparam i = _gv_i_10;
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:209:11
						assign upper_mask[i] = (i > rr_q ? req_d[i] : 1'b0);
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:210:11
						assign lower_mask[i] = (i <= rr_q ? req_d[i] : 1'b0);
					end
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:213:9
					lzc #(
						.WIDTH(NumIn),
						.MODE(1'b0)
					) i_lzc_upper(
						.in_i(upper_mask),
						.cnt_o(upper_idx),
						.empty_o(upper_empty)
					);
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:222:9
					lzc #(
						.WIDTH(NumIn),
						.MODE(1'b0)
					) i_lzc_lower(
						.in_i(lower_mask),
						.cnt_o(lower_idx),
						.empty_o()
					);
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:231:9
					assign next_idx = (upper_empty ? lower_idx : upper_idx);
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:232:9
					assign rr_d = (gnt_i && req_o ? next_idx : rr_q);
				end
				else begin : gen_unfair_arb
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:235:9
					assign rr_d = (gnt_i && req_o ? (rr_q == sv2v_cast_5FDFE(NumIn - 1) ? {IdxWidth {1'sb0}} : rr_q + 1'b1) : rr_q);
				end
				// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:239:7
				always @(posedge clk_i or negedge rst_ni) begin : p_rr_regs
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:240:9
					if (!rst_ni)
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:241:11
						rr_q <= 1'sb0;
					else
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:243:11
						if (flush_i)
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:244:13
							rr_q <= 1'sb0;
						else
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:246:13
							rr_q <= rr_d;
				end
			end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:252:5
			assign gnt_nodes[0] = gnt_i;
			genvar _gv_level_2;
			for (_gv_level_2 = 0; $unsigned(_gv_level_2) < NumLevels; _gv_level_2 = _gv_level_2 + 1) begin : gen_levels
				localparam level = _gv_level_2;
				genvar _gv_l_2;
				for (_gv_l_2 = 0; _gv_l_2 < (2 ** level); _gv_l_2 = _gv_l_2 + 1) begin : gen_level
					localparam l = _gv_l_2;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:258:9
					wire sel;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:260:9
					localparam [31:0] Idx0 = ((2 ** level) - 1) + l;
					// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:261:9
					localparam [31:0] Idx1 = ((2 ** (level + 1)) - 1) + (l * 2);
					if ($unsigned(level) == (NumLevels - 1)) begin : gen_first_level
						if (($unsigned(l) * 2) < (NumIn - 1)) begin : gen_reduce
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:267:13
							assign req_nodes[Idx0] = req_d[l * 2] | req_d[(l * 2) + 1];
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:270:13
							assign sel = ~req_d[l * 2] | (req_d[(l * 2) + 1] & rr_q[(NumLevels - 1) - level]);
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:272:13
							assign index_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * IdxWidth+:IdxWidth] = sv2v_cast_5FDFE(sel);
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:273:13
							assign data_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * DataWidth+:DataWidth] = (sel ? data_i[((l * 2) + 1) * DataWidth+:DataWidth] : data_i[(l * 2) * DataWidth+:DataWidth]);
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:274:13
							assign gnt_o[l * 2] = (gnt_nodes[Idx0] & (AxiVldRdy | req_d[l * 2])) & ~sel;
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:275:13
							assign gnt_o[(l * 2) + 1] = (gnt_nodes[Idx0] & (AxiVldRdy | req_d[(l * 2) + 1])) & sel;
						end
						if (($unsigned(l) * 2) == (NumIn - 1)) begin : gen_first
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:279:13
							assign req_nodes[Idx0] = req_d[l * 2];
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:280:13
							assign index_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * IdxWidth+:IdxWidth] = 1'sb0;
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:281:13
							assign data_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * DataWidth+:DataWidth] = data_i[(l * 2) * DataWidth+:DataWidth];
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:282:13
							assign gnt_o[l * 2] = gnt_nodes[Idx0] & (AxiVldRdy | req_d[l * 2]);
						end
						if (($unsigned(l) * 2) > (NumIn - 1)) begin : gen_out_of_range
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:286:13
							assign req_nodes[Idx0] = 1'b0;
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:287:13
							assign index_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * IdxWidth+:IdxWidth] = sv2v_cast_5FDFE(1'sb0);
							// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:288:13
							assign data_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * DataWidth+:DataWidth] = sv2v_cast_8536A(1'sb0);
						end
					end
					else begin : gen_other_levels
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:293:11
						assign req_nodes[Idx0] = req_nodes[Idx1] | req_nodes[Idx1 + 1];
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:296:11
						assign sel = ~req_nodes[Idx1] | (req_nodes[Idx1 + 1] & rr_q[(NumLevels - 1) - level]);
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:298:11
						assign index_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * IdxWidth+:IdxWidth] = (sel ? sv2v_cast_5FDFE({1'b1, index_nodes[((((2 ** NumLevels) - 2) >= 0 ? Idx1 + 1 : ((2 ** NumLevels) - 2) - (Idx1 + 1)) * IdxWidth) + (((NumLevels - $unsigned(level)) - 2) >= 0 ? (NumLevels - $unsigned(level)) - 2 : (((NumLevels - $unsigned(level)) - 2) + (((NumLevels - $unsigned(level)) - 2) >= 0 ? (NumLevels - $unsigned(level)) - 1 : 3 - (NumLevels - $unsigned(level)))) - 1)-:(((NumLevels - $unsigned(level)) - 2) >= 0 ? (NumLevels - $unsigned(level)) - 1 : 3 - (NumLevels - $unsigned(level)))]}) : sv2v_cast_5FDFE({1'b0, index_nodes[((((2 ** NumLevels) - 2) >= 0 ? Idx1 : ((2 ** NumLevels) - 2) - Idx1) * IdxWidth) + (((NumLevels - $unsigned(level)) - 2) >= 0 ? (NumLevels - $unsigned(level)) - 2 : (((NumLevels - $unsigned(level)) - 2) + (((NumLevels - $unsigned(level)) - 2) >= 0 ? (NumLevels - $unsigned(level)) - 1 : 3 - (NumLevels - $unsigned(level)))) - 1)-:(((NumLevels - $unsigned(level)) - 2) >= 0 ? (NumLevels - $unsigned(level)) - 1 : 3 - (NumLevels - $unsigned(level)))]}));
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:302:11
						assign data_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx0 : ((2 ** NumLevels) - 2) - Idx0) * DataWidth+:DataWidth] = (sel ? data_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx1 + 1 : ((2 ** NumLevels) - 2) - (Idx1 + 1)) * DataWidth+:DataWidth] : data_nodes[(((2 ** NumLevels) - 2) >= 0 ? Idx1 : ((2 ** NumLevels) - 2) - Idx1) * DataWidth+:DataWidth]);
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:303:11
						assign gnt_nodes[Idx1] = gnt_nodes[Idx0] & ~sel;
						// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:304:11
						assign gnt_nodes[Idx1 + 1] = gnt_nodes[Idx0] & sel;
					end
				end
			end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:313:5
			initial begin : p_assert
				// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:314:7
			end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:320:5
			// removed an assertion item
			// hot_one : assert property (@(posedge clk_i) 
			// 	$onehot0(gnt_o)
			// ) else begin
			// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:322:14
			// 	$fatal(1, "Grant signal must be hot1 or zero.");
			// end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:324:5
			// removed an assertion item
			// gnt0 : assert property (@(posedge clk_i) 
			// 	(|gnt_o |-> gnt_i)
			// ) else begin
			// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:326:14
			// 	$fatal(1, "Grant out implies grant in.");
			// end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:328:5
			// removed an assertion item
			// gnt1 : assert property (@(posedge clk_i) 
			// 	(req_o |-> (gnt_i |-> |gnt_o))
			// ) else begin
			// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:330:14
			// 	$fatal(1, "Req out and grant in implies grant out.");
			// end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:332:5
			// removed an assertion item
			// gnt_idx : assert property (@(posedge clk_i) 
			// 	(req_o |-> (gnt_i |-> gnt_o[idx_o]))
			// ) else begin
			// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:334:14
			// 	$fatal(1, "Idx_o / gnt_o do not match.");
			// end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:336:5
			// removed an assertion item
			// req0 : assert property (@(posedge clk_i) 
			// 	(|req_i |-> req_o)
			// ) else begin
			// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:338:14
			// 	$fatal(1, "Req in implies req out.");
			// end
			// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:340:5
			// removed an assertion item
			// req1 : assert property (@(posedge clk_i) 
			// 	(req_o |-> |req_i)
			// ) else begin
			// 	// Trace: src/src/rtl/design/svsrc/rr_arb_tree.sv:342:14
			// 	$fatal(1, "Req out implies req in.");
			// end
		end
	endgenerate
endmodule
