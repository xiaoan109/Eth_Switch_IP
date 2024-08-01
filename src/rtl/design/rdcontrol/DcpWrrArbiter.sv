/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/DcpWrrArbiter.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-15
 * @LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-05-18
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
module DcpWrrArbiter #(
  parameter DW = 8,
  parameter ARB_NUM = 8,        //
  parameter WEIGHT_NUM = 8     //权重个数
) (
  input   logic                         iClk,
  input   logic                         iRst_n,

  Decoupled.slave                       iDcpIn[0:ARB_NUM-1],
  Decoupled.master                      oDcpOut,

  input   logic [$clog2(WEIGHT_NUM):0]  iWeight[ARB_NUM],
  input   logic                         iWeightLoad
);
  logic  [ARB_NUM-1:0]          iReq;
  logic  [ARB_NUM-1:0]          oGnt;
  logic  [ARB_NUM-1:0][DW-1:0]  iData;

  logic                         oReq;
  logic                         iGnt;
  logic   [DW-1:0]              oData;

  genvar i;
  generate
    for(i=0; i<ARB_NUM; i=i+1) begin
      assign iReq[i] = iDcpIn[i].Vld;
      assign iData[i] = {iDcpIn[i].Pld};
      assign iDcpIn[i].Rdy = oGnt[i];
    end
  endgenerate

  assign oDcpOut.Vld = oReq;
  assign oDcpOut.Pld = oData;
  assign iGnt = oDcpOut.Rdy;

WrrArbiter #(
  .DW(DW),
  .ARB_NUM(ARB_NUM),
  .WEIGHT_NUM(WEIGHT_NUM)
) U_WRRARBITER(
  .iRst_n       (iRst_n),
  .iClk         (iClk),
  .iReq         (iReq),
  .oGnt         (oGnt),
  .iData        (iData),
  .oReq         (oReq),
  .iGnt         (iGnt),
  .oData        (oData),
  .iWeightLoad  (iWeightLoad),
  .iWeight      (iWeight)
);

endmodule