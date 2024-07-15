// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_interconnect_block_drv.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-19
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

module tb_interconnect_block_drv;

  // Parameters
  localparam AW = 12;
  localparam DW = 32;
  localparam SW = 4;
  localparam MEM_SIZE = 4096;
  localparam VAW = AW;
  localparam PAW = VAW + 2;
  localparam TRANSLEN = 16;


  //Ports
  reg            iClk;
  reg            iRst_n;
  wire           iMst0WrReq;
  wire           iMst0WrValid;
  wire [ AW-1:0] iMst0WrAddr;
  wire [ SW-1:0] iMst0WrSel;
  wire           iMst0WrLast;
  wire [ DW-1:0] iMst0WrData;
  wire           oMst0WrReady;
  wire           iMst1WrReq;
  wire           iMst1WrValid;
  wire [ AW-1:0] iMst1WrAddr;
  wire [ SW-1:0] iMst1WrSel;
  wire           iMst1WrLast;
  wire [ DW-1:0] iMst1WrData;
  wire           oMst1WrReady;
  wire           iMst2WrReq;
  wire           iMst2WrValid;
  wire [ AW-1:0] iMst2WrAddr;
  wire [ SW-1:0] iMst2WrSel;
  wire           iMst2WrLast;
  wire [ DW-1:0] iMst2WrData;
  wire           oMst2WrReady;
  wire           iMst3WrReq;
  wire           iMst3WrValid;
  wire [ AW-1:0] iMst3WrAddr;
  wire [ SW-1:0] iMst3WrSel;
  wire           iMst3WrLast;
  wire [ DW-1:0] iMst3WrData;
  wire           oMst3WrReady;
  wire           iMst0RdReq;
  wire           iMst0RdValid;
  wire [ AW-1:0] iMst0RdAddr;
  wire [ SW-1:0] iMst0RdSel;
  wire           iMst0RdLast;
  wire           oMst0RdReady;
  wire [ DW-1:0] oMst0RdData;
  wire           iMst1RdReq;
  wire           iMst1RdValid;
  wire [ AW-1:0] iMst1RdAddr;
  wire [ SW-1:0] iMst1RdSel;
  wire           iMst1RdLast;
  wire           oMst1RdReady;
  wire [ DW-1:0] oMst1RdData;
  wire           iMst2RdReq;
  wire           iMst2RdValid;
  wire [ AW-1:0] iMst2RdAddr;
  wire [ SW-1:0] iMst2RdSel;
  wire           iMst2RdLast;
  wire           oMst2RdReady;
  wire [ DW-1:0] oMst2RdData;
  wire           iMst3RdReq;
  wire           iMst3RdValid;
  wire [ AW-1:0] iMst3RdAddr;
  wire [ SW-1:0] iMst3RdSel;
  wire           iMst3RdLast;
  wire           oMst3RdReady;
  wire [ DW-1:0] oMst3RdData;
  wire           oSlv0WrReq;
  wire           oSlv0WrValid;
  wire [ AW-1:0] oSlv0WrAddr;
  wire [ SW-1:0] oSlv0WrSel;
  wire           oSlv0WrLast;
  wire [ DW-1:0] oSlv0WrData;
  wire           iSlv0WrReady;
  wire           oSlv1WrReq;
  wire           oSlv1WrValid;
  wire [ AW-1:0] oSlv1WrAddr;
  wire [ SW-1:0] oSlv1WrSel;
  wire           oSlv1WrLast;
  wire [ DW-1:0] oSlv1WrData;
  wire           iSlv1WrReady;
  wire           oSlv2WrReq;
  wire           oSlv2WrValid;
  wire [ AW-1:0] oSlv2WrAddr;
  wire [ SW-1:0] oSlv2WrSel;
  wire           oSlv2WrLast;
  wire [ DW-1:0] oSlv2WrData;
  wire           iSlv2WrReady;
  wire           oSlv3WrReq;
  wire           oSlv3WrValid;
  wire [ AW-1:0] oSlv3WrAddr;
  wire [ SW-1:0] oSlv3WrSel;
  wire           oSlv3WrLast;
  wire [ DW-1:0] oSlv3WrData;
  wire           iSlv3WrReady;
  wire           oSlv0RdReq;
  wire           oSlv0RdValid;
  wire [ AW-1:0] oSlv0RdAddr;
  wire [ SW-1:0] oSlv0RdSel;
  wire           oSlv0RdLast;
  wire           iSlv0RdReady;
  wire [ DW-1:0] iSlv0RdData;
  wire           oSlv1RdReq;
  wire           oSlv1RdValid;
  wire [ AW-1:0] oSlv1RdAddr;
  wire [ SW-1:0] oSlv1RdSel;
  wire           oSlv1RdLast;
  wire           iSlv1RdReady;
  wire [ DW-1:0] iSlv1RdData;
  wire           oSlv2RdReq;
  wire           oSlv2RdValid;
  wire [ AW-1:0] oSlv2RdAddr;
  wire [ SW-1:0] oSlv2RdSel;
  wire           oSlv2RdLast;
  wire           iSlv2RdReady;
  wire [ DW-1:0] iSlv2RdData;
  wire           oSlv3RdReq;
  wire           oSlv3RdValid;
  wire [ AW-1:0] oSlv3RdAddr;
  wire [ SW-1:0] oSlv3RdSel;
  wire           oSlv3RdLast;
  wire           iSlv3RdReady;
  wire [ DW-1:0] iSlv3RdData;
  // SRAM interface
  wire           oCEnA0;
  wire           oCEnB0;
  wire           oWEnA0;
  wire           oWEnB0;
  wire [ DW-1:0] oBWEnA0;
  wire [ DW-1:0] oBWEnB0;
  wire [PAW-1:0] oAddrA0;
  wire [PAW-1:0] oAddrB0;
  wire [ DW-1:0] oWDataA0;
  wire [ DW-1:0] oWDataB0;
  wire [ DW-1:0] iRDataA0;
  wire [ DW-1:0] iRDataB0;
  wire           oCEnA1;
  wire           oCEnB1;
  wire           oWEnA1;
  wire           oWEnB1;
  wire [ DW-1:0] oBWEnA1;
  wire [ DW-1:0] oBWEnB1;
  wire [PAW-1:0] oAddrA1;
  wire [PAW-1:0] oAddrB1;
  wire [ DW-1:0] oWDataA1;
  wire [ DW-1:0] oWDataB1;
  wire [ DW-1:0] iRDataA1;
  wire [ DW-1:0] iRDataB1;
  wire           oCEnA2;
  wire           oCEnB2;
  wire           oWEnA2;
  wire           oWEnB2;
  wire [ DW-1:0] oBWEnA2;
  wire [ DW-1:0] oBWEnB2;
  wire [PAW-1:0] oAddrA2;
  wire [PAW-1:0] oAddrB2;
  wire [ DW-1:0] oWDataA2;
  wire [ DW-1:0] oWDataB2;
  wire [ DW-1:0] iRDataA2;
  wire [ DW-1:0] iRDataB2;
  wire           oCEnA3;
  wire           oCEnB3;
  wire           oWEnA3;
  wire           oWEnB3;
  wire [ DW-1:0] oBWEnA3;
  wire [ DW-1:0] oBWEnB3;
  wire [PAW-1:0] oAddrA3;
  wire [PAW-1:0] oAddrB3;
  wire [ DW-1:0] oWDataA3;
  wire [ DW-1:0] oWDataB3;
  wire [ DW-1:0] iRDataA3;
  wire [ DW-1:0] iRDataB3;


  interconnect_4x4 #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) U_interconnect_4x4 (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (iMst0WrReq),
    .iMst0WrValid(iMst0WrValid),
    .iMst0WrAddr (iMst0WrAddr),
    .iMst0WrSel  (iMst0WrSel),
    .iMst0WrLast (iMst0WrLast),
    .iMst0WrData (iMst0WrData),
    .oMst0WrReady(oMst0WrReady),
    .iMst1WrReq  (iMst1WrReq),
    .iMst1WrValid(iMst1WrValid),
    .iMst1WrAddr (iMst1WrAddr),
    .iMst1WrSel  (iMst1WrSel),
    .iMst1WrLast (iMst1WrLast),
    .iMst1WrData (iMst1WrData),
    .oMst1WrReady(oMst1WrReady),
    .iMst2WrReq  (iMst2WrReq),
    .iMst2WrValid(iMst2WrValid),
    .iMst2WrAddr (iMst2WrAddr),
    .iMst2WrSel  (iMst2WrSel),
    .iMst2WrLast (iMst2WrLast),
    .iMst2WrData (iMst2WrData),
    .oMst2WrReady(oMst2WrReady),
    .iMst3WrReq  (iMst3WrReq),
    .iMst3WrValid(iMst3WrValid),
    .iMst3WrAddr (iMst3WrAddr),
    .iMst3WrSel  (iMst3WrSel),
    .iMst3WrLast (iMst3WrLast),
    .iMst3WrData (iMst3WrData),
    .oMst3WrReady(oMst3WrReady),
    .iMst0RdReq  (iMst0RdReq),
    .iMst0RdValid(iMst0RdValid),
    .iMst0RdAddr (iMst0RdAddr),
    .iMst0RdSel  (iMst0RdSel),
    .iMst0RdLast (iMst0RdLast),
    .oMst0RdReady(oMst0RdReady),
    .oMst0RdData (oMst0RdData),
    .iMst1RdReq  (iMst1RdReq),
    .iMst1RdValid(iMst1RdValid),
    .iMst1RdAddr (iMst1RdAddr),
    .iMst1RdSel  (iMst1RdSel),
    .iMst1RdLast (iMst1RdLast),
    .oMst1RdReady(oMst1RdReady),
    .oMst1RdData (oMst1RdData),
    .iMst2RdReq  (iMst2RdReq),
    .iMst2RdValid(iMst2RdValid),
    .iMst2RdAddr (iMst2RdAddr),
    .iMst2RdSel  (iMst2RdSel),
    .iMst2RdLast (iMst2RdLast),
    .oMst2RdReady(oMst2RdReady),
    .oMst2RdData (oMst2RdData),
    .iMst3RdReq  (iMst3RdReq),
    .iMst3RdValid(iMst3RdValid),
    .iMst3RdAddr (iMst3RdAddr),
    .iMst3RdSel  (iMst3RdSel),
    .iMst3RdLast (iMst3RdLast),
    .oMst3RdReady(oMst3RdReady),
    .oMst3RdData (oMst3RdData),
    .oSlv0WrReq  (oSlv0WrReq),
    .oSlv0WrValid(oSlv0WrValid),
    .oSlv0WrAddr (oSlv0WrAddr),
    .oSlv0WrSel  (oSlv0WrSel),
    .oSlv0WrLast (oSlv0WrLast),
    .oSlv0WrData (oSlv0WrData),
    .iSlv0WrReady(iSlv0WrReady),
    .oSlv1WrReq  (oSlv1WrReq),
    .oSlv1WrValid(oSlv1WrValid),
    .oSlv1WrAddr (oSlv1WrAddr),
    .oSlv1WrSel  (oSlv1WrSel),
    .oSlv1WrLast (oSlv1WrLast),
    .oSlv1WrData (oSlv1WrData),
    .iSlv1WrReady(iSlv1WrReady),
    .oSlv2WrReq  (oSlv2WrReq),
    .oSlv2WrValid(oSlv2WrValid),
    .oSlv2WrAddr (oSlv2WrAddr),
    .oSlv2WrSel  (oSlv2WrSel),
    .oSlv2WrLast (oSlv2WrLast),
    .oSlv2WrData (oSlv2WrData),
    .iSlv2WrReady(iSlv2WrReady),
    .oSlv3WrReq  (oSlv3WrReq),
    .oSlv3WrValid(oSlv3WrValid),
    .oSlv3WrAddr (oSlv3WrAddr),
    .oSlv3WrSel  (oSlv3WrSel),
    .oSlv3WrLast (oSlv3WrLast),
    .oSlv3WrData (oSlv3WrData),
    .iSlv3WrReady(iSlv3WrReady),
    .oSlv0RdReq  (oSlv0RdReq),
    .oSlv0RdValid(oSlv0RdValid),
    .oSlv0RdAddr (oSlv0RdAddr),
    .oSlv0RdSel  (oSlv0RdSel),
    .oSlv0RdLast (oSlv0RdLast),
    .iSlv0RdReady(iSlv0RdReady),
    .iSlv0RdData (iSlv0RdData),
    .oSlv1RdReq  (oSlv1RdReq),
    .oSlv1RdValid(oSlv1RdValid),
    .oSlv1RdAddr (oSlv1RdAddr),
    .oSlv1RdSel  (oSlv1RdSel),
    .oSlv1RdLast (oSlv1RdLast),
    .iSlv1RdReady(iSlv1RdReady),
    .iSlv1RdData (iSlv1RdData),
    .oSlv2RdReq  (oSlv2RdReq),
    .oSlv2RdValid(oSlv2RdValid),
    .oSlv2RdAddr (oSlv2RdAddr),
    .oSlv2RdSel  (oSlv2RdSel),
    .oSlv2RdLast (oSlv2RdLast),
    .iSlv2RdReady(iSlv2RdReady),
    .iSlv2RdData (iSlv2RdData),
    .oSlv3RdReq  (oSlv3RdReq),
    .oSlv3RdValid(oSlv3RdValid),
    .oSlv3RdAddr (oSlv3RdAddr),
    .oSlv3RdSel  (oSlv3RdSel),
    .oSlv3RdLast (oSlv3RdLast),
    .iSlv3RdReady(iSlv3RdReady),
    .iSlv3RdData (iSlv3RdData)
  );

  master_new_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m0 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst0WrReq),
    .oMstWrValid(iMst0WrValid),
    .oMstWrAddr (iMst0WrAddr),
    .oMstWrSel  (iMst0WrSel),
    .oMstWrLast (iMst0WrLast),
    .oMstWrData (iMst0WrData),
    .iMstWrReady(oMst0WrReady),
    .oMstRdReq  (iMst0RdReq),
    .oMstRdValid(iMst0RdValid),
    .oMstRdAddr (iMst0RdAddr),
    .oMstRdSel  (iMst0RdSel),
    .oMstRdLast (iMst0RdLast),
    .iMstRdReady(oMst0RdReady),
    .iMstRdData (oMst0RdData)
  );

  master_new_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m1 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst1WrReq),
    .oMstWrValid(iMst1WrValid),
    .oMstWrAddr (iMst1WrAddr),
    .oMstWrSel  (iMst1WrSel),
    .oMstWrLast (iMst1WrLast),
    .oMstWrData (iMst1WrData),
    .iMstWrReady(oMst1WrReady),
    .oMstRdReq  (iMst1RdReq),
    .oMstRdValid(iMst1RdValid),
    .oMstRdAddr (iMst1RdAddr),
    .oMstRdSel  (iMst1RdSel),
    .oMstRdLast (iMst1RdLast),
    .iMstRdReady(oMst1RdReady),
    .iMstRdData (oMst1RdData)
  );

  master_new_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m2 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst2WrReq),
    .oMstWrValid(iMst2WrValid),
    .oMstWrAddr (iMst2WrAddr),
    .oMstWrSel  (iMst2WrSel),
    .oMstWrLast (iMst2WrLast),
    .oMstWrData (iMst2WrData),
    .iMstWrReady(oMst2WrReady),
    .oMstRdReq  (iMst2RdReq),
    .oMstRdValid(iMst2RdValid),
    .oMstRdAddr (iMst2RdAddr),
    .oMstRdSel  (iMst2RdSel),
    .oMstRdLast (iMst2RdLast),
    .iMstRdReady(oMst2RdReady),
    .iMstRdData (oMst2RdData)
  );

  master_new_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m3 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst3WrReq),
    .oMstWrValid(iMst3WrValid),
    .oMstWrAddr (iMst3WrAddr),
    .oMstWrSel  (iMst3WrSel),
    .oMstWrLast (iMst3WrLast),
    .oMstWrData (iMst3WrData),
    .iMstWrReady(oMst3WrReady),
    .oMstRdReq  (iMst3RdReq),
    .oMstRdValid(iMst3RdValid),
    .oMstRdAddr (iMst3RdAddr),
    .oMstRdSel  (iMst3RdSel),
    .oMstRdLast (iMst3RdLast),
    .iMstRdReady(oMst3RdReady),
    .iMstRdData (oMst3RdData)
  );

  sram_block_drv #(
    .DW      (DW),
    .PAW     (PAW),
    .VAW     (VAW),
    .SW      (SW),
    .TRANSLEN(TRANSLEN)
  ) s0_block_drv (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iSRAMWrReq  (oSlv0WrReq),
    .iSRAMWrValid(oSlv0WrValid),
    .iSRAMWrAddr (oSlv0WrAddr),
    .iSRAMWrSel  (oSlv0WrSel),
    .iSRAMWrLast (oSlv0WrLast),
    .iSRAMWrData (oSlv0WrData),
    .oSRAMWrReady(iSlv0WrReady),
    .iSRAMRdReq  (oSlv0RdReq),
    .iSRAMRdValid(oSlv0RdValid),
    .iSRAMRdAddr (oSlv0RdAddr),
    .iSRAMRdSel  (oSlv0RdSel),
    .iSRAMRdLast (oSlv0RdLast),
    .oSRAMRdReady(iSlv0RdReady),
    .oSRAMRdData (iSlv0RdData),
    .oCEnA       (oCEnA0),
    .oCEnB       (oCEnB0),
    .oWEnA       (oWEnA0),
    .oWEnB       (oWEnB0),
    .oBWEnA      (oBWEnA0),
    .oBWEnB      (oBWEnB0),
    .oAddrA      (oAddrA0),
    .oAddrB      (oAddrB0),
    .oWDataA     (oWDataA0),
    .oWDataB     (oWDataB0),
    .iRDataA     (iRDataA0),
    .iRDataB     (iRDataB0)
  );

  sram_wrapper sram0 (
    .iClkA  (iClk),
    .iClkB  (iClk),
    .iRst_n (iRst_n),
    .iCEnA  (oCEnA0),
    .iCEnB  (oCEnB0),
    .iWEnA  (oWEnA0),
    .iWEnB  (oWEnB0),
    .iBWEnA (oBWEnA0),
    .iBWEnB (oBWEnB0),
    .iAddrA (oAddrA0),
    .iAddrB (oAddrB0),
    .iWDataA(oWDataA0),
    .iWDataB(oWDataB0),
    .oRDataA(iRDataA0),
    .oRDataB(iRDataB0)
  );

  sram_block_drv #(
    .DW      (DW),
    .PAW     (PAW),
    .VAW     (VAW),
    .SW      (SW),
    .TRANSLEN(TRANSLEN)
  ) s1_block_drv (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iSRAMWrReq  (oSlv1WrReq),
    .iSRAMWrValid(oSlv1WrValid),
    .iSRAMWrAddr (oSlv1WrAddr),
    .iSRAMWrSel  (oSlv1WrSel),
    .iSRAMWrLast (oSlv1WrLast),
    .iSRAMWrData (oSlv1WrData),
    .oSRAMWrReady(iSlv1WrReady),
    .iSRAMRdReq  (oSlv1RdReq),
    .iSRAMRdValid(oSlv1RdValid),
    .iSRAMRdAddr (oSlv1RdAddr),
    .iSRAMRdSel  (oSlv1RdSel),
    .iSRAMRdLast (oSlv1RdLast),
    .oSRAMRdReady(iSlv1RdReady),
    .oSRAMRdData (iSlv1RdData),
    .oCEnA       (oCEnA1),
    .oCEnB       (oCEnB1),
    .oWEnA       (oWEnA1),
    .oWEnB       (oWEnB1),
    .oBWEnA      (oBWEnA1),
    .oBWEnB      (oBWEnB1),
    .oAddrA      (oAddrA1),
    .oAddrB      (oAddrB1),
    .oWDataA     (oWDataA1),
    .oWDataB     (oWDataB1),
    .iRDataA     (iRDataA1),
    .iRDataB     (iRDataB1)
  );

  sram_wrapper sram1 (
    .iClkA  (iClk),
    .iClkB  (iClk),
    .iRst_n (iRst_n),
    .iCEnA  (oCEnA1),
    .iCEnB  (oCEnB1),
    .iWEnA  (oWEnA1),
    .iWEnB  (oWEnB1),
    .iBWEnA (oBWEnA1),
    .iBWEnB (oBWEnB1),
    .iAddrA (oAddrA1),
    .iAddrB (oAddrB1),
    .iWDataA(oWDataA1),
    .iWDataB(oWDataB1),
    .oRDataA(iRDataA1),
    .oRDataB(iRDataB1)
  );

  sram_block_drv #(
    .DW      (DW),
    .PAW     (PAW),
    .VAW     (VAW),
    .SW      (SW),
    .TRANSLEN(TRANSLEN)
  ) s2_block_drv (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iSRAMWrReq  (oSlv2WrReq),
    .iSRAMWrValid(oSlv2WrValid),
    .iSRAMWrAddr (oSlv2WrAddr),
    .iSRAMWrSel  (oSlv2WrSel),
    .iSRAMWrLast (oSlv2WrLast),
    .iSRAMWrData (oSlv2WrData),
    .oSRAMWrReady(iSlv2WrReady),
    .iSRAMRdReq  (oSlv2RdReq),
    .iSRAMRdValid(oSlv2RdValid),
    .iSRAMRdAddr (oSlv2RdAddr),
    .iSRAMRdSel  (oSlv2RdSel),
    .iSRAMRdLast (oSlv2RdLast),
    .oSRAMRdReady(iSlv2RdReady),
    .oSRAMRdData (iSlv2RdData),
    .oCEnA       (oCEnA2),
    .oCEnB       (oCEnB2),
    .oWEnA       (oWEnA2),
    .oWEnB       (oWEnB2),
    .oBWEnA      (oBWEnA2),
    .oBWEnB      (oBWEnB2),
    .oAddrA      (oAddrA2),
    .oAddrB      (oAddrB2),
    .oWDataA     (oWDataA2),
    .oWDataB     (oWDataB2),
    .iRDataA     (iRDataA2),
    .iRDataB     (iRDataB2)
  );

  sram_wrapper sram2 (
    .iClkA  (iClk),
    .iClkB  (iClk),
    .iRst_n (iRst_n),
    .iCEnA  (oCEnA2),
    .iCEnB  (oCEnB2),
    .iWEnA  (oWEnA2),
    .iWEnB  (oWEnB2),
    .iBWEnA (oBWEnA2),
    .iBWEnB (oBWEnB2),
    .iAddrA (oAddrA2),
    .iAddrB (oAddrB2),
    .iWDataA(oWDataA2),
    .iWDataB(oWDataB2),
    .oRDataA(iRDataA2),
    .oRDataB(iRDataB2)
  );

  sram_block_drv #(
    .DW      (DW),
    .PAW     (PAW),
    .VAW     (VAW),
    .SW      (SW),
    .TRANSLEN(TRANSLEN)
  ) s3_block_drv (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iSRAMWrReq  (oSlv3WrReq),
    .iSRAMWrValid(oSlv3WrValid),
    .iSRAMWrAddr (oSlv3WrAddr),
    .iSRAMWrSel  (oSlv3WrSel),
    .iSRAMWrLast (oSlv3WrLast),
    .iSRAMWrData (oSlv3WrData),
    .oSRAMWrReady(iSlv3WrReady),
    .iSRAMRdReq  (oSlv3RdReq),
    .iSRAMRdValid(oSlv3RdValid),
    .iSRAMRdAddr (oSlv3RdAddr),
    .iSRAMRdSel  (oSlv3RdSel),
    .iSRAMRdLast (oSlv3RdLast),
    .oSRAMRdReady(iSlv3RdReady),
    .oSRAMRdData (iSlv3RdData),
    .oCEnA       (oCEnA3),
    .oCEnB       (oCEnB3),
    .oWEnA       (oWEnA3),
    .oWEnB       (oWEnB3),
    .oBWEnA      (oBWEnA3),
    .oBWEnB      (oBWEnB3),
    .oAddrA      (oAddrA3),
    .oAddrB      (oAddrB3),
    .oWDataA     (oWDataA3),
    .oWDataB     (oWDataB3),
    .iRDataA     (iRDataA3),
    .iRDataB     (iRDataB3)
  );

  sram_wrapper sram3 (
    .iClkA  (iClk),
    .iClkB  (iClk),
    .iRst_n (iRst_n),
    .iCEnA  (oCEnA3),
    .iCEnB  (oCEnB3),
    .iWEnA  (oWEnA3),
    .iWEnB  (oWEnB3),
    .iBWEnA (oBWEnA3),
    .iBWEnB (oBWEnB3),
    .iAddrA (oAddrA3),
    .iAddrB (oAddrB3),
    .iWDataA(oWDataA3),
    .iWDataB(oWDataB3),
    .oRDataA(iRDataA3),
    .oRDataB(iRDataB3)
  );


  initial begin
    $fsdbDumpfile("tb_interconnect_block_drv.fsdb");
    $fsdbDumpvars(0, tb_interconnect_block_drv);
    $fsdbDumpMDA();
  end

  initial begin
    iClk = 1'b0;
    forever begin
      #5 iClk = !iClk;
    end
  end

  initial begin
    repeat (10000) @(posedge iClk);
    $display("timeout!");
    $finish;
  end

  reg [DW-1:0] rdata;
  initial begin
    iRst_n = 1'b0;
    repeat (5) @(posedge iClk);
    // s0.delay = 1;
    // s1.delay = 1;
    // s2.delay = 1;
    // s3.delay = 1;
    #1 iRst_n = 1'b1;
    repeat (10) @(posedge iClk);
    test_dp;
    test_arb;

    init_all_mem;
    m0.wr1('h000 + 0, 4'hf, 32'hdeadbee1);
    repeat (5) @(posedge iClk);
    m0.rd1('h000 + 0, 4'hf, rdata);

    m0.wr1('h010 + 0, 4'hf, 32'hdeadbee2);
    repeat (2) @(posedge iClk);
    m0.rd1('h010 + 0, 4'hf, rdata);

    m0.wr1('h020 + 0, 4'hf, 32'hdeadbee3);
    repeat (1) @(posedge iClk);
    m0.rd1('h020 + 0, 4'hf, rdata);

    m0.wr1('h030 + 0, 4'hf, 32'hdeadbee4);
    repeat (0) @(posedge iClk);
    m0.rd1('h030 + 0, 4'hf, rdata);

    repeat (2) @(posedge iClk);
    fork
      m0.wr1('h040 + 0, 4'hf, 32'hdeadbee5);
      m0.rd1('h050 + 0, 4'hf, rdata);
    join


    #100 $finish;
  end


  task init_all_mem;
    integer i;
    begin
      m0.mem_fill;
      m1.mem_fill;
      m2.mem_fill;
      m3.mem_fill;
      // s0.fill_mem(1);
      // s1.fill_mem(1);
      // s2.fill_mem(1);
      // s3.fill_mem(1);
      for (i = 0; i < MEM_SIZE; i = i + 1) begin
        sram0.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;
        sram0.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;

        sram1.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;
        sram1.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;

        sram2.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;
        sram2.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;

        sram3.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;
        sram3.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[i] = $random;
      end
    end
  endtask

  task verify;
    input master;
    input slave;
    input count;
    integer master, slave, count;
    begin
      verify_sub(master, slave, count, 0, 0);
    end
  endtask


  task verify_sub;
    input master;
    input slave;
    input count;
    input mo;
    input so;

    integer master, slave, count;
    integer mo, so;
    integer o;
    integer n;
    reg [DW-1:0] mdata, sdata;

    begin

      //$display("V2: %0d %0d %0d %0d %0d",master, slave, count, mo,so);

      for (n = 0; n < count; n = n + 1) begin
        case (master)
          0: begin
            mdata = m0.mem[n+mo];
          end
          1: begin
            mdata = m1.mem[n+mo];
          end
          2: begin
            mdata = m2.mem[n+mo];
          end
          3: begin
            mdata = m3.mem[n+mo];
          end
          default: begin
            $display("ERROR: Illegal Master %0d", master);
            $finish;
          end
        endcase

        // o = 0;
        // case (master)
        //   0: o = 16'h000;
        //   1: o = 16'h100;
        //   2: o = 16'h200;
        //   3: o = 16'h300;
        // endcase

        case ({
          master, slave
        })
          {
            32'd0, 32'd0
          } :
          sdata = {
            sram0.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[n+so],
            sram0.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd1, 32'd0
          } :
          sdata = {
            sram0.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[n+so],
            sram0.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd2, 32'd0
          } :
          sdata = {
            sram0.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[n+so],
            sram0.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd3, 32'd0
          } :
          sdata = {
            sram0.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[n+so],
            sram0.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd0, 32'd1
          } :
          sdata = {
            sram1.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[n+so],
            sram1.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd1, 32'd1
          } :
          sdata = {
            sram1.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[n+so],
            sram1.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd2, 32'd1
          } :
          sdata = {
            sram1.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[n+so],
            sram1.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd3, 32'd1
          } :
          sdata = {
            sram1.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[n+so],
            sram1.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd0, 32'd2
          } :
          sdata = {
            sram2.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[n+so],
            sram2.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd1, 32'd2
          } :
          sdata = {
            sram2.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[n+so],
            sram2.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd2, 32'd2
          } :
          sdata = {
            sram2.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[n+so],
            sram2.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd3, 32'd2
          } :
          sdata = {
            sram2.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[n+so],
            sram2.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd0, 32'd3
          } :
          sdata = {
            sram3.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.mem_array[n+so],
            sram3.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd1, 32'd3
          } :
          sdata = {
            sram3.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.mem_array[n+so],
            sram3.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd2, 32'd3
          } :
          sdata = {
            sram3.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.mem_array[n+so],
            sram3.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.mem_array[n+so]
          };
          {
            32'd3, 32'd3
          } :
          sdata = {
            sram3.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.mem_array[n+so],
            sram3.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.mem_array[n+so]
          };
          default: begin
            $display("ERROR: Illegal Slave %0d", slave);
            $finish;
          end
        endcase
        //$display("INFO: Master[%0d]: %h - Slave[%0d]: %h (%0t)",
        //	master, mdata, slave, sdata, $time);
        if (mdata !== sdata) begin
          $display("ERROR: Master[%0d][%0d]: %h - Slave[%0d]: %h (%0t)", master, n, mdata, slave,
                   sdata, $time);
          // error_cnt = error_cnt + 1;
        end
      end
    end
  endtask

  task test_dp;
    integer n;
    reg [1:0] s0;
    reg [1:0] s1;
    reg [1:0] s2;
    reg [1:0] s3;
    begin
      $display("\n\n");
      $display("*****************************************************");
      $display("*** Datapath Test ...                             ***");
      $display("*****************************************************\n");

      s0 = 0;
      s1 = 1;
      s2 = 2;
      s3 = 3;
      for (n = 0; n < 4; n = n + 1) begin
        init_all_mem;
        $display("Mode: %0d", n);
        fork
          begin
            m0.wr_mult('h000 + s0, 4'hf, 0, 16, "FIXED");
            m0.rd_mult('h004 + s0, 4'hf, 0, 16, "FIXED");
            m0.wr_mult('h008 + s0, 4'hf, 0, 16, "FIXED");
            m0.rd_mult('h00C + s0, 4'hf, 0, 16, "FIXED");

          end
          begin
            m1.wr_mult('h400 + s1, 4'hf, 0, 16, "FIXED");
            m1.rd_mult('h404 + s1, 4'hf, 0, 16, "FIXED");
            m1.wr_mult('h408 + s1, 4'hf, 0, 16, "FIXED");
            m1.rd_mult('h40C + s1, 4'hf, 0, 16, "FIXED");
          end
          begin
            m2.wr_mult('h800 + s2, 4'hf, 0, 16, "FIXED");
            m2.rd_mult('h804 + s2, 4'hf, 0, 16, "FIXED");
            m2.wr_mult('h808 + s2, 4'hf, 0, 16, "FIXED");
            m2.rd_mult('h80C + s2, 4'hf, 0, 16, "FIXED");
          end
          begin
            m3.wr_mult('hC00 + s3, 4'hf, 0, 16, "FIXED");
            m3.rd_mult('hC04 + s3, 4'hf, 0, 16, "FIXED");
            m3.wr_mult('hC08 + s3, 4'hf, 0, 16, "FIXED");
            m3.rd_mult('hC0C + s3, 4'hf, 0, 16, "FIXED");
          end
        join
        verify(0, s0, 64);
        verify(1, s1, 64);
        verify(2, s2, 64);
        verify(3, s3, 64);
        @(posedge iClk);
        s0 = s0 + 1;
        s1 = s1 + 1;
        s2 = s2 + 1;
        s3 = s3 + 1;
        @(posedge iClk);

      end

      $display("*****************************************************");
      $display("*** Test DONE ...                                 ***");
      $display("*****************************************************\n\n");

    end
  endtask


  task test_arb;
    integer n, del;
    begin
      $display("\n\n");
      $display("*****************************************************");
      $display("*** Arb Test ...                                  ***");
      $display("*****************************************************\n");

      for (del = 0; del < 5; del = del + 1) begin
        $display("Delay: %0d", del);
        init_all_mem;
        fork
          begin
            m0.rd_mult('h000 + 0, 4'hf, del, 16, "FIXED");
            m0.wr_mult('h004 + 0, 4'hf, del, 16, "FIXED");
            m0.rd_mult('h008 + 0, 4'hf, del, 16, "FIXED");
            m0.wr_mult('h00C + 0, 4'hf, del, 16, "FIXED");
          end
          begin
            m1.wr_mult('h400 + 0, 4'hf, del, 16, "FIXED");
            m1.rd_mult('h404 + 0, 4'hf, del, 16, "FIXED");
            m1.wr_mult('h408 + 0, 4'hf, del, 16, "FIXED");
            m1.rd_mult('h40C + 0, 4'hf, del, 16, "FIXED");
          end
          begin
            m2.rd_mult('h800 + 0, 4'hf, del, 16, "FIXED");
            m2.wr_mult('h804 + 0, 4'hf, del, 16, "FIXED");
            m2.rd_mult('h808 + 0, 4'hf, del, 16, "FIXED");
            m2.wr_mult('h80C + 0, 4'hf, del, 16, "FIXED");
          end
          begin
            m3.wr_mult('hC00 + 0, 4'hf, del, 16, "FIXED");
            m3.rd_mult('hC04 + 0, 4'hf, del, 16, "FIXED");
            m3.wr_mult('hC08 + 0, 4'hf, del, 16, "FIXED");
            m3.rd_mult('hC0C + 0, 4'hf, del, 16, "FIXED");
          end
        join

        verify(0, 0, 64);
        verify(1, 0, 64);
        verify(2, 0, 64);
        verify(3, 0, 64);
      end

      $display("*****************************************************");
      $display("*** Test DONE ...                                 ***");
      $display("*****************************************************\n\n");
    end

  endtask

endmodule
