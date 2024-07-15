// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/xbar/slave_if_rd.v
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
//  23-08-24 |     NJU    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module slave_if_rd #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4
) (
  input  wire          iClk,
  input  wire          iRst_n,
  // master intf
  input  wire          iMst0RdReq,
  input  wire          iMst0RdValid,
  input  wire [AW-1:0] iMst0RdAddr,
  input  wire [SW-1:0] iMst0RdSel,
  input  wire          iMst0RdLast,
  output wire          oMst0RdReady,
  output wire [DW-1:0] oMst0RdData,
  input  wire          iMst1RdReq,
  input  wire          iMst1RdValid,
  input  wire [AW-1:0] iMst1RdAddr,
  input  wire [SW-1:0] iMst1RdSel,
  input  wire          iMst1RdLast,
  output wire          oMst1RdReady,
  output wire [DW-1:0] oMst1RdData,
  input  wire          iMst2RdReq,
  input  wire          iMst2RdValid,
  input  wire [AW-1:0] iMst2RdAddr,
  input  wire [SW-1:0] iMst2RdSel,
  input  wire          iMst2RdLast,
  output wire          oMst2RdReady,
  output wire [DW-1:0] oMst2RdData,
  input  wire          iMst3RdReq,
  input  wire          iMst3RdValid,
  input  wire [AW-1:0] iMst3RdAddr,
  input  wire [SW-1:0] iMst3RdSel,
  input  wire          iMst3RdLast,
  output wire          oMst3RdReady,
  output wire [DW-1:0] oMst3RdData,
  // slave intf
  output reg           oSlvRdReq,
  output reg           oSlvRdValid,
  output reg  [AW-1:0] oSlvRdAddr,
  output reg  [SW-1:0] oSlvRdSel,
  output reg           oSlvRdLast,
  input  wire          iSlvRdReady,
  input  wire [DW-1:0] iSlvRdData
);

  wire [1:0] mst_sel;
  reg        iMst0RdReq_r;
  reg        iMst1RdReq_r;
  reg        iMst2RdReq_r;
  reg        iMst3RdReq_r;
  wire       grantValid;

  rr_arbiter U_arbiter (
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iReq({iMst3RdReq, iMst2RdReq, iMst1RdReq, iMst0RdReq}),
    .oGrant(mst_sel),
    .oGrantValid(grantValid)
  );

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvRdAddr = iMst0RdAddr;
      2'b01:   oSlvRdAddr = iMst1RdAddr;
      2'b10:   oSlvRdAddr = iMst2RdAddr;
      2'b11:   oSlvRdAddr = iMst3RdAddr;
      default: oSlvRdAddr = {AW{1'bx}};
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvRdSel = iMst0RdSel;
      2'b01:   oSlvRdSel = iMst1RdSel;
      2'b10:   oSlvRdSel = iMst2RdSel;
      2'b11:   oSlvRdSel = iMst3RdSel;
      default: oSlvRdSel = {SW{1'bx}};
    endcase
  end

  assign oMst0RdData = iSlvRdData;
  assign oMst1RdData = iSlvRdData;
  assign oMst2RdData = iSlvRdData;
  assign oMst3RdData = iSlvRdData;

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvRdValid = iMst0RdValid;
      2'b01:   oSlvRdValid = iMst1RdValid;
      2'b10:   oSlvRdValid = iMst2RdValid;
      2'b11:   oSlvRdValid = iMst3RdValid;
      default: oSlvRdValid = 1'b0;
    endcase
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvRdLast = iMst0RdLast;
      2'b01:   oSlvRdLast = iMst1RdLast;
      2'b10:   oSlvRdLast = iMst2RdLast;
      2'b11:   oSlvRdLast = iMst3RdLast;
      default: oSlvRdLast = 1'b0;
    endcase
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst0RdReq_r <= 1'b0;
    end else begin
      iMst0RdReq_r <= iMst0RdReq;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst1RdReq_r <= 1'b0;
    end else begin
      iMst1RdReq_r <= iMst1RdReq;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst2RdReq_r <= 1'b0;
    end else begin
      iMst2RdReq_r <= iMst2RdReq;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iMst3RdReq_r <= 1'b0;
    end else begin
      iMst3RdReq_r <= iMst3RdReq;
    end
  end

  always @(*) begin
    case (mst_sel)
      2'b00:   oSlvRdReq = iMst0RdReq && iMst0RdReq_r;
      2'b01:   oSlvRdReq = iMst1RdReq && iMst1RdReq_r;
      2'b10:   oSlvRdReq = iMst2RdReq && iMst2RdReq_r;
      2'b11:   oSlvRdReq = iMst3RdReq && iMst3RdReq_r;
      default: oSlvRdReq = 1'b0;
    endcase
  end

  assign oMst0RdReady = (mst_sel == 2'b00) && grantValid && iSlvRdReady;
  assign oMst1RdReady = (mst_sel == 2'b01) && grantValid && iSlvRdReady;
  assign oMst2RdReady = (mst_sel == 2'b10) && grantValid && iSlvRdReady;
  assign oMst3RdReady = (mst_sel == 2'b11) && grantValid && iSlvRdReady;

endmodule
