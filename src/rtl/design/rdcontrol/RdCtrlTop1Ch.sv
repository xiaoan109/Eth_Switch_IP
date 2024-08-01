/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/RdCtrlTop1Ch.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-15
 * @LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-05-17
 * Version        :
 * @Description    : 
 *                  
 * 
 * Parameter       :
 *                  
 * 
 * IO Port         :
 *                  
 * 
 * Modification History
 *    Date   |   Author   |   Version   |   Change Description
 * ==============================================================================
 *  23-08-24 |     CICC2060    |     0.1     | Original Version
 *                  
 * 
 */
 `include "define.v"
module RdCtrlTop1Ch #(
  parameter PORT_ADDR = 0,
  parameter PRI_DEPTH = 8,            // 优先级队列深度
  // DO NOT OVERWRITE !!!!
  parameter PRI_NUM = 8,              // 优先级个数
  parameter WRR_WEIGHT_NUM = 8        // WRR最大权重数

)(
  input   logic                             iClk,
  input   logic                             iRst_n,

  Decoupled.slave                           iTagIn,
  Decoupled.master                          oRdCmd,     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4)) 
  //{Msg, Drop}}
  Decoupled.slave                           iRdData,    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

  output  logic                             oRdSop,
  output  logic                             oRdEop,
  output  logic                             oRdVld,
  output  logic [`DATA_WIDTH-1:0]           oRdData,
  input   logic                             iRdRdy,
  output  logic                             oRdLast,

  input   logic [$clog2(WRR_WEIGHT_NUM):0]  iWeight[PRI_NUM],
  input   logic                             iWeightLoad  
);

  localparam TAG_QUEUE_WIDTH = `ADDR_LENTH+8;

  Decoupled#(.DW(TAG_QUEUE_WIDTH), .AW(1)) tagQueueIn[PRI_NUM]();
  Decoupled#(.DW(TAG_QUEUE_WIDTH), .AW(1)) tagQueueOut[PRI_NUM]();
  Decoupled#(.DW(TAG_QUEUE_WIDTH), .AW(1)) tagDrop();
  Decoupled#(.DW(TAG_QUEUE_WIDTH), .AW(1)) tagQueue();

  TagRx U_TAGRX(
    .iClk         (iClk),
    .iRst_n       (iRst_n),
    .iTagIn       (iTagIn),
    .oTagQueueOut (tagQueueIn),     // 进入优先级队列
    .oTagDropOut  (tagDrop)       // 丢包
  );

  genvar i;
  generate
    for(i=0; i<PRI_NUM; i=i+1) begin : GEN_PRI_FIFO
      DcpFifo #(
        .DATA_WIDTH(TAG_QUEUE_WIDTH),
        .DEPTH(PRI_DEPTH)
      ) U_PRIFIFO (
        .iClk       (iClk),
        .iRst_n     (iRst_n),
        .iDcpIn     (tagQueueIn[i]),
        .oDcpOut    (tagQueueOut[i]),
        .oUsage     (),
        .iTestmode  (1'b0),
        .iFlush     (1'b0)
      );  
    end
  endgenerate

  DcpWrrArbiter #(
    .DW         (TAG_QUEUE_WIDTH),
    .WEIGHT_NUM (WRR_WEIGHT_NUM),
    .ARB_NUM    (PRI_NUM)
  ) U_DCP_WRR_ARBITER (
    .iClk         (iClk),
    .iRst_n       (iRst_n),
    .iDcpIn       (tagQueueOut),
    .oDcpOut      (tagQueue),
    .iWeightLoad  (iWeightLoad),
    .iWeight      (iWeight)
  );

  PortCtrl #(
    .PORT_ADDR(PORT_ADDR)
  )U_PORT_CTRL(
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    
    .iTagQueueIn    (tagQueue),       // Decoupled#(.DW(`ADDR_LENTH+8), .AW(0))
    .iTagDropIn     (tagDrop),        // Decoupled#(.DW(`ADDR_LENTH+8), .AW(0))

    .oRdCmd         (oRdCmd),     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4)) 

    .iRdData        (iRdData),    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

    .oRdSop         (oRdSop),
    .oRdEop         (oRdEop),
    .oRdVld         (oRdVld),
    .oRdData        (oRdData),
    .iRdRdy         (iRdRdy),
    .oRdLast        (oRdLast)
  );

  
endmodule