`include "define.v"
module RdScheTop #(
  parameter PRI_DEPTH = 8,            // 优先级队列深度
  parameter WRR_WEIGHT_NUM = 8,        // WRR最大权重数
  // DO NOT OVERWRITE
  parameter PRI_NUM = 8
) (
  input   logic                             iClk,
  input   logic                             iRst_n,

  Decoupled.slave                           iTagIn[0:15],
  Decoupled.slave                           iRdDataIn[0:15],
  Decoupled.master                          oRdCmdOut[0:15],

  output  logic                             oRdSop[16],
  output  logic                             oRdEop[16],
  output  logic                             oRdVld[16],
  output  logic [`DATA_WIDTH-1:0]           oRdData[16],
  input   logic                             iRdRdy[16],
  output  logic                             oRdLast[16],

  input   logic [$clog2(WRR_WEIGHT_NUM):0]  iWeightPld[PRI_NUM],
  input   logic [3:0]                       iWeightIdx,
  input   logic                             iWeightLoad  
); 
  genvar i;

  localparam TAG_WIDTH = `ADDR_LENTH+11;
  localparam RDCMD_WIDTH = `ADDR_LENTH+9;
  localparam RDDATA_WIDTH = `DATA_WIDTH+1;

  Decoupled#(.DW(TAG_WIDTH), .AW(4))    tagCrsbarOut[16]();

  Decoupled#(.DW(RDCMD_WIDTH), .AW(4))  rdcmdCrsbarIn[16]();
  Decoupled#(.DW(RDCMD_WIDTH), .AW(4))  rdcmdCrsbarOut[16]();

  Decoupled#(.DW(RDDATA_WIDTH), .AW(4)) rddataCrsbarIn[16]();
  Decoupled#(.DW(RDDATA_WIDTH), .AW(4)) rddataCrsbarOut[16]();

  generate
    for(i=0; i<16; i=i+1) begin : GEN_RDDST_LOCK
      RdDstLock U_RDDST_LOCK(
        .iClk         (iClk),
        .iRst_n       (iRst_n),
        .iRdCmdIn     (rdcmdCrsbarOut[i]),
        .oRdCmdOut    (oRdCmdOut[i]),
        .iRdDataIn    (iRdDataIn[i]),
        .oRdDataOut   (rddataCrsbarIn[i])
      );      
      // assign rdcmdCrsbarOut[i].Rdy = oRdCmdOut[i].Rdy;
      // assign oRdCmdOut[i].Vld      = rdcmdCrsbarOut[i].Vld;
      // assign oRdCmdOut[i].Pld      = rdcmdCrsbarOut[i].Pld;
      // assign oRdCmdOut[i].Dst      = rdcmdCrsbarOut[i].Dst;
    end
  endgenerate


  DcpTag16x16 U_TAG_CRSBAR(
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iTagIn(iTagIn),
    .oTagOut(tagCrsbarOut)
  );

  DcpRdData16x16 U_RDDATA_CRSBAR(
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iRdDataIn(rddataCrsbarIn),
    .oRdDataOut(rddataCrsbarOut)
  );

  DcpRdCmd16x16 U_RDCMD_CRSBAR(
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iRdCmdIn(rdcmdCrsbarIn),
    .oRdCmdOut(rdcmdCrsbarOut)
  );


  RdCtrlTop16Ch#(
    .PRI_DEPTH       (PRI_DEPTH     ),            // 优先级队列深度
    .WRR_WEIGHT_NUM  (WRR_WEIGHT_NUM)        // WRR最大权重数
  ) U_RDCTRLTOP16(
    .iClk   (iClk),
    .iRst_n (iRst_n),

    .iTagIn   (tagCrsbarOut),
    .oRdCmd   (rdcmdCrsbarIn),     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4)) 
    //{Msg, Drop}}
    .iRdData  (rddataCrsbarOut),    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

    .oRdSop       (oRdSop ),
    .oRdEop       (oRdEop ),
    .oRdVld       (oRdVld ),
    .oRdData      (oRdData),
    .iRdRdy       (iRdRdy ),
    .oRdLast      (oRdLast),

    .iWeightPld   (iWeightPld ),
    .iWeightIdx   (iWeightIdx ),
    .iWeightLoad  (iWeightLoad)  
  );

endmodule