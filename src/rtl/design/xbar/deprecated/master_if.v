// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/master_if.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-09
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-14
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
module master_if #(
  parameter CMD_W = 1,
  parameter AW    = 12,
  parameter DW    = 32,
  parameter SW    = 4
) (
  input  wire             iClk,
  input  wire             iRst_n,
  // master intf
  input  wire             iMstReq,
  input  wire [CMD_W-1:0] iMstCmd,
  input  wire [   AW-1:0] iMstAddr,
  input  wire [   SW-1:0] iMstSel,
  input  wire [   DW-1:0] iMstWData,
  output reg              oMstAck,
  output reg  [   DW-1:0] oMstRData,
  // slave intf
  output reg              oSlv0Req,
  output wire [CMD_W-1:0] oSlv0Cmd,
  output wire [   AW-1:0] oSlv0Addr,
  output wire [   SW-1:0] oSlv0Sel,
  output wire [   DW-1:0] oSlv0WData,
  input  wire             iSlv0Ack,
  input  wire [   DW-1:0] iSlv0RData,
  output reg              oSlv1Req,
  output wire [CMD_W-1:0] oSlv1Cmd,
  output wire [   AW-1:0] oSlv1Addr,
  output wire [   SW-1:0] oSlv1Sel,
  output wire [   DW-1:0] oSlv1WData,
  input  wire             iSlv1Ack,
  input  wire [   DW-1:0] iSlv1RData,
  output reg              oSlv2Req,
  output wire [CMD_W-1:0] oSlv2Cmd,
  output wire [   AW-1:0] oSlv2Addr,
  output wire [   SW-1:0] oSlv2Sel,
  output wire [   DW-1:0] oSlv2WData,
  input  wire             iSlv2Ack,
  input  wire [   DW-1:0] iSlv2RData,
  output reg              oSlv3Req,
  output wire [CMD_W-1:0] oSlv3Cmd,
  output wire [   AW-1:0] oSlv3Addr,
  output wire [   SW-1:0] oSlv3Sel,
  output wire [   DW-1:0] oSlv3WData,
  input  wire             iSlv3Ack,
  input  wire [   DW-1:0] iSlv3RData
);


  wire [1:0] slv_sel;
  wire       oSlv0Req_next;
  wire       oSlv1Req_next;
  wire       oSlv2Req_next;
  wire       oSlv3Req_next;


  assign slv_sel = iMstAddr[1:0];

  assign oSlv0Addr = iMstAddr;
  assign oSlv1Addr = iMstAddr;
  assign oSlv2Addr = iMstAddr;
  assign oSlv3Addr = iMstAddr;

  assign oSlv0Sel = iMstSel;
  assign oSlv1Sel = iMstSel;
  assign oSlv2Sel = iMstSel;
  assign oSlv3Sel = iMstSel;

  assign oSlv0WData = iMstWData;
  assign oSlv1WData = iMstWData;
  assign oSlv2WData = iMstWData;
  assign oSlv3WData = iMstWData;

  always @(*) begin
    case (slv_sel)
      2'b00:   oMstRData = iSlv0RData;
      2'b01:   oMstRData = iSlv1RData;
      2'b10:   oMstRData = iSlv2RData;
      2'b11:   oMstRData = iSlv3RData;
      default: oMstRData = {DW{1'bx}};
    endcase
  end

  assign oSlv0Cmd = iMstCmd;
  assign oSlv1Cmd = iMstCmd;
  assign oSlv2Cmd = iMstCmd;
  assign oSlv3Cmd = iMstCmd;

  assign oSlv0Req_next = !iMstReq ? 1'b0 : (slv_sel == 2'b00 ? iMstReq : 1'b0);
  assign oSlv1Req_next = !iMstReq ? 1'b0 : (slv_sel == 2'b01 ? iMstReq : 1'b0);
  assign oSlv2Req_next = !iMstReq ? 1'b0 : (slv_sel == 2'b10 ? iMstReq : 1'b0);
  assign oSlv3Req_next = !iMstReq ? 1'b0 : (slv_sel == 2'b11 ? iMstReq : 1'b0);

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oSlv0Req <= 1'b0;
      oSlv1Req <= 1'b0;
      oSlv2Req <= 1'b0;
      oSlv3Req <= 1'b0;
    end else begin
      oSlv0Req <= oSlv0Req_next;
      oSlv1Req <= oSlv1Req_next;
      oSlv2Req <= oSlv2Req_next;
      oSlv3Req <= oSlv3Req_next;
    end
  end

  always @(*) begin
    case (slv_sel)
      2'b00:   oMstAck = iSlv0Ack;
      2'b01:   oMstAck = iSlv1Ack;
      2'b10:   oMstAck = iSlv2Ack;
      2'b11:   oMstAck = iSlv3Ack;
      default: oMstAck = 1'b0;
    endcase
  end


endmodule
