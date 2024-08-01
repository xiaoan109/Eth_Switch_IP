`include "define.v"
module DcpCrossbar16x4 #(
) (
  input   logic     iClk,
  input   logic     iRst_n,

  Decoupled.slave     iRdDataIn[0:15],
  Decoupled.master    oRdDataOut[0:3]
);
  
  localparam CRSBAR_WIDTH = `DATA_WIDTH+1;

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) switchOut[4]();

  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) rdDataIn[16]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) rdDataOut[4]();

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
    .oDcpOut  (rdDataOut)
  );
  
  generate
    for(i=0; i<4; i=i+1) begin : GENCON
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
  
endmodule