// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/CRC/Crc.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-15
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-13
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
//  2024-4-15 |  liuyanlong |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
// CRC module for data[31:0] ,   crc[15:0]=1+x^2+x^15+x^16;
//-----------------------------------------------------------------------------
module Crc (
  input  [31:0] iData,
  input         iCrcEn,
  input         iCrcClr,
  output [15:0] oCrc,
  input         iRst_n,
  input         iClk
);

  reg [15:0] rLfsrCur, rLfsrNxt;

  assign oCrc = rLfsrCur;

  always @(*) begin
    rLfsrNxt[0]  = rLfsrCur[0]  ^ rLfsrCur[1]  ^ rLfsrCur[2] ^ rLfsrCur[3] ^ rLfsrCur[4] ^ rLfsrCur[5] ^ rLfsrCur[6] ^ rLfsrCur[7] ^ rLfsrCur[8] ^ rLfsrCur[9] ^ rLfsrCur[10] ^ rLfsrCur[11] ^ rLfsrCur[14] ^ rLfsrCur[15] ^ iData[0] ^ iData[1] ^ iData[2] ^ iData[3] ^ iData[4] ^ iData[5] ^ iData[6] ^ iData[7] ^ iData[8] ^ iData[9] ^ iData[10] ^ iData[11] ^ iData[12] ^ iData[13] ^ iData[15] ^ iData[16] ^ iData[17] ^ iData[18] ^ iData[19] ^ iData[20] ^ iData[21] ^ iData[22] ^ iData[23] ^ iData[24] ^ iData[25] ^ iData[26] ^ iData[27] ^ iData[30] ^ iData[31];
    rLfsrNxt[1]  = rLfsrCur[0]  ^ rLfsrCur[1]  ^ rLfsrCur[2] ^ rLfsrCur[3] ^ rLfsrCur[4] ^ rLfsrCur[5] ^ rLfsrCur[6] ^ rLfsrCur[7] ^ rLfsrCur[8] ^ rLfsrCur[9] ^ rLfsrCur[10] ^ rLfsrCur[11] ^ rLfsrCur[12] ^ rLfsrCur[15] ^ iData[1] ^ iData[2] ^ iData[3] ^ iData[4] ^ iData[5] ^ iData[6] ^ iData[7] ^ iData[8] ^ iData[9] ^ iData[10] ^ iData[11] ^ iData[12] ^ iData[13] ^ iData[14] ^ iData[16] ^ iData[17] ^ iData[18] ^ iData[19] ^ iData[20] ^ iData[21] ^ iData[22] ^ iData[23] ^ iData[24] ^ iData[25] ^ iData[26] ^ iData[27] ^ iData[28] ^ iData[31];
    rLfsrNxt[2]  = rLfsrCur[0]  ^ rLfsrCur[12] ^ rLfsrCur[13] ^ rLfsrCur[14] ^ rLfsrCur[15] ^ iData[0] ^ iData[1] ^ iData[14] ^ iData[16] ^ iData[28] ^ iData[29] ^ iData[30] ^ iData[31];
    rLfsrNxt[3]  = rLfsrCur[1]  ^ rLfsrCur[13] ^ rLfsrCur[14] ^ rLfsrCur[15] ^ iData[1] ^ iData[2] ^ iData[15] ^ iData[17] ^ iData[29] ^ iData[30] ^ iData[31];
    rLfsrNxt[4]  = rLfsrCur[0]  ^ rLfsrCur[2]  ^ rLfsrCur[14] ^ rLfsrCur[15] ^ iData[2] ^ iData[3] ^ iData[16] ^ iData[18] ^ iData[30] ^ iData[31];
    rLfsrNxt[5]  = rLfsrCur[1]  ^ rLfsrCur[3]  ^ rLfsrCur[15] ^ iData[3] ^ iData[4] ^ iData[17] ^ iData[19] ^ iData[31];
    rLfsrNxt[6] = rLfsrCur[2] ^ rLfsrCur[4] ^ iData[4] ^ iData[5] ^ iData[18] ^ iData[20];
    rLfsrNxt[7] = rLfsrCur[3] ^ rLfsrCur[5] ^ iData[5] ^ iData[6] ^ iData[19] ^ iData[21];
    rLfsrNxt[8] = rLfsrCur[4] ^ rLfsrCur[6] ^ iData[6] ^ iData[7] ^ iData[20] ^ iData[22];
    rLfsrNxt[9] = rLfsrCur[5] ^ rLfsrCur[7] ^ iData[7] ^ iData[8] ^ iData[21] ^ iData[23];
    rLfsrNxt[10] = rLfsrCur[6] ^ rLfsrCur[8] ^ iData[8] ^ iData[9] ^ iData[22] ^ iData[24];
    rLfsrNxt[11] = rLfsrCur[7] ^ rLfsrCur[9] ^ iData[9] ^ iData[10] ^ iData[23] ^ iData[25];
    rLfsrNxt[12] = rLfsrCur[8] ^ rLfsrCur[10] ^ iData[10] ^ iData[11] ^ iData[24] ^ iData[26];
    rLfsrNxt[13] = rLfsrCur[9] ^ rLfsrCur[11] ^ iData[11] ^ iData[12] ^ iData[25] ^ iData[27];
    rLfsrNxt[14] = rLfsrCur[10] ^ rLfsrCur[12] ^ iData[12] ^ iData[13] ^ iData[26] ^ iData[28];
    rLfsrNxt[15] = rLfsrCur[0]  ^ rLfsrCur[1]  ^ rLfsrCur[2] ^ rLfsrCur[3] ^ rLfsrCur[4] ^ rLfsrCur[5] ^ rLfsrCur[6] ^ rLfsrCur[7] ^ rLfsrCur[8] ^ rLfsrCur[9] ^ rLfsrCur[10] ^ rLfsrCur[13] ^ rLfsrCur[14] ^ rLfsrCur[15] ^ iData[0] ^ iData[1] ^ iData[2] ^ iData[3] ^ iData[4] ^ iData[5] ^ iData[6] ^ iData[7] ^ iData[8] ^ iData[9] ^ iData[10] ^ iData[11] ^ iData[12] ^ iData[14] ^ iData[15] ^ iData[16] ^ iData[17] ^ iData[18] ^ iData[19] ^ iData[20] ^ iData[21] ^ iData[22] ^ iData[23] ^ iData[24] ^ iData[25] ^ iData[26] ^ iData[29] ^ iData[30] ^ iData[31];
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rLfsrCur <= {16{1'b1}};  //初始值全1
    end else if (iCrcClr) begin
      rLfsrCur <= {16{1'b1}};  //初始值全1
    end else begin
      rLfsrCur <= iCrcEn ? rLfsrNxt : rLfsrCur;
    end
  end
endmodule
