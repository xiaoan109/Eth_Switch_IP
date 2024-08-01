// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/xbar/master_if_rd.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-17
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-19
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
module master_if_rd #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4
) (
  input  wire          iClk,
  input  wire          iRst_n,
  // master intf
  input  wire          iMstRdReq,
  input  wire          iMstRdValid,
  input  wire [AW-1:0] iMstRdAddr,
  input  wire [SW-1:0] iMstRdSel,
  input  wire          iMstRdLast,
  output reg           oMstRdReady,
  output reg  [DW-1:0] oMstRdData,
  // slave intf
  output reg           oSlv0RdReq,
  output wire          oSlv0RdValid,
  output wire [AW-1:0] oSlv0RdAddr,
  output wire [SW-1:0] oSlv0RdSel,
  output wire          oSlv0RdLast,
  input  wire          iSlv0RdReady,
  input  wire [DW-1:0] iSlv0RdData,
  output reg           oSlv1RdReq,
  output wire          oSlv1RdValid,
  output wire [AW-1:0] oSlv1RdAddr,
  output wire [SW-1:0] oSlv1RdSel,
  output wire          oSlv1RdLast,
  input  wire          iSlv1RdReady,
  input  wire [DW-1:0] iSlv1RdData,
  output reg           oSlv2RdReq,
  output wire          oSlv2RdValid,
  output wire [AW-1:0] oSlv2RdAddr,
  output wire [SW-1:0] oSlv2RdSel,
  output wire          oSlv2RdLast,
  input  wire          iSlv2RdReady,
  input  wire [DW-1:0] iSlv2RdData,
  output reg           oSlv3RdReq,
  output wire          oSlv3RdValid,
  output wire [AW-1:0] oSlv3RdAddr,
  output wire [SW-1:0] oSlv3RdSel,
  output wire          oSlv3RdLast,
  input  wire          iSlv3RdReady,
  input  wire [DW-1:0] iSlv3RdData
);


  wire [1:0] slv_sel;
  wire       oSlv0RdReq_next;
  wire       oSlv1RdReq_next;
  wire       oSlv2RdReq_next;
  wire       oSlv3RdReq_next;
  reg  [1:0] slv_sel_buf;


  assign slv_sel = iMstRdAddr[1:0];

  assign oSlv0RdAddr = iMstRdAddr;
  assign oSlv1RdAddr = iMstRdAddr;
  assign oSlv2RdAddr = iMstRdAddr;
  assign oSlv3RdAddr = iMstRdAddr;

  assign oSlv0RdSel = iMstRdSel;
  assign oSlv1RdSel = iMstRdSel;
  assign oSlv2RdSel = iMstRdSel;
  assign oSlv3RdSel = iMstRdSel;

  assign oSlv0RdLast = (slv_sel == 2'b00) ? iMstRdLast : 1'b0;
  assign oSlv1RdLast = (slv_sel == 2'b01) ? iMstRdLast : 1'b0;
  assign oSlv2RdLast = (slv_sel == 2'b10) ? iMstRdLast : 1'b0;
  assign oSlv3RdLast = (slv_sel == 2'b11) ? iMstRdLast : 1'b0;


  assign oSlv0RdReq_next = (iMstRdReq && !iMstRdValid) ? oSlv0RdReq : (slv_sel == 2'b00 ? iMstRdReq : 1'b0);
  assign oSlv1RdReq_next = (iMstRdReq && !iMstRdValid) ? oSlv1RdReq : (slv_sel == 2'b01 ? iMstRdReq : 1'b0);
  assign oSlv2RdReq_next = (iMstRdReq && !iMstRdValid) ? oSlv2RdReq : (slv_sel == 2'b10 ? iMstRdReq : 1'b0);
  assign oSlv3RdReq_next = (iMstRdReq && !iMstRdValid) ? oSlv3RdReq : (slv_sel == 2'b11 ? iMstRdReq : 1'b0);
  // assign oSlv0RdReq_next = !iMstRdReq ? 1'b0 : (slv_sel == 2'b00 ? iMstRdReq : 1'b0);
  // assign oSlv1RdReq_next = !iMstRdReq ? 1'b0 : (slv_sel == 2'b01 ? iMstRdReq : 1'b0);
  // assign oSlv2RdReq_next = !iMstRdReq ? 1'b0 : (slv_sel == 2'b10 ? iMstRdReq : 1'b0);
  // assign oSlv3RdReq_next = !iMstRdReq ? 1'b0 : (slv_sel == 2'b11 ? iMstRdReq : 1'b0);

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oSlv0RdReq <= 1'b0;
      oSlv1RdReq <= 1'b0;
      oSlv2RdReq <= 1'b0;
      oSlv3RdReq <= 1'b0;
    end else begin
      oSlv0RdReq <= oSlv0RdReq_next;
      oSlv1RdReq <= oSlv1RdReq_next;
      oSlv2RdReq <= oSlv2RdReq_next;
      oSlv3RdReq <= oSlv3RdReq_next;
    end
  end

  assign oSlv0RdValid = (slv_sel == 2'b00) ? iMstRdValid : 1'b0;
  assign oSlv1RdValid = (slv_sel == 2'b01) ? iMstRdValid : 1'b0;
  assign oSlv2RdValid = (slv_sel == 2'b10) ? iMstRdValid : 1'b0;
  assign oSlv3RdValid = (slv_sel == 2'b11) ? iMstRdValid : 1'b0;

  always @(*) begin
    case (slv_sel)
      2'b00:   oMstRdReady = iSlv0RdReady;
      2'b01:   oMstRdReady = iSlv1RdReady;
      2'b10:   oMstRdReady = iSlv2RdReady;
      2'b11:   oMstRdReady = iSlv3RdReady;
      default: oMstRdReady = 1'b0;
    endcase
  end

  always @(*) begin
    case (slv_sel == slv_sel_buf ? slv_sel : slv_sel_buf)
      2'b00:   oMstRdData = iSlv0RdData;
      2'b01:   oMstRdData = iSlv1RdData;
      2'b10:   oMstRdData = iSlv2RdData;
      2'b11:   oMstRdData = iSlv3RdData;
      default: oMstRdData = {DW{1'bx}};
    endcase
  end


  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      slv_sel_buf <= 2'b00;
    end else if(iMstRdValid) begin
      slv_sel_buf <= slv_sel;
    end
  end


endmodule
