// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/CRC/CrcDataSend.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-13
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-07-06
// Version        :
// Description    : TODO: remove iAlmostFull and wWrVld
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
module CrcDataSend (
  input  wire        iClk,
  input  wire        iRst_n,
  input  wire        iWrSop,
  input  wire        iWrEop,
  input  wire        iWrVld,
  input  wire [31:0] iWrData,
  input  wire        iFifoFull,
  input  wire        iAlmostFull,
  output wire        oWrSop,
  output wire        oWrEop,
  output wire        oWrVld,
  output wire [31:0] oWrData,
  output wire        oFull
);

  reg rWrEop;
  reg rNonCtrl;
  wire [31:0] rWrData;
  wire [15:0] wCrcData;
  reg [15:0] rCrcData;
  reg rCrcVld;
  wire wWrVld;  //TODO: remove me
  assign oWrSop = iWrSop;
  assign oWrEop = rWrEop;
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rWrEop <= 1'b0;
    end else begin
      rWrEop <= iWrEop;
    end
  end

  assign wWrVld  = iWrVld || iWrEop || rCrcVld;
  assign oWrVld  = wWrVld && !iAlmostFull;

  assign rWrData = iWrVld ? iWrData : 32'b0;

  // assign oWrData = iWrVld ? rWrData : iWrEop ? wCrcData  : rCrcVld ? rCrcData : 32'b0;
  assign oWrData = rCrcVld ? rCrcData : iWrVld ? rWrData : iWrEop ? wCrcData : 32'b0;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rNonCtrl <= 1'b0;
    end else if (iWrVld && !oFull) begin
      rNonCtrl <= 1'b1;
    end else if (iWrEop) begin
      rNonCtrl <= 1'b0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rCrcData <= 16'b0;
      rCrcVld  <= 1'b0;
    end else if (iWrEop && iFifoFull) begin
      rCrcData <= wCrcData;
      rCrcVld  <= 1'b1;
    end else if (rCrcVld && !iFifoFull && !iAlmostFull) begin
      rCrcData <= 16'b0;
      rCrcVld  <= 1'b0;
    end
  end

  Crc U_Crc (
    .iClk   (iClk),
    .iRst_n (iRst_n),
    .iData  (rWrData),
    .iCrcEn (iWrVld && rNonCtrl && !iFifoFull && !iAlmostFull),
    .iCrcClr(iWrEop),
    .oCrc   (wCrcData)
  );

  assign oFull = iFifoFull || rCrcVld;  // Backpress sender when crc value is sending but unpack FIFO full

endmodule
