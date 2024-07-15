`include "define.v"
module DcpRdData16x16 #(
) (
  input   logic     iClk,
  input   logic     iRst_n,

  Decoupled.slave     iRdDataIn[0:15],
  Decoupled.master    oRdDataOut[0:15]
);
  
  localparam CRSBAR_WIDTH = `DATA_WIDTH+1;
`ifdef RDDATA_CRSBAR_SHARE_MODE 

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) switchOut[4]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) routeIn[4]();

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) rdDataIn[16]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) rdDataOut[16]();

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
        .iDcpIn   (rdDataIn[4*i+:4]),
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
        .oDcpOut  (rdDataOut[i*4+:4])
      );
    end
  endgenerate

  generate
    for(i=0; i<16; i=i+1) begin : GENCON
      assign rdDataOut[i].Rdy = oRdDataOut[i].Rdy;
      assign oRdDataOut[i].Pld = rdDataOut[i].Pld;
      assign oRdDataOut[i].Vld = rdDataOut[i].Vld;
      assign oRdDataOut[i].Dst = rdDataOut[i].Dst;

      assign iRdDataIn[i].Rdy = rdDataIn[i].Rdy;
      assign rdDataIn[i].Pld = iRdDataIn[i].Pld;
      assign rdDataIn[i].Vld = iRdDataIn[i].Vld;
      assign rdDataIn[i].Dst = iRdDataIn[i].Dst;
    end
  endgenerate
`else
  DcpCrossbarNxN #(
    .DW (CRSBAR_WIDTH),
    .AW (4),
    .N  (16)
  ) U_CRSBAR(
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .iDcpIn   (iRdDataIn),
    .oDcpOut  (oRdDataOut)
  );
`endif 
  
endmodule