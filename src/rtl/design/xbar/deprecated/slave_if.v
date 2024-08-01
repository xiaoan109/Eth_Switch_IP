// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/deprecated/slave_if.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-09
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-07
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
module slave_if #(
  parameter CMD_W = 1,
  parameter AW    = 12,
  parameter DW    = 32,
  parameter SW    = 4
) (
  input  wire             iClk,
  input  wire             iRst_n,
  // master intf
  input  wire             iMst0Req,
  input  wire [CMD_W-1:0] iMst0Cmd,
  input  wire [   AW-1:0] iMst0Addr,
  input  wire [   SW-1:0] iMst0Sel,
  input  wire [   DW-1:0] iMst0WData,
  output wire             oMst0Ack,
  output wire [   DW-1:0] oMst0RData,
  input  wire             iMst1Req,
  input  wire [CMD_W-1:0] iMst1Cmd,
  input  wire [   AW-1:0] iMst1Addr,
  input  wire [   SW-1:0] iMst1Sel,
  input  wire [   DW-1:0] iMst1WData,
  output wire             oMst1Ack,
  output wire [   DW-1:0] oMst1RData,
  input  wire             iMst2Req,
  input  wire [CMD_W-1:0] iMst2Cmd,
  input  wire [   AW-1:0] iMst2Addr,
  input  wire [   SW-1:0] iMst2Sel,
  input  wire [   DW-1:0] iMst2WData,
  output wire             oMst2Ack,
  output wire [   DW-1:0] oMst2RData,
  input  wire             iMst3Req,
  input  wire [CMD_W-1:0] iMst3Cmd,
  input  wire [   AW-1:0] iMst3Addr,
  input  wire [   SW-1:0] iMst3Sel,
  input  wire [   DW-1:0] iMst3WData,
  output wire             oMst3Ack,
  output wire [   DW-1:0] oMst3RData,
  // slave intf
  output reg              oSlvReq,
  output reg  [CMD_W-1:0] oSlvCmd,
  output reg  [   AW-1:0] oSlvAddr,
  output reg  [   SW-1:0] oSlvSel,
  output reg  [   DW-1:0] oSlvWData,
  input  wire             iSlvAck,
  input  wire [   DW-1:0] iSlvRData
);

  wire [1:0] mst_sel;
  reg        iMst0Req_r;
  reg        iMst1Req_r;
  reg        iMst2Req_r;
  reg        iMst3Req_r;

  rr_arbiter U_arbiter (
    .iClk  (iClk),
    .iRst_n(iRst_n),
    .iReq  ({iMst3Req, iMst2Req, iMst1Req, iMst0Req}),
    .oGrant(mst_sel)
  );

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvAddr = iMst0Addr;
      2'b01:   oSlvAddr = iMst1Addr;
      2'b10:   oSlvAddr = iMst2Addr;
      2'b11:   oSlvAddr = iMst3Addr;
      default: oSlvAddr = {AW{1'bx}};
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvSel = iMst0Sel;
      2'b01:   oSlvSel = iMst1Sel;
      2'b10:   oSlvSel = iMst2Sel;
      2'b11:   oSlvSel = iMst3Sel;
      default: oSlvSel = {SW{1'bx}};
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWData = iMst0WData;
      2'b01:   oSlvWData = iMst1WData;
      2'b10:   oSlvWData = iMst2WData;
      2'b11:   oSlvWData = iMst3WData;
      default: oSlvWData = {DW{1'bx}};
    endcase
  end

  assign oMst0RData = iSlvRData;
  assign oMst1RData = iSlvRData;
  assign oMst2RData = iSlvRData;
  assign oMst3RData = iSlvRData;

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvCmd = iMst0Cmd;
      2'b01:   oSlvCmd = iMst1Cmd;
      2'b10:   oSlvCmd = iMst2Cmd;
      2'b11:   oSlvCmd = iMst3Cmd;
      default: oSlvCmd = {CMD_W{1'bx}};
    endcase
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst0Req_r <= 1'b0;
    end else begin
      iMst0Req_r <= iMst0Req;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst1Req_r <= 1'b0;
    end else begin
      iMst1Req_r <= iMst1Req;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst2Req_r <= 1'b0;
    end else begin
      iMst2Req_r <= iMst2Req;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst3Req_r <= 1'b0;
    end else begin
      iMst3Req_r <= iMst3Req;
    end
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvReq = iMst0Req && iMst0Req_r;
      2'b01:   oSlvReq = iMst1Req && iMst1Req_r;
      2'b10:   oSlvReq = iMst2Req && iMst2Req_r;
      2'b11:   oSlvReq = iMst3Req && iMst3Req_r;
      default: oSlvReq = 1'b0;
    endcase
  end

  assign oMst0Ack = (mst_sel == 2'b00) && iSlvAck;
  assign oMst1Ack = (mst_sel == 2'b01) && iSlvAck;
  assign oMst2Ack = (mst_sel == 2'b10) && iSlvAck;
  assign oMst3Ack = (mst_sel == 2'b11) && iSlvAck;

endmodule
