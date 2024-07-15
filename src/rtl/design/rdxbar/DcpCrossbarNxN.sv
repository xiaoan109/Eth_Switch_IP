/*
 * @FilePath       : /Switch/src/rtl/design/rdxbar/DcpCrossbarNxN.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-14
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
 *  23-08-24 |     NJU    |     0.1     | Original Version
 *                  
 * 
 */
`include "define.v"
module DcpCrossbarNxN #(
  parameter DW  = 16,
  parameter AW  = 4,
  parameter N   = 4
)(
  input   logic           iClk,
  input   logic           iRst_n,
  Decoupled.slave         iDcpIn[0:N-1],
  Decoupled.master        oDcpOut[0:N-1]
);
  initial begin
    if($clog2(N)>AW) begin
      $fatal("ERROR: AW is not enough to address all the output ports");
    end
  end

  Decoupled#(.DW(DW), .AW(AW)) xbarCon[N*N]();    // crossbar连接矩阵
  Decoupled#(.DW(DW), .AW(AW)) xbarConT[N*N]();   // 矩阵转置

  genvar i;
  genvar j;
  generate
    for(i=0; i<N; i=i+1) begin : GEN_XBAR_CON_TRANS_ROW
      for(j=0; j<N; j=j+1) begin : GEN_XBAR_CON_TRANS_COL
        // 如果这里是chisel或者spinal，我就能用foreach直接遍历每个成员，不用显示写出所有成员
        // 只能说sv不太行
        // 我甚至不能为decouple写一个函数来执行赋值，因为function不接受interface做参数，令人遗憾
        assign xbarConT[i*N+j].Vld = xbarCon[j*N+i].Vld;
        assign xbarConT[i*N+j].Pld = xbarCon[j*N+i].Pld;
        assign xbarConT[i*N+j].Dst = xbarCon[j*N+i].Dst;
        assign xbarCon[j*N+i].Rdy = xbarConT[i*N+j].Rdy;
      end
    end
  endgenerate

  generate
    for(i=0; i<N; i=i+1) begin : GEN_CON
      DcpRouteUnit#(
        .DW (DW),
        .AW (AW),
        .RNUM (N)
      )U_ROUTEUNIT(
        .iClk   (iClk),
        .iRst_n (iRst_n),
        .iDcpIn  (iDcpIn[i]),   
        .oDcpOut  (xbarCon[N*i+:N])
      );
      DcpSwitchUnit#(
        .DW (DW),
        .AW (AW),
        .SNUM (N)
      )U_SWITCHUNIT(
        .iClk   (iClk),
        .iRst_n (iRst_n),
        .iDcpIn  (xbarConT[N*i+:N]),   
        .oDcpOut  (oDcpOut[i])
      );
    end
  endgenerate

endmodule