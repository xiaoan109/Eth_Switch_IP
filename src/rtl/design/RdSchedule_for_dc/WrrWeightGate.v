module WrrWeightGate (
	iClk,
	iRst_n,
	iReq,
	oGnt,
	oReq,
	iGnt,
	iWeight,
	iWeightLoad
);
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:2:13
	parameter WEIGHT_NUM = 8;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:3:13
	parameter ARB_NUM = 8;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:5:3
	input wire iClk;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:6:3
	input wire iRst_n;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:8:3
	input wire [ARB_NUM - 1:0] iReq;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:9:3
	output wire [ARB_NUM - 1:0] oGnt;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:11:3
	output wire [ARB_NUM - 1:0] oReq;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:12:3
	input wire [ARB_NUM - 1:0] iGnt;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:14:3
	input wire [($clog2(WEIGHT_NUM) >= 0 ? (ARB_NUM * ($clog2(WEIGHT_NUM) + 1)) - 1 : (ARB_NUM * (1 - $clog2(WEIGHT_NUM))) + ($clog2(WEIGHT_NUM) - 1)):($clog2(WEIGHT_NUM) >= 0 ? 0 : $clog2(WEIGHT_NUM) + 0)] iWeight;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:15:3
	input wire iWeightLoad;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:18:3
	reg [$clog2(WEIGHT_NUM):0] initWeight [0:ARB_NUM - 1];
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:19:3
	reg [$clog2(WEIGHT_NUM):0] currWeight [0:ARB_NUM - 1];
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:21:3
	wire [ARB_NUM - 1:0] gntMask;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:22:3
	wire weightRefesh;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:24:3
	genvar _gv_i_12;
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:26:3
	generate
		for (_gv_i_12 = 0; _gv_i_12 < ARB_NUM; _gv_i_12 = _gv_i_12 + 1) begin : GEN_GATE
			localparam i = _gv_i_12;
			// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:28:7
			always @(posedge iClk or negedge iRst_n)
				// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:29:9
				if (!iRst_n)
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:30:11
					initWeight[i] <= {$clog2(WEIGHT_NUM) + 1 {1'b1}};
				else if (iWeightLoad)
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:32:11
					initWeight[i] <= iWeight[($clog2(WEIGHT_NUM) >= 0 ? 0 : $clog2(WEIGHT_NUM)) + (((ARB_NUM - 1) - i) * ($clog2(WEIGHT_NUM) >= 0 ? $clog2(WEIGHT_NUM) + 1 : 1 - $clog2(WEIGHT_NUM)))+:($clog2(WEIGHT_NUM) >= 0 ? $clog2(WEIGHT_NUM) + 1 : 1 - $clog2(WEIGHT_NUM))];
				else
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:34:11
					initWeight[i] <= initWeight[i];
			// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:38:7
			always @(posedge iClk or negedge iRst_n)
				// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:39:9
				if (!iRst_n)
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:40:11
					currWeight[i] <= {$clog2(WEIGHT_NUM) + 1 {1'b1}};
				else if (iWeightLoad)
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:42:11
					currWeight[i] <= iWeight[($clog2(WEIGHT_NUM) >= 0 ? 0 : $clog2(WEIGHT_NUM)) + (((ARB_NUM - 1) - i) * ($clog2(WEIGHT_NUM) >= 0 ? $clog2(WEIGHT_NUM) + 1 : 1 - $clog2(WEIGHT_NUM)))+:($clog2(WEIGHT_NUM) >= 0 ? $clog2(WEIGHT_NUM) + 1 : 1 - $clog2(WEIGHT_NUM))];
				else if (weightRefesh)
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:44:11
					currWeight[i] <= initWeight[i];
				else if (iReq[i] && oGnt[i])
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:46:11
					currWeight[i] <= currWeight[i] - 'b1;
				else
					// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:48:11
					currWeight[i] <= currWeight[i];
			// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:52:7
			assign gntMask[i] = |currWeight[i];
			// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:54:7
			assign oReq[i] = iReq[i] & gntMask[i];
			// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:55:7
			assign oGnt[i] = iGnt[i] & gntMask[i];
		end
	endgenerate
	// Trace: src/src/rtl/design/svsrc/WrrWeightGate.sv:60:3
	assign weightRefesh = !(|gntMask);
endmodule
