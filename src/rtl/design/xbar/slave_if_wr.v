// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/xbar/slave_if_wr.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-17
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-08
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
module slave_if_wr #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4
) (
  input  wire          iClk,
  input  wire          iRst_n,
  // master intf
  input  wire          iMst0WrReq,
  input  wire          iMst0WrValid,
  input  wire [AW-1:0] iMst0WrAddr,
  input  wire [SW-1:0] iMst0WrSel,
  input  wire [DW-1:0] iMst0WrData,
  input  wire          iMst0WrLast,
  output wire          oMst0WrReady,
  input  wire          iMst1WrReq,
  input  wire          iMst1WrValid,
  input  wire [AW-1:0] iMst1WrAddr,
  input  wire [SW-1:0] iMst1WrSel,
  input  wire [DW-1:0] iMst1WrData,
  input  wire          iMst1WrLast,
  output wire          oMst1WrReady,
  input  wire          iMst2WrReq,
  input  wire          iMst2WrValid,
  input  wire [AW-1:0] iMst2WrAddr,
  input  wire [SW-1:0] iMst2WrSel,
  input  wire [DW-1:0] iMst2WrData,
  input  wire          iMst2WrLast,
  output wire          oMst2WrReady,
  input  wire          iMst3WrReq,
  input  wire          iMst3WrValid,
  input  wire [AW-1:0] iMst3WrAddr,
  input  wire [SW-1:0] iMst3WrSel,
  input  wire [DW-1:0] iMst3WrData,
  input  wire          iMst3WrLast,
  output wire          oMst3WrReady,
  // slave intf
  output reg           oSlvWrReq,
  output reg           oSlvWrValid,
  output reg  [AW-1:0] oSlvWrAddr,
  output reg  [SW-1:0] oSlvWrSel,
  output reg  [DW-1:0] oSlvWrData,
  output reg           oSlvWrLast,
  input  wire          iSlvWrReady
);

  wire [1:0] mst_sel;
  reg        iMst0WrReq_r;
  reg        iMst1WrReq_r;
  reg        iMst2WrReq_r;
  reg        iMst3WrReq_r;
  wire       grantValid;

  rr_arbiter U_arbiter (
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iReq({iMst3WrReq, iMst2WrReq, iMst1WrReq, iMst0WrReq}),
    .oGrant(mst_sel),
    .oGrantValid(grantValid)
  );

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWrAddr = iMst0WrAddr;
      2'b01:   oSlvWrAddr = iMst1WrAddr;
      2'b10:   oSlvWrAddr = iMst2WrAddr;
      2'b11:   oSlvWrAddr = iMst3WrAddr;
      default: oSlvWrAddr = {AW{1'bx}};
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWrSel = iMst0WrSel;
      2'b01:   oSlvWrSel = iMst1WrSel;
      2'b10:   oSlvWrSel = iMst2WrSel;
      2'b11:   oSlvWrSel = iMst3WrSel;
      default: oSlvWrSel = {SW{1'bx}};
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWrData = iMst0WrData;
      2'b01:   oSlvWrData = iMst1WrData;
      2'b10:   oSlvWrData = iMst2WrData;
      2'b11:   oSlvWrData = iMst3WrData;
      default: oSlvWrData = {DW{1'bx}};
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWrValid = iMst0WrValid;
      2'b01:   oSlvWrValid = iMst1WrValid;
      2'b10:   oSlvWrValid = iMst2WrValid;
      2'b11:   oSlvWrValid = iMst3WrValid;
      default: oSlvWrValid = 1'b0;
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWrLast = iMst0WrLast;
      2'b01:   oSlvWrLast = iMst1WrLast;
      2'b10:   oSlvWrLast = iMst2WrLast;
      2'b11:   oSlvWrLast = iMst3WrLast;
      default: oSlvWrLast = 1'b0;
    endcase
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst0WrReq_r <= 1'b0;
    end else begin
      iMst0WrReq_r <= iMst0WrReq;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst1WrReq_r <= 1'b0;
    end else begin
      iMst1WrReq_r <= iMst1WrReq;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst2WrReq_r <= 1'b0;
    end else begin
      iMst2WrReq_r <= iMst2WrReq;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst3WrReq_r <= 1'b0;
    end else begin
      iMst3WrReq_r <= iMst3WrReq;
    end
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvWrReq = iMst0WrReq && iMst0WrReq_r;
      2'b01:   oSlvWrReq = iMst1WrReq && iMst1WrReq_r;
      2'b10:   oSlvWrReq = iMst2WrReq && iMst2WrReq_r;
      2'b11:   oSlvWrReq = iMst3WrReq && iMst3WrReq_r;
      default: oSlvWrReq = 1'b0;
    endcase
  end

  assign oMst0WrReady = (mst_sel == 2'b00) && grantValid && iSlvWrReady;
  assign oMst1WrReady = (mst_sel == 2'b01) && grantValid && iSlvWrReady;
  assign oMst2WrReady = (mst_sel == 2'b10) && grantValid && iSlvWrReady;
  assign oMst3WrReady = (mst_sel == 2'b11) && grantValid && iSlvWrReady;

endmodule
