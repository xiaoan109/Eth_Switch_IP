`include "define.v"
module RdScheTopWrapper #(
  parameter PRI_DEPTH = 8,            // 优先级队列深度
  parameter WRR_WEIGHT_NUM = 8        // WRR最大权重数
) (
  input   wire      iClk,
  input   wire      iRst_n,

  // ============== TAG ===============
  output  wire                          oPktRdy0,
  input   wire [2:0]                    iPktPri0,
  input   wire [3:0]                    iPktDstPort0,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr0,
  input   wire [3:0]                    iPktLen0,
  input   wire                          iPktTagVld0,

  output  wire                          oPktRdy1,
  input   wire [2:0]                    iPktPri1,
  input   wire [3:0]                    iPktDstPort1,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr1,
  input   wire [3:0]                    iPktLen1,
  input   wire                          iPktTagVld1,

  output  wire                          oPktRdy2,
  input   wire [2:0]                    iPktPri2,
  input   wire [3:0]                    iPktDstPort2,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr2,
  input   wire [3:0]                    iPktLen2,
  input   wire                          iPktTagVld2,

  output  wire                          oPktRdy3,
  input   wire [2:0]                    iPktPri3,
  input   wire [3:0]                    iPktDstPort3,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr3,
  input   wire [3:0]                    iPktLen3,
  input   wire                          iPktTagVld3,

  output  wire                          oPktRdy4,
  input   wire [2:0]                    iPktPri4,
  input   wire [3:0]                    iPktDstPort4,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr4,
  input   wire [3:0]                    iPktLen4,
  input   wire                          iPktTagVld4,

  output  wire                          oPktRdy5,
  input   wire [2:0]                    iPktPri5,
  input   wire [3:0]                    iPktDstPort5,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr5,
  input   wire [3:0]                    iPktLen5,
  input   wire                          iPktTagVld5,

  output  wire                          oPktRdy6,
  input   wire [2:0]                    iPktPri6,
  input   wire [3:0]                    iPktDstPort6,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr6,
  input   wire [3:0]                    iPktLen6,
  input   wire                          iPktTagVld6,

  output  wire                          oPktRdy7,
  input   wire [2:0]                    iPktPri7,
  input   wire [3:0]                    iPktDstPort7,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr7,
  input   wire [3:0]                    iPktLen7,
  input   wire                          iPktTagVld7,

  output  wire                          oPktRdy8,
  input   wire [2:0]                    iPktPri8,
  input   wire [3:0]                    iPktDstPort8,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr8,
  input   wire [3:0]                    iPktLen8,
  input   wire                          iPktTagVld8,

  output  wire                          oPktRdy9,
  input   wire [2:0]                    iPktPri9,
  input   wire [3:0]                    iPktDstPort9,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr9,
  input   wire [3:0]                    iPktLen9,
  input   wire                          iPktTagVld9,

  output  wire                          oPktRdy10,
  input   wire [2:0]                    iPktPri10,
  input   wire [3:0]                    iPktDstPort10,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr10,
  input   wire [3:0]                    iPktLen10,
  input   wire                          iPktTagVld10,

  output  wire                          oPktRdy11,
  input   wire [2:0]                    iPktPri11,
  input   wire [3:0]                    iPktDstPort11,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr11,
  input   wire [3:0]                    iPktLen11,
  input   wire                          iPktTagVld11,

  output  wire                          oPktRdy12,
  input   wire [2:0]                    iPktPri12,
  input   wire [3:0]                    iPktDstPort12,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr12,
  input   wire [3:0]                    iPktLen12,
  input   wire                          iPktTagVld12,

  output  wire                          oPktRdy13,
  input   wire [2:0]                    iPktPri13,
  input   wire [3:0]                    iPktDstPort13,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr13,
  input   wire [3:0]                    iPktLen13,
  input   wire                          iPktTagVld13,

  output  wire                          oPktRdy14,
  input   wire [2:0]                    iPktPri14,
  input   wire [3:0]                    iPktDstPort14,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr14,
  input   wire [3:0]                    iPktLen14,
  input   wire                          iPktTagVld14,

  output  wire                          oPktRdy15,
  input   wire [2:0]                    iPktPri15,
  input   wire [3:0]                    iPktDstPort15,
  input   wire [`ADDR_LENTH-1 : 0]      iPktFirAddr15,
  input   wire [3:0]                    iPktLen15,
  input   wire                          iPktTagVld15,

  // ================== RDCMD ============================
  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr0,       //FirAddr
  output  wire                          oPktFirAddrVld0,    
  output  wire    [3:0]                 oPktBlockNum0,      //Len
  output  wire                          oPktDrop0,
  input   wire                          iPktFirAddrRdy0,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr1,
  output  wire                          oPktFirAddrVld1,
  output  wire    [3:0]                 oPktBlockNum1,
  output  wire                          oPktDrop1,
  input   wire                          iPktFirAddrRdy1,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr2,
  output  wire                          oPktFirAddrVld2,
  output  wire    [3:0]                 oPktBlockNum2,
  output  wire                          oPktDrop2,
  input   wire                          iPktFirAddrRdy2,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr3,
  output  wire                          oPktFirAddrVld3,
  output  wire    [3:0]                 oPktBlockNum3,
  output  wire                          oPktDrop3,
  input   wire                          iPktFirAddrRdy3,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr4,
  output  wire                          oPktFirAddrVld4,
  output  wire    [3:0]                 oPktBlockNum4,
  output  wire                          oPktDrop4,
  input   wire                          iPktFirAddrRdy4,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr5,
  output  wire                          oPktFirAddrVld5,
  output  wire    [3:0]                 oPktBlockNum5,
  output  wire                          oPktDrop5,
  input   wire                          iPktFirAddrRdy5,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr6,
  output  wire                          oPktFirAddrVld6,
  output  wire    [3:0]                 oPktBlockNum6,
  output  wire                          oPktDrop6,
  input   wire                          iPktFirAddrRdy6,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr7,
  output  wire                          oPktFirAddrVld7,
  output  wire    [3:0]                 oPktBlockNum7,
  output  wire                          oPktDrop7,
  input   wire                          iPktFirAddrRdy7,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr8,
  output  wire                          oPktFirAddrVld8,
  output  wire    [3:0]                 oPktBlockNum8,
  output  wire                          oPktDrop8,
  input   wire                          iPktFirAddrRdy8,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr9,
  output  wire                          oPktFirAddrVld9,
  output  wire    [3:0]                 oPktBlockNum9,
  output  wire                          oPktDrop9,
  input   wire                          iPktFirAddrRdy9,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr10,
  output  wire                          oPktFirAddrVld10,
  output  wire    [3:0]                 oPktBlockNum10,
  output  wire                          oPktDrop10,
  input   wire                          iPktFirAddrRdy10,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr11,
  output  wire                          oPktFirAddrVld11,
  output  wire    [3:0]                 oPktBlockNum11,
  output  wire                          oPktDrop11,
  input   wire                          iPktFirAddrRdy11,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr12,
  output  wire                          oPktFirAddrVld12,
  output  wire    [3:0]                 oPktBlockNum12,
  output  wire                          oPktDrop12,
  input   wire                          iPktFirAddrRdy12,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr13,
  output  wire                          oPktFirAddrVld13,
  output  wire    [3:0]                 oPktBlockNum13,
  output  wire                          oPktDrop13,
  input   wire                          iPktFirAddrRdy13,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr14,
  output  wire                          oPktFirAddrVld14,
  output  wire    [3:0]                 oPktBlockNum14,
  output  wire                          oPktDrop14,
  input   wire                          iPktFirAddrRdy14,

  output  wire    [`ADDR_LENTH-1:0]     oPktFirAddr15,
  output  wire                          oPktFirAddrVld15,
  output  wire    [3:0]                 oPktBlockNum15,
  output  wire                          oPktDrop15,
  input   wire                          iPktFirAddrRdy15,

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
  assign intTag[0].Vld = iPktTagVld0;
  assign intTag[0].Dst = iPktDstPort0;
  assign intTag[0].Pld = {iPktPri0, iPktFirAddr0, iPktLen0, 4'h0};
  assign oPktRdy0 = intTag[0].Rdy;

  assign intTag[1].Vld = iPktTagVld1;
  assign intTag[1].Dst = iPktDstPort1;
  assign intTag[1].Pld = {iPktPri1, iPktFirAddr1, iPktLen1, 4'h1};
  assign oPktRdy1 = intTag[1].Rdy;

  assign intTag[2].Vld = iPktTagVld2;
  assign intTag[2].Dst = iPktDstPort2;
  assign intTag[2].Pld = {iPktPri2, iPktFirAddr2, iPktLen2, 4'h2};
  assign oPktRdy2 = intTag[2].Rdy;

  assign intTag[3].Vld = iPktTagVld3;
  assign intTag[3].Dst = iPktDstPort3;
  assign intTag[3].Pld = {iPktPri3, iPktFirAddr3, iPktLen3, 4'h3};
  assign oPktRdy3 = intTag[3].Rdy;

  assign intTag[4].Vld = iPktTagVld4;
  assign intTag[4].Dst = iPktDstPort4;
  assign intTag[4].Pld = {iPktPri4, iPktFirAddr4, iPktLen4, 4'h4};
  assign oPktRdy4 = intTag[4].Rdy;

  assign intTag[5].Vld = iPktTagVld5;
  assign intTag[5].Dst = iPktDstPort5;
  assign intTag[5].Pld = {iPktPri5, iPktFirAddr5, iPktLen5, 4'h5};
  assign oPktRdy5 = intTag[5].Rdy;

  assign intTag[6].Vld = iPktTagVld6;
  assign intTag[6].Dst = iPktDstPort6;
  assign intTag[6].Pld = {iPktPri6, iPktFirAddr6, iPktLen6, 4'h6};
  assign oPktRdy6 = intTag[6].Rdy;

  assign intTag[7].Vld = iPktTagVld7;
  assign intTag[7].Dst = iPktDstPort7;
  assign intTag[7].Pld = {iPktPri7, iPktFirAddr7, iPktLen7, 4'h7};
  assign oPktRdy7 = intTag[7].Rdy;

  assign intTag[8].Vld = iPktTagVld8;
  assign intTag[8].Dst = iPktDstPort8;
  assign intTag[8].Pld = {iPktPri8, iPktFirAddr8, iPktLen8, 4'h8};
  assign oPktRdy8 = intTag[8].Rdy;

  assign intTag[9].Vld = iPktTagVld9;
  assign intTag[9].Dst = iPktDstPort9;
  assign intTag[9].Pld = {iPktPri9, iPktFirAddr9, iPktLen9, 4'h9};
  assign oPktRdy9 = intTag[9].Rdy;

  assign intTag[10].Vld = iPktTagVld10;
  assign intTag[10].Dst = iPktDstPort10;
  assign intTag[10].Pld = {iPktPri10, iPktFirAddr10, iPktLen10, 4'ha};
  assign oPktRdy10 = intTag[10].Rdy;

  assign intTag[11].Vld = iPktTagVld11;
  assign intTag[11].Dst = iPktDstPort11;
  assign intTag[11].Pld = {iPktPri11, iPktFirAddr11, iPktLen11, 4'hb};
  assign oPktRdy11 = intTag[11].Rdy;

  assign intTag[12].Vld = iPktTagVld12;
  assign intTag[12].Dst = iPktDstPort12;
  assign intTag[12].Pld = {iPktPri12, iPktFirAddr12, iPktLen12, 4'hc};
  assign oPktRdy12 = intTag[12].Rdy;

  assign intTag[13].Vld = iPktTagVld13;
  assign intTag[13].Dst = iPktDstPort13;
  assign intTag[13].Pld = {iPktPri13, iPktFirAddr13, iPktLen13, 4'hd};
  assign oPktRdy13 = intTag[13].Rdy;

  assign intTag[14].Vld = iPktTagVld14;
  assign intTag[14].Dst = iPktDstPort14;
  assign intTag[14].Pld = {iPktPri14, iPktFirAddr14, iPktLen14, 4'he};
  assign oPktRdy14 = intTag[14].Rdy;

  assign intTag[15].Vld = iPktTagVld15;
  assign intTag[15].Dst = iPktDstPort15;
  assign intTag[15].Pld = {iPktPri15, iPktFirAddr15, iPktLen15, 4'hf};
  assign oPktRdy15 = intTag[15].Rdy;


  // ===================== RDCMD ======================
  wire  [3:0]   rdCmdDstPort[16];   // no use

  assign oPktFirAddrVld0 = intRdCmd[0].Vld;
  assign intRdCmd[0].Rdy = iPktFirAddrRdy0;
  assign {oPktFirAddr0, oPktBlockNum0, rdCmdDstPort[0], oPktDrop0} = intRdCmd[0].Pld;

  assign oPktFirAddrVld1 = intRdCmd[1].Vld;
  assign intRdCmd[1].Rdy = iPktFirAddrRdy1;
  assign {oPktFirAddr1, oPktBlockNum1, rdCmdDstPort[1], oPktDrop1} = intRdCmd[1].Pld;

  assign oPktFirAddrVld2 = intRdCmd[2].Vld;
  assign intRdCmd[2].Rdy = iPktFirAddrRdy2;
  assign {oPktFirAddr2, oPktBlockNum2, rdCmdDstPort[2], oPktDrop2} = intRdCmd[2].Pld;

  assign oPktFirAddrVld3 = intRdCmd[3].Vld;
  assign intRdCmd[3].Rdy = iPktFirAddrRdy3;
  assign {oPktFirAddr3, oPktBlockNum3, rdCmdDstPort[3], oPktDrop3} = intRdCmd[3].Pld;

  assign oPktFirAddrVld4 = intRdCmd[4].Vld;
  assign intRdCmd[4].Rdy = iPktFirAddrRdy4;
  assign {oPktFirAddr4, oPktBlockNum4, rdCmdDstPort[4], oPktDrop4} = intRdCmd[4].Pld;

  assign oPktFirAddrVld5 = intRdCmd[5].Vld;
  assign intRdCmd[5].Rdy = iPktFirAddrRdy5;
  assign {oPktFirAddr5, oPktBlockNum5, rdCmdDstPort[5], oPktDrop5} = intRdCmd[5].Pld;

  assign oPktFirAddrVld6 = intRdCmd[6].Vld;
  assign intRdCmd[6].Rdy = iPktFirAddrRdy6;
  assign {oPktFirAddr6, oPktBlockNum6, rdCmdDstPort[6], oPktDrop6} = intRdCmd[6].Pld;

  assign oPktFirAddrVld7 = intRdCmd[7].Vld;
  assign intRdCmd[7].Rdy = iPktFirAddrRdy7;
  assign {oPktFirAddr7, oPktBlockNum7, rdCmdDstPort[7], oPktDrop7} = intRdCmd[7].Pld;

  assign oPktFirAddrVld8 = intRdCmd[8].Vld;
  assign intRdCmd[8].Rdy = iPktFirAddrRdy8;
  assign {oPktFirAddr8, oPktBlockNum8, rdCmdDstPort[8], oPktDrop8} = intRdCmd[8].Pld;

  assign oPktFirAddrVld9 = intRdCmd[9].Vld;
  assign intRdCmd[9].Rdy = iPktFirAddrRdy9;
  assign {oPktFirAddr9, oPktBlockNum9, rdCmdDstPort[9], oPktDrop9} = intRdCmd[9].Pld;

  assign oPktFirAddrVld10 = intRdCmd[10].Vld;
  assign intRdCmd[10].Rdy = iPktFirAddrRdy10;
  assign {oPktFirAddr10, oPktBlockNum10, rdCmdDstPort[10], oPktDrop10} = intRdCmd[10].Pld;

  assign oPktFirAddrVld11 = intRdCmd[11].Vld;
  assign intRdCmd[11].Rdy = iPktFirAddrRdy11;
  assign {oPktFirAddr11, oPktBlockNum11, rdCmdDstPort[11], oPktDrop11} = intRdCmd[11].Pld;

  assign oPktFirAddrVld12 = intRdCmd[12].Vld;
  assign intRdCmd[12].Rdy = iPktFirAddrRdy12;
  assign {oPktFirAddr12, oPktBlockNum12, rdCmdDstPort[12], oPktDrop12} = intRdCmd[12].Pld;

  assign oPktFirAddrVld13 = intRdCmd[13].Vld;
  assign intRdCmd[13].Rdy = iPktFirAddrRdy13;
  assign {oPktFirAddr13, oPktBlockNum13, rdCmdDstPort[13], oPktDrop13} = intRdCmd[13].Pld;

  assign oPktFirAddrVld14 = intRdCmd[14].Vld;
  assign intRdCmd[14].Rdy = iPktFirAddrRdy14;
  assign {oPktFirAddr14, oPktBlockNum14, rdCmdDstPort[14], oPktDrop14} = intRdCmd[14].Pld;

  assign oPktFirAddrVld15 = intRdCmd[15].Vld;
  assign intRdCmd[15].Rdy = iPktFirAddrRdy15;
  assign {oPktFirAddr15, oPktBlockNum15, rdCmdDstPort[15], oPktDrop15} = intRdCmd[15].Pld;

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