`include "define.v"
module RdScheTopWrapper #(
  parameter PRI_DEPTH = 8,            // 优先级队列深度
  parameter WRR_WEIGHT_NUM = 8        // WRR最大权重数
) (
  input   wire      iClk,
  input   wire      iRst_n,

  // ============== TAG ===============
  output  wire                          oPkgRdy0,
  input   wire [2:0]                    iPkgPri0,
  input   wire [3:0]                    iPkgDstPort0,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr0,
  input   wire [3:0]                    iPkgLen0,
  input   wire                          iPkgTagVld0,

  output  wire                          oPkgRdy1,
  input   wire [2:0]                    iPkgPri1,
  input   wire [3:0]                    iPkgDstPort1,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr1,
  input   wire [3:0]                    iPkgLen1,
  input   wire                          iPkgTagVld1,

  output  wire                          oPkgRdy2,
  input   wire [2:0]                    iPkgPri2,
  input   wire [3:0]                    iPkgDstPort2,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr2,
  input   wire [3:0]                    iPkgLen2,
  input   wire                          iPkgTagVld2,

  output  wire                          oPkgRdy3,
  input   wire [2:0]                    iPkgPri3,
  input   wire [3:0]                    iPkgDstPort3,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr3,
  input   wire [3:0]                    iPkgLen3,
  input   wire                          iPkgTagVld3,

  output  wire                          oPkgRdy4,
  input   wire [2:0]                    iPkgPri4,
  input   wire [3:0]                    iPkgDstPort4,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr4,
  input   wire [3:0]                    iPkgLen4,
  input   wire                          iPkgTagVld4,

  output  wire                          oPkgRdy5,
  input   wire [2:0]                    iPkgPri5,
  input   wire [3:0]                    iPkgDstPort5,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr5,
  input   wire [3:0]                    iPkgLen5,
  input   wire                          iPkgTagVld5,

  output  wire                          oPkgRdy6,
  input   wire [2:0]                    iPkgPri6,
  input   wire [3:0]                    iPkgDstPort6,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr6,
  input   wire [3:0]                    iPkgLen6,
  input   wire                          iPkgTagVld6,

  output  wire                          oPkgRdy7,
  input   wire [2:0]                    iPkgPri7,
  input   wire [3:0]                    iPkgDstPort7,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr7,
  input   wire [3:0]                    iPkgLen7,
  input   wire                          iPkgTagVld7,

  output  wire                          oPkgRdy8,
  input   wire [2:0]                    iPkgPri8,
  input   wire [3:0]                    iPkgDstPort8,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr8,
  input   wire [3:0]                    iPkgLen8,
  input   wire                          iPkgTagVld8,

  output  wire                          oPkgRdy9,
  input   wire [2:0]                    iPkgPri9,
  input   wire [3:0]                    iPkgDstPort9,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr9,
  input   wire [3:0]                    iPkgLen9,
  input   wire                          iPkgTagVld9,

  output  wire                          oPkgRdy10,
  input   wire [2:0]                    iPkgPri10,
  input   wire [3:0]                    iPkgDstPort10,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr10,
  input   wire [3:0]                    iPkgLen10,
  input   wire                          iPkgTagVld10,

  output  wire                          oPkgRdy11,
  input   wire [2:0]                    iPkgPri11,
  input   wire [3:0]                    iPkgDstPort11,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr11,
  input   wire [3:0]                    iPkgLen11,
  input   wire                          iPkgTagVld11,

  output  wire                          oPkgRdy12,
  input   wire [2:0]                    iPkgPri12,
  input   wire [3:0]                    iPkgDstPort12,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr12,
  input   wire [3:0]                    iPkgLen12,
  input   wire                          iPkgTagVld12,

  output  wire                          oPkgRdy13,
  input   wire [2:0]                    iPkgPri13,
  input   wire [3:0]                    iPkgDstPort13,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr13,
  input   wire [3:0]                    iPkgLen13,
  input   wire                          iPkgTagVld13,

  output  wire                          oPkgRdy14,
  input   wire [2:0]                    iPkgPri14,
  input   wire [3:0]                    iPkgDstPort14,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr14,
  input   wire [3:0]                    iPkgLen14,
  input   wire                          iPkgTagVld14,

  output  wire                          oPkgRdy15,
  input   wire [2:0]                    iPkgPri15,
  input   wire [3:0]                    iPkgDstPort15,
  input   wire [`ADDR_LENTH-1 : 0]      iPkgFirAddr15,
  input   wire [3:0]                    iPkgLen15,
  input   wire                          iPkgTagVld15,

  // ================== RDCMD ============================
  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr0,       //FirAddr
  output  wire                          oPkgFirAddrVld0,    
  output  wire    [3:0]                 oPkgBlockNum0,      //Len
  output  wire                          oPkgDrop0,
  input   wire                          iPkgFirAddrRdy0,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr1,
  output  wire                          oPkgFirAddrVld1,
  output  wire    [3:0]                 oPkgBlockNum1,
  output  wire                          oPkgDrop1,
  input   wire                          iPkgFirAddrRdy1,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr2,
  output  wire                          oPkgFirAddrVld2,
  output  wire    [3:0]                 oPkgBlockNum2,
  output  wire                          oPkgDrop2,
  input   wire                          iPkgFirAddrRdy2,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr3,
  output  wire                          oPkgFirAddrVld3,
  output  wire    [3:0]                 oPkgBlockNum3,
  output  wire                          oPkgDrop3,
  input   wire                          iPkgFirAddrRdy3,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr4,
  output  wire                          oPkgFirAddrVld4,
  output  wire    [3:0]                 oPkgBlockNum4,
  output  wire                          oPkgDrop4,
  input   wire                          iPkgFirAddrRdy4,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr5,
  output  wire                          oPkgFirAddrVld5,
  output  wire    [3:0]                 oPkgBlockNum5,
  output  wire                          oPkgDrop5,
  input   wire                          iPkgFirAddrRdy5,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr6,
  output  wire                          oPkgFirAddrVld6,
  output  wire    [3:0]                 oPkgBlockNum6,
  output  wire                          oPkgDrop6,
  input   wire                          iPkgFirAddrRdy6,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr7,
  output  wire                          oPkgFirAddrVld7,
  output  wire    [3:0]                 oPkgBlockNum7,
  output  wire                          oPkgDrop7,
  input   wire                          iPkgFirAddrRdy7,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr8,
  output  wire                          oPkgFirAddrVld8,
  output  wire    [3:0]                 oPkgBlockNum8,
  output  wire                          oPkgDrop8,
  input   wire                          iPkgFirAddrRdy8,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr9,
  output  wire                          oPkgFirAddrVld9,
  output  wire    [3:0]                 oPkgBlockNum9,
  output  wire                          oPkgDrop9,
  input   wire                          iPkgFirAddrRdy9,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr10,
  output  wire                          oPkgFirAddrVld10,
  output  wire    [3:0]                 oPkgBlockNum10,
  output  wire                          oPkgDrop10,
  input   wire                          iPkgFirAddrRdy10,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr11,
  output  wire                          oPkgFirAddrVld11,
  output  wire    [3:0]                 oPkgBlockNum11,
  output  wire                          oPkgDrop11,
  input   wire                          iPkgFirAddrRdy11,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr12,
  output  wire                          oPkgFirAddrVld12,
  output  wire    [3:0]                 oPkgBlockNum12,
  output  wire                          oPkgDrop12,
  input   wire                          iPkgFirAddrRdy12,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr13,
  output  wire                          oPkgFirAddrVld13,
  output  wire    [3:0]                 oPkgBlockNum13,
  output  wire                          oPkgDrop13,
  input   wire                          iPkgFirAddrRdy13,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr14,
  output  wire                          oPkgFirAddrVld14,
  output  wire    [3:0]                 oPkgBlockNum14,
  output  wire                          oPkgDrop14,
  input   wire                          iPkgFirAddrRdy14,

  output  wire    [`ADDR_LENTH-1:0]     oPkgFirAddr15,
  output  wire                          oPkgFirAddrVld15,
  output  wire    [3:0]                 oPkgBlockNum15,
  output  wire                          oPkgDrop15,
  input   wire                          iPkgFirAddrRdy15,

  // ============== RDDATA =======================
  input   wire    [`DATA_WIDTH-1:0]     iWrrData0,
  input   wire                          iWrrVld0,
  input   wire                          iWrrLast0,
  output  wire                          oWrrRdy0,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData1,
  input   wire                          iWrrVld1,
  input   wire                          iWrrLast1,
  output  wire                          oWrrRdy1,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData2,
  input   wire                          iWrrVld2,
  input   wire                          iWrrLast2,
  output  wire                          oWrrRdy2,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData3,
  input   wire                          iWrrVld3,
  input   wire                          iWrrLast3,
  output  wire                          oWrrRdy3,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData4,
  input   wire                          iWrrVld4,
  input   wire                          iWrrLast4,
  output  wire                          oWrrRdy4,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData5,
  input   wire                          iWrrVld5,
  input   wire                          iWrrLast5,
  output  wire                          oWrrRdy5,
  
  input   wire    [`DATA_WIDTH-1:0]     iWrrData6,
  input   wire                          iWrrVld6,
  input   wire                          iWrrLast6,
  output  wire                          oWrrRdy6,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData7,
  input   wire                          iWrrVld7,
  input   wire                          iWrrLast7,
  output  wire                          oWrrRdy7,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData8,
  input   wire                          iWrrVld8,
  input   wire                          iWrrLast8,
  output  wire                          oWrrRdy8,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData9,
  input   wire                          iWrrVld9,
  input   wire                          iWrrLast9,
  output  wire                          oWrrRdy9,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData10,
  input   wire                          iWrrVld10,
  input   wire                          iWrrLast10,
  output  wire                          oWrrRdy10,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData11,
  input   wire                          iWrrVld11,
  input   wire                          iWrrLast11,
  output  wire                          oWrrRdy11,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData12,
  input   wire                          iWrrVld12,
  input   wire                          iWrrLast12,
  output  wire                          oWrrRdy12,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData13,
  input   wire                          iWrrVld13,
  input   wire                          iWrrLast13,
  output  wire                          oWrrRdy13,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData14,
  input   wire                          iWrrVld14,
  input   wire                          iWrrLast14,
  output  wire                          oWrrRdy14,

  input   wire    [`DATA_WIDTH-1:0]     iWrrData15,
  input   wire                          iWrrVld15,
  input   wire                          iWrrLast15,
  output  wire                          oWrrRdy15,

  // ================ OUTPUT ==========================
  output  wire                          oRdSop0,
  output  wire                          oRdEop0,
  output  wire                          oRdVld0,
  output  wire  [`DATA_WIDTH-1:0]       oRdData0,
  input   wire                          iRdRdy0,
  output  wire                          oRdLast0,

  output  wire                          oRdSop1,
  output  wire                          oRdEop1,
  output  wire                          oRdVld1,
  output  wire  [`DATA_WIDTH-1:0]       oRdData1,
  input   wire                          iRdRdy1,
  output  wire                          oRdLast1,

  output  wire                          oRdSop2,
  output  wire                          oRdEop2,
  output  wire                          oRdVld2,
  output  wire  [`DATA_WIDTH-1:0]       oRdData2,
  input   wire                          iRdRdy2,
  output  wire                          oRdLast2,

  output  wire                          oRdSop3,
  output  wire                          oRdEop3,
  output  wire                          oRdVld3,
  output  wire  [`DATA_WIDTH-1:0]       oRdData3,
  input   wire                          iRdRdy3,
  output  wire                          oRdLast3,

  output  wire                          oRdSop4,
  output  wire                          oRdEop4,
  output  wire                          oRdVld4,
  output  wire  [`DATA_WIDTH-1:0]       oRdData4,
  input   wire                          iRdRdy4,
  output  wire                          oRdLast4,

  output  wire                          oRdSop5,
  output  wire                          oRdEop5,
  output  wire                          oRdVld5,
  output  wire  [`DATA_WIDTH-1:0]       oRdData5,
  input   wire                          iRdRdy5,
  output  wire                          oRdLast5,

  output  wire                          oRdSop6,
  output  wire                          oRdEop6,
  output  wire                          oRdVld6,
  output  wire  [`DATA_WIDTH-1:0]       oRdData6,
  input   wire                          iRdRdy6,
  output  wire                          oRdLast6,

  output  wire                          oRdSop7,
  output  wire                          oRdEop7,
  output  wire                          oRdVld7,
  output  wire  [`DATA_WIDTH-1:0]       oRdData7,
  input   wire                          iRdRdy7,
  output  wire                          oRdLast7,

  output  wire                          oRdSop8,
  output  wire                          oRdEop8,
  output  wire                          oRdVld8,
  output  wire  [`DATA_WIDTH-1:0]       oRdData8,
  input   wire                          iRdRdy8,
  output  wire                          oRdLast8,

  output  wire                          oRdSop9,
  output  wire                          oRdEop9,
  output  wire                          oRdVld9,
  output  wire  [`DATA_WIDTH-1:0]       oRdData9,
  input   wire                          iRdRdy9,
  output  wire                          oRdLast9,

  output  wire                          oRdSop10,
  output  wire                          oRdEop10,
  output  wire                          oRdVld10,
  output  wire  [`DATA_WIDTH-1:0]       oRdData10,
  input   wire                          iRdRdy10,
  output  wire                          oRdLast10,

  output  wire                          oRdSop11,
  output  wire                          oRdEop11,
  output  wire                          oRdVld11,
  output  wire  [`DATA_WIDTH-1:0]       oRdData11,
  input   wire                          iRdRdy11,
  output  wire                          oRdLast11,

  output  wire                          oRdSop12,
  output  wire                          oRdEop12,
  output  wire                          oRdVld12,
  output  wire  [`DATA_WIDTH-1:0]       oRdData12,
  input   wire                          iRdRdy12,
  output  wire                          oRdLast12,

  output  wire                          oRdSop13,
  output  wire                          oRdEop13,
  output  wire                          oRdVld13,
  output  wire  [`DATA_WIDTH-1:0]       oRdData13,
  input   wire                          iRdRdy13,
  output  wire                          oRdLast13,

  output  wire                          oRdSop14,
  output  wire                          oRdEop14,
  output  wire                          oRdVld14,
  output  wire  [`DATA_WIDTH-1:0]       oRdData14,
  input   wire                          iRdRdy14,
  output  wire                          oRdLast14,

  output  wire                          oRdSop15,
  output  wire                          oRdEop15,
  output  wire                          oRdVld15,
  output  wire  [`DATA_WIDTH-1:0]       oRdData15,
  input   wire                          iRdRdy15,
  output  wire                          oRdLast15,

  // ===================== WRR WEIGHT ======================
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld0,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld1,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld2,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld3,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld4,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld5,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld6,
  input   wire [$clog2(WRR_WEIGHT_NUM):0]  iWrrWeightPld7,
  input   wire [3:0]                       iWrrWeightIdx,
  input   wire                             iWrrWeightLoad  
);

  localparam TAG_WIDTH = `ADDR_LENTH+11;
  localparam RDCMD_WIDTH = `ADDR_LENTH+9;
  localparam RDDATA_WIDTH = `DATA_WIDTH+1;


  Decoupled#(.DW(TAG_WIDTH), .AW(4))    intTag[16]();
  Decoupled#(.DW(RDCMD_WIDTH), .AW(4))  intRdCmd[16]();
  Decoupled#(.DW(RDDATA_WIDTH), .AW(4)) intRdData[16]();

  // ================== TAG =================
  assign intTag[0].Vld = iPkgTagVld0;
  assign intTag[0].Dst = iPkgDstPort0;
  assign intTag[0].Pld = {iPkgPri0, iPkgFirAddr0, iPkgLen0, 4'h0};
  assign oPkgRdy0 = intTag[0].Rdy;

  assign intTag[1].Vld = iPkgTagVld1;
  assign intTag[1].Dst = iPkgDstPort1;
  assign intTag[1].Pld = {iPkgPri1, iPkgFirAddr1, iPkgLen1, 4'h1};
  assign oPkgRdy1 = intTag[1].Rdy;

  assign intTag[2].Vld = iPkgTagVld2;
  assign intTag[2].Dst = iPkgDstPort2;
  assign intTag[2].Pld = {iPkgPri2, iPkgFirAddr2, iPkgLen2, 4'h2};
  assign oPkgRdy2 = intTag[2].Rdy;

  assign intTag[3].Vld = iPkgTagVld3;
  assign intTag[3].Dst = iPkgDstPort3;
  assign intTag[3].Pld = {iPkgPri3, iPkgFirAddr3, iPkgLen3, 4'h3};
  assign oPkgRdy3 = intTag[3].Rdy;

  assign intTag[4].Vld = iPkgTagVld4;
  assign intTag[4].Dst = iPkgDstPort4;
  assign intTag[4].Pld = {iPkgPri4, iPkgFirAddr4, iPkgLen4, 4'h4};
  assign oPkgRdy4 = intTag[4].Rdy;

  assign intTag[5].Vld = iPkgTagVld5;
  assign intTag[5].Dst = iPkgDstPort5;
  assign intTag[5].Pld = {iPkgPri5, iPkgFirAddr5, iPkgLen5, 4'h5};
  assign oPkgRdy5 = intTag[5].Rdy;

  assign intTag[6].Vld = iPkgTagVld6;
  assign intTag[6].Dst = iPkgDstPort6;
  assign intTag[6].Pld = {iPkgPri6, iPkgFirAddr6, iPkgLen6, 4'h6};
  assign oPkgRdy6 = intTag[6].Rdy;

  assign intTag[7].Vld = iPkgTagVld7;
  assign intTag[7].Dst = iPkgDstPort7;
  assign intTag[7].Pld = {iPkgPri7, iPkgFirAddr7, iPkgLen7, 4'h7};
  assign oPkgRdy7 = intTag[7].Rdy;

  assign intTag[8].Vld = iPkgTagVld8;
  assign intTag[8].Dst = iPkgDstPort8;
  assign intTag[8].Pld = {iPkgPri8, iPkgFirAddr8, iPkgLen8, 4'h8};
  assign oPkgRdy8 = intTag[8].Rdy;

  assign intTag[9].Vld = iPkgTagVld9;
  assign intTag[9].Dst = iPkgDstPort9;
  assign intTag[9].Pld = {iPkgPri9, iPkgFirAddr9, iPkgLen9, 4'h9};
  assign oPkgRdy9 = intTag[9].Rdy;

  assign intTag[10].Vld = iPkgTagVld10;
  assign intTag[10].Dst = iPkgDstPort10;
  assign intTag[10].Pld = {iPkgPri10, iPkgFirAddr10, iPkgLen10, 4'ha};
  assign oPkgRdy10 = intTag[10].Rdy;

  assign intTag[11].Vld = iPkgTagVld11;
  assign intTag[11].Dst = iPkgDstPort11;
  assign intTag[11].Pld = {iPkgPri11, iPkgFirAddr11, iPkgLen11, 4'hb};
  assign oPkgRdy11 = intTag[11].Rdy;

  assign intTag[12].Vld = iPkgTagVld12;
  assign intTag[12].Dst = iPkgDstPort12;
  assign intTag[12].Pld = {iPkgPri12, iPkgFirAddr12, iPkgLen12, 4'hc};
  assign oPkgRdy12 = intTag[12].Rdy;

  assign intTag[13].Vld = iPkgTagVld13;
  assign intTag[13].Dst = iPkgDstPort13;
  assign intTag[13].Pld = {iPkgPri13, iPkgFirAddr13, iPkgLen13, 4'hd};
  assign oPkgRdy13 = intTag[13].Rdy;

  assign intTag[14].Vld = iPkgTagVld14;
  assign intTag[14].Dst = iPkgDstPort14;
  assign intTag[14].Pld = {iPkgPri14, iPkgFirAddr14, iPkgLen14, 4'he};
  assign oPkgRdy14 = intTag[14].Rdy;

  assign intTag[15].Vld = iPkgTagVld15;
  assign intTag[15].Dst = iPkgDstPort15;
  assign intTag[15].Pld = {iPkgPri15, iPkgFirAddr15, iPkgLen15, 4'hf};
  assign oPkgRdy15 = intTag[15].Rdy;


  // ===================== RDCMD ======================
  wire  [3:0]   rdCmdDstPort[16];   // no use

  assign oPkgFirAddrVld0 = intRdCmd[0].Vld;
  assign intRdCmd[0].Rdy = iPkgFirAddrRdy0;
  assign {oPkgFirAddr0, oPkgBlockNum0, rdCmdDstPort[0], oPkgDrop0} = intRdCmd[0].Pld;

  assign oPkgFirAddrVld1 = intRdCmd[1].Vld;
  assign intRdCmd[1].Rdy = iPkgFirAddrRdy1;
  assign {oPkgFirAddr1, oPkgBlockNum1, rdCmdDstPort[1], oPkgDrop1} = intRdCmd[1].Pld;

  assign oPkgFirAddrVld2 = intRdCmd[2].Vld;
  assign intRdCmd[2].Rdy = iPkgFirAddrRdy2;
  assign {oPkgFirAddr2, oPkgBlockNum2, rdCmdDstPort[2], oPkgDrop2} = intRdCmd[2].Pld;

  assign oPkgFirAddrVld3 = intRdCmd[3].Vld;
  assign intRdCmd[3].Rdy = iPkgFirAddrRdy3;
  assign {oPkgFirAddr3, oPkgBlockNum3, rdCmdDstPort[3], oPkgDrop3} = intRdCmd[3].Pld;

  assign oPkgFirAddrVld4 = intRdCmd[4].Vld;
  assign intRdCmd[4].Rdy = iPkgFirAddrRdy4;
  assign {oPkgFirAddr4, oPkgBlockNum4, rdCmdDstPort[4], oPkgDrop4} = intRdCmd[4].Pld;

  assign oPkgFirAddrVld5 = intRdCmd[5].Vld;
  assign intRdCmd[5].Rdy = iPkgFirAddrRdy5;
  assign {oPkgFirAddr5, oPkgBlockNum5, rdCmdDstPort[5], oPkgDrop5} = intRdCmd[5].Pld;

  assign oPkgFirAddrVld6 = intRdCmd[6].Vld;
  assign intRdCmd[6].Rdy = iPkgFirAddrRdy6;
  assign {oPkgFirAddr6, oPkgBlockNum6, rdCmdDstPort[6], oPkgDrop6} = intRdCmd[6].Pld;

  assign oPkgFirAddrVld7 = intRdCmd[7].Vld;
  assign intRdCmd[7].Rdy = iPkgFirAddrRdy7;
  assign {oPkgFirAddr7, oPkgBlockNum7, rdCmdDstPort[7], oPkgDrop7} = intRdCmd[7].Pld;

  assign oPkgFirAddrVld8 = intRdCmd[8].Vld;
  assign intRdCmd[8].Rdy = iPkgFirAddrRdy8;
  assign {oPkgFirAddr8, oPkgBlockNum8, rdCmdDstPort[8], oPkgDrop8} = intRdCmd[8].Pld;

  assign oPkgFirAddrVld9 = intRdCmd[9].Vld;
  assign intRdCmd[9].Rdy = iPkgFirAddrRdy9;
  assign {oPkgFirAddr9, oPkgBlockNum9, rdCmdDstPort[9], oPkgDrop9} = intRdCmd[9].Pld;

  assign oPkgFirAddrVld10 = intRdCmd[10].Vld;
  assign intRdCmd[10].Rdy = iPkgFirAddrRdy10;
  assign {oPkgFirAddr10, oPkgBlockNum10, rdCmdDstPort[10], oPkgDrop10} = intRdCmd[10].Pld;

  assign oPkgFirAddrVld11 = intRdCmd[11].Vld;
  assign intRdCmd[11].Rdy = iPkgFirAddrRdy11;
  assign {oPkgFirAddr11, oPkgBlockNum11, rdCmdDstPort[11], oPkgDrop11} = intRdCmd[11].Pld;

  assign oPkgFirAddrVld12 = intRdCmd[12].Vld;
  assign intRdCmd[12].Rdy = iPkgFirAddrRdy12;
  assign {oPkgFirAddr12, oPkgBlockNum12, rdCmdDstPort[12], oPkgDrop12} = intRdCmd[12].Pld;

  assign oPkgFirAddrVld13 = intRdCmd[13].Vld;
  assign intRdCmd[13].Rdy = iPkgFirAddrRdy13;
  assign {oPkgFirAddr13, oPkgBlockNum13, rdCmdDstPort[13], oPkgDrop13} = intRdCmd[13].Pld;

  assign oPkgFirAddrVld14 = intRdCmd[14].Vld;
  assign intRdCmd[14].Rdy = iPkgFirAddrRdy14;
  assign {oPkgFirAddr14, oPkgBlockNum14, rdCmdDstPort[14], oPkgDrop14} = intRdCmd[14].Pld;

  assign oPkgFirAddrVld15 = intRdCmd[15].Vld;
  assign intRdCmd[15].Rdy = iPkgFirAddrRdy15;
  assign {oPkgFirAddr15, oPkgBlockNum15, rdCmdDstPort[15], oPkgDrop15} = intRdCmd[15].Pld;

  // ===================== RDDATA ============================

  assign intRdData[0].Vld = iWrrVld0;
  assign intRdData[0].Pld = {iWrrData0, iWrrLast0};
  assign oWrrRdy0 = intRdData[0].Rdy;

  assign intRdData[1].Vld = iWrrVld1;
  assign intRdData[1].Pld = {iWrrData1, iWrrLast1};
  assign oWrrRdy1 = intRdData[1].Rdy;

  assign intRdData[2].Vld = iWrrVld2;
  assign intRdData[2].Pld = {iWrrData2, iWrrLast2};
  assign oWrrRdy2 = intRdData[2].Rdy;

  assign intRdData[3].Vld = iWrrVld3;
  assign intRdData[3].Pld = {iWrrData3, iWrrLast3};
  assign oWrrRdy3 = intRdData[3].Rdy;

  assign intRdData[4].Vld = iWrrVld4;
  assign intRdData[4].Pld = {iWrrData4, iWrrLast4};
  assign oWrrRdy4 = intRdData[4].Rdy;

  assign intRdData[5].Vld = iWrrVld5;
  assign intRdData[5].Pld = {iWrrData5, iWrrLast5};
  assign oWrrRdy5 = intRdData[5].Rdy;

  assign intRdData[6].Vld = iWrrVld6;
  assign intRdData[6].Pld = {iWrrData6, iWrrLast6};
  assign oWrrRdy6 = intRdData[6].Rdy;

  assign intRdData[7].Vld = iWrrVld7;
  assign intRdData[7].Pld = {iWrrData7, iWrrLast7};
  assign oWrrRdy7 = intRdData[7].Rdy;

  assign intRdData[8].Vld = iWrrVld8;
  assign intRdData[8].Pld = {iWrrData8, iWrrLast8};
  assign oWrrRdy8 = intRdData[8].Rdy;

  assign intRdData[9].Vld = iWrrVld9;
  assign intRdData[9].Pld = {iWrrData9, iWrrLast9};
  assign oWrrRdy9 = intRdData[9].Rdy;

  assign intRdData[10].Vld = iWrrVld10;
  assign intRdData[10].Pld = {iWrrData10, iWrrLast10};
  assign oWrrRdy10 = intRdData[10].Rdy;

  assign intRdData[11].Vld = iWrrVld11;
  assign intRdData[11].Pld = {iWrrData11, iWrrLast11};
  assign oWrrRdy11 = intRdData[11].Rdy;

  assign intRdData[12].Vld = iWrrVld12;
  assign intRdData[12].Pld = {iWrrData12, iWrrLast12};
  assign oWrrRdy12 = intRdData[12].Rdy;

  assign intRdData[13].Vld = iWrrVld13;
  assign intRdData[13].Pld = {iWrrData13, iWrrLast13};
  assign oWrrRdy13 = intRdData[13].Rdy;

  assign intRdData[14].Vld = iWrrVld14;
  assign intRdData[14].Pld = {iWrrData14, iWrrLast14};
  assign oWrrRdy14 = intRdData[14].Rdy;

  assign intRdData[15].Vld = iWrrVld15;
  assign intRdData[15].Pld = {iWrrData15, iWrrLast15};
  assign oWrrRdy15 = intRdData[15].Rdy;


  // ============== OUTPUT ================
  wire                             rdSop[16];
  wire                             rdEop[16];
  wire                             rdVld[16];
  wire [`DATA_WIDTH-1:0]           rdData[16];
  wire                             rdRdy[16];
  wire                             rdLast[16];

  assign oRdSop0  = rdSop[0];
  assign oRdEop0  = rdEop[0];
  assign oRdVld0  = rdVld[0];
  assign oRdData0 = rdData[0];
  assign rdRdy[0] = iRdRdy0;
  assign oRdLast0 = rdLast[0];

  assign oRdSop1  = rdSop[1];
  assign oRdEop1  = rdEop[1];
  assign oRdVld1  = rdVld[1];
  assign oRdData1 = rdData[1];
  assign rdRdy[1] = iRdRdy1;
  assign oRdLast1 = rdLast[1];

  assign oRdSop2  = rdSop[2];
  assign oRdEop2  = rdEop[2];
  assign oRdVld2  = rdVld[2];
  assign oRdData2 = rdData[2];
  assign rdRdy[2] = iRdRdy2;
  assign oRdLast2 = rdLast[2];

  assign oRdSop3  = rdSop[3];
  assign oRdEop3  = rdEop[3];
  assign oRdVld3  = rdVld[3];
  assign oRdData3 = rdData[3];
  assign rdRdy[3] = iRdRdy3;
  assign oRdLast3 = rdLast[3];

  assign oRdSop4  = rdSop[4];
  assign oRdEop4  = rdEop[4];
  assign oRdVld4  = rdVld[4];
  assign oRdData4 = rdData[4];
  assign rdRdy[4] = iRdRdy4;
  assign oRdLast4 = rdLast[4];

  assign oRdSop5  = rdSop[5];
  assign oRdEop5  = rdEop[5];
  assign oRdVld5  = rdVld[5];
  assign oRdData5 = rdData[5];
  assign rdRdy[5] = iRdRdy5;
  assign oRdLast5 = rdLast[5];

  assign oRdSop6  = rdSop[6];
  assign oRdEop6  = rdEop[6];
  assign oRdVld6  = rdVld[6];
  assign oRdData6 = rdData[6];
  assign rdRdy[6] = iRdRdy6;
  assign oRdLast6 = rdLast[6];

  assign oRdSop7  = rdSop[7];
  assign oRdEop7  = rdEop[7];
  assign oRdVld7  = rdVld[7];
  assign oRdData7 = rdData[7];
  assign rdRdy[7] = iRdRdy7;
  assign oRdLast7 = rdLast[7];

  assign oRdSop8  = rdSop[8];
  assign oRdEop8  = rdEop[8];
  assign oRdVld8  = rdVld[8];
  assign oRdData8 = rdData[8];
  assign rdRdy[8] = iRdRdy8;
  assign oRdLast8 = rdLast[8];

  assign oRdSop9  = rdSop[9];
  assign oRdEop9  = rdEop[9];
  assign oRdVld9  = rdVld[9];
  assign oRdData9 = rdData[9];
  assign rdRdy[9] = iRdRdy9;
  assign oRdLast9 = rdLast[9];

  assign oRdSop10  = rdSop[10];
  assign oRdEop10  = rdEop[10];
  assign oRdVld10  = rdVld[10];
  assign oRdData10 = rdData[10];
  assign rdRdy[10] = iRdRdy10;
  assign oRdLast10 = rdLast[10];

  assign oRdSop11  = rdSop[11];
  assign oRdEop11  = rdEop[11];
  assign oRdVld11  = rdVld[11];
  assign oRdData11 = rdData[11];
  assign rdRdy[11] = iRdRdy11;
  assign oRdLast11 = rdLast[11];

  assign oRdSop12  = rdSop[12];
  assign oRdEop12  = rdEop[12];
  assign oRdVld12  = rdVld[12];
  assign oRdData12 = rdData[12];
  assign rdRdy[12] = iRdRdy12;
  assign oRdLast12 = rdLast[12];

  assign oRdSop13  = rdSop[13];
  assign oRdEop13  = rdEop[13];
  assign oRdVld13  = rdVld[13];
  assign oRdData13 = rdData[13];
  assign rdRdy[13] = iRdRdy13;
  assign oRdLast13 = rdLast[13];

  assign oRdSop14  = rdSop[14];
  assign oRdEop14  = rdEop[14];
  assign oRdVld14  = rdVld[14];
  assign oRdData14 = rdData[14];
  assign rdRdy[14] = iRdRdy14;
  assign oRdLast14 = rdLast[14];

  assign oRdSop15  = rdSop[15];
  assign oRdEop15  = rdEop[15];
  assign oRdVld15  = rdVld[15];
  assign oRdData15 = rdData[15];
  assign rdRdy[15] = iRdRdy15;
  assign oRdLast15 = rdLast[15];

// ===================== WRR WEIGHT =======================

  logic [$clog2(WRR_WEIGHT_NUM):0]  weightPld[8];

  assign weightPld[0] = iWrrWeightPld0;
  assign weightPld[1] = iWrrWeightPld1;
  assign weightPld[2] = iWrrWeightPld2;
  assign weightPld[3] = iWrrWeightPld3;
  assign weightPld[4] = iWrrWeightPld4;
  assign weightPld[5] = iWrrWeightPld5;
  assign weightPld[6] = iWrrWeightPld6;
  assign weightPld[7] = iWrrWeightPld7;


RdScheTop #(
  .PRI_DEPTH       (PRI_DEPTH     ),            // 优先级队列深度
  .WRR_WEIGHT_NUM  (WRR_WEIGHT_NUM)        // WRR最大权重数
)U_RD_SCHE_TOP_SV(
  .iClk     (iClk),
  .iRst_n   (iRst_n),

  .iTagIn     (intTag),
  .iRdDataIn  (intRdData),
  .oRdCmdOut  (intRdCmd),

  .oRdSop     (rdSop ),
  .oRdEop     (rdEop ),
  .oRdVld     (rdVld ),
  .oRdData    (rdData),
  .iRdRdy     (rdRdy ),
  .oRdLast    (rdLast),

  .iWeightPld (weightPld),
  .iWeightIdx (iWrrWeightIdx),
  .iWeightLoad(iWrrWeightLoad)  
); 
  
endmodule