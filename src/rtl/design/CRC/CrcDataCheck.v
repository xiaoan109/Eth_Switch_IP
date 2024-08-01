// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/CRC/CrcDataCheck.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-15
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-18
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
module CrcDataCheck (
  input wire iClk,
  input wire iRst_n,
  input wire iRdSop,
  input wire iRdEop,
  input wire iRdVld,
  input wire iRdLast,
  input wire [31:0] iRdData,
  output wire oRdSop,
  output wire oRdEop,
  output wire oRdVld,
  output wire [31:0] oRdData,
  output wire oErr,
  input wire iReady
);
  wire [15:0] wCrcData;
  reg rRdLast;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rRdLast <= 1'b0;
    end else begin
      rRdLast <= iRdLast;
    end
  end

  assign oRdSop = iRdSop;
  assign oRdEop = !rRdLast & iRdLast;

  assign oRdVld = iRdVld && !iRdLast;
  assign oRdData = iRdData;
  assign oErr = oRdEop ? (wCrcData != iRdData) : 1'b0;

  Crc U_Crc (
    .iClk   (iClk),
    .iRst_n (iRst_n),
    .iData  (iRdData),
    .iCrcEn (iRdVld && iReady && !iRdLast),
    .iCrcClr(iRdEop),
    .oCrc   (wCrcData)
  );

endmodule
