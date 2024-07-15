// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/interconnect_4x4.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-17
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-21
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
module interconnect_4x4 #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4
) (
  input  wire          iClk,
  input  wire          iRst_n,
  // Master Wr interface
  input  wire          iMst0WrReq,
  input  wire          iMst0WrValid,
  input  wire [AW-1:0] iMst0WrAddr,
  input  wire [SW-1:0] iMst0WrSel,
  input  wire          iMst0WrLast,
  input  wire [DW-1:0] iMst0WrData,
  output wire          oMst0WrReady,
  input  wire          iMst1WrReq,
  input  wire          iMst1WrValid,
  input  wire [AW-1:0] iMst1WrAddr,
  input  wire [SW-1:0] iMst1WrSel,
  input  wire          iMst1WrLast,
  input  wire [DW-1:0] iMst1WrData,
  output wire          oMst1WrReady,
  input  wire          iMst2WrReq,
  input  wire          iMst2WrValid,
  input  wire [AW-1:0] iMst2WrAddr,
  input  wire [SW-1:0] iMst2WrSel,
  input  wire          iMst2WrLast,
  input  wire [DW-1:0] iMst2WrData,
  output wire          oMst2WrReady,
  input  wire          iMst3WrReq,
  input  wire          iMst3WrValid,
  input  wire [AW-1:0] iMst3WrAddr,
  input  wire [SW-1:0] iMst3WrSel,
  input  wire          iMst3WrLast,
  input  wire [DW-1:0] iMst3WrData,
  output wire          oMst3WrReady,
  // Master Rd interface
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
  // Slave Wr interface
  output wire          oSlv0WrReq,
  output wire          oSlv0WrValid,
  output wire [AW-1:0] oSlv0WrAddr,
  output wire [SW-1:0] oSlv0WrSel,
  output wire          oSlv0WrLast,
  output wire [DW-1:0] oSlv0WrData,
  input  wire          iSlv0WrReady,
  output wire          oSlv1WrReq,
  output wire          oSlv1WrValid,
  output wire [AW-1:0] oSlv1WrAddr,
  output wire [SW-1:0] oSlv1WrSel,
  output wire          oSlv1WrLast,
  output wire [DW-1:0] oSlv1WrData,
  input  wire          iSlv1WrReady,
  output wire          oSlv2WrReq,
  output wire          oSlv2WrValid,
  output wire [AW-1:0] oSlv2WrAddr,
  output wire [SW-1:0] oSlv2WrSel,
  output wire          oSlv2WrLast,
  output wire [DW-1:0] oSlv2WrData,
  input  wire          iSlv2WrReady,
  output wire          oSlv3WrReq,
  output wire          oSlv3WrValid,
  output wire [AW-1:0] oSlv3WrAddr,
  output wire [SW-1:0] oSlv3WrSel,
  output wire          oSlv3WrLast,
  output wire [DW-1:0] oSlv3WrData,
  input  wire          iSlv3WrReady,
  // Slave Rd interface
  output wire          oSlv0RdReq,
  output wire          oSlv0RdValid,
  output wire [AW-1:0] oSlv0RdAddr,
  output wire [SW-1:0] oSlv0RdSel,
  output wire          oSlv0RdLast,
  input  wire          iSlv0RdReady,
  input  wire [DW-1:0] iSlv0RdData,
  output wire          oSlv1RdReq,
  output wire          oSlv1RdValid,
  output wire [AW-1:0] oSlv1RdAddr,
  output wire [SW-1:0] oSlv1RdSel,
  output wire          oSlv1RdLast,
  input  wire          iSlv1RdReady,
  input  wire [DW-1:0] iSlv1RdData,
  output wire          oSlv2RdReq,
  output wire          oSlv2RdValid,
  output wire [AW-1:0] oSlv2RdAddr,
  output wire [SW-1:0] oSlv2RdSel,
  output wire          oSlv2RdLast,
  input  wire          iSlv2RdReady,
  input  wire [DW-1:0] iSlv2RdData,
  output wire          oSlv3RdReq,
  output wire          oSlv3RdValid,
  output wire [AW-1:0] oSlv3RdAddr,
  output wire [SW-1:0] oSlv3RdSel,
  output wire          oSlv3RdLast,
  input  wire          iSlv3RdReady,
  input  wire [DW-1:0] iSlv3RdData
);

  // local Write signals
  wire          m0s0WrReq;
  wire          m0s0WrValid;
  wire [AW-1:0] m0s0WrAddr;
  wire [SW-1:0] m0s0WrSel;
  wire          m0s0WrLast;
  wire [DW-1:0] m0s0WrData;
  wire          m0s0WrReady;
  wire          m0s1WrReq;
  wire          m0s1WrValid;
  wire [AW-1:0] m0s1WrAddr;
  wire [SW-1:0] m0s1WrSel;
  wire          m0s1WrLast;
  wire [DW-1:0] m0s1WrData;
  wire          m0s1WrReady;
  wire          m0s2WrReq;
  wire          m0s2WrValid;
  wire [AW-1:0] m0s2WrAddr;
  wire [SW-1:0] m0s2WrSel;
  wire          m0s2WrLast;
  wire [DW-1:0] m0s2WrData;
  wire          m0s2WrReady;
  wire          m0s3WrReq;
  wire          m0s3WrValid;
  wire [AW-1:0] m0s3WrAddr;
  wire [SW-1:0] m0s3WrSel;
  wire          m0s3WrLast;
  wire [DW-1:0] m0s3WrData;
  wire          m0s3WrReady;
  wire          m1s0WrReq;
  wire          m1s0WrValid;
  wire [AW-1:0] m1s0WrAddr;
  wire [SW-1:0] m1s0WrSel;
  wire          m1s0WrLast;
  wire [DW-1:0] m1s0WrData;
  wire          m1s0WrReady;
  wire          m1s1WrReq;
  wire          m1s1WrValid;
  wire [AW-1:0] m1s1WrAddr;
  wire [SW-1:0] m1s1WrSel;
  wire          m1s1WrLast;
  wire [DW-1:0] m1s1WrData;
  wire          m1s1WrReady;
  wire          m1s2WrReq;
  wire          m1s2WrValid;
  wire [AW-1:0] m1s2WrAddr;
  wire [SW-1:0] m1s2WrSel;
  wire          m1s2WrLast;
  wire [DW-1:0] m1s2WrData;
  wire          m1s2WrReady;
  wire          m1s3WrReq;
  wire          m1s3WrValid;
  wire [AW-1:0] m1s3WrAddr;
  wire [SW-1:0] m1s3WrSel;
  wire          m1s3WrLast;
  wire [DW-1:0] m1s3WrData;
  wire          m1s3WrReady;
  wire          m2s0WrReq;
  wire          m2s0WrValid;
  wire [AW-1:0] m2s0WrAddr;
  wire [SW-1:0] m2s0WrSel;
  wire          m2s0WrLast;
  wire [DW-1:0] m2s0WrData;
  wire          m2s0WrReady;
  wire          m2s1WrReq;
  wire          m2s1WrValid;
  wire [AW-1:0] m2s1WrAddr;
  wire [SW-1:0] m2s1WrSel;
  wire          m2s1WrLast;
  wire [DW-1:0] m2s1WrData;
  wire          m2s1WrReady;
  wire          m2s2WrReq;
  wire          m2s2WrValid;
  wire [AW-1:0] m2s2WrAddr;
  wire [SW-1:0] m2s2WrSel;
  wire          m2s2WrLast;
  wire [DW-1:0] m2s2WrData;
  wire          m2s2WrReady;
  wire          m2s3WrReq;
  wire          m2s3WrValid;
  wire [AW-1:0] m2s3WrAddr;
  wire [SW-1:0] m2s3WrSel;
  wire          m2s3WrLast;
  wire [DW-1:0] m2s3WrData;
  wire          m2s3WrReady;
  wire          m3s0WrReq;
  wire          m3s0WrValid;
  wire [AW-1:0] m3s0WrAddr;
  wire [SW-1:0] m3s0WrSel;
  wire          m3s0WrLast;
  wire [DW-1:0] m3s0WrData;
  wire          m3s0WrReady;
  wire          m3s1WrReq;
  wire          m3s1WrValid;
  wire [AW-1:0] m3s1WrAddr;
  wire [SW-1:0] m3s1WrSel;
  wire          m3s1WrLast;
  wire [DW-1:0] m3s1WrData;
  wire          m3s1WrReady;
  wire          m3s2WrReq;
  wire          m3s2WrValid;
  wire [AW-1:0] m3s2WrAddr;
  wire [SW-1:0] m3s2WrSel;
  wire          m3s2WrLast;
  wire [DW-1:0] m3s2WrData;
  wire          m3s2WrReady;
  wire          m3s3WrReq;
  wire          m3s3WrValid;
  wire [AW-1:0] m3s3WrAddr;
  wire [SW-1:0] m3s3WrSel;
  wire          m3s3WrLast;
  wire [DW-1:0] m3s3WrData;
  wire          m3s3WrReady;

  // local Read signals
  wire          m0s0RdReq;
  wire          m0s0RdValid;
  wire [AW-1:0] m0s0RdAddr;
  wire [SW-1:0] m0s0RdSel;
  wire          m0s0RdLast;
  wire          m0s0RdReady;
  wire [DW-1:0] m0s0RdRData;
  wire          m0s1RdReq;
  wire          m0s1RdValid;
  wire [AW-1:0] m0s1RdAddr;
  wire [SW-1:0] m0s1RdSel;
  wire          m0s1RdLast;
  wire          m0s1RdReady;
  wire [DW-1:0] m0s1RdRData;
  wire          m0s2RdReq;
  wire          m0s2RdValid;
  wire [AW-1:0] m0s2RdAddr;
  wire [SW-1:0] m0s2RdSel;
  wire          m0s2RdLast;
  wire          m0s2RdReady;
  wire [DW-1:0] m0s2RdRData;
  wire          m0s3RdReq;
  wire          m0s3RdValid;
  wire [AW-1:0] m0s3RdAddr;
  wire [SW-1:0] m0s3RdSel;
  wire          m0s3RdLast;
  wire          m0s3RdReady;
  wire [DW-1:0] m0s3RdRData;
  wire          m1s0RdReq;
  wire          m1s0RdValid;
  wire [AW-1:0] m1s0RdAddr;
  wire [SW-1:0] m1s0RdSel;
  wire          m1s0RdLast;
  wire          m1s0RdReady;
  wire [DW-1:0] m1s0RdRData;
  wire          m1s1RdReq;
  wire          m1s1RdValid;
  wire [AW-1:0] m1s1RdAddr;
  wire [SW-1:0] m1s1RdSel;
  wire          m1s1RdLast;
  wire          m1s1RdReady;
  wire [DW-1:0] m1s1RdRData;
  wire          m1s2RdReq;
  wire          m1s2RdValid;
  wire [AW-1:0] m1s2RdAddr;
  wire [SW-1:0] m1s2RdSel;
  wire          m1s2RdLast;
  wire          m1s2RdReady;
  wire [DW-1:0] m1s2RdRData;
  wire          m1s3RdReq;
  wire          m1s3RdValid;
  wire [AW-1:0] m1s3RdAddr;
  wire [SW-1:0] m1s3RdSel;
  wire          m1s3RdLast;
  wire          m1s3RdReady;
  wire [DW-1:0] m1s3RdRData;
  wire          m2s0RdReq;
  wire          m2s0RdValid;
  wire [AW-1:0] m2s0RdAddr;
  wire [SW-1:0] m2s0RdSel;
  wire          m2s0RdLast;
  wire          m2s0RdReady;
  wire [DW-1:0] m2s0RdRData;
  wire          m2s1RdReq;
  wire          m2s1RdValid;
  wire [AW-1:0] m2s1RdAddr;
  wire [SW-1:0] m2s1RdSel;
  wire          m2s1RdLast;
  wire          m2s1RdReady;
  wire [DW-1:0] m2s1RdRData;
  wire          m2s2RdReq;
  wire          m2s2RdValid;
  wire [AW-1:0] m2s2RdAddr;
  wire [SW-1:0] m2s2RdSel;
  wire          m2s2RdLast;
  wire          m2s2RdReady;
  wire [DW-1:0] m2s2RdRData;
  wire          m2s3RdReq;
  wire          m2s3RdValid;
  wire [AW-1:0] m2s3RdAddr;
  wire [SW-1:0] m2s3RdSel;
  wire          m2s3RdLast;
  wire          m2s3RdReady;
  wire [DW-1:0] m2s3RdRData;
  wire          m3s0RdReq;
  wire          m3s0RdValid;
  wire [AW-1:0] m3s0RdAddr;
  wire [SW-1:0] m3s0RdSel;
  wire          m3s0RdLast;
  wire          m3s0RdReady;
  wire [DW-1:0] m3s0RdRData;
  wire          m3s1RdReq;
  wire          m3s1RdValid;
  wire [AW-1:0] m3s1RdAddr;
  wire [SW-1:0] m3s1RdSel;
  wire          m3s1RdLast;
  wire          m3s1RdReady;
  wire [DW-1:0] m3s1RdRData;
  wire          m3s2RdReq;
  wire          m3s2RdValid;
  wire [AW-1:0] m3s2RdAddr;
  wire [SW-1:0] m3s2RdSel;
  wire          m3s2RdLast;
  wire          m3s2RdReady;
  wire [DW-1:0] m3s2RdRData;
  wire          m3s3RdReq;
  wire          m3s3RdValid;
  wire [AW-1:0] m3s3RdAddr;
  wire [SW-1:0] m3s3RdSel;
  wire          m3s3RdLast;
  wire          m3s3RdReady;
  wire [DW-1:0] m3s3RdRData;

  master_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m0_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstWrReq   (iMst0WrReq),
    .iMstWrValid (iMst0WrValid),
    .iMstWrAddr  (iMst0WrAddr),
    .iMstWrSel   (iMst0WrSel),
    .iMstWrLast  (iMst0WrLast),
    .iMstWrData  (iMst0WrData),
    .oMstWrReady (oMst0WrReady),
    .oSlv0WrReq  (m0s0WrReq),
    .oSlv0WrValid(m0s0WrValid),
    .oSlv0WrAddr (m0s0WrAddr),
    .oSlv0WrSel  (m0s0WrSel),
    .oSlv0WrLast (m0s0WrLast),
    .oSlv0WrData (m0s0WrData),
    .iSlv0WrReady(m0s0WrReady),
    .oSlv1WrReq  (m0s1WrReq),
    .oSlv1WrValid(m0s1WrValid),
    .oSlv1WrAddr (m0s1WrAddr),
    .oSlv1WrSel  (m0s1WrSel),
    .oSlv1WrLast (m0s1WrLast),
    .oSlv1WrData (m0s1WrData),
    .iSlv1WrReady(m0s1WrReady),
    .oSlv2WrReq  (m0s2WrReq),
    .oSlv2WrValid(m0s2WrValid),
    .oSlv2WrAddr (m0s2WrAddr),
    .oSlv2WrSel  (m0s2WrSel),
    .oSlv2WrLast (m0s2WrLast),
    .oSlv2WrData (m0s2WrData),
    .iSlv2WrReady(m0s2WrReady),
    .oSlv3WrReq  (m0s3WrReq),
    .oSlv3WrValid(m0s3WrValid),
    .oSlv3WrAddr (m0s3WrAddr),
    .oSlv3WrSel  (m0s3WrSel),
    .oSlv3WrLast (m0s3WrLast),
    .oSlv3WrData (m0s3WrData),
    .iSlv3WrReady(m0s3WrReady)
  );

  master_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m1_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstWrReq   (iMst1WrReq),
    .iMstWrValid (iMst1WrValid),
    .iMstWrAddr  (iMst1WrAddr),
    .iMstWrSel   (iMst1WrSel),
    .iMstWrLast  (iMst1WrLast),
    .iMstWrData  (iMst1WrData),
    .oMstWrReady (oMst1WrReady),
    .oSlv0WrReq  (m1s0WrReq),
    .oSlv0WrValid(m1s0WrValid),
    .oSlv0WrAddr (m1s0WrAddr),
    .oSlv0WrSel  (m1s0WrSel),
    .oSlv0WrLast (m1s0WrLast),
    .oSlv0WrData (m1s0WrData),
    .iSlv0WrReady(m1s0WrReady),
    .oSlv1WrReq  (m1s1WrReq),
    .oSlv1WrValid(m1s1WrValid),
    .oSlv1WrAddr (m1s1WrAddr),
    .oSlv1WrSel  (m1s1WrSel),
    .oSlv1WrLast (m1s1WrLast),
    .oSlv1WrData (m1s1WrData),
    .iSlv1WrReady(m1s1WrReady),
    .oSlv2WrReq  (m1s2WrReq),
    .oSlv2WrValid(m1s2WrValid),
    .oSlv2WrAddr (m1s2WrAddr),
    .oSlv2WrSel  (m1s2WrSel),
    .oSlv2WrLast (m1s2WrLast),
    .oSlv2WrData (m1s2WrData),
    .iSlv2WrReady(m1s2WrReady),
    .oSlv3WrReq  (m1s3WrReq),
    .oSlv3WrValid(m1s3WrValid),
    .oSlv3WrAddr (m1s3WrAddr),
    .oSlv3WrSel  (m1s3WrSel),
    .oSlv3WrLast (m1s3WrLast),
    .oSlv3WrData (m1s3WrData),
    .iSlv3WrReady(m1s3WrReady)
  );

  master_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m2_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstWrReq   (iMst2WrReq),
    .iMstWrValid (iMst2WrValid),
    .iMstWrAddr  (iMst2WrAddr),
    .iMstWrSel   (iMst2WrSel),
    .iMstWrLast  (iMst2WrLast),
    .iMstWrData  (iMst2WrData),
    .oMstWrReady (oMst2WrReady),
    .oSlv0WrReq  (m2s0WrReq),
    .oSlv0WrValid(m2s0WrValid),
    .oSlv0WrAddr (m2s0WrAddr),
    .oSlv0WrSel  (m2s0WrSel),
    .oSlv0WrLast (m2s0WrLast),
    .oSlv0WrData (m2s0WrData),
    .iSlv0WrReady(m2s0WrReady),
    .oSlv1WrReq  (m2s1WrReq),
    .oSlv1WrValid(m2s1WrValid),
    .oSlv1WrAddr (m2s1WrAddr),
    .oSlv1WrSel  (m2s1WrSel),
    .oSlv1WrLast (m2s1WrLast),
    .oSlv1WrData (m2s1WrData),
    .iSlv1WrReady(m2s1WrReady),
    .oSlv2WrReq  (m2s2WrReq),
    .oSlv2WrValid(m2s2WrValid),
    .oSlv2WrAddr (m2s2WrAddr),
    .oSlv2WrSel  (m2s2WrSel),
    .oSlv2WrLast (m2s2WrLast),
    .oSlv2WrData (m2s2WrData),
    .iSlv2WrReady(m2s2WrReady),
    .oSlv3WrReq  (m2s3WrReq),
    .oSlv3WrValid(m2s3WrValid),
    .oSlv3WrAddr (m2s3WrAddr),
    .oSlv3WrSel  (m2s3WrSel),
    .oSlv3WrLast (m2s3WrLast),
    .oSlv3WrData (m2s3WrData),
    .iSlv3WrReady(m2s3WrReady)
  );

  master_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m3_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstWrReq   (iMst3WrReq),
    .iMstWrValid (iMst3WrValid),
    .iMstWrAddr  (iMst3WrAddr),
    .iMstWrSel   (iMst3WrSel),
    .iMstWrLast  (iMst3WrLast),
    .iMstWrData  (iMst3WrData),
    .oMstWrReady (oMst3WrReady),
    .oSlv0WrReq  (m3s0WrReq),
    .oSlv0WrValid(m3s0WrValid),
    .oSlv0WrAddr (m3s0WrAddr),
    .oSlv0WrSel  (m3s0WrSel),
    .oSlv0WrLast (m3s0WrLast),
    .oSlv0WrData (m3s0WrData),
    .iSlv0WrReady(m3s0WrReady),
    .oSlv1WrReq  (m3s1WrReq),
    .oSlv1WrValid(m3s1WrValid),
    .oSlv1WrAddr (m3s1WrAddr),
    .oSlv1WrSel  (m3s1WrSel),
    .oSlv1WrLast (m3s1WrLast),
    .oSlv1WrData (m3s1WrData),
    .iSlv1WrReady(m3s1WrReady),
    .oSlv2WrReq  (m3s2WrReq),
    .oSlv2WrValid(m3s2WrValid),
    .oSlv2WrAddr (m3s2WrAddr),
    .oSlv2WrSel  (m3s2WrSel),
    .oSlv2WrLast (m3s2WrLast),
    .oSlv2WrData (m3s2WrData),
    .iSlv2WrReady(m3s2WrReady),
    .oSlv3WrReq  (m3s3WrReq),
    .oSlv3WrValid(m3s3WrValid),
    .oSlv3WrAddr (m3s3WrAddr),
    .oSlv3WrSel  (m3s3WrSel),
    .oSlv3WrLast (m3s3WrLast),
    .oSlv3WrData (m3s3WrData),
    .iSlv3WrReady(m3s3WrReady)
  );

  master_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m0_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstRdReq   (iMst0RdReq),
    .iMstRdValid (iMst0RdValid),
    .iMstRdAddr  (iMst0RdAddr),
    .iMstRdSel   (iMst0RdSel),
    .iMstRdLast  (iMst0RdLast),
    .oMstRdReady (oMst0RdReady),
    .oMstRdData  (oMst0RdData),
    .oSlv0RdReq  (m0s0RdReq),
    .oSlv0RdValid(m0s0RdValid),
    .oSlv0RdAddr (m0s0RdAddr),
    .oSlv0RdSel  (m0s0RdSel),
    .oSlv0RdLast (m0s0RdLast),
    .iSlv0RdReady(m0s0RdReady),
    .iSlv0RdData (m0s0RdRData),
    .oSlv1RdReq  (m0s1RdReq),
    .oSlv1RdValid(m0s1RdValid),
    .oSlv1RdAddr (m0s1RdAddr),
    .oSlv1RdSel  (m0s1RdSel),
    .oSlv1RdLast (m0s1RdLast),
    .iSlv1RdReady(m0s1RdReady),
    .iSlv1RdData (m0s1RdRData),
    .oSlv2RdReq  (m0s2RdReq),
    .oSlv2RdValid(m0s2RdValid),
    .oSlv2RdAddr (m0s2RdAddr),
    .oSlv2RdSel  (m0s2RdSel),
    .oSlv2RdLast (m0s2RdLast),
    .iSlv2RdReady(m0s2RdReady),
    .iSlv2RdData (m0s2RdRData),
    .oSlv3RdReq  (m0s3RdReq),
    .oSlv3RdValid(m0s3RdValid),
    .oSlv3RdAddr (m0s3RdAddr),
    .oSlv3RdSel  (m0s3RdSel),
    .oSlv3RdLast (m0s3RdLast),
    .iSlv3RdReady(m0s3RdReady),
    .iSlv3RdData (m0s3RdRData)
  );

  master_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m1_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstRdReq   (iMst1RdReq),
    .iMstRdValid (iMst1RdValid),
    .iMstRdAddr  (iMst1RdAddr),
    .iMstRdSel   (iMst1RdSel),
    .iMstRdLast  (iMst1RdLast),
    .oMstRdReady (oMst1RdReady),
    .oMstRdData  (oMst1RdData),
    .oSlv0RdReq  (m1s0RdReq),
    .oSlv0RdValid(m1s0RdValid),
    .oSlv0RdAddr (m1s0RdAddr),
    .oSlv0RdSel  (m1s0RdSel),
    .oSlv0RdLast (m1s0RdLast),
    .iSlv0RdReady(m1s0RdReady),
    .iSlv0RdData (m1s0RdRData),
    .oSlv1RdReq  (m1s1RdReq),
    .oSlv1RdValid(m1s1RdValid),
    .oSlv1RdAddr (m1s1RdAddr),
    .oSlv1RdSel  (m1s1RdSel),
    .oSlv1RdLast (m1s1RdLast),
    .iSlv1RdReady(m1s1RdReady),
    .iSlv1RdData (m1s1RdRData),
    .oSlv2RdReq  (m1s2RdReq),
    .oSlv2RdValid(m1s2RdValid),
    .oSlv2RdAddr (m1s2RdAddr),
    .oSlv2RdSel  (m1s2RdSel),
    .oSlv2RdLast (m1s2RdLast),
    .iSlv2RdReady(m1s2RdReady),
    .iSlv2RdData (m1s2RdRData),
    .oSlv3RdReq  (m1s3RdReq),
    .oSlv3RdValid(m1s3RdValid),
    .oSlv3RdAddr (m1s3RdAddr),
    .oSlv3RdSel  (m1s3RdSel),
    .oSlv3RdLast (m1s3RdLast),
    .iSlv3RdReady(m1s3RdReady),
    .iSlv3RdData (m1s3RdRData)
  );

  master_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m2_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstRdReq   (iMst2RdReq),
    .iMstRdValid (iMst2RdValid),
    .iMstRdAddr  (iMst2RdAddr),
    .iMstRdSel   (iMst2RdSel),
    .iMstRdLast  (iMst2RdLast),
    .oMstRdReady (oMst2RdReady),
    .oMstRdData  (oMst2RdData),
    .oSlv0RdReq  (m2s0RdReq),
    .oSlv0RdValid(m2s0RdValid),
    .oSlv0RdAddr (m2s0RdAddr),
    .oSlv0RdSel  (m2s0RdSel),
    .oSlv0RdLast (m2s0RdLast),
    .iSlv0RdReady(m2s0RdReady),
    .iSlv0RdData (m2s0RdRData),
    .oSlv1RdReq  (m2s1RdReq),
    .oSlv1RdValid(m2s1RdValid),
    .oSlv1RdAddr (m2s1RdAddr),
    .oSlv1RdSel  (m2s1RdSel),
    .oSlv1RdLast (m2s1RdLast),
    .iSlv1RdReady(m2s1RdReady),
    .iSlv1RdData (m2s1RdRData),
    .oSlv2RdReq  (m2s2RdReq),
    .oSlv2RdValid(m2s2RdValid),
    .oSlv2RdAddr (m2s2RdAddr),
    .oSlv2RdSel  (m2s2RdSel),
    .oSlv2RdLast (m2s2RdLast),
    .iSlv2RdReady(m2s2RdReady),
    .iSlv2RdData (m2s2RdRData),
    .oSlv3RdReq  (m2s3RdReq),
    .oSlv3RdValid(m2s3RdValid),
    .oSlv3RdAddr (m2s3RdAddr),
    .oSlv3RdSel  (m2s3RdSel),
    .oSlv3RdLast (m2s3RdLast),
    .iSlv3RdReady(m2s3RdReady),
    .iSlv3RdData (m2s3RdRData)
  );

  master_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) m3_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMstRdReq   (iMst3RdReq),
    .iMstRdValid (iMst3RdValid),
    .iMstRdAddr  (iMst3RdAddr),
    .iMstRdSel   (iMst3RdSel),
    .iMstRdLast  (iMst3RdLast),
    .oMstRdReady (oMst3RdReady),
    .oMstRdData  (oMst3RdData),
    .oSlv0RdReq  (m3s0RdReq),
    .oSlv0RdValid(m3s0RdValid),
    .oSlv0RdAddr (m3s0RdAddr),
    .oSlv0RdSel  (m3s0RdSel),
    .oSlv0RdLast (m3s0RdLast),
    .iSlv0RdReady(m3s0RdReady),
    .iSlv0RdData (m3s0RdRData),
    .oSlv1RdReq  (m3s1RdReq),
    .oSlv1RdValid(m3s1RdValid),
    .oSlv1RdAddr (m3s1RdAddr),
    .oSlv1RdSel  (m3s1RdSel),
    .oSlv1RdLast (m3s1RdLast),
    .iSlv1RdReady(m3s1RdReady),
    .iSlv1RdData (m3s1RdRData),
    .oSlv2RdReq  (m3s2RdReq),
    .oSlv2RdValid(m3s2RdValid),
    .oSlv2RdAddr (m3s2RdAddr),
    .oSlv2RdSel  (m3s2RdSel),
    .oSlv2RdLast (m3s2RdLast),
    .iSlv2RdReady(m3s2RdReady),
    .iSlv2RdData (m3s2RdRData),
    .oSlv3RdReq  (m3s3RdReq),
    .oSlv3RdValid(m3s3RdValid),
    .oSlv3RdAddr (m3s3RdAddr),
    .oSlv3RdSel  (m3s3RdSel),
    .oSlv3RdLast (m3s3RdLast),
    .iSlv3RdReady(m3s3RdReady),
    .iSlv3RdData (m3s3RdRData)
  );

  slave_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s0_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (m0s0WrReq),
    .iMst0WrValid(m0s0WrValid),
    .iMst0WrAddr (m0s0WrAddr),
    .iMst0WrSel  (m0s0WrSel),
    .iMst0WrLast (m0s0WrLast),
    .iMst0WrData (m0s0WrData),
    .oMst0WrReady(m0s0WrReady),
    .iMst1WrReq  (m1s0WrReq),
    .iMst1WrValid(m1s0WrValid),
    .iMst1WrAddr (m1s0WrAddr),
    .iMst1WrSel  (m1s0WrSel),
    .iMst1WrLast (m1s0WrLast),
    .iMst1WrData (m1s0WrData),
    .oMst1WrReady(m1s0WrReady),
    .iMst2WrReq  (m2s0WrReq),
    .iMst2WrValid(m2s0WrValid),
    .iMst2WrAddr (m2s0WrAddr),
    .iMst2WrSel  (m2s0WrSel),
    .iMst2WrLast (m2s0WrLast),
    .iMst2WrData (m2s0WrData),
    .oMst2WrReady(m2s0WrReady),
    .iMst3WrReq  (m3s0WrReq),
    .iMst3WrValid(m3s0WrValid),
    .iMst3WrAddr (m3s0WrAddr),
    .iMst3WrSel  (m3s0WrSel),
    .iMst3WrLast (m3s0WrLast),
    .iMst3WrData (m3s0WrData),
    .oMst3WrReady(m3s0WrReady),
    .oSlvWrReq   (oSlv0WrReq),
    .oSlvWrValid (oSlv0WrValid),
    .oSlvWrAddr  (oSlv0WrAddr),
    .oSlvWrSel   (oSlv0WrSel),
    .oSlvWrLast  (oSlv0WrLast),
    .oSlvWrData  (oSlv0WrData),
    .iSlvWrReady (iSlv0WrReady)
  );

  slave_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s1_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (m0s1WrReq),
    .iMst0WrValid(m0s1WrValid),
    .iMst0WrAddr (m0s1WrAddr),
    .iMst0WrSel  (m0s1WrSel),
    .iMst0WrLast (m0s1WrLast),
    .iMst0WrData (m0s1WrData),
    .oMst0WrReady(m0s1WrReady),
    .iMst1WrReq  (m1s1WrReq),
    .iMst1WrValid(m1s1WrValid),
    .iMst1WrAddr (m1s1WrAddr),
    .iMst1WrSel  (m1s1WrSel),
    .iMst1WrLast (m1s1WrLast),
    .iMst1WrData (m1s1WrData),
    .oMst1WrReady(m1s1WrReady),
    .iMst2WrReq  (m2s1WrReq),
    .iMst2WrValid(m2s1WrValid),
    .iMst2WrAddr (m2s1WrAddr),
    .iMst2WrSel  (m2s1WrSel),
    .iMst2WrLast (m2s1WrLast),
    .iMst2WrData (m2s1WrData),
    .oMst2WrReady(m2s1WrReady),
    .iMst3WrReq  (m3s1WrReq),
    .iMst3WrValid(m3s1WrValid),
    .iMst3WrAddr (m3s1WrAddr),
    .iMst3WrSel  (m3s1WrSel),
    .iMst3WrLast (m3s1WrLast),
    .iMst3WrData (m3s1WrData),
    .oMst3WrReady(m3s1WrReady),
    .oSlvWrReq   (oSlv1WrReq),
    .oSlvWrValid (oSlv1WrValid),
    .oSlvWrAddr  (oSlv1WrAddr),
    .oSlvWrSel   (oSlv1WrSel),
    .oSlvWrLast  (oSlv1WrLast),
    .oSlvWrData  (oSlv1WrData),
    .iSlvWrReady (iSlv1WrReady)
  );

  slave_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s2_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (m0s2WrReq),
    .iMst0WrValid(m0s2WrValid),
    .iMst0WrAddr (m0s2WrAddr),
    .iMst0WrSel  (m0s2WrSel),
    .iMst0WrLast (m0s2WrLast),
    .iMst0WrData (m0s2WrData),
    .oMst0WrReady(m0s2WrReady),
    .iMst1WrReq  (m1s2WrReq),
    .iMst1WrValid(m1s2WrValid),
    .iMst1WrAddr (m1s2WrAddr),
    .iMst1WrSel  (m1s2WrSel),
    .iMst1WrLast (m1s2WrLast),
    .iMst1WrData (m1s2WrData),
    .oMst1WrReady(m1s2WrReady),
    .iMst2WrReq  (m2s2WrReq),
    .iMst2WrValid(m2s2WrValid),
    .iMst2WrAddr (m2s2WrAddr),
    .iMst2WrSel  (m2s2WrSel),
    .iMst2WrLast (m2s2WrLast),
    .iMst2WrData (m2s2WrData),
    .oMst2WrReady(m2s2WrReady),
    .iMst3WrReq  (m3s2WrReq),
    .iMst3WrValid(m3s2WrValid),
    .iMst3WrAddr (m3s2WrAddr),
    .iMst3WrSel  (m3s2WrSel),
    .iMst3WrLast (m3s2WrLast),
    .iMst3WrData (m3s2WrData),
    .oMst3WrReady(m3s2WrReady),
    .oSlvWrReq   (oSlv2WrReq),
    .oSlvWrValid (oSlv2WrValid),
    .oSlvWrAddr  (oSlv2WrAddr),
    .oSlvWrSel   (oSlv2WrSel),
    .oSlvWrLast  (oSlv2WrLast),
    .oSlvWrData  (oSlv2WrData),
    .iSlvWrReady (iSlv2WrReady)
  );

  slave_if_wr #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s3_wr (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (m0s3WrReq),
    .iMst0WrValid(m0s3WrValid),
    .iMst0WrAddr (m0s3WrAddr),
    .iMst0WrSel  (m0s3WrSel),
    .iMst0WrLast (m0s3WrLast),
    .iMst0WrData (m0s3WrData),
    .oMst0WrReady(m0s3WrReady),
    .iMst1WrReq  (m1s3WrReq),
    .iMst1WrValid(m1s3WrValid),
    .iMst1WrAddr (m1s3WrAddr),
    .iMst1WrSel  (m1s3WrSel),
    .iMst1WrLast (m1s3WrLast),
    .iMst1WrData (m1s3WrData),
    .oMst1WrReady(m1s3WrReady),
    .iMst2WrReq  (m2s3WrReq),
    .iMst2WrValid(m2s3WrValid),
    .iMst2WrAddr (m2s3WrAddr),
    .iMst2WrSel  (m2s3WrSel),
    .iMst2WrLast (m2s3WrLast),
    .iMst2WrData (m2s3WrData),
    .oMst2WrReady(m2s3WrReady),
    .iMst3WrReq  (m3s3WrReq),
    .iMst3WrValid(m3s3WrValid),
    .iMst3WrAddr (m3s3WrAddr),
    .iMst3WrSel  (m3s3WrSel),
    .iMst3WrLast (m3s3WrLast),
    .iMst3WrData (m3s3WrData),
    .oMst3WrReady(m3s3WrReady),
    .oSlvWrReq   (oSlv3WrReq),
    .oSlvWrValid (oSlv3WrValid),
    .oSlvWrAddr  (oSlv3WrAddr),
    .oSlvWrSel   (oSlv3WrSel),
    .oSlvWrLast  (oSlv3WrLast),
    .oSlvWrData  (oSlv3WrData),
    .iSlvWrReady (iSlv3WrReady)
  );

  slave_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s0_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0RdReq  (m0s0RdReq),
    .iMst0RdValid(m0s0RdValid),
    .iMst0RdAddr (m0s0RdAddr),
    .iMst0RdSel  (m0s0RdSel),
    .iMst0RdLast (m0s0RdLast),
    .oMst0RdReady(m0s0RdReady),
    .oMst0RdData (m0s0RdRData),
    .iMst1RdReq  (m1s0RdReq),
    .iMst1RdValid(m1s0RdValid),
    .iMst1RdAddr (m1s0RdAddr),
    .iMst1RdSel  (m1s0RdSel),
    .iMst1RdLast (m1s0RdLast),
    .oMst1RdReady(m1s0RdReady),
    .oMst1RdData (m1s0RdRData),
    .iMst2RdReq  (m2s0RdReq),
    .iMst2RdValid(m2s0RdValid),
    .iMst2RdAddr (m2s0RdAddr),
    .iMst2RdSel  (m2s0RdSel),
    .iMst2RdLast (m2s0RdLast),
    .oMst2RdReady(m2s0RdReady),
    .oMst2RdData (m2s0RdRData),
    .iMst3RdReq  (m3s0RdReq),
    .iMst3RdValid(m3s0RdValid),
    .iMst3RdAddr (m3s0RdAddr),
    .iMst3RdSel  (m3s0RdSel),
    .iMst3RdLast (m3s0RdLast),
    .oMst3RdReady(m3s0RdReady),
    .oMst3RdData (m3s0RdRData),
    .oSlvRdReq   (oSlv0RdReq),
    .oSlvRdValid (oSlv0RdValid),
    .oSlvRdAddr  (oSlv0RdAddr),
    .oSlvRdSel   (oSlv0RdSel),
    .oSlvRdLast  (oSlv0RdLast),
    .iSlvRdReady (iSlv0RdReady),
    .iSlvRdData  (iSlv0RdData)
  );

  slave_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s1_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0RdReq  (m0s1RdReq),
    .iMst0RdValid(m0s1RdValid),
    .iMst0RdAddr (m0s1RdAddr),
    .iMst0RdSel  (m0s1RdSel),
    .iMst0RdLast (m0s1RdLast),
    .oMst0RdReady(m0s1RdReady),
    .oMst0RdData (m0s1RdRData),
    .iMst1RdReq  (m1s1RdReq),
    .iMst1RdValid(m1s1RdValid),
    .iMst1RdAddr (m1s1RdAddr),
    .iMst1RdSel  (m1s1RdSel),
    .iMst1RdLast (m1s1RdLast),
    .oMst1RdReady(m1s1RdReady),
    .oMst1RdData (m1s1RdRData),
    .iMst2RdReq  (m2s1RdReq),
    .iMst2RdValid(m2s1RdValid),
    .iMst2RdAddr (m2s1RdAddr),
    .iMst2RdSel  (m2s1RdSel),
    .iMst2RdLast (m2s1RdLast),
    .oMst2RdReady(m2s1RdReady),
    .oMst2RdData (m2s1RdRData),
    .iMst3RdReq  (m3s1RdReq),
    .iMst3RdValid(m3s1RdValid),
    .iMst3RdAddr (m3s1RdAddr),
    .iMst3RdSel  (m3s1RdSel),
    .iMst3RdLast (m3s1RdLast),
    .oMst3RdReady(m3s1RdReady),
    .oMst3RdData (m3s1RdRData),
    .oSlvRdReq   (oSlv1RdReq),
    .oSlvRdValid (oSlv1RdValid),
    .oSlvRdAddr  (oSlv1RdAddr),
    .oSlvRdSel   (oSlv1RdSel),
    .oSlvRdLast  (oSlv1RdLast),
    .iSlvRdReady (iSlv1RdReady),
    .iSlvRdData  (iSlv1RdData)
  );

  slave_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s2_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0RdReq  (m0s2RdReq),
    .iMst0RdValid(m0s2RdValid),
    .iMst0RdAddr (m0s2RdAddr),
    .iMst0RdSel  (m0s2RdSel),
    .iMst0RdLast (m0s2RdLast),
    .oMst0RdReady(m0s2RdReady),
    .oMst0RdData (m0s2RdRData),
    .iMst1RdReq  (m1s2RdReq),
    .iMst1RdValid(m1s2RdValid),
    .iMst1RdAddr (m1s2RdAddr),
    .iMst1RdSel  (m1s2RdSel),
    .iMst1RdLast (m1s2RdLast),
    .oMst1RdReady(m1s2RdReady),
    .oMst1RdData (m1s2RdRData),
    .iMst2RdReq  (m2s2RdReq),
    .iMst2RdValid(m2s2RdValid),
    .iMst2RdAddr (m2s2RdAddr),
    .iMst2RdSel  (m2s2RdSel),
    .iMst2RdLast (m2s2RdLast),
    .oMst2RdReady(m2s2RdReady),
    .oMst2RdData (m2s2RdRData),
    .iMst3RdReq  (m3s2RdReq),
    .iMst3RdValid(m3s2RdValid),
    .iMst3RdAddr (m3s2RdAddr),
    .iMst3RdSel  (m3s2RdSel),
    .iMst3RdLast (m3s2RdLast),
    .oMst3RdReady(m3s2RdReady),
    .oMst3RdData (m3s2RdRData),
    .oSlvRdReq   (oSlv2RdReq),
    .oSlvRdValid (oSlv2RdValid),
    .oSlvRdAddr  (oSlv2RdAddr),
    .oSlvRdSel   (oSlv2RdSel),
    .oSlvRdLast  (oSlv2RdLast),
    .iSlvRdReady (iSlv2RdReady),
    .iSlvRdData  (iSlv2RdData)
  );

  slave_if_rd #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) s3_rd (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0RdReq  (m0s3RdReq),
    .iMst0RdValid(m0s3RdValid),
    .iMst0RdAddr (m0s3RdAddr),
    .iMst0RdSel  (m0s3RdSel),
    .iMst0RdLast (m0s3RdLast),
    .oMst0RdReady(m0s3RdReady),
    .oMst0RdData (m0s3RdRData),
    .iMst1RdReq  (m1s3RdReq),
    .iMst1RdValid(m1s3RdValid),
    .iMst1RdAddr (m1s3RdAddr),
    .iMst1RdSel  (m1s3RdSel),
    .iMst1RdLast (m1s3RdLast),
    .oMst1RdReady(m1s3RdReady),
    .oMst1RdData (m1s3RdRData),
    .iMst2RdReq  (m2s3RdReq),
    .iMst2RdValid(m2s3RdValid),
    .iMst2RdAddr (m2s3RdAddr),
    .iMst2RdSel  (m2s3RdSel),
    .iMst2RdLast (m2s3RdLast),
    .oMst2RdReady(m2s3RdReady),
    .oMst2RdData (m2s3RdRData),
    .iMst3RdReq  (m3s3RdReq),
    .iMst3RdValid(m3s3RdValid),
    .iMst3RdAddr (m3s3RdAddr),
    .iMst3RdSel  (m3s3RdSel),
    .iMst3RdLast (m3s3RdLast),
    .oMst3RdReady(m3s3RdReady),
    .oMst3RdData (m3s3RdRData),
    .oSlvRdReq   (oSlv3RdReq),
    .oSlvRdValid (oSlv3RdValid),
    .oSlvRdAddr  (oSlv3RdAddr),
    .oSlvRdSel   (oSlv3RdSel),
    .oSlvRdLast  (oSlv3RdLast),
    .iSlvRdReady (iSlv3RdReady),
    .iSlvRdData  (iSlv3RdData)
  );

endmodule
