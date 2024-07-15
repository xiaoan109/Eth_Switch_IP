module WrrArbiter (
	iClk,
	iRst_n,
	iReq,
	oGnt,
	iData,
	oReq,
	iGnt,
	oData,
	iWeight,
	iWeightLoad
);
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:25:13
	parameter DW = 8;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:26:13
	parameter ARB_NUM = 8;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:27:13
	parameter WEIGHT_NUM = 8;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:29:3
	input wire iClk;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:30:3
	input wire iRst_n;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:32:3
	input wire [ARB_NUM - 1:0] iReq;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:33:3
	output wire [ARB_NUM - 1:0] oGnt;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:34:3
	input wire [(ARB_NUM * DW) - 1:0] iData;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:36:3
	output wire oReq;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:37:3
	input wire iGnt;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:38:3
	output wire [DW - 1:0] oData;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:40:3
	input wire [($clog2(WEIGHT_NUM) >= 0 ? (ARB_NUM * ($clog2(WEIGHT_NUM) + 1)) - 1 : (ARB_NUM * (1 - $clog2(WEIGHT_NUM))) + ($clog2(WEIGHT_NUM) - 1)):($clog2(WEIGHT_NUM) >= 0 ? 0 : $clog2(WEIGHT_NUM) + 0)] iWeight;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:41:3
	input wire iWeightLoad;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:43:3
	wire [ARB_NUM - 1:0] gatedReq;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:44:3
	wire [ARB_NUM - 1:0] gatedGnt;
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:46:3
	WrrWeightGate #(
		.ARB_NUM(ARB_NUM),
		.WEIGHT_NUM(WEIGHT_NUM)
	) U_WrrWeightGate(
		.iRst_n(iRst_n),
		.iClk(iClk),
		.iReq(iReq),
		.oGnt(oGnt),
		.oReq(gatedReq),
		.iGnt(gatedGnt),
		.iWeightLoad(iWeightLoad),
		.iWeight(iWeight)
	);
	// Trace: src/src/rtl/design/svsrc/WrrArbiter.sv:60:3
	rr_arb_tree #(
		.NumIn(ARB_NUM),
		.DataWidth(DW),
		.AxiVldRdy(1),
		.LockIn(0)
	) U_RR_ARB(
		.rst_ni(iRst_n),
		.clk_i(iClk),
		.req_i(gatedReq),
		.gnt_o(gatedGnt),
		.data_i(iData),
		.req_o(oReq),
		.gnt_i(iGnt),
		.data_o(oData)
	);
endmodule
