// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/xbar/master_if_wr.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-16
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
module master_if_wr #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4
) (
  input  wire          iClk,
  input  wire          iRst_n,
  // master intf
  input  wire          iMstWrReq,
  input  wire          iMstWrValid,
  input  wire [AW-1:0] iMstWrAddr,
  input  wire [SW-1:0] iMstWrSel,
  input  wire [DW-1:0] iMstWrData,
  input  wire          iMstWrLast,
  output reg           oMstWrReady,
  // slave intf                     
  output reg           oSlv0WrReq,
  output wire          oSlv0WrValid,
  output wire [AW-1:0] oSlv0WrAddr,
  output wire [SW-1:0] oSlv0WrSel,
  output wire [DW-1:0] oSlv0WrData,
  output wire          oSlv0WrLast,
  input  wire          iSlv0WrReady,
  output reg           oSlv1WrReq,
  output wire          oSlv1WrValid,
  output wire [AW-1:0] oSlv1WrAddr,
  output wire [SW-1:0] oSlv1WrSel,
  output wire [DW-1:0] oSlv1WrData,
  output wire          oSlv1WrLast,
  input  wire          iSlv1WrReady,
  output reg           oSlv2WrReq,
  output wire          oSlv2WrValid,
  output wire [AW-1:0] oSlv2WrAddr,
  output wire [SW-1:0] oSlv2WrSel,
  output wire [DW-1:0] oSlv2WrData,
  output wire          oSlv2WrLast,
  input  wire          iSlv2WrReady,
  output reg           oSlv3WrReq,
  output wire          oSlv3WrValid,
  output wire [AW-1:0] oSlv3WrAddr,
  output wire [SW-1:0] oSlv3WrSel,
  output wire [DW-1:0] oSlv3WrData,
  output wire          oSlv3WrLast,
  input  wire          iSlv3WrReady
);


  wire [1:0] slv_sel;
  wire       oSlv0WrReq_next;
  wire       oSlv1WrReq_next;
  wire       oSlv2WrReq_next;
  wire       oSlv3WrReq_next;


  assign slv_sel = iMstWrAddr[1:0];

  assign oSlv0WrAddr = iMstWrAddr;
  assign oSlv1WrAddr = iMstWrAddr;
  assign oSlv2WrAddr = iMstWrAddr;
  assign oSlv3WrAddr = iMstWrAddr;

  assign oSlv0WrSel = iMstWrSel;
  assign oSlv1WrSel = iMstWrSel;
  assign oSlv2WrSel = iMstWrSel;
  assign oSlv3WrSel = iMstWrSel;

  assign oSlv0WrData = iMstWrData;
  assign oSlv1WrData = iMstWrData;
  assign oSlv2WrData = iMstWrData;
  assign oSlv3WrData = iMstWrData;

  assign oSlv0WrLast = (slv_sel == 2'b00) ? iMstWrLast : 1'b0;
  assign oSlv1WrLast = (slv_sel == 2'b01) ? iMstWrLast : 1'b0;
  assign oSlv2WrLast = (slv_sel == 2'b10) ? iMstWrLast : 1'b0;
  assign oSlv3WrLast = (slv_sel == 2'b11) ? iMstWrLast : 1'b0;


  assign oSlv0WrReq_next = (iMstWrReq && !iMstWrValid) ? oSlv0WrReq : (slv_sel == 2'b00 ? iMstWrReq : 1'b0);
  assign oSlv1WrReq_next = (iMstWrReq && !iMstWrValid) ? oSlv1WrReq : (slv_sel == 2'b01 ? iMstWrReq : 1'b0);
  assign oSlv2WrReq_next = (iMstWrReq && !iMstWrValid) ? oSlv2WrReq : (slv_sel == 2'b10 ? iMstWrReq : 1'b0);
  assign oSlv3WrReq_next = (iMstWrReq && !iMstWrValid) ? oSlv3WrReq : (slv_sel == 2'b11 ? iMstWrReq : 1'b0);
  // assign oSlv0WrReq_next = !iMstWrReq ? 1'b0 : (slv_sel == 2'b00 ? iMstWrReq : 1'b0);
  // assign oSlv1WrReq_next = !iMstWrReq ? 1'b0 : (slv_sel == 2'b01 ? iMstWrReq : 1'b0);
  // assign oSlv2WrReq_next = !iMstWrReq ? 1'b0 : (slv_sel == 2'b10 ? iMstWrReq : 1'b0);
  // assign oSlv3WrReq_next = !iMstWrReq ? 1'b0 : (slv_sel == 2'b11 ? iMstWrReq : 1'b0);

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oSlv0WrReq <= 1'b0;
      oSlv1WrReq <= 1'b0;
      oSlv2WrReq <= 1'b0;
      oSlv3WrReq <= 1'b0;
    end else begin
      oSlv0WrReq <= oSlv0WrReq_next;
      oSlv1WrReq <= oSlv1WrReq_next;
      oSlv2WrReq <= oSlv2WrReq_next;
      oSlv3WrReq <= oSlv3WrReq_next;
    end
  end

  assign oSlv0WrValid = (slv_sel == 2'b00) ? iMstWrValid : 1'b0;
  assign oSlv1WrValid = (slv_sel == 2'b01) ? iMstWrValid : 1'b0;
  assign oSlv2WrValid = (slv_sel == 2'b10) ? iMstWrValid : 1'b0;
  assign oSlv3WrValid = (slv_sel == 2'b11) ? iMstWrValid : 1'b0;

  always @(*) begin
    case (slv_sel)
      2'b00:   oMstWrReady = iSlv0WrReady;
      2'b01:   oMstWrReady = iSlv1WrReady;
      2'b10:   oMstWrReady = iSlv2WrReady;
      2'b11:   oMstWrReady = iSlv3WrReady;
      default: oMstWrReady = 1'b0;
    endcase
  end


endmodule
