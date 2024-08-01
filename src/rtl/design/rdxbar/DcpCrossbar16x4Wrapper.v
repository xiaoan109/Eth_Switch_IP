module DcpCrossbar16x4Wrapper (
	iClk,
	iRst_n,
	iFifoCrcMsg0,
	iFifoCrcVld0,
	oFifoCrcRdy0,
	iFifoCrcMsg1,
	iFifoCrcVld1,
	oFifoCrcRdy1,
	iFifoCrcMsg2,
	iFifoCrcVld2,
	oFifoCrcRdy2,
	iFifoCrcMsg3,
	iFifoCrcVld3,
	oFifoCrcRdy3,
	iFifoCrcMsg4,
	iFifoCrcVld4,
	oFifoCrcRdy4,
	iFifoCrcMsg5,
	iFifoCrcVld5,
	oFifoCrcRdy5,
	iFifoCrcMsg6,
	iFifoCrcVld6,
	oFifoCrcRdy6,
	iFifoCrcMsg7,
	iFifoCrcVld7,
	oFifoCrcRdy7,
	iFifoCrcMsg8,
	iFifoCrcVld8,
	oFifoCrcRdy8,
	iFifoCrcMsg9,
	iFifoCrcVld9,
	oFifoCrcRdy9,
	iFifoCrcMsg10,
	iFifoCrcVld10,
	oFifoCrcRdy10,
	iFifoCrcMsg11,
	iFifoCrcVld11,
	oFifoCrcRdy11,
	iFifoCrcMsg12,
	iFifoCrcVld12,
	oFifoCrcRdy12,
	iFifoCrcMsg13,
	iFifoCrcVld13,
	oFifoCrcRdy13,
	iFifoCrcMsg14,
	iFifoCrcVld14,
	oFifoCrcRdy14,
	iFifoCrcMsg15,
	iFifoCrcVld15,
	oFifoCrcRdy15,
	oInterMsg0,
	oInterVld0,
	iInterRdy0,
	oInterMsg1,
	oInterVld1,
	iInterRdy1,
	oInterMsg2,
	oInterVld2,
	iInterRdy2,
	oInterMsg3,
	oInterVld3,
	iInterRdy3
);
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:25:3
	input wire iClk;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:26:3
	input wire iRst_n;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:28:3
	input wire [33:0] iFifoCrcMsg0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:29:3
	input wire iFifoCrcVld0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:30:3
	output wire oFifoCrcRdy0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:32:3
	input wire [33:0] iFifoCrcMsg1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:33:3
	input wire iFifoCrcVld1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:34:3
	output wire oFifoCrcRdy1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:36:3
	input wire [33:0] iFifoCrcMsg2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:37:3
	input wire iFifoCrcVld2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:38:3
	output wire oFifoCrcRdy2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:40:3
	input wire [33:0] iFifoCrcMsg3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:41:3
	input wire iFifoCrcVld3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:42:3
	output wire oFifoCrcRdy3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:44:3
	input wire [33:0] iFifoCrcMsg4;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:45:3
	input wire iFifoCrcVld4;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:46:3
	output wire oFifoCrcRdy4;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:48:3
	input wire [33:0] iFifoCrcMsg5;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:49:3
	input wire iFifoCrcVld5;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:50:3
	output wire oFifoCrcRdy5;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:52:3
	input wire [33:0] iFifoCrcMsg6;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:53:3
	input wire iFifoCrcVld6;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:54:3
	output wire oFifoCrcRdy6;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:56:3
	input wire [33:0] iFifoCrcMsg7;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:57:3
	input wire iFifoCrcVld7;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:58:3
	output wire oFifoCrcRdy7;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:60:3
	input wire [33:0] iFifoCrcMsg8;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:61:3
	input wire iFifoCrcVld8;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:62:3
	output wire oFifoCrcRdy8;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:64:3
	input wire [33:0] iFifoCrcMsg9;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:65:3
	input wire iFifoCrcVld9;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:66:3
	output wire oFifoCrcRdy9;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:68:3
	input wire [33:0] iFifoCrcMsg10;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:69:3
	input wire iFifoCrcVld10;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:70:3
	output wire oFifoCrcRdy10;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:72:3
	input wire [33:0] iFifoCrcMsg11;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:73:3
	input wire iFifoCrcVld11;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:74:3
	output wire oFifoCrcRdy11;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:76:3
	input wire [33:0] iFifoCrcMsg12;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:77:3
	input wire iFifoCrcVld12;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:78:3
	output wire oFifoCrcRdy12;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:80:3
	input wire [33:0] iFifoCrcMsg13;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:81:3
	input wire iFifoCrcVld13;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:82:3
	output wire oFifoCrcRdy13;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:84:3
	input wire [33:0] iFifoCrcMsg14;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:85:3
	input wire iFifoCrcVld14;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:86:3
	output wire oFifoCrcRdy14;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:88:3
	input wire [33:0] iFifoCrcMsg15;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:89:3
	input wire iFifoCrcVld15;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:90:3
	output wire oFifoCrcRdy15;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:92:3
	output wire [33:0] oInterMsg0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:93:3
	output wire oInterVld0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:94:3
	input wire iInterRdy0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:96:3
	output wire [33:0] oInterMsg1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:97:3
	output wire oInterVld1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:98:3
	input wire iInterRdy1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:100:3
	output wire [33:0] oInterMsg2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:101:3
	output wire oInterVld2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:102:3
	input wire iInterRdy2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:104:3
	output wire [33:0] oInterMsg3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:105:3
	output wire oInterVld3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:106:3
	input wire iInterRdy3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:108:3
	localparam CRSBAR_WIDTH = 33;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:110:3
	// expanded interface instance: dcpIn
	localparam _param_A1758_DW = CRSBAR_WIDTH;
	localparam _param_A1758_AW = 4;
	genvar _arr_A1758;
	generate
		for (_arr_A1758 = 0; _arr_A1758 <= 15; _arr_A1758 = _arr_A1758 + 1) begin : dcpIn
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
			localparam DW = _param_A1758_DW;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
			localparam AW = _param_A1758_AW;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
			wire [32:0] Pld;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
			wire [3:0] Dst;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
			wire Vld;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
			wire Rdy;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
		end
	endgenerate
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:111:3
	// expanded interface instance: dcpOut
	localparam _param_AEAB2_DW = CRSBAR_WIDTH;
	localparam _param_AEAB2_AW = 4;
	genvar _arr_AEAB2;
	generate
		for (_arr_AEAB2 = 0; _arr_AEAB2 <= 3; _arr_AEAB2 = _arr_AEAB2 + 1) begin : dcpOut
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
			localparam DW = _param_AEAB2_DW;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
			localparam AW = _param_AEAB2_AW;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
			wire [32:0] Pld;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
			wire [3:0] Dst;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
			wire Vld;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
			wire Rdy;
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
			// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
		end
	endgenerate
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:113:3
	assign dcpIn[0].Pld[31:0] = iFifoCrcMsg0[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:114:3
	assign dcpIn[0].Pld[32] = iFifoCrcMsg0[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:115:3
	assign dcpIn[0].Vld = iFifoCrcVld0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:116:3
	assign dcpIn[0].Dst = 4'b0000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:117:3
	assign oFifoCrcRdy0 = dcpIn[0].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:119:3
	assign dcpIn[1].Pld[31:0] = iFifoCrcMsg1[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:120:3
	assign dcpIn[1].Pld[32] = iFifoCrcMsg1[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:121:3
	assign dcpIn[1].Vld = iFifoCrcVld1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:122:3
	assign dcpIn[1].Dst = 4'b0000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:123:3
	assign oFifoCrcRdy1 = dcpIn[1].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:125:3
	assign dcpIn[2].Pld[31:0] = iFifoCrcMsg2[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:126:3
	assign dcpIn[2].Pld[32] = iFifoCrcMsg2[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:127:3
	assign dcpIn[2].Vld = iFifoCrcVld2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:128:3
	assign dcpIn[2].Dst = 4'b0000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:129:3
	assign oFifoCrcRdy2 = dcpIn[2].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:131:3
	assign dcpIn[3].Pld[31:0] = iFifoCrcMsg3[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:132:3
	assign dcpIn[3].Pld[32] = iFifoCrcMsg3[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:133:3
	assign dcpIn[3].Vld = iFifoCrcVld3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:134:3
	assign dcpIn[3].Dst = 4'b0000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:135:3
	assign oFifoCrcRdy3 = dcpIn[3].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:137:3
	assign dcpIn[4].Pld[31:0] = iFifoCrcMsg4[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:138:3
	assign dcpIn[4].Pld[32] = iFifoCrcMsg4[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:139:3
	assign dcpIn[4].Vld = iFifoCrcVld4;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:140:3
	assign dcpIn[4].Dst = 4'b0100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:141:3
	assign oFifoCrcRdy4 = dcpIn[4].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:143:3
	assign dcpIn[5].Pld[31:0] = iFifoCrcMsg5[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:144:3
	assign dcpIn[5].Pld[32] = iFifoCrcMsg5[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:145:3
	assign dcpIn[5].Vld = iFifoCrcVld5;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:146:3
	assign dcpIn[5].Dst = 4'b0100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:147:3
	assign oFifoCrcRdy5 = dcpIn[5].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:149:3
	assign dcpIn[6].Pld[31:0] = iFifoCrcMsg6[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:150:3
	assign dcpIn[6].Pld[32] = iFifoCrcMsg6[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:151:3
	assign dcpIn[6].Vld = iFifoCrcVld6;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:152:3
	assign dcpIn[6].Dst = 4'b0100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:153:3
	assign oFifoCrcRdy6 = dcpIn[6].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:155:3
	assign dcpIn[7].Pld[31:0] = iFifoCrcMsg7[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:156:3
	assign dcpIn[7].Pld[32] = iFifoCrcMsg7[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:157:3
	assign dcpIn[7].Vld = iFifoCrcVld7;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:158:3
	assign dcpIn[7].Dst = 4'b0100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:159:3
	assign oFifoCrcRdy7 = dcpIn[7].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:161:3
	assign dcpIn[8].Pld[31:0] = iFifoCrcMsg8[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:162:3
	assign dcpIn[8].Pld[32] = iFifoCrcMsg8[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:163:3
	assign dcpIn[8].Vld = iFifoCrcVld8;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:164:3
	assign dcpIn[8].Dst = 4'b1000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:165:3
	assign oFifoCrcRdy8 = dcpIn[8].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:167:3
	assign dcpIn[9].Pld[31:0] = iFifoCrcMsg9[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:168:3
	assign dcpIn[9].Pld[32] = iFifoCrcMsg9[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:169:3
	assign dcpIn[9].Vld = iFifoCrcVld9;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:170:3
	assign dcpIn[9].Dst = 4'b1000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:171:3
	assign oFifoCrcRdy9 = dcpIn[9].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:173:3
	assign dcpIn[10].Pld[31:0] = iFifoCrcMsg10[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:174:3
	assign dcpIn[10].Pld[32] = iFifoCrcMsg10[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:175:3
	assign dcpIn[10].Vld = iFifoCrcVld10;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:176:3
	assign dcpIn[10].Dst = 4'b1000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:177:3
	assign oFifoCrcRdy10 = dcpIn[10].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:179:3
	assign dcpIn[11].Pld[31:0] = iFifoCrcMsg11[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:180:3
	assign dcpIn[11].Pld[32] = iFifoCrcMsg11[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:181:3
	assign dcpIn[11].Vld = iFifoCrcVld11;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:182:3
	assign dcpIn[11].Dst = 4'b1000;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:183:3
	assign oFifoCrcRdy11 = dcpIn[11].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:185:3
	assign dcpIn[12].Pld[31:0] = iFifoCrcMsg12[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:186:3
	assign dcpIn[12].Pld[32] = iFifoCrcMsg12[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:187:3
	assign dcpIn[12].Vld = iFifoCrcVld12;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:188:3
	assign dcpIn[12].Dst = 4'b1100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:189:3
	assign oFifoCrcRdy12 = dcpIn[12].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:191:3
	assign dcpIn[13].Pld[31:0] = iFifoCrcMsg13[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:192:3
	assign dcpIn[13].Pld[32] = iFifoCrcMsg13[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:193:3
	assign dcpIn[13].Vld = iFifoCrcVld13;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:194:3
	assign dcpIn[13].Dst = 4'b1100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:195:3
	assign oFifoCrcRdy13 = dcpIn[13].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:197:3
	assign dcpIn[14].Pld[31:0] = iFifoCrcMsg14[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:198:3
	assign dcpIn[14].Pld[32] = iFifoCrcMsg14[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:199:3
	assign dcpIn[14].Vld = iFifoCrcVld14;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:200:3
	assign dcpIn[14].Dst = 4'b1100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:201:3
	assign oFifoCrcRdy14 = dcpIn[14].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:203:3
	assign dcpIn[15].Pld[31:0] = iFifoCrcMsg15[33:2];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:204:3
	assign dcpIn[15].Pld[32] = iFifoCrcMsg15[1];
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:205:3
	assign dcpIn[15].Vld = iFifoCrcVld15;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:206:3
	assign dcpIn[15].Dst = 4'b1100;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:207:3
	assign oFifoCrcRdy15 = dcpIn[15].Rdy;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:210:3
	assign oInterMsg0 = dcpOut[0].Pld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:211:3
	assign oInterVld0 = dcpOut[0].Vld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:212:3
	assign dcpOut[0].Rdy = iInterRdy0;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:214:3
	assign oInterMsg1 = dcpOut[1].Pld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:215:3
	assign oInterVld1 = dcpOut[1].Vld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:216:3
	assign dcpOut[1].Rdy = iInterRdy1;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:218:3
	assign oInterMsg2 = dcpOut[2].Pld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:219:3
	assign oInterVld2 = dcpOut[2].Vld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:220:3
	assign dcpOut[2].Rdy = iInterRdy2;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:222:3
	assign oInterMsg3 = dcpOut[3].Pld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:223:3
	assign oInterVld3 = dcpOut[3].Vld;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:224:3
	assign dcpOut[3].Rdy = iInterRdy3;
	// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4Wrapper.sv:226:3
	// expanded module instance: U_DCPCRSBAR_16X4
	localparam _bbase_DFF07_iRdDataIn = 0;
	localparam _bbase_DFF07_oRdDataOut = 0;
	generate
		if (1) begin : U_DCPCRSBAR_16X4
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:4:3
			wire iClk;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:5:3
			wire iRst_n;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:7:3
			localparam _mbase_iRdDataIn = 0;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:8:3
			localparam _mbase_oRdDataOut = 0;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:11:3
			localparam CRSBAR_WIDTH = 33;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:13:3
			// expanded interface instance: switchOut
			localparam _param_CF9F8_DW = CRSBAR_WIDTH;
			localparam _param_CF9F8_AW = 4;
			genvar _arr_CF9F8;
			for (_arr_CF9F8 = 0; _arr_CF9F8 <= 3; _arr_CF9F8 = _arr_CF9F8 + 1) begin : switchOut
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
				localparam DW = _param_CF9F8_DW;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
				localparam AW = _param_CF9F8_AW;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
				wire [32:0] Pld;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
				wire [3:0] Dst;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
				wire Vld;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
				wire Rdy;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
			end
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:15:3
			// expanded interface instance: rdDataIn
			localparam _param_CE6E4_DW = CRSBAR_WIDTH;
			localparam _param_CE6E4_AW = 4;
			genvar _arr_CE6E4;
			for (_arr_CE6E4 = 0; _arr_CE6E4 <= 15; _arr_CE6E4 = _arr_CE6E4 + 1) begin : rdDataIn
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
				localparam DW = _param_CE6E4_DW;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
				localparam AW = _param_CE6E4_AW;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
				wire [32:0] Pld;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
				wire [3:0] Dst;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
				wire Vld;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
				wire Rdy;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
			end
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:16:3
			// expanded interface instance: rdDataOut
			localparam _param_00E5C_DW = CRSBAR_WIDTH;
			localparam _param_00E5C_AW = 4;
			genvar _arr_00E5C;
			for (_arr_00E5C = 0; _arr_00E5C <= 3; _arr_00E5C = _arr_00E5C + 1) begin : rdDataOut
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
				localparam DW = _param_00E5C_DW;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
				localparam AW = _param_00E5C_AW;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
				wire [32:0] Pld;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
				wire [3:0] Dst;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
				wire Vld;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
				wire Rdy;
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
				// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
			end
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:18:3
			genvar _gv_i_1;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:20:3
			for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : GEN_INPUT_SWITCH
				localparam i = _gv_i_1;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:22:7
				// expanded module instance: U_INPUT_SWITCH
				localparam _bbase_66B98_iDcpIn = 4 * _gv_i_1;
				localparam _bbase_66B98_oDcpOut = _gv_i_1;
				localparam _param_66B98_DW = CRSBAR_WIDTH;
				localparam _param_66B98_AW = 4;
				localparam _param_66B98_SNUM = 4;
				if (1) begin : U_INPUT_SWITCH
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:28:13
					localparam DW = _param_66B98_DW;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:29:13
					localparam AW = _param_66B98_AW;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:30:13
					localparam SNUM = _param_66B98_SNUM;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:32:3
					wire iClk;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:33:3
					wire iRst_n;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:35:3
					localparam _mbase_iDcpIn = _bbase_66B98_iDcpIn;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:36:3
					localparam _mbase_oDcpOut = _bbase_66B98_oDcpOut;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:38:3
					wire [3:0] arbInReqArray;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:39:3
					wire [3:0] arbInGntArray;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:40:3
					wire [147:0] arbInPldArray;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:42:3
					wire arbOutReq;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:43:3
					wire arbOutGnt;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:44:3
					wire [36:0] arbOutPld;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:46:3
					genvar _gv_i_5;
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:48:3
					for (_gv_i_5 = 0; _gv_i_5 < SNUM; _gv_i_5 = _gv_i_5 + 1) begin : GEN_INBUF
						localparam i = _gv_i_5;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:50:7
						gnrl_buf #(
							.DW(37),
							.CUT_RDY(1)
						) U_INBUF(
							.clk_i(iClk),
							.rst_n_i(iRst_n),
							.din_i({DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataIn[i + _mbase_iDcpIn].Dst, DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataIn[i + _mbase_iDcpIn].Pld}),
							.din_vld_i(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataIn[i + _mbase_iDcpIn].Vld),
							.din_rdy_o(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataIn[i + _mbase_iDcpIn].Rdy),
							.dout_o(arbInPldArray[i * 37+:37]),
							.dout_vld_o(arbInReqArray[i]),
							.dout_rdy_i(arbInGntArray[i])
						);
					end
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:67:3
					rr_arb_tree #(
						.NumIn(SNUM),
						.DataWidth(37),
						.AxiVldRdy(1),
						.LockIn(0)
					) U_RR_ARB(
						.rst_ni(iRst_n),
						.clk_i(iClk),
						.req_i(arbInReqArray),
						.gnt_o(arbInGntArray),
						.data_i(arbInPldArray),
						.req_o(arbOutReq),
						.gnt_i(arbOutGnt),
						.data_o(arbOutPld)
					);
					// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:86:3
					gnrl_buf #(
						.DW(37),
						.CUT_RDY(1)
					) U_INBUF(
						.clk_i(iClk),
						.rst_n_i(iRst_n),
						.din_i(arbOutPld),
						.din_vld_i(arbOutReq),
						.din_rdy_o(arbOutGnt),
						.dout_o({DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_oDcpOut].Dst, DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_oDcpOut].Pld}),
						.dout_vld_o(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_oDcpOut].Vld),
						.dout_rdy_i(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_oDcpOut].Rdy)
					);
				end
				assign U_INPUT_SWITCH.iClk = iClk;
				assign U_INPUT_SWITCH.iRst_n = iRst_n;
			end
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:35:3
			// expanded module instance: U_CRSBAR
			localparam _bbase_509DC_iDcpIn = 0;
			localparam _bbase_509DC_oDcpOut = 0;
			localparam _param_509DC_DW = CRSBAR_WIDTH;
			localparam _param_509DC_AW = 4;
			localparam _param_509DC_N = 4;
			if (1) begin : U_CRSBAR
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:26:13
				localparam DW = _param_509DC_DW;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:27:13
				localparam AW = _param_509DC_AW;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:28:13
				localparam N = _param_509DC_N;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:30:3
				wire iClk;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:31:3
				wire iRst_n;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:32:3
				localparam _mbase_iDcpIn = 0;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:33:3
				localparam _mbase_oDcpOut = 0;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:35:3
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:41:3
				// expanded interface instance: xbarCon
				localparam _param_7FFE1_DW = DW;
				localparam _param_7FFE1_AW = AW;
				genvar _arr_7FFE1;
				for (_arr_7FFE1 = 0; _arr_7FFE1 <= 15; _arr_7FFE1 = _arr_7FFE1 + 1) begin : xbarCon
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
					localparam DW = _param_7FFE1_DW;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
					localparam AW = _param_7FFE1_AW;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
					wire [32:0] Pld;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
					wire [3:0] Dst;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
					wire Vld;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
					wire Rdy;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
				end
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:42:3
				// expanded interface instance: xbarConT
				localparam _param_46BCA_DW = DW;
				localparam _param_46BCA_AW = AW;
				genvar _arr_46BCA;
				for (_arr_46BCA = 0; _arr_46BCA <= 15; _arr_46BCA = _arr_46BCA + 1) begin : xbarConT
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:33
					localparam DW = _param_46BCA_DW;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:64:52
					localparam AW = _param_46BCA_AW;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:65:3
					wire [32:0] Pld;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:66:3
					wire [3:0] Dst;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:67:3
					wire Vld;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:68:3
					wire Rdy;
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:69:3
					// Trace: src/src/rtl/design/svsrc/interface_list.sv:75:3
				end
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:44:3
				genvar _gv_i_2;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:45:3
				genvar _gv_j_1;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:46:3
				for (_gv_i_2 = 0; _gv_i_2 < N; _gv_i_2 = _gv_i_2 + 1) begin : GEN_XBAR_CON_TRANS_ROW
					localparam i = _gv_i_2;
					for (_gv_j_1 = 0; _gv_j_1 < N; _gv_j_1 = _gv_j_1 + 1) begin : GEN_XBAR_CON_TRANS_COL
						localparam j = _gv_j_1;
						// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:52:9
						assign xbarConT[(i * N) + j].Vld = xbarCon[(j * N) + i].Vld;
						// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:53:9
						assign xbarConT[(i * N) + j].Pld = xbarCon[(j * N) + i].Pld;
						// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:54:9
						assign xbarConT[(i * N) + j].Dst = xbarCon[(j * N) + i].Dst;
						// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:55:9
						assign xbarCon[(j * N) + i].Rdy = xbarConT[(i * N) + j].Rdy;
					end
				end
				// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:60:3
				for (_gv_i_2 = 0; _gv_i_2 < N; _gv_i_2 = _gv_i_2 + 1) begin : GEN_CON
					localparam i = _gv_i_2;
					// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:62:7
					// expanded module instance: U_ROUTEUNIT
					localparam _bbase_08BCB_iDcpIn = _gv_i_2 + _mbase_iDcpIn;
					localparam _bbase_08BCB_oDcpOut = N * _gv_i_2;
					localparam _param_08BCB_DW = DW;
					localparam _param_08BCB_AW = AW;
					localparam _param_08BCB_RNUM = N;
					if (1) begin : U_ROUTEUNIT
						reg _sv2v_0;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:3:13
						localparam DW = _param_08BCB_DW;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:4:13
						localparam AW = _param_08BCB_AW;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:5:13
						localparam RNUM = _param_08BCB_RNUM;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:7:3
						wire iClk;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:8:3
						wire iRst_n;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:10:3
						localparam _mbase_iDcpIn = _bbase_08BCB_iDcpIn;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:11:3
						localparam _mbase_oDcpOut = _bbase_08BCB_oDcpOut;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:14:3
						reg swiInRdy;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:15:3
						wire swiInVld;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:16:3
						wire [32:0] swiInPld;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:17:3
						wire [3:0] swiInDst;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:19:3
						reg [3:0] swiOutVld;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:20:3
						wire [3:0] swiOutRdy;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:22:3
						localparam IDLE = 1'b0;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:23:3
						localparam GRANT = 1'b1;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:25:3
						gnrl_buf #(
							.DW(37),
							.CUT_RDY(1)
						) U_INBUF(
							.clk_i(iClk),
							.rst_n_i(iRst_n),
							.din_i({DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_iDcpIn].Dst[3:0], DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_iDcpIn].Pld}),
							.din_vld_i(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_iDcpIn].Vld),
							.din_rdy_o(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.switchOut[_mbase_iDcpIn].Rdy),
							.dout_o({swiInDst, swiInPld}),
							.dout_vld_o(swiInVld),
							.dout_rdy_i(swiInRdy)
						);
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:39:3
						genvar _gv_i_4;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:40:3
						for (_gv_i_4 = 0; _gv_i_4 < RNUM; _gv_i_4 = _gv_i_4 + 1) begin : GEN_ROUTE
							localparam i = _gv_i_4;
							// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:42:7
							always @(*) begin
								if (_sv2v_0)
									;
								// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:44:9
								if (swiInVld && (swiInDst[3-:2] == i))
									// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:45:11
									swiOutVld[i] = swiInVld;
								else
									// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:47:11
									swiOutVld[i] = 1'b0;
							end
						end
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:53:3
						reg signed [31:0] j;
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:54:3
						always @(*) begin
							if (_sv2v_0)
								;
							// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:55:5
							if (swiInVld) begin
								begin
									// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:56:7
									for (j = 0; j < RNUM; j = j + 1)
										begin
											// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:58:9
											if (swiInDst[3-:2] == j)
												// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:59:11
												swiInRdy = swiOutRdy[j];
										end
								end
							end
							else
								// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:63:7
								swiInRdy = 1'b0;
						end
						// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:67:3
						for (_gv_i_4 = 0; _gv_i_4 < RNUM; _gv_i_4 = _gv_i_4 + 1) begin : GEN_OUTBUF
							localparam i = _gv_i_4;
							// Trace: src/src/rtl/design/svsrc/DcpRouteUnit.sv:69:7
							gnrl_buf #(
								.DW(37),
								.CUT_RDY(1)
							) U_OUTBUF(
								.clk_i(iClk),
								.rst_n_i(iRst_n),
								.din_i({swiInDst, swiInPld}),
								.din_vld_i(swiOutVld[i]),
								.din_rdy_o(swiOutRdy[i]),
								.dout_o({DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarCon[i + _mbase_oDcpOut].Dst[3:0], DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarCon[i + _mbase_oDcpOut].Pld}),
								.dout_vld_o(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarCon[i + _mbase_oDcpOut].Vld),
								.dout_rdy_i(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarCon[i + _mbase_oDcpOut].Rdy)
							);
						end
						initial _sv2v_0 = 0;
					end
					assign U_ROUTEUNIT.iClk = iClk;
					assign U_ROUTEUNIT.iRst_n = iRst_n;
					// Trace: src/src/rtl/design/svsrc/DcpCrossbarNxN.sv:72:7
					// expanded module instance: U_SWITCHUNIT
					localparam _bbase_C87B5_iDcpIn = N * _gv_i_2;
					localparam _bbase_C87B5_oDcpOut = _gv_i_2 + _mbase_oDcpOut;
					localparam _param_C87B5_DW = DW;
					localparam _param_C87B5_AW = AW;
					localparam _param_C87B5_SNUM = N;
					if (1) begin : U_SWITCHUNIT
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:28:13
						localparam DW = _param_C87B5_DW;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:29:13
						localparam AW = _param_C87B5_AW;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:30:13
						localparam SNUM = _param_C87B5_SNUM;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:32:3
						wire iClk;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:33:3
						wire iRst_n;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:35:3
						localparam _mbase_iDcpIn = _bbase_C87B5_iDcpIn;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:36:3
						localparam _mbase_oDcpOut = _bbase_C87B5_oDcpOut;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:38:3
						wire [3:0] arbInReqArray;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:39:3
						wire [3:0] arbInGntArray;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:40:3
						wire [147:0] arbInPldArray;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:42:3
						wire arbOutReq;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:43:3
						wire arbOutGnt;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:44:3
						wire [36:0] arbOutPld;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:46:3
						genvar _gv_i_5;
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:48:3
						for (_gv_i_5 = 0; _gv_i_5 < SNUM; _gv_i_5 = _gv_i_5 + 1) begin : GEN_INBUF
							localparam i = _gv_i_5;
							// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:50:7
							gnrl_buf #(
								.DW(37),
								.CUT_RDY(1)
							) U_INBUF(
								.clk_i(iClk),
								.rst_n_i(iRst_n),
								.din_i({DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarConT[i + _mbase_iDcpIn].Dst, DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarConT[i + _mbase_iDcpIn].Pld}),
								.din_vld_i(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarConT[i + _mbase_iDcpIn].Vld),
								.din_rdy_o(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.U_CRSBAR.xbarConT[i + _mbase_iDcpIn].Rdy),
								.dout_o(arbInPldArray[i * 37+:37]),
								.dout_vld_o(arbInReqArray[i]),
								.dout_rdy_i(arbInGntArray[i])
							);
						end
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:67:3
						rr_arb_tree #(
							.NumIn(SNUM),
							.DataWidth(37),
							.AxiVldRdy(1),
							.LockIn(0)
						) U_RR_ARB(
							.rst_ni(iRst_n),
							.clk_i(iClk),
							.req_i(arbInReqArray),
							.gnt_o(arbInGntArray),
							.data_i(arbInPldArray),
							.req_o(arbOutReq),
							.gnt_i(arbOutGnt),
							.data_o(arbOutPld)
						);
						// Trace: src/src/rtl/design/svsrc/DcpSwitchUnit.sv:86:3
						gnrl_buf #(
							.DW(37),
							.CUT_RDY(1)
						) U_INBUF(
							.clk_i(iClk),
							.rst_n_i(iRst_n),
							.din_i(arbOutPld),
							.din_vld_i(arbOutReq),
							.din_rdy_o(arbOutGnt),
							.dout_o({DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataOut[_mbase_oDcpOut].Dst, DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataOut[_mbase_oDcpOut].Pld}),
							.dout_vld_o(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataOut[_mbase_oDcpOut].Vld),
							.dout_rdy_i(DcpCrossbar16x4Wrapper.U_DCPCRSBAR_16X4.rdDataOut[_mbase_oDcpOut].Rdy)
						);
					end
					assign U_SWITCHUNIT.iClk = iClk;
					assign U_SWITCHUNIT.iRst_n = iRst_n;
				end
			end
			assign U_CRSBAR.iClk = iClk;
			assign U_CRSBAR.iRst_n = iRst_n;
			// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:46:3
			for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : GENCON
				localparam i = _gv_i_1;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:48:7
				assign rdDataOut[i].Rdy = DcpCrossbar16x4Wrapper.dcpOut[i + _mbase_oRdDataOut].Rdy;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:49:7
				assign DcpCrossbar16x4Wrapper.dcpOut[i + _mbase_oRdDataOut].Pld = rdDataOut[i].Pld;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:50:7
				assign DcpCrossbar16x4Wrapper.dcpOut[i + _mbase_oRdDataOut].Vld = rdDataOut[i].Vld;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:51:7
				assign DcpCrossbar16x4Wrapper.dcpOut[i + _mbase_oRdDataOut].Dst = rdDataOut[i].Dst;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:53:7
				assign DcpCrossbar16x4Wrapper.dcpIn[i + _mbase_iRdDataIn].Rdy = rdDataIn[i].Rdy;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:54:7
				assign rdDataIn[i].Pld = DcpCrossbar16x4Wrapper.dcpIn[i + _mbase_iRdDataIn].Pld;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:55:7
				assign rdDataIn[i].Vld = DcpCrossbar16x4Wrapper.dcpIn[i + _mbase_iRdDataIn].Vld;
				// Trace: src/src/rtl/design/svsrc/DcpCrossbar16x4.sv:56:7
				assign rdDataIn[i].Dst = DcpCrossbar16x4Wrapper.dcpIn[i + _mbase_iRdDataIn].Dst;
			end
		end
	endgenerate
	assign U_DCPCRSBAR_16X4.iClk = iClk;
	assign U_DCPCRSBAR_16X4.iRst_n = iRst_n;
endmodule
