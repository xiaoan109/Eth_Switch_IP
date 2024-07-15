// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/sram/sram_block_drv.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-03-29
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-16
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
//  23-08-24 |     NJU    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module sram_block_drv #(
  parameter DW = 32,
  parameter PAW = 14,
  parameter VAW = 12,
  parameter SW = 4,
  parameter TRANSLEN = 16  // 64Byte/32bit = 16
) (
  input  wire           iClk,
  input  wire           iRst_n,
  // Wr  Ports
  input  wire           iSRAMWrReq,
  input  wire           iSRAMWrValid,
  input  wire [VAW-1:0] iSRAMWrAddr,
  input  wire [ SW-1:0] iSRAMWrSel,
  input  wire           iSRAMWrLast,
  input  wire [ DW-1:0] iSRAMWrData,
  output wire           oSRAMWrReady,
  // Rd Ports
  input  wire           iSRAMRdReq,
  input  wire           iSRAMRdValid,
  input  wire [VAW-1:0] iSRAMRdAddr,
  input  wire [ SW-1:0] iSRAMRdSel,
  input  wire           iSRAMRdLast,
  output wire           oSRAMRdReady,
  output wire [ DW-1:0] oSRAMRdData,
  // optional
  // output reg                    oSRAMWrResp,
  // output reg                    oSRAMRdResp,
  // TODO: A copy of the above ports can be added for full shared memory access
  // SRAM interface
  output wire           oCEnA,
  output wire           oCEnB,
  output wire           oWEnA,
  output wire           oWEnB,
  output wire [ DW-1:0] oBWEnA,
  output wire [ DW-1:0] oBWEnB,
  output wire [PAW-1:0] oAddrA,
  output wire [PAW-1:0] oAddrB,
  output wire [ DW-1:0] oWDataA,
  output wire [ DW-1:0] oWDataB,       // unused
  input  wire [ DW-1:0] iRDataA,       // unused
  input  wire [ DW-1:0] iRDataB
);
  // data in -> calculate physical addr -> sram sigs
  // port A wr only, port B rd only
  reg [$clog2(TRANSLEN)-1:0] wCnt;
  reg [$clog2(TRANSLEN)-1:0] rCnt;

  assign oSRAMWrReady = 1'b1;
  assign oSRAMRdReady = 1'b1;


  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      wCnt <= 0;
    end else if (iSRAMWrReq && iSRAMWrValid && iSRAMWrLast) begin
      wCnt <= 0;
    end else if (iSRAMWrReq && iSRAMWrValid) begin
      wCnt <= wCnt + 1;
    end
  end
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rCnt <= 0;
    end else if (iSRAMRdReq && iSRAMRdValid && iSRAMRdLast) begin
      rCnt <= 0;
    end else if (iSRAMRdReq && iSRAMRdValid) begin
      rCnt <= rCnt + 1;
    end
  end

  assign oCEnA = !iSRAMWrReq;
  assign oWEnA = !(iSRAMWrReq && iSRAMWrValid);
  genvar i;
  generate
    for (i = 0; i < SW; i = i + 1) begin : gen_bwena
      assign oBWEnA[i*8+:8] = {8{!(iSRAMWrReq && iSRAMWrValid && iSRAMWrSel[i])}};
    end
  endgenerate
  assign oAddrA = ((iSRAMWrAddr & ~3) << 2) + wCnt;
  assign oWDataA = iSRAMWrData;


  assign oCEnB = !iSRAMRdReq;
  assign oWEnB = iSRAMRdReq && iSRAMRdValid;
  assign oBWEnB = {DW{1'b1}};

  assign oAddrB = ((iSRAMRdAddr & ~3) << 2) + rCnt;
  assign oSRAMRdData = iRDataB;

endmodule
