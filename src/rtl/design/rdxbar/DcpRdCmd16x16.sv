/*
 * @FilePath       : /Switch/src/rtl/design/rdxbar/DcpRdCmd16x16.sv
 * @Author         : zhouziheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-16
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
module DcpRdCmd16x16 #(
) (
  input   logic     iClk,
  input   logic     iRst_n,

  Decoupled.slave     iRdCmdIn[0:15],
  Decoupled.master    oRdCmdOut[0:15]
);
  localparam CRSBAR_N = 4;
  localparam CRSBAR_WIDTH = `ADDR_LENTH+9;

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) switchOut[4]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) routeIn[4]();

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) rdCmdIn[16]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) rdCmdOut[16]();

  genvar i;

  generate
    for(i=0; i<4; i=i+1) begin : GEN_INPUT_SWITCH
      DcpSwitchUnit #(
        .DW   (CRSBAR_WIDTH),
        .AW   (4),
        .SNUM (4)
      ) U_INPUT_SWITCH (
        .iClk      (iClk),
        .iRst_n    (iRst_n),
        .iDcpIn   (rdCmdIn[4*i+:4]),
        .oDcpOut  (switchOut[i])
      );
    end 
  endgenerate

  DcpCrossbarNxN #(
    .DW (CRSBAR_WIDTH),
    .AW (4),
    .N  (4)
  ) U_CRSBAR(
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .iDcpIn   (switchOut),
    .oDcpOut  (routeIn)
  );

  generate
    for(i=0; i<4; i=i+1) begin : GEN_OUTPUT_ROUTE
      DcpRouteUnit #(
        .DW   (CRSBAR_WIDTH),
        //.AW   (4),
        .AW   (2),    // FIRST STAGE INDEX IS COMPLETED BY CRSBAR
        .RNUM (4)
      ) U_OUTPUT_ROUTE (
        .iClk      (iClk),
        .iRst_n    (iRst_n),
        .iDcpIn   (routeIn[i]),
        .oDcpOut  (rdCmdOut[i*4+:4])
      );
    end
  endgenerate

  generate
    for(i=0; i<16; i=i+1) begin : GENCON
      assign rdCmdOut[i].Rdy = oRdCmdOut[i].Rdy;
      assign oRdCmdOut[i].Pld = rdCmdOut[i].Pld;
      assign oRdCmdOut[i].Vld = rdCmdOut[i].Vld;
      assign oRdCmdOut[i].Dst = rdCmdOut[i].Dst;

      assign iRdCmdIn[i].Rdy = rdCmdIn[i].Rdy;
      assign rdCmdIn[i].Pld = iRdCmdIn[i].Pld;
      assign rdCmdIn[i].Vld = iRdCmdIn[i].Vld;
      assign rdCmdIn[i].Dst = iRdCmdIn[i].Dst;
    end
  endgenerate

endmodule