// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/unpack/Fifo.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-03
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-14
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

module Fifo #(
  parameter FIFO_DEPTH = 32,
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = $clog2(FIFO_DEPTH)
) (
  input  wire                  iClk,
  input  wire                  iRst_n,
  input  wire [DATA_WIDTH-1:0] iWData,
  input  wire                  iWEn,
  input  wire                  iREn,
  output wire [DATA_WIDTH-1:0] oReadData,
  output wire                  oReadDataVld,
  output wire                  oFull,
  output wire                  oEmpty
);

  // Def Write & Read Address
  wire [    ADDR_WIDTH - 1 : 0] wWriteAddress;
  wire [    ADDR_WIDTH - 1 : 0] wReadAddress;

  // Def Write & Read En & rVld
  wire                          wWriteEn;
  wire                          wReadEn;
  wire                          rVld;

  // Def Internal Data
  wire [    DATA_WIDTH - 1 : 0] rReadData;

  // Def Counter 
  reg  [ADDR_WIDTH - 1 + 1 : 0] rDataCounter;
  reg  [    DATA_WIDTH - 1 : 0] Memory        [0:FIFO_DEPTH-1];

  // Def Internal Addr
  reg  [    ADDR_WIDTH - 1 : 0] rWriteAddress;
  reg  [    ADDR_WIDTH - 1 : 0] rReadAddress;


  assign wWriteEn      = iWEn && (!oFull);
  assign wReadEn       = iREn && (!oEmpty);

  assign wWriteAddress = rWriteAddress[ADDR_WIDTH-1 : 0];
  assign wReadAddress  = rReadAddress[ADDR_WIDTH-1 : 0];

  // Calculation of read and write address
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rWriteAddress <= 0;
    end else if (wWriteEn) begin
      rWriteAddress <= (rWriteAddress == (FIFO_DEPTH - 1)) ? 'b0 : rWriteAddress + 1'b1;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rReadAddress <= 0;
    end else if (wReadEn) begin
      rReadAddress <= (rReadAddress == (FIFO_DEPTH - 1)) ? 0 : rReadAddress + 1'b1;
    end
  end

  //rDataCounter
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rDataCounter <= 0;
    end else if (wWriteEn && wReadEn) begin
      rDataCounter <= rDataCounter;
    end else if (wWriteEn) begin
      rDataCounter <= rDataCounter + 1'b1;
    end else if (wReadEn) begin
      rDataCounter <= rDataCounter - 1'b1;
    end else begin
      rDataCounter <= rDataCounter;
    end
  end

  //Read data and read valid
  assign rReadData = (wReadEn) ? Memory[wReadAddress] : 1'b0;
  assign rVld = (wReadEn) ? 1'b1 : 1'b0;

  //Write data
  always @(posedge iClk) begin
    if (wWriteEn) begin
      Memory[wWriteAddress] <= iWData;
    end
  end

  //Output
  assign oReadDataVld = rVld;
  assign oReadData = rReadData;
  assign oEmpty = (rDataCounter == 0);
  assign oFull = (rDataCounter == FIFO_DEPTH);
endmodule
