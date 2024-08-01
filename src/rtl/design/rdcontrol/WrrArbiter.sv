/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/WrrArbiter.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-15
 * @LastEditors    : ZhouZiheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-05-15
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
module WrrArbiter #(
  parameter DW = 8,
  parameter ARB_NUM = 8,        //
  parameter WEIGHT_NUM = 8     //权重个数
)(
  input   logic                         iClk,
  input   logic                         iRst_n,

  input   logic  [ARB_NUM-1:0]          iReq,
  output  logic  [ARB_NUM-1:0]          oGnt,
  input   logic  [ARB_NUM-1:0][DW-1:0]  iData,

  output  logic                         oReq,
  input   logic                         iGnt,
  output  logic   [DW-1:0]              oData,

  input   logic [$clog2(WEIGHT_NUM):0]  iWeight[ARB_NUM],
  input   logic                         iWeightLoad
);
  logic  [ARB_NUM-1:0]          gatedReq;
  logic  [ARB_NUM-1:0]          gatedGnt;

  WrrWeightGate #(
    .ARB_NUM(ARB_NUM),
    .WEIGHT_NUM(WEIGHT_NUM)
  ) U_WrrWeightGate(
    .iRst_n (iRst_n),
    .iClk (iClk),
    .iReq (iReq),
    .oGnt (oGnt),
    .oReq (gatedReq),
    .iGnt (gatedGnt),
    .iWeightLoad (iWeightLoad),
    .iWeight (iWeight)
  );

  rr_arb_tree #(
    .NumIn(ARB_NUM),
    .DataWidth(DW),
    .AxiVldRdy(1),
    .LockIn(0)
  )U_RR_ARB(
    .rst_ni (iRst_n),
    .clk_i (iClk),

    .req_i(gatedReq),
    .gnt_o(gatedGnt),
    .data_i(iData),

    .req_o(oReq),
    .gnt_i(iGnt),
    .data_o(oData)
  );
  
endmodule