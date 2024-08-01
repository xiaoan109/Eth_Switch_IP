/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/RdCtrlTop16Ch.sv
 * @Author         : zhouziheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-16
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
module RdCtrlTop16Ch#(
  parameter PRI_DEPTH = 8,            // 优先级队列深度
  // DO NOT OVERWRITE !!!!
  parameter PRI_NUM = 8,              // 优先级个数
  parameter WRR_WEIGHT_NUM = 8        // WRR最大权重数
) (
  input   logic                             iClk,
  input   logic                             iRst_n,

  Decoupled.slave                           iTagIn[0:15],
  Decoupled.master                          oRdCmd[0:15],     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4)) 
  //{Msg, Drop}}
  Decoupled.slave                           iRdData[0:15],    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

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

  logic [15:0]  weightLoadArray;

  generate
    for(i=0; i<16; i=i+1) begin
      assign weightLoadArray[i] = iWeightIdx == i ? iWeightLoad : 1'b0;
      RdCtrlTop1Ch #(
        .PORT_ADDR(i),
        .PRI_DEPTH(PRI_DEPTH),            // 优先级队列深度
        .WRR_WEIGHT_NUM(WRR_WEIGHT_NUM)        // WRR最大权重数
      )U_RD_CHN(
        .iClk         (iClk),
        .iRst_n       (iRst_n),

        .iTagIn       (iTagIn[i]),
        .oRdCmd       (oRdCmd[i]),     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4)) 

        .iRdData      (iRdData[i]),    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

        .oRdSop       (oRdSop[i]),
        .oRdEop       (oRdEop[i]),
        .oRdVld       (oRdVld[i]),
        .oRdData      (oRdData[i]),
        .iRdRdy       (iRdRdy[i]),
        .oRdLast      (oRdLast[i]),

        .iWeight      (iWeightPld),
        .iWeightLoad  (weightLoadArray[i])
      );
    end
  endgenerate
  
endmodule