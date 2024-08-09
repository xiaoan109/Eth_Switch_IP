// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_UnpackSgDma.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-11
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-12
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
`include "define.v"
module tb_UnpackSgDma ();
  //Parameters
  localparam AW = 12;
  localparam DW = 32;
  localparam SW = 4;
  localparam MEM_SIZE = 4096;
  localparam VAW = AW;
  localparam PAW = VAW + 2;
  localparam TRANSLEN = 16;
  localparam FIFO_DEPTH = 4096;
  localparam ADDR_LENTH = 12;
  localparam ADDR_WIDTH = $clog2(FIFO_DEPTH);
  localparam DATA_WIDTH = 12;

  //Ports
  reg                       iClk;
  reg                       iRst_n;
  //outside
  reg                       iWrSop         [3:0];
  reg                       iWrEop         [3:0];
  reg                       iWrVld         [3:0];
  reg  [              31:0] iWrData        [3:0];
  //Empty Addr
  reg  [ADDR_LENTH - 1 : 0] iRecAddr       [3:0];
  reg                       iRecAddrVld    [3:0];
  wire [ADDR_LENTH - 1 : 0] wEptyAddr      [3:0];
  wire                      wEptyAddrVld   [3:0];
  wire                      wEptyAddrRcvRdy[3:0];
  //wrr
  reg                       iWrrRdy        [3:0];
  wire [               2:0] oPktPri        [3:0];
  wire [               3:0] oPktDstPort    [3:0];
  wire [              11:0] oPktFirAddr    [3:0];  //包首地址
  wire [               3:0] oPktLen        [3:0];
  wire                      oPktTagVld     [3:0];
  //Lsram
  reg                       iLWriteRdy     [3:0];
  wire [              11:0] oLdata         [3:0];
  wire [              11:0] oLaddr         [3:0];  //link list addr
  wire                      oLaddrVld      [3:0];
  //MMU
  wire                      iPktDataRdy    [3:0];  //mmu
  wire [              31:0] oPktData       [3:0];
  wire                      oPktDataVld    [3:0];
  wire [              11:0] oPktAddr       [3:0];
  wire                      oPktAddrVld    [3:0];
  wire                      oPktWrLast     [3:0];
  //FIFO
  wire [               3:0] oFifoFull;
  //Xbar
  // wire           iMst0WrReq;
  // wire           iMst0WrValid;
  // wire [ AW-1:0] iMst0WrAddr;
  // wire [ SW-1:0] iMst0WrSel;
  // wire           iMst0WrLast;
  // wire [ DW-1:0] iMst0WrData;
  // wire           oMst0WrReady;
  // wire           iMst1WrReq;
  // wire           iMst1WrValid;
  // wire [ AW-1:0] iMst1WrAddr;
  // wire [ SW-1:0] iMst1WrSel;
  // wire           iMst1WrLast;
  // wire [ DW-1:0] iMst1WrData;
  // wire           oMst1WrReady;
  // wire           iMst2WrReq;
  // wire           iMst2WrValid;
  // wire [ AW-1:0] iMst2WrAddr;
  // wire [ SW-1:0] iMst2WrSel;
  // wire           iMst2WrLast;
  // wire [ DW-1:0] iMst2WrData;
  // wire           oMst2WrReady;
  // wire           iMst3WrReq;
  // wire           iMst3WrValid;
  // wire [ AW-1:0] iMst3WrAddr;
  // wire [ SW-1:0] iMst3WrSel;
  // wire           iMst3WrLast;
  // wire [ DW-1:0] iMst3WrData;
  // wire           oMst3WrReady;
  wire                      iMst0RdReq;
  wire                      iMst0RdValid;
  wire [            AW-1:0] iMst0RdAddr;
  wire [            SW-1:0] iMst0RdSel;
  wire                      iMst0RdLast;
  wire                      oMst0RdReady;
  wire [            DW-1:0] oMst0RdData;
  wire                      iMst1RdReq;
  wire                      iMst1RdValid;
  wire [            AW-1:0] iMst1RdAddr;
  wire [            SW-1:0] iMst1RdSel;
  wire                      iMst1RdLast;
  wire                      oMst1RdReady;
  wire [            DW-1:0] oMst1RdData;
  wire                      iMst2RdReq;
  wire                      iMst2RdValid;
  wire [            AW-1:0] iMst2RdAddr;
  wire [            SW-1:0] iMst2RdSel;
  wire                      iMst2RdLast;
  wire                      oMst2RdReady;
  wire [            DW-1:0] oMst2RdData;
  wire                      iMst3RdReq;
  wire                      iMst3RdValid;
  wire [            AW-1:0] iMst3RdAddr;
  wire [            SW-1:0] iMst3RdSel;
  wire                      iMst3RdLast;
  wire                      oMst3RdReady;
  wire [            DW-1:0] oMst3RdData;
  wire                      oSlv0WrReq;
  wire                      oSlv0WrValid;
  wire [            AW-1:0] oSlv0WrAddr;
  wire [            SW-1:0] oSlv0WrSel;
  wire                      oSlv0WrLast;
  wire [            DW-1:0] oSlv0WrData;
  wire                      iSlv0WrReady;
  wire                      oSlv1WrReq;
  wire                      oSlv1WrValid;
  wire [            AW-1:0] oSlv1WrAddr;
  wire [            SW-1:0] oSlv1WrSel;
  wire                      oSlv1WrLast;
  wire [            DW-1:0] oSlv1WrData;
  wire                      iSlv1WrReady;
  wire                      oSlv2WrReq;
  wire                      oSlv2WrValid;
  wire [            AW-1:0] oSlv2WrAddr;
  wire [            SW-1:0] oSlv2WrSel;
  wire                      oSlv2WrLast;
  wire [            DW-1:0] oSlv2WrData;
  wire                      iSlv2WrReady;
  wire                      oSlv3WrReq;
  wire                      oSlv3WrValid;
  wire [            AW-1:0] oSlv3WrAddr;
  wire [            SW-1:0] oSlv3WrSel;
  wire                      oSlv3WrLast;
  wire [            DW-1:0] oSlv3WrData;
  wire                      iSlv3WrReady;
  wire                      oSlv0RdReq;
  wire                      oSlv0RdValid;
  wire [            AW-1:0] oSlv0RdAddr;
  wire [            SW-1:0] oSlv0RdSel;
  wire                      oSlv0RdLast;
  wire                      iSlv0RdReady;
  wire [            DW-1:0] iSlv0RdData;
  wire                      oSlv1RdReq;
  wire                      oSlv1RdValid;
  wire [            AW-1:0] oSlv1RdAddr;
  wire [            SW-1:0] oSlv1RdSel;
  wire                      oSlv1RdLast;
  wire                      iSlv1RdReady;
  wire [            DW-1:0] iSlv1RdData;
  wire                      oSlv2RdReq;
  wire                      oSlv2RdValid;
  wire [            AW-1:0] oSlv2RdAddr;
  wire [            SW-1:0] oSlv2RdSel;
  wire                      oSlv2RdLast;
  wire                      iSlv2RdReady;
  wire [            DW-1:0] iSlv2RdData;
  wire                      oSlv3RdReq;
  wire                      oSlv3RdValid;
  wire [            AW-1:0] oSlv3RdAddr;
  wire [            SW-1:0] oSlv3RdSel;
  wire                      oSlv3RdLast;
  wire                      iSlv3RdReady;
  wire [            DW-1:0] iSlv3RdData;
  // SRAM interface
  wire                      oCEnA0;
  wire                      oCEnB0;
  wire                      oWEnA0;
  wire                      oWEnB0;
  wire [            DW-1:0] oBWEnA0;
  wire [            DW-1:0] oBWEnB0;
  wire [           PAW-1:0] oAddrA0;
  wire [           PAW-1:0] oAddrB0;
  wire [            DW-1:0] oWDataA0;
  wire [            DW-1:0] oWDataB0;
  wire [            DW-1:0] iRDataA0;
  wire [            DW-1:0] iRDataB0;
  wire                      oCEnA1;
  wire                      oCEnB1;
  wire                      oWEnA1;
  wire                      oWEnB1;
  wire [            DW-1:0] oBWEnA1;
  wire [            DW-1:0] oBWEnB1;
  wire [           PAW-1:0] oAddrA1;
  wire [           PAW-1:0] oAddrB1;
  wire [            DW-1:0] oWDataA1;
  wire [            DW-1:0] oWDataB1;
  wire [            DW-1:0] iRDataA1;
  wire [            DW-1:0] iRDataB1;
  wire                      oCEnA2;
  wire                      oCEnB2;
  wire                      oWEnA2;
  wire                      oWEnB2;
  wire [            DW-1:0] oBWEnA2;
  wire [            DW-1:0] oBWEnB2;
  wire [           PAW-1:0] oAddrA2;
  wire [           PAW-1:0] oAddrB2;
  wire [            DW-1:0] oWDataA2;
  wire [            DW-1:0] oWDataB2;
  wire [            DW-1:0] iRDataA2;
  wire [            DW-1:0] iRDataB2;
  wire                      oCEnA3;
  wire                      oCEnB3;
  wire                      oWEnA3;
  wire                      oWEnB3;
  wire [            DW-1:0] oBWEnA3;
  wire [            DW-1:0] oBWEnB3;
  wire [           PAW-1:0] oAddrA3;
  wire [           PAW-1:0] oAddrB3;
  wire [            DW-1:0] oWDataA3;
  wire [            DW-1:0] oWDataB3;
  wire [            DW-1:0] iRDataA3;
  wire [            DW-1:0] iRDataB3;



  //DUT
  UnpackSgDma U_UnpackSgDma (
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iWrSop({iWrSop[3], iWrSop[2], iWrSop[1], iWrSop[0]}),
    .iWrEop({iWrEop[3], iWrEop[2], iWrEop[1], iWrEop[0]}),
    .iWrVld({iWrVld[3], iWrVld[2], iWrVld[1], iWrVld[0]}),
    .iWrData({iWrData[3], iWrData[2], iWrData[1], iWrData[0]}),
    .iEptyAddr({wEptyAddr[3], wEptyAddr[2], wEptyAddr[1], wEptyAddr[0]}),
    .iEptyAddrVld({wEptyAddrVld[3], wEptyAddrVld[2], wEptyAddrVld[1], wEptyAddrVld[0]}),
    .oEptyAddrRcvRdy({
      wEptyAddrRcvRdy[3], wEptyAddrRcvRdy[2], wEptyAddrRcvRdy[1], wEptyAddrRcvRdy[0]
    }),
    .iWrrRdy({iWrrRdy[3], iWrrRdy[2], iWrrRdy[1], iWrrRdy[0]}),
    .oPktPri({oPktPri[3], oPktPri[2], oPktPri[1], oPktPri[0]}),
    .oPktDstPort({oPktDstPort[3], oPktDstPort[2], oPktDstPort[1], oPktDstPort[0]}),
    .oPktFirAddr({oPktFirAddr[3], oPktFirAddr[2], oPktFirAddr[1], oPktFirAddr[0]}),
    .oPktLen({oPktLen[3], oPktLen[2], oPktLen[1], oPktLen[0]}),
    .oPktTagVld({oPktTagVld[3], oPktTagVld[2], oPktTagVld[1], oPktTagVld[0]}),
    .iLWriteRdy({iLWriteRdy[3], iLWriteRdy[2], iLWriteRdy[1], iLWriteRdy[0]}),
    .oLdata({oLdata[3], oLdata[2], oLdata[1], oLdata[0]}),
    .oLaddr({oLaddr[3], oLaddr[2], oLaddr[1], oLaddr[0]}),
    .oLaddrVld({oLaddrVld[3], oLaddrVld[2], oLaddrVld[1], oLaddrVld[0]}),
    .iMmuRdy({iPktDataRdy[3], iPktDataRdy[2], iPktDataRdy[1], iPktDataRdy[0]}),
    .oPktData({oPktData[3], oPktData[2], oPktData[1], oPktData[0]}),
    .oPktDataVld({oPktDataVld[3], oPktDataVld[2], oPktDataVld[1], oPktDataVld[0]}),
    .oPktAddr({oPktAddr[3], oPktAddr[2], oPktAddr[1], oPktAddr[0]}),
    .oPktAddrVld({oPktAddrVld[3], oPktAddrVld[2], oPktAddrVld[1], oPktAddrVld[0]}),
    .oPktWrLast({oPktWrLast[3], oPktWrLast[2], oPktWrLast[1], oPktWrLast[0]}),
    .oFifoFull({oFifoFull[3], oFifoFull[2], oFifoFull[1], oFifoFull[0]})
  );



  AddrCtrl #(
    .FIFO_DEPTH(FIFO_DEPTH),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .ADDR_LENTH(ADDR_LENTH)
  ) U_AddrCtrl (
    .iClk         (iClk),
    .iRst_n       (iRst_n),
    .iRecAddr0    (iRecAddr[0]),
    .iRecAddrVld0 (iRecAddrVld[0]),
    .iRecAddr1    (iRecAddr[1]),
    .iRecAddrVld1 (iRecAddrVld[1]),
    .iRecAddr2    (iRecAddr[2]),
    .iRecAddrVld2 (iRecAddrVld[2]),
    .iRecAddr3    (iRecAddr[3]),
    .iRecAddrVld3 (iRecAddrVld[3]),
    .iEptyAddrRdy0(wEptyAddrRcvRdy[0]),
    .oEptyAddr0   (wEptyAddr[0]),
    .oEptyAddrVld0(wEptyAddrVld[0]),
    .iEptyAddrRdy1(wEptyAddrRcvRdy[1]),
    .oEptyAddr1   (wEptyAddr[1]),
    .oEptyAddrVld1(wEptyAddrVld[1]),
    .iEptyAddrRdy2(wEptyAddrRcvRdy[2]),
    .oEptyAddr2   (wEptyAddr[2]),
    .oEptyAddrVld2(wEptyAddrVld[2]),
    .iEptyAddrRdy3(wEptyAddrRcvRdy[3]),
    .oEptyAddr3   (wEptyAddr[3]),
    .oEptyAddrVld3(wEptyAddrVld[3]),
    .oFull        (),
    .oEmpty       ()
  );


  interconnect_4x4 #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) U_interconnect_4x4 (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (oPktAddrVld[0]),
    .iMst0WrValid(oPktDataVld[0]),
    .iMst0WrAddr (oPktAddr[0]),
    .iMst0WrSel  ({SW{1'b1}}),
    .iMst0WrLast (oPktWrLast[0]),
    .iMst0WrData (oPktData[0]),
    .oMst0WrReady(iPktDataRdy[0]),
    .iMst1WrReq  (oPktAddrVld[1]),
    .iMst1WrValid(oPktDataVld[1]),
    .iMst1WrAddr (oPktAddr[1]),
    .iMst1WrSel  ({SW{1'b1}}),
    .iMst1WrLast (oPktWrLast[1]),
    .iMst1WrData (oPktData[1]),
    .oMst1WrReady(iPktDataRdy[1]),
    .iMst2WrReq  (oPktAddrVld[2]),
    .iMst2WrValid(oPktDataVld[2]),
    .iMst2WrAddr (oPktAddr[2]),
    .iMst2WrSel  ({SW{1'b1}}),
    .iMst2WrLast (oPktWrLast[2]),
    .iMst2WrData (oPktData[2]),
    .oMst2WrReady(iPktDataRdy[2]),
    .iMst3WrReq  (oPktAddrVld[3]),
    .iMst3WrValid(oPktDataVld[3]),
    .iMst3WrAddr (oPktAddr[3]),
    .iMst3WrSel  ({SW{1'b1}}),
    .iMst3WrLast (oPktWrLast[3]),
    .iMst3WrData (oPktData[3]),
    .oMst3WrReady(iPktDataRdy[3]),
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
    $fsdbDumpfile("tb_UnpackSgDma.fsdb");
    $fsdbDumpvars(0, tb_UnpackSgDma);
    $fsdbDumpMDA();
  end

  initial begin
    iClk = 1'b0;
    forever begin
      #5 iClk = !iClk;
    end
  end

  initial begin
    repeat (100000) @(posedge iClk);
    $display("timeout!");
    $finish;
  end



  reg [10:0] rPktLen[3:0];  // 64-1024
  reg [4:0] rBlockLen[3:0];  // 1-17
  integer m;
  initial begin
    iRst_n = 1'b0;
    for (m = 0; m < 4; m = m + 1) begin
      iWrSop[m] = 1'b0;
      iWrEop[m] = 1'b0;
      iWrVld[m] = 1'b0;
      iWrData[m] = 32'bx;
      iWrrRdy[m] = 1'b0;
      iLWriteRdy[m] = 1'b0;
    end
    `DELAY(10, iClk)
    iRst_n = 1'b1;
    rPktLen[0] = 64 + {$random($get_initial_random_seed)} % (1025 - 64);
    // rPktLen = 128;
    rBlockLen[0] = (rPktLen[0] + 63 + 4) >> 6;
    rPktLen[1] = 64 + {$random($get_initial_random_seed + 1)} % (1025 - 64);
    rBlockLen[1] = (rPktLen[1] + 63 + 4) >> 6;
    rPktLen[2] = 64 + {$random($get_initial_random_seed + 2)} % (1025 - 64);
    rBlockLen[2] = (rPktLen[2] + 63 + 4) >> 6;
    rPktLen[3] = 64 + {$random($get_initial_random_seed + 3)} % (1025 - 64);
    rBlockLen[3] = (rPktLen[3] + 63 + 4) >> 6;
    fork
      INITADDR(0);
      INITADDR(1);
      INITADDR(2);
      INITADDR(3);
    join
    fork
      begin
        `DELAY(5, iClk)
        fork
          PKTSEND(0, 0, 0, rPktLen[0], 0);
          PKTSEND(1, 0, 0, rPktLen[1], 0);
          PKTSEND(2, 0, 0, rPktLen[2], 0);
          PKTSEND(3, 0, 0, rPktLen[3], 0);
        join
      end
      // begin
      //   `DELAY(5, iClk)
      //   fork
      //     repeat (rBlockLen[0]) begin
      //       ADDRGEN(0, $random);
      //     end
      //     repeat (rBlockLen[1]) begin
      //       ADDRGEN(1, $random);
      //     end
      //     repeat (rBlockLen[2]) begin
      //       ADDRGEN(2, $random);
      //     end
      //     repeat (rBlockLen[3]) begin
      //       ADDRGEN(3, $random);
      //     end
      //   join
      // end
      begin
        `DELAY(5, iClk)
        fork
          LINKSRAMREADY(0, 1, 0, 1000);
          LINKSRAMREADY(1, 1, 0, 1000);
          LINKSRAMREADY(2, 1, 0, 1000);
          LINKSRAMREADY(3, 1, 0, 1000);
        join
      end
      WRRREADY(0, 1, 0, 1000);
      WRRREADY(1, 1, 0, 1000);
      WRRREADY(2, 1, 0, 1000);
      WRRREADY(3, 1, 0, 1000);
    join


    #10000 $finish;
  end

  task automatic PKTSEND;
    input [1:0] inPort;  // 0-3
    input [2:0] prio;  // 0-7
    input [3:0] destPort;  // 0-15
    input [10:0] pktLen;  //Byte :64-1024
    input integer delay;  //random delay
    reg [9:0] rLen;
    begin
      rLen = pktLen - 1;
      //Sop
      iWrSop[inPort] = 1'b1;
      `DELAY(1, iClk)
      iWrSop[inPort] = 1'b0;
      //Ctrl frame
      `DELAY(delay, iClk)
      iWrVld[inPort]  = 1'b1;
      iWrData[inPort] = {15'b0, rLen, prio, destPort};
      `DELAY(1, iClk)
      iWrVld[inPort] = 1'b0;
      //Data frame
      repeat (pktLen >> 2) begin
        `DELAY(delay, iClk)
        iWrVld[inPort]  = 1'b1;
        iWrData[inPort] = $random;
        @(posedge iClk);
        while (oFifoFull[inPort]) @(posedge iClk);
        #1;
        iWrVld[inPort] = 1'b0;
      end
      iWrData[inPort] = 32'bx;
      if (pktLen[1:0]) begin
        `DELAY(delay, iClk)
        iWrVld[inPort] = 1'b1;
        iWrData[inPort][31:24] = 8'b0;
        iWrData[inPort][23:16] = pktLen[1:0] > 2 ? $random : 8'b0;
        iWrData[inPort][15:8] = pktLen[1:0] > 1 ? $random : 8'b0;
        iWrData[inPort][7:0] = $random;
        @(posedge iClk);
        while (oFifoFull[inPort]) @(posedge iClk);
        #1;
        iWrVld[inPort] = 1'b0;
      end
      iWrData[inPort] = 32'bx;
      //CRC result
      `DELAY(delay, iClk)
      iWrVld[inPort]  = 1'b1;
      iWrData[inPort] = 32'hdeadbeef;
      @(posedge iClk);
      while (oFifoFull[inPort]) @(posedge iClk);
      #1;
      iWrVld[inPort]  = 1'b0;
      iWrData[inPort] = 32'bx;
      //Eop
      iWrEop[inPort]  = 1'b1;
      `DELAY(1, iClk)
      iWrEop[inPort] = 1'b0;
    end
  endtask


  // task automatic ADDRGEN;
  //   input [1:0] inPort;
  //   input [11:0] addr;
  //   begin
  //     iEptyAddr[inPort] = addr;
  //     iEptyAddrVld[inPort] = 1'b1;
  //     while (!oEptyAddrRcvRdy[inPort]) @(posedge iClk);
  //     @(posedge iClk) #1;
  //   end
  // endtask

  task automatic INITADDR;
    input [1:0] inPort;
    reg [ADDR_LENTH-1:0] rAddrCnt;
    begin
      rAddrCnt = 0;
      repeat (4096) begin
        iRecAddrVld[inPort] = 1;
        iRecAddr[inPort] = rAddrCnt;
        `DELAY(1, iClk)
        rAddrCnt = rAddrCnt + 1;
      end
      iRecAddr[inPort] <= 0;
      iRecAddrVld[inPort] <= 0;
      `DELAY(1, iClk)
    end
  endtask

  // task MMUREADY;
  //   input [1:0] inPort;
  //   input ready_on;
  //   input rdm_on;
  //   input integer max_cyc;
  //   begin
  //     repeat (max_cyc) begin
  //       `DELAY(1, iClk)
  //       if (rdm_on) begin
  //         iPktDataRdy[inPort] = $random;
  //       end else begin
  //         iPktDataRdy[inPort] = ready_on;
  //       end
  //     end
  //   end
  // endtask

  task automatic LINKSRAMREADY;
    input [1:0] inPort;
    input ready_on;
    input rdm_on;
    input integer max_cyc;
    begin
      repeat (max_cyc) begin
        `DELAY(1, iClk)
        if (rdm_on) begin
          iLWriteRdy[inPort] = $random;
        end else begin
          iLWriteRdy[inPort] = ready_on;
        end
      end
    end
  endtask

  task automatic WRRREADY;
    input [1:0] inPort;
    input ready_on;
    input rdm_on;
    input integer max_cyc;
    begin
      repeat (max_cyc) begin
        `DELAY(1, iClk)
        if (rdm_on) begin
          iWrrRdy[inPort] = $random;
        end else begin
          iWrrRdy[inPort] = ready_on;
        end
      end
    end
  endtask


endmodule
