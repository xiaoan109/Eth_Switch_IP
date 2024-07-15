/*
 * @FilePath       : /Switch/src/rtl/design/rdxbar/DcpTag16x16.sv
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
module DcpTag16x16 #(
) (
  input   logic     iClk,
  input   logic     iRst_n,

  Decoupled.slave     iTagIn[0:15],
  Decoupled.master    oTagOut[0:15]
);
  localparam CRSBAR_N = 4;
  localparam CRSBAR_WIDTH = `ADDR_LENTH+11;

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) switchOut[4]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) routeIn[4]();

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) tagIn[16]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) tagOut[16]();

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
        .iDcpIn   (tagIn[4*i+:4]),
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
        .oDcpOut  (tagOut[4*i+:4])
      );
    end
  endgenerate

  generate
    for(i=0; i<16; i=i+1) begin : GENCON
      assign tagOut[i].Rdy = oTagOut[i].Rdy;
      assign oTagOut[i].Pld = tagOut[i].Pld;
      assign oTagOut[i].Vld = tagOut[i].Vld;
      assign oTagOut[i].Dst = tagOut[i].Dst;

      assign iTagIn[i].Rdy = tagIn[i].Rdy;
      assign tagIn[i].Pld = iTagIn[i].Pld;
      assign tagIn[i].Vld = iTagIn[i].Vld;
      assign tagIn[i].Dst = iTagIn[i].Dst;
    end
  endgenerate
endmodule