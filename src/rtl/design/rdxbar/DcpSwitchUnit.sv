/*
 * @FilePath       : /Switch/src/rtl/design/rdxbar/DcpSwitchUnit.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-08
 * @LastEditors    : wangxuanji 18364998790@163.com
 * @LastEditTime   : 24-05-18
 * Version        :
 * @Description    :    s1 -> buf -> |A|
 *                      s2 -> buf -> |R|
 *                                   |B| -> buf -> m1 
 *                      s3 -> buf -> |I|
 *                      s4 -> buf -> |T|
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
module DcpSwitchUnit#(
  parameter DW  = 16,
  parameter AW  = 2,
  parameter SNUM = 4
)(
  input   logic           iClk,
  input   logic           iRst_n,
  // 注意，这里Decoupled的Width是由外部的interface决定的，所以本模块无法单独综合
  Decoupled.slave         iDcpIn[0:SNUM-1],
  Decoupled.master        oDcpOut
);
  logic [SNUM-1:0]             arbInReqArray;          
  logic [SNUM-1:0]             arbInGntArray;      
  logic [SNUM-1:0][DW+AW-1:0]  arbInPldArray;  

  logic                       arbOutReq;          
  logic                       arbOutGnt;      
  logic [DW+AW-1:0]           arbOutPld;  
  
  genvar i;

  generate
    for(i=0; i<SNUM; i=i+1) begin : GEN_INBUF    // 生成输入buf
      gnrl_buf#(
        .DW(DW+AW),
        .CUT_RDY(1)
      ) U_INBUF(
        .clk_i      (iClk),
        .rst_n_i    (iRst_n),
        .din_i      ({iDcpIn[i].Dst, iDcpIn[i].Pld}),
        .din_vld_i  (iDcpIn[i].Vld),
        .din_rdy_o  (iDcpIn[i].Rdy),
        .dout_o     (arbInPldArray[i]),
        .dout_vld_o (arbInReqArray[i]),
        .dout_rdy_i (arbInGntArray[i])
      );
    end
  endgenerate

  // rr的arbiter，注意有未使用接口，fv潜在问题
  rr_arb_tree #(
    .NumIn(SNUM),
    .DataWidth(DW+AW),
    .AxiVldRdy(1),
    .LockIn(0)
  )U_RR_ARB(
    .rst_ni (iRst_n),
    .clk_i (iClk),

    .req_i(arbInReqArray),
    .gnt_o(arbInGntArray),
    .data_i(arbInPldArray),

    .req_o(arbOutReq),
    .gnt_i(arbOutGnt),
    .data_o(arbOutPld)
  );

  // 输出buf
  gnrl_buf#(
    .DW(DW+AW),
    .CUT_RDY(1)
  ) U_INBUF(
    .clk_i      (iClk),
    .rst_n_i    (iRst_n),
    .din_i      (arbOutPld),
    .din_vld_i  (arbOutReq),
    .din_rdy_o  (arbOutGnt),
    .dout_o     ({oDcpOut.Dst, oDcpOut.Pld}),
    .dout_vld_o (oDcpOut.Vld),
    .dout_rdy_i (oDcpOut.Rdy)
  );

endmodule
