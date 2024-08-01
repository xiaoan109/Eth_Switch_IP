// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/interconnect_4W4R.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-06
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
module interconnect_4W4R #(
  parameter CMD_W = 1,
  parameter AW    = 12,
  parameter DW    = 32,
  parameter SW    = 4
) (
  input  wire             iClk,
  input  wire             iRst_n,
  // Master interface
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
  // Slave interface
  output wire             oSlv0Req,
  output wire [CMD_W-1:0] oSlv0Cmd,
  output wire [   AW-1:0] oSlv0Addr,
  output wire [   SW-1:0] oSlv0Sel,
  output wire [   DW-1:0] oSlv0WData,
  input  wire             iSlv0Ack,
  input  wire [   DW-1:0] iSlv0RData,
  output wire             oSlv1Req,
  output wire [CMD_W-1:0] oSlv1Cmd,
  output wire [   AW-1:0] oSlv1Addr,
  output wire [   SW-1:0] oSlv1Sel,
  output wire [   DW-1:0] oSlv1WData,
  input  wire             iSlv1Ack,
  input  wire [   DW-1:0] iSlv1RData,
  output wire             oSlv2Req,
  output wire [CMD_W-1:0] oSlv2Cmd,
  output wire [   AW-1:0] oSlv2Addr,
  output wire [   SW-1:0] oSlv2Sel,
  output wire [   DW-1:0] oSlv2WData,
  input  wire             iSlv2Ack,
  input  wire [   DW-1:0] iSlv2RData,
  output wire             oSlv3Req,
  output wire [CMD_W-1:0] oSlv3Cmd,
  output wire [   AW-1:0] oSlv3Addr,
  output wire [   SW-1:0] oSlv3Sel,
  output wire [   DW-1:0] oSlv3WData,
  input  wire             iSlv3Ack,
  input  wire [   DW-1:0] iSlv3RData
  // other sigs

);


  wire             m0s0Req;
  wire [CMD_W-1:0] m0s0Cmd;
  wire [   AW-1:0] m0s0Addr;
  wire [   SW-1:0] m0s0Sel;
  wire [   DW-1:0] m0s0WData;
  wire             m0s0Ack;
  wire [   DW-1:0] m0s0RData;
  wire             m0s1Req;
  wire [CMD_W-1:0] m0s1Cmd;
  wire [   AW-1:0] m0s1Addr;
  wire [   SW-1:0] m0s1Sel;
  wire [   DW-1:0] m0s1WData;
  wire             m0s1Ack;
  wire [   DW-1:0] m0s1RData;
  wire             m0s2Req;
  wire [CMD_W-1:0] m0s2Cmd;
  wire [   AW-1:0] m0s2Addr;
  wire [   SW-1:0] m0s2Sel;
  wire [   DW-1:0] m0s2WData;
  wire             m0s2Ack;
  wire [   DW-1:0] m0s2RData;
  wire             m0s3Req;
  wire [CMD_W-1:0] m0s3Cmd;
  wire [   AW-1:0] m0s3Addr;
  wire [   SW-1:0] m0s3Sel;
  wire [   DW-1:0] m0s3WData;
  wire             m0s3Ack;
  wire [   DW-1:0] m0s3RData;
  wire             m1s0Req;
  wire [CMD_W-1:0] m1s0Cmd;
  wire [   AW-1:0] m1s0Addr;
  wire [   SW-1:0] m1s0Sel;
  wire [   DW-1:0] m1s0WData;
  wire             m1s0Ack;
  wire [   DW-1:0] m1s0RData;
  wire             m1s1Req;
  wire [CMD_W-1:0] m1s1Cmd;
  wire [   AW-1:0] m1s1Addr;
  wire [   SW-1:0] m1s1Sel;
  wire [   DW-1:0] m1s1WData;
  wire             m1s1Ack;
  wire [   DW-1:0] m1s1RData;
  wire             m1s2Req;
  wire [CMD_W-1:0] m1s2Cmd;
  wire [   AW-1:0] m1s2Addr;
  wire [   SW-1:0] m1s2Sel;
  wire [   DW-1:0] m1s2WData;
  wire             m1s2Ack;
  wire [   DW-1:0] m1s2RData;
  wire             m1s3Req;
  wire [CMD_W-1:0] m1s3Cmd;
  wire [   AW-1:0] m1s3Addr;
  wire [   SW-1:0] m1s3Sel;
  wire [   DW-1:0] m1s3WData;
  wire             m1s3Ack;
  wire [   DW-1:0] m1s3RData;
  wire             m2s0Req;
  wire [CMD_W-1:0] m2s0Cmd;
  wire [   AW-1:0] m2s0Addr;
  wire [   SW-1:0] m2s0Sel;
  wire [   DW-1:0] m2s0WData;
  wire             m2s0Ack;
  wire [   DW-1:0] m2s0RData;
  wire             m2s1Req;
  wire [CMD_W-1:0] m2s1Cmd;
  wire [   AW-1:0] m2s1Addr;
  wire [   SW-1:0] m2s1Sel;
  wire [   DW-1:0] m2s1WData;
  wire             m2s1Ack;
  wire [   DW-1:0] m2s1RData;
  wire             m2s2Req;
  wire [CMD_W-1:0] m2s2Cmd;
  wire [   AW-1:0] m2s2Addr;
  wire [   SW-1:0] m2s2Sel;
  wire [   DW-1:0] m2s2WData;
  wire             m2s2Ack;
  wire [   DW-1:0] m2s2RData;
  wire             m2s3Req;
  wire [CMD_W-1:0] m2s3Cmd;
  wire [   AW-1:0] m2s3Addr;
  wire [   SW-1:0] m2s3Sel;
  wire [   DW-1:0] m2s3WData;
  wire             m2s3Ack;
  wire [   DW-1:0] m2s3RData;
  wire             m3s0Req;
  wire [CMD_W-1:0] m3s0Cmd;
  wire [   AW-1:0] m3s0Addr;
  wire [   SW-1:0] m3s0Sel;
  wire [   DW-1:0] m3s0WData;
  wire             m3s0Ack;
  wire [   DW-1:0] m3s0RData;
  wire             m3s1Req;
  wire [CMD_W-1:0] m3s1Cmd;
  wire [   AW-1:0] m3s1Addr;
  wire [   SW-1:0] m3s1Sel;
  wire [   DW-1:0] m3s1WData;
  wire             m3s1Ack;
  wire [   DW-1:0] m3s1RData;
  wire             m3s2Req;
  wire [CMD_W-1:0] m3s2Cmd;
  wire [   AW-1:0] m3s2Addr;
  wire [   SW-1:0] m3s2Sel;
  wire [   DW-1:0] m3s2WData;
  wire             m3s2Ack;
  wire [   DW-1:0] m3s2RData;
  wire             m3s3Req;
  wire [CMD_W-1:0] m3s3Cmd;
  wire [   AW-1:0] m3s3Addr;
  wire [   SW-1:0] m3s3Sel;
  wire [   DW-1:0] m3s3WData;
  wire             m3s3Ack;
  wire [   DW-1:0] m3s3RData;


  master_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U0_master_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMstReq   (iMst0Req),
    .iMstCmd   (iMst0Cmd),
    .iMstAddr  (iMst0Addr),
    .iMstWData (iMst0WData),
    .iMstSel   (iMst0Sel),
    .oMstAck   (oMst0Ack),
    .oMstRData (oMst0RData),
    .oSlv0Req  (m0s0Req),
    .oSlv0Cmd  (m0s0Cmd),
    .oSlv0Addr (m0s0Addr),
    .oSlv0Sel  (m0s0Sel),
    .oSlv0WData(m0s0WData),
    .iSlv0Ack  (m0s0Ack),
    .iSlv0RData(m0s0RData),
    .oSlv1Req  (m0s1Req),
    .oSlv1Cmd  (m0s1Cmd),
    .oSlv1Addr (m0s1Addr),
    .oSlv1Sel  (m0s1Sel),
    .oSlv1WData(m0s1WData),
    .iSlv1Ack  (m0s1Ack),
    .iSlv1RData(m0s1RData),
    .oSlv2Req  (m0s2Req),
    .oSlv2Cmd  (m0s2Cmd),
    .oSlv2Addr (m0s2Addr),
    .oSlv2Sel  (m0s2Sel),
    .oSlv2WData(m0s2WData),
    .iSlv2Ack  (m0s2Ack),
    .iSlv2RData(m0s2RData),
    .oSlv3Req  (m0s3Req),
    .oSlv3Cmd  (m0s3Cmd),
    .oSlv3Addr (m0s3Addr),
    .oSlv3Sel  (m0s3Sel),
    .oSlv3WData(m0s3WData),
    .iSlv3Ack  (m0s3Ack),
    .iSlv3RData(m0s3RData)
  );

  master_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U1_master_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMstReq   (iMst1Req),
    .iMstCmd   (iMst1Cmd),
    .iMstAddr  (iMst1Addr),
    .iMstSel   (iMst1Sel),
    .iMstWData (iMst1WData),
    .oMstAck   (oMst1Ack),
    .oMstRData (oMst1RData),
    .oSlv0Req  (m1s0Req),
    .oSlv0Cmd  (m1s0Cmd),
    .oSlv0Addr (m1s0Addr),
    .oSlv0Sel  (m1s0Sel),
    .oSlv0WData(m1s0WData),
    .iSlv0Ack  (m1s0Ack),
    .iSlv0RData(m1s0RData),
    .oSlv1Req  (m1s1Req),
    .oSlv1Cmd  (m1s1Cmd),
    .oSlv1Addr (m1s1Addr),
    .oSlv1Sel  (m1s1Sel),
    .oSlv1WData(m1s1WData),
    .iSlv1Ack  (m1s1Ack),
    .iSlv1RData(m1s1RData),
    .oSlv2Req  (m1s2Req),
    .oSlv2Cmd  (m1s2Cmd),
    .oSlv2Addr (m1s2Addr),
    .oSlv2Sel  (m1s2Sel),
    .oSlv2WData(m1s2WData),
    .iSlv2Ack  (m1s2Ack),
    .iSlv2RData(m1s2RData),
    .oSlv3Req  (m1s3Req),
    .oSlv3Cmd  (m1s3Cmd),
    .oSlv3Addr (m1s3Addr),
    .oSlv3Sel  (m1s3Sel),
    .oSlv3WData(m1s3WData),
    .iSlv3Ack  (m1s3Ack),
    .iSlv3RData(m1s3RData)
  );

  master_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U2_master_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMstReq   (iMst2Req),
    .iMstCmd   (iMst2Cmd),
    .iMstAddr  (iMst2Addr),
    .iMstSel   (iMst2Sel),
    .iMstWData (iMst2WData),
    .oMstAck   (oMst2Ack),
    .oMstRData (oMst2RData),
    .oSlv0Req  (m2s0Req),
    .oSlv0Cmd  (m2s0Cmd),
    .oSlv0Addr (m2s0Addr),
    .oSlv0Sel  (m2s0Sel),
    .oSlv0WData(m2s0WData),
    .iSlv0Ack  (m2s0Ack),
    .iSlv0RData(m2s0RData),
    .oSlv1Req  (m2s1Req),
    .oSlv1Cmd  (m2s1Cmd),
    .oSlv1Addr (m2s1Addr),
    .oSlv1Sel  (m2s1Sel),
    .oSlv1WData(m2s1WData),
    .iSlv1Ack  (m2s1Ack),
    .iSlv1RData(m2s1RData),
    .oSlv2Req  (m2s2Req),
    .oSlv2Cmd  (m2s2Cmd),
    .oSlv2Addr (m2s2Addr),
    .oSlv2Sel  (m2s2Sel),
    .oSlv2WData(m2s2WData),
    .iSlv2Ack  (m2s2Ack),
    .iSlv2RData(m2s2RData),
    .oSlv3Req  (m2s3Req),
    .oSlv3Cmd  (m2s3Cmd),
    .oSlv3Addr (m2s3Addr),
    .oSlv3Sel  (m2s3Sel),
    .oSlv3WData(m2s3WData),
    .iSlv3Ack  (m2s3Ack),
    .iSlv3RData(m2s3RData)
  );

  master_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U3_master_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMstReq   (iMst3Req),
    .iMstCmd   (iMst3Cmd),
    .iMstAddr  (iMst3Addr),
    .iMstSel   (iMst3Sel),
    .iMstWData (iMst3WData),
    .oMstAck   (oMst3Ack),
    .oMstRData (oMst3RData),
    .oSlv0Req  (m3s0Req),
    .oSlv0Cmd  (m3s0Cmd),
    .oSlv0Addr (m3s0Addr),
    .oSlv0Sel  (m3s0Sel),
    .oSlv0WData(m3s0WData),
    .iSlv0Ack  (m3s0Ack),
    .iSlv0RData(m3s0RData),
    .oSlv1Req  (m3s1Req),
    .oSlv1Cmd  (m3s1Cmd),
    .oSlv1Addr (m3s1Addr),
    .oSlv1Sel  (m3s1Sel),
    .oSlv1WData(m3s1WData),
    .iSlv1Ack  (m3s1Ack),
    .iSlv1RData(m3s1RData),
    .oSlv2Req  (m3s2Req),
    .oSlv2Cmd  (m3s2Cmd),
    .oSlv2Addr (m3s2Addr),
    .oSlv2Sel  (m3s2Sel),
    .oSlv2WData(m3s2WData),
    .iSlv2Ack  (m3s2Ack),
    .iSlv2RData(m3s2RData),
    .oSlv3Req  (m3s3Req),
    .oSlv3Cmd  (m3s3Cmd),
    .oSlv3Addr (m3s3Addr),
    .oSlv3Sel  (m3s3Sel),
    .oSlv3WData(m3s3WData),
    .iSlv3Ack  (m3s3Ack),
    .iSlv3RData(m3s3RData)
  );

  slave_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U0_slave_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMst0Req  (m0s0Req),
    .iMst0Cmd  (m0s0Cmd),
    .iMst0Addr (m0s0Addr),
    .iMst0Sel  (m0s0Sel),
    .iMst0WData(m0s0WData),
    .oMst0Ack  (m0s0Ack),
    .oMst0RData(m0s0RData),
    .iMst1Req  (m1s0Req),
    .iMst1Cmd  (m1s0Cmd),
    .iMst1Addr (m1s0Addr),
    .iMst1Sel  (m1s0Sel),
    .iMst1WData(m1s0WData),
    .oMst1Ack  (m1s0Ack),
    .oMst1RData(m1s0RData),
    .iMst2Req  (m2s0Req),
    .iMst2Cmd  (m2s0Cmd),
    .iMst2Addr (m2s0Addr),
    .iMst2Sel  (m2s0Sel),
    .iMst2WData(m2s0WData),
    .oMst2Ack  (m2s0Ack),
    .oMst2RData(m2s0RData),
    .iMst3Req  (m3s0Req),
    .iMst3Cmd  (m3s0Cmd),
    .iMst3Addr (m3s0Addr),
    .iMst3Sel  (m3s0Sel),
    .iMst3WData(m3s0WData),
    .oMst3Ack  (m3s0Ack),
    .oMst3RData(m3s0RData),
    .oSlvReq   (oSlv0Req),
    .oSlvCmd   (oSlv0Cmd),
    .oSlvAddr  (oSlv0Addr),
    .oSlvSel   (oSlv0Sel),
    .oSlvWData (oSlv0WData),
    .iSlvAck   (iSlv0Ack),
    .iSlvRData (iSlv0RData)
  );

  slave_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U1_slave_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMst0Req  (m0s1Req),
    .iMst0Cmd  (m0s1Cmd),
    .iMst0Addr (m0s1Addr),
    .iMst0Sel  (m0s1Sel),
    .iMst0WData(m0s1WData),
    .oMst0Ack  (m0s1Ack),
    .oMst0RData(m0s1RData),
    .iMst1Req  (m1s1Req),
    .iMst1Cmd  (m1s1Cmd),
    .iMst1Addr (m1s1Addr),
    .iMst1Sel  (m1s1Sel),
    .iMst1WData(m1s1WData),
    .oMst1Ack  (m1s1Ack),
    .oMst1RData(m1s1RData),
    .iMst2Req  (m2s1Req),
    .iMst2Cmd  (m2s1Cmd),
    .iMst2Addr (m2s1Addr),
    .iMst2Sel  (m2s1Sel),
    .iMst2WData(m2s1WData),
    .oMst2Ack  (m2s1Ack),
    .oMst2RData(m2s1RData),
    .iMst3Req  (m3s1Req),
    .iMst3Cmd  (m3s1Cmd),
    .iMst3Addr (m3s1Addr),
    .iMst3Sel  (m3s1Sel),
    .iMst3WData(m3s1WData),
    .oMst3Ack  (m3s1Ack),
    .oMst3RData(m3s1RData),
    .oSlvReq   (oSlv1Req),
    .oSlvCmd   (oSlv1Cmd),
    .oSlvAddr  (oSlv1Addr),
    .oSlvSel   (oSlv1Sel),
    .oSlvWData (oSlv1WData),
    .iSlvAck   (iSlv1Ack),
    .iSlvRData (iSlv1RData)
  );

  slave_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U2_slave_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMst0Req  (m0s2Req),
    .iMst0Cmd  (m0s2Cmd),
    .iMst0Addr (m0s2Addr),
    .iMst0Sel  (m0s2Sel),
    .iMst0WData(m0s2WData),
    .oMst0Ack  (m0s2Ack),
    .oMst0RData(m0s2RData),
    .iMst1Req  (m1s2Req),
    .iMst1Cmd  (m1s2Cmd),
    .iMst1Addr (m1s2Addr),
    .iMst1Sel  (m1s2Sel),
    .iMst1WData(m1s2WData),
    .oMst1Ack  (m1s2Ack),
    .oMst1RData(m1s2RData),
    .iMst2Req  (m2s2Req),
    .iMst2Cmd  (m2s2Cmd),
    .iMst2Addr (m2s2Addr),
    .iMst2Sel  (m2s2Sel),
    .iMst2WData(m2s2WData),
    .oMst2Ack  (m2s2Ack),
    .oMst2RData(m2s2RData),
    .iMst3Req  (m3s2Req),
    .iMst3Cmd  (m3s2Cmd),
    .iMst3Addr (m3s2Addr),
    .iMst3Sel  (m3s2Sel),
    .iMst3WData(m3s2WData),
    .oMst3Ack  (m3s2Ack),
    .oMst3RData(m3s2RData),
    .oSlvReq   (oSlv2Req),
    .oSlvCmd   (oSlv2Cmd),
    .oSlvAddr  (oSlv2Addr),
    .oSlvSel   (oSlv2Sel),
    .oSlvWData (oSlv2WData),
    .iSlvAck   (iSlv2Ack),
    .iSlvRData (iSlv2RData)
  );

  slave_if #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U3_slave_if (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMst0Req  (m0s3Req),
    .iMst0Cmd  (m0s3Cmd),
    .iMst0Addr (m0s3Addr),
    .iMst0Sel  (m0s3Sel),
    .iMst0WData(m0s3WData),
    .oMst0Ack  (m0s3Ack),
    .oMst0RData(m0s3RData),
    .iMst1Req  (m1s3Req),
    .iMst1Cmd  (m1s3Cmd),
    .iMst1Addr (m1s3Addr),
    .iMst1Sel  (m1s3Sel),
    .iMst1WData(m1s3WData),
    .oMst1Ack  (m1s3Ack),
    .oMst1RData(m1s3RData),
    .iMst2Req  (m2s3Req),
    .iMst2Cmd  (m2s3Cmd),
    .iMst2Addr (m2s3Addr),
    .iMst2Sel  (m2s3Sel),
    .iMst2WData(m2s3WData),
    .oMst2Ack  (m2s3Ack),
    .oMst2RData(m2s3RData),
    .iMst3Req  (m3s3Req),
    .iMst3Cmd  (m3s3Cmd),
    .iMst3Addr (m3s3Addr),
    .iMst3Sel  (m3s3Sel),
    .iMst3WData(m3s3WData),
    .oMst3Ack  (m3s3Ack),
    .oMst3RData(m3s3RData),
    .oSlvReq   (oSlv3Req),
    .oSlvCmd   (oSlv3Cmd),
    .oSlvAddr  (oSlv3Addr),
    .oSlvSel   (oSlv3Sel),
    .oSlvWData (oSlv3WData),
    .iSlvAck   (iSlv3Ack),
    .iSlvRData (iSlv3RData)
  );
endmodule
