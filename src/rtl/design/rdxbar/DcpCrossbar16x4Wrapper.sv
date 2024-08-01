// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/rdxbar/DcpCrossbar16x4Wrapper.v
// Author         : zhouziheng ziheng.zhou.1999@qq.com
// CreateDate     : 24-07-23
// LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
// LastEditTime   : 24-07-23
// Version        :
// Description    : 
//                  
// 
// Parameter       :
//                  
// 
// IO Port         :
//                  
// 
// Modification History
//    Date   |   Author   |   Version   |   Change Description
// ==============================================================================
//  23-08-24 |     CICC2060    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module DcpCrossbar16x4Wrapper (
  input   wire            iClk        ,
  input   wire            iRst_n      ,

  input   wire  [33:0]    iFifoCrcMsg0,
  input   wire            iFifoCrcVld0,
  output  wire            oFifoCrcRdy0,

  input   wire  [33:0]    iFifoCrcMsg1,
  input   wire            iFifoCrcVld1,
  output  wire            oFifoCrcRdy1,

  input   wire  [33:0]    iFifoCrcMsg2,
  input   wire            iFifoCrcVld2,
  output  wire            oFifoCrcRdy2,

  input   wire  [33:0]    iFifoCrcMsg3,
  input   wire            iFifoCrcVld3,
  output  wire            oFifoCrcRdy3,

  input   wire  [33:0]    iFifoCrcMsg4,
  input   wire            iFifoCrcVld4,
  output  wire            oFifoCrcRdy4,

  input   wire  [33:0]    iFifoCrcMsg5,
  input   wire            iFifoCrcVld5,
  output  wire            oFifoCrcRdy5,

  input   wire  [33:0]    iFifoCrcMsg6,
  input   wire            iFifoCrcVld6,
  output  wire            oFifoCrcRdy6,

  input   wire  [33:0]    iFifoCrcMsg7,
  input   wire            iFifoCrcVld7,
  output  wire            oFifoCrcRdy7,

  input   wire  [33:0]    iFifoCrcMsg8,
  input   wire            iFifoCrcVld8,
  output  wire            oFifoCrcRdy8,

  input   wire  [33:0]    iFifoCrcMsg9,
  input   wire            iFifoCrcVld9,
  output  wire            oFifoCrcRdy9,

  input   wire  [33:0]    iFifoCrcMsg10,
  input   wire            iFifoCrcVld10,
  output  wire            oFifoCrcRdy10,

  input   wire  [33:0]    iFifoCrcMsg11,
  input   wire            iFifoCrcVld11,
  output  wire            oFifoCrcRdy11,

  input   wire  [33:0]    iFifoCrcMsg12,
  input   wire            iFifoCrcVld12,
  output  wire            oFifoCrcRdy12,

  input   wire  [33:0]    iFifoCrcMsg13,
  input   wire            iFifoCrcVld13,
  output  wire            oFifoCrcRdy13,

  input   wire  [33:0]    iFifoCrcMsg14,
  input   wire            iFifoCrcVld14,
  output  wire            oFifoCrcRdy14,

  input   wire  [33:0]    iFifoCrcMsg15,
  input   wire            iFifoCrcVld15,
  output  wire            oFifoCrcRdy15,

  output  wire  [33:0]    oInterMsg0,
  output  wire            oInterVld0,
  input   wire            iInterRdy0,

  output  wire  [33:0]    oInterMsg1,
  output  wire            oInterVld1,
  input   wire            iInterRdy1,

  output  wire  [33:0]    oInterMsg2,
  output  wire            oInterVld2,
  input   wire            iInterRdy2,

  output  wire  [33:0]    oInterMsg3,
  output  wire            oInterVld3,
  input   wire            iInterRdy3
);
  localparam CRSBAR_WIDTH = `DATA_WIDTH+1;
  
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) dcpIn[16]();
  Decoupled#(.DW(CRSBAR_WIDTH), .AW(4)) dcpOut[4]();

  assign dcpIn[0].Pld[31:0] = iFifoCrcMsg0[33:2];
  assign dcpIn[0].Pld[32]   = iFifoCrcMsg0[1]   ;
  assign dcpIn[0].Vld       = iFifoCrcVld0      ;
  assign dcpIn[0].Dst       = 4'b0000           ;
  assign oFifoCrcRdy0       = dcpIn[0].Rdy      ;

  assign dcpIn[1].Pld[31:0] = iFifoCrcMsg1[33:2];
  assign dcpIn[1].Pld[32]   = iFifoCrcMsg1[1]   ;
  assign dcpIn[1].Vld       = iFifoCrcVld1      ;
  assign dcpIn[1].Dst       = 4'b0000           ;
  assign oFifoCrcRdy1       = dcpIn[1].Rdy      ;

  assign dcpIn[2].Pld[31:0] = iFifoCrcMsg2[33:2];
  assign dcpIn[2].Pld[32]   = iFifoCrcMsg2[1]   ;
  assign dcpIn[2].Vld       = iFifoCrcVld2      ;
  assign dcpIn[2].Dst       = 4'b0000           ;
  assign oFifoCrcRdy2       = dcpIn[2].Rdy      ;

  assign dcpIn[3].Pld[31:0] = iFifoCrcMsg3[33:2];
  assign dcpIn[3].Pld[32]   = iFifoCrcMsg3[1]   ;
  assign dcpIn[3].Vld       = iFifoCrcVld3      ;
  assign dcpIn[3].Dst       = 4'b0000           ;
  assign oFifoCrcRdy3       = dcpIn[3].Rdy      ;

  assign dcpIn[4].Pld[31:0] = iFifoCrcMsg4[33:2];
  assign dcpIn[4].Pld[32]   = iFifoCrcMsg4[1]   ;
  assign dcpIn[4].Vld       = iFifoCrcVld4      ;
  assign dcpIn[4].Dst       = 4'b0100           ;
  assign oFifoCrcRdy4       = dcpIn[4].Rdy      ;

  assign dcpIn[5].Pld[31:0] = iFifoCrcMsg5[33:2];
  assign dcpIn[5].Pld[32]   = iFifoCrcMsg5[1]   ;
  assign dcpIn[5].Vld       = iFifoCrcVld5      ;
  assign dcpIn[5].Dst       = 4'b0100           ;
  assign oFifoCrcRdy5       = dcpIn[5].Rdy      ;

  assign dcpIn[6].Pld[31:0] = iFifoCrcMsg6[33:2];
  assign dcpIn[6].Pld[32]   = iFifoCrcMsg6[1]   ;
  assign dcpIn[6].Vld       = iFifoCrcVld6      ;
  assign dcpIn[6].Dst       = 4'b0100           ;
  assign oFifoCrcRdy6       = dcpIn[6].Rdy      ;

  assign dcpIn[7].Pld[31:0] = iFifoCrcMsg7[33:2];
  assign dcpIn[7].Pld[32]   = iFifoCrcMsg7[1]   ;
  assign dcpIn[7].Vld       = iFifoCrcVld7      ;
  assign dcpIn[7].Dst       = 4'b0100           ;
  assign oFifoCrcRdy7       = dcpIn[7].Rdy      ;

  assign dcpIn[8].Pld[31:0] = iFifoCrcMsg8[33:2];
  assign dcpIn[8].Pld[32]   = iFifoCrcMsg8[1]   ;
  assign dcpIn[8].Vld       = iFifoCrcVld8      ;
  assign dcpIn[8].Dst       = 4'b1000           ;
  assign oFifoCrcRdy8       = dcpIn[8].Rdy      ;

  assign dcpIn[9].Pld[31:0] = iFifoCrcMsg9[33:2];
  assign dcpIn[9].Pld[32]   = iFifoCrcMsg9[1]   ;
  assign dcpIn[9].Vld       = iFifoCrcVld9      ;
  assign dcpIn[9].Dst       = 4'b1000           ;
  assign oFifoCrcRdy9       = dcpIn[9].Rdy      ;

  assign dcpIn[10].Pld[31:0] = iFifoCrcMsg10[33:2];
  assign dcpIn[10].Pld[32]   = iFifoCrcMsg10[1]   ;
  assign dcpIn[10].Vld       = iFifoCrcVld10      ;
  assign dcpIn[10].Dst       = 4'b1000           ;
  assign oFifoCrcRdy10       = dcpIn[10].Rdy      ;

  assign dcpIn[11].Pld[31:0] = iFifoCrcMsg11[33:2];
  assign dcpIn[11].Pld[32]   = iFifoCrcMsg11[1]   ;
  assign dcpIn[11].Vld       = iFifoCrcVld11      ;
  assign dcpIn[11].Dst       = 4'b1000           ;
  assign oFifoCrcRdy11       = dcpIn[11].Rdy      ;

  assign dcpIn[12].Pld[31:0] = iFifoCrcMsg12[33:2];
  assign dcpIn[12].Pld[32]   = iFifoCrcMsg12[1]   ;
  assign dcpIn[12].Vld       = iFifoCrcVld12      ;
  assign dcpIn[12].Dst       = 4'b1100           ;
  assign oFifoCrcRdy12       = dcpIn[12].Rdy      ;

  assign dcpIn[13].Pld[31:0] = iFifoCrcMsg13[33:2];
  assign dcpIn[13].Pld[32]   = iFifoCrcMsg13[1]   ;
  assign dcpIn[13].Vld       = iFifoCrcVld13      ;
  assign dcpIn[13].Dst       = 4'b1100           ;
  assign oFifoCrcRdy13       = dcpIn[13].Rdy      ;

  assign dcpIn[14].Pld[31:0] = iFifoCrcMsg14[33:2];
  assign dcpIn[14].Pld[32]   = iFifoCrcMsg14[1]   ;
  assign dcpIn[14].Vld       = iFifoCrcVld14      ;
  assign dcpIn[14].Dst       = 4'b1100           ;
  assign oFifoCrcRdy14       = dcpIn[14].Rdy      ;

  assign dcpIn[15].Pld[31:0] = iFifoCrcMsg15[33:2];
  assign dcpIn[15].Pld[32]   = iFifoCrcMsg15[1]   ;
  assign dcpIn[15].Vld       = iFifoCrcVld15      ;
  assign dcpIn[15].Dst       = 4'b1100           ;
  assign oFifoCrcRdy15       = dcpIn[15].Rdy      ;


  assign oInterMsg0     = dcpOut[0].Pld ;
  assign oInterVld0     = dcpOut[0].Vld ;
  assign dcpOut[0].Rdy  = iInterRdy0    ;

  assign oInterMsg1     = dcpOut[1].Pld ;
  assign oInterVld1     = dcpOut[1].Vld ;
  assign dcpOut[1].Rdy  = iInterRdy1    ;

  assign oInterMsg2     = dcpOut[2].Pld ;
  assign oInterVld2     = dcpOut[2].Vld ;
  assign dcpOut[2].Rdy  = iInterRdy2    ;

  assign oInterMsg3     = dcpOut[3].Pld ;
  assign oInterVld3     = dcpOut[3].Vld ;
  assign dcpOut[3].Rdy  = iInterRdy3    ;

  DcpCrossbar16x4 U_DCPCRSBAR_16X4(
    .iClk           (iClk),
    .iRst_n         (iRst_n),

    .iRdDataIn      (dcpIn),
    .oRdDataOut     (dcpOut)
  );

endmodule