// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_PkgReadToXbar.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-16
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-16
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
module tb_PkgReadToXbar ();

  // Parameters
  localparam ADDR_LENTH = 12;
  localparam DATA_WIDTH = 32;
  localparam AW = 12;
  localparam DW = 32;
  localparam SW = 4;
  localparam MEM_SIZE = 4096;
  localparam VAW = AW;
  localparam PAW = VAW + 2;
  localparam TRANSLEN = 16;
  
  defparam sram0.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram0.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram0.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  
  defparam sram1.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram1.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram1.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
   
  defparam sram2.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram2.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram2.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
   
  defparam sram3.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Lo.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Lo.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Lo.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Lo.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Hi.gen_sram[0].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Hi.gen_sram[1].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Hi.gen_sram[2].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";
  defparam sram3.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.USE_INIT_FILE = 1;
  defparam sram3.U_sram16x16k_Hi.gen_sram[3].U_dpram16x4096.INIT_FILE = "../../src/rtl/design/sram/init.mem";






  //Ports
  reg                     iClk;
  reg                     iRst_n;
  wire [ADDR_LENTH - 1:0] oRcvrAddr        [3:0];
  wire                    oRcvrAddrVld     [3:0];
  wire [ADDR_LENTH - 1:0] oDropRcvrAddr;
  wire                    oDropRcvrAddrVld;
  reg  [ADDR_LENTH - 1:0] iLdata           [3:0];
  reg                     iLdataVld        [3:0];
  wire [ADDR_LENTH - 1:0] oLaddr           [3:0];
  wire                    oLaddrVld        [3:0];
  wire [ADDR_LENTH - 1:0] oDropAddr;
  wire                    oDropAddrVld;
  reg  [ADDR_LENTH - 1:0] iDropData;
  reg                     iDropDataVld;
  wire [DATA_WIDTH - 1:0] iData            [3:0];
  wire                    iMmuRdy          [3:0];
  wire [ADDR_LENTH - 1:0] oBlockAddr       [3:0];
  wire                    oBlockAddrVld    [3:0];
  wire                    oMmuReadReq      [3:0];
  wire                    oMmuReadLast     [3:0];
  reg  [ADDR_LENTH - 1:0] iPkgFirAddr      [3:0];
  reg                     iPkgFirAddrVld   [3:0];
  reg  [           3 : 0] iPkgBlockNum     [3:0];
  reg                     iPkgDrop         [3:0];
  wire                    oPkgFirAddrRdy   [3:0];
  wire [DATA_WIDTH - 1:0] oWrrData         [3:0];
  wire                    oWrrVld          [3:0];
  wire                    oWrrDataLast     [3:0];
  reg                     iWrrRdy          [3:0];
  //Xbar
  wire                    iMst0WrReq;
  wire                    iMst0WrValid;
  wire [          AW-1:0] iMst0WrAddr;
  wire [          SW-1:0] iMst0WrSel;
  wire                    iMst0WrLast;
  wire [          DW-1:0] iMst0WrData;
  wire                    oMst0WrReady;
  wire                    iMst1WrReq;
  wire                    iMst1WrValid;
  wire [          AW-1:0] iMst1WrAddr;
  wire [          SW-1:0] iMst1WrSel;
  wire                    iMst1WrLast;
  wire [          DW-1:0] iMst1WrData;
  wire                    oMst1WrReady;
  wire                    iMst2WrReq;
  wire                    iMst2WrValid;
  wire [          AW-1:0] iMst2WrAddr;
  wire [          SW-1:0] iMst2WrSel;
  wire                    iMst2WrLast;
  wire [          DW-1:0] iMst2WrData;
  wire                    oMst2WrReady;
  wire                    iMst3WrReq;
  wire                    iMst3WrValid;
  wire [          AW-1:0] iMst3WrAddr;
  wire [          SW-1:0] iMst3WrSel;
  wire                    iMst3WrLast;
  wire [          DW-1:0] iMst3WrData;
  wire                    oMst3WrReady;
  //   wire                    iMst0RdReq;
  //   wire                    iMst0RdValid;
  //   wire [          AW-1:0] iMst0RdAddr;
  //   wire [          SW-1:0] iMst0RdSel;
  //   wire                    iMst0RdLast;
  //   wire                    oMst0RdReady;
  //   wire [          DW-1:0] oMst0RdData;
  //   wire                    iMst1RdReq;
  //   wire                    iMst1RdValid;
  //   wire [          AW-1:0] iMst1RdAddr;
  //   wire [          SW-1:0] iMst1RdSel;
  //   wire                    iMst1RdLast;
  //   wire                    oMst1RdReady;
  //   wire [          DW-1:0] oMst1RdData;
  //   wire                    iMst2RdReq;
  //   wire                    iMst2RdValid;
  //   wire [          AW-1:0] iMst2RdAddr;
  //   wire [          SW-1:0] iMst2RdSel;
  //   wire                    iMst2RdLast;
  //   wire                    oMst2RdReady;
  //   wire [          DW-1:0] oMst2RdData;
  //   wire                    iMst3RdReq;
  //   wire                    iMst3RdValid;
  //   wire [          AW-1:0] iMst3RdAddr;
  //   wire [          SW-1:0] iMst3RdSel;
  //   wire                    iMst3RdLast;
  //   wire                    oMst3RdReady;
  //   wire [          DW-1:0] oMst3RdData;
  wire                    oSlv0WrReq;
  wire                    oSlv0WrValid;
  wire [          AW-1:0] oSlv0WrAddr;
  wire [          SW-1:0] oSlv0WrSel;
  wire                    oSlv0WrLast;
  wire [          DW-1:0] oSlv0WrData;
  wire                    iSlv0WrReady;
  wire                    oSlv1WrReq;
  wire                    oSlv1WrValid;
  wire [          AW-1:0] oSlv1WrAddr;
  wire [          SW-1:0] oSlv1WrSel;
  wire                    oSlv1WrLast;
  wire [          DW-1:0] oSlv1WrData;
  wire                    iSlv1WrReady;
  wire                    oSlv2WrReq;
  wire                    oSlv2WrValid;
  wire [          AW-1:0] oSlv2WrAddr;
  wire [          SW-1:0] oSlv2WrSel;
  wire                    oSlv2WrLast;
  wire [          DW-1:0] oSlv2WrData;
  wire                    iSlv2WrReady;
  wire                    oSlv3WrReq;
  wire                    oSlv3WrValid;
  wire [          AW-1:0] oSlv3WrAddr;
  wire [          SW-1:0] oSlv3WrSel;
  wire                    oSlv3WrLast;
  wire [          DW-1:0] oSlv3WrData;
  wire                    iSlv3WrReady;
  wire                    oSlv0RdReq;
  wire                    oSlv0RdValid;
  wire [          AW-1:0] oSlv0RdAddr;
  wire [          SW-1:0] oSlv0RdSel;
  wire                    oSlv0RdLast;
  wire                    iSlv0RdReady;
  wire [          DW-1:0] iSlv0RdData;
  wire                    oSlv1RdReq;
  wire                    oSlv1RdValid;
  wire [          AW-1:0] oSlv1RdAddr;
  wire [          SW-1:0] oSlv1RdSel;
  wire                    oSlv1RdLast;
  wire                    iSlv1RdReady;
  wire [          DW-1:0] iSlv1RdData;
  wire                    oSlv2RdReq;
  wire                    oSlv2RdValid;
  wire [          AW-1:0] oSlv2RdAddr;
  wire [          SW-1:0] oSlv2RdSel;
  wire                    oSlv2RdLast;
  wire                    iSlv2RdReady;
  wire [          DW-1:0] iSlv2RdData;
  wire                    oSlv3RdReq;
  wire                    oSlv3RdValid;
  wire [          AW-1:0] oSlv3RdAddr;
  wire [          SW-1:0] oSlv3RdSel;
  wire                    oSlv3RdLast;
  wire                    iSlv3RdReady;
  wire [          DW-1:0] iSlv3RdData;
  // SRAM interface
  wire                    oCEnA0;
  wire                    oCEnB0;
  wire                    oWEnA0;
  wire                    oWEnB0;
  wire [          DW-1:0] oBWEnA0;
  wire [          DW-1:0] oBWEnB0;
  wire [         PAW-1:0] oAddrA0;
  wire [         PAW-1:0] oAddrB0;
  wire [          DW-1:0] oWDataA0;
  wire [          DW-1:0] oWDataB0;
  wire [          DW-1:0] iRDataA0;
  wire [          DW-1:0] iRDataB0;
  wire                    oCEnA1;
  wire                    oCEnB1;
  wire                    oWEnA1;
  wire                    oWEnB1;
  wire [          DW-1:0] oBWEnA1;
  wire [          DW-1:0] oBWEnB1;
  wire [         PAW-1:0] oAddrA1;
  wire [         PAW-1:0] oAddrB1;
  wire [          DW-1:0] oWDataA1;
  wire [          DW-1:0] oWDataB1;
  wire [          DW-1:0] iRDataA1;
  wire [          DW-1:0] iRDataB1;
  wire                    oCEnA2;
  wire                    oCEnB2;
  wire                    oWEnA2;
  wire                    oWEnB2;
  wire [          DW-1:0] oBWEnA2;
  wire [          DW-1:0] oBWEnB2;
  wire [         PAW-1:0] oAddrA2;
  wire [         PAW-1:0] oAddrB2;
  wire [          DW-1:0] oWDataA2;
  wire [          DW-1:0] oWDataB2;
  wire [          DW-1:0] iRDataA2;
  wire [          DW-1:0] iRDataB2;
  wire                    oCEnA3;
  wire                    oCEnB3;
  wire                    oWEnA3;
  wire                    oWEnB3;
  wire [          DW-1:0] oBWEnA3;
  wire [          DW-1:0] oBWEnB3;
  wire [         PAW-1:0] oAddrA3;
  wire [         PAW-1:0] oAddrB3;
  wire [          DW-1:0] oWDataA3;
  wire [          DW-1:0] oWDataB3;
  wire [          DW-1:0] iRDataA3;
  wire [          DW-1:0] iRDataB3;

  PkgRead #(
    .ADDR_LENTH(ADDR_LENTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) PkgRead_inst (
    .iClk            (iClk),
    .iRst_n          (iRst_n),
    .oRcvrAddr0      (oRcvrAddr[0]),
    .oRcvrAddrVld0   (oRcvrAddrVld[0]),
    .oRcvrAddr1      (oRcvrAddr[1]),
    .oRcvrAddrVld1   (oRcvrAddrVld[1]),
    .oRcvrAddr2      (oRcvrAddr[2]),
    .oRcvrAddrVld2   (oRcvrAddrVld[2]),
    .oRcvrAddr3      (oRcvrAddr[3]),
    .oRcvrAddrVld3   (oRcvrAddrVld[3]),
    .oDropRcvrAddr   (oDropRcvrAddr),
    .oDropRcvrAddrVld(oDropRcvrAddrVld),
    .iLdata0         (iLdata[0]),
    .iLdataVld0      (iLdataVld[0]),
    .oLaddr0         (oLaddr[0]),
    .oLaddrVld0      (oLaddrVld[0]),
    .iLdata1         (iLdata[1]),
    .iLdataVld1      (iLdataVld[1]),
    .oLaddr1         (oLaddr[1]),
    .oLaddrVld1      (oLaddrVld[1]),
    .iLdata2         (iLdata[2]),
    .iLdataVld2      (iLdataVld[2]),
    .oLaddr2         (oLaddr[2]),
    .oLaddrVld2      (oLaddrVld[2]),
    .iLdata3         (iLdata[3]),
    .iLdataVld3      (iLdataVld[3]),
    .oLaddr3         (oLaddr[3]),
    .oLaddrVld3      (oLaddrVld[3]),
    .oDropAddr       (oDropAddr),
    .oDropAddrVld    (oDropAddrVld),
    .iDropData       (iDropData),
    .iDropDataVld    (iDropDataVld),
    .iData0          (iData[0]),
    .iMmuRdy0        (iMmuRdy[0]),
    .oBlockAddr0     (oBlockAddr[0]),
    .oBlockAddrVld0  (oBlockAddrVld[0]),
    .oMmuReadReq0    (oMmuReadReq[0]),
    .oMmuReadLast0   (oMmuReadLast[0]),
    .iData1          (iData[1]),
    .iMmuRdy1        (iMmuRdy[1]),
    .oBlockAddr1     (oBlockAddr[1]),
    .oBlockAddrVld1  (oBlockAddrVld[1]),
    .oMmuReadReq1    (oMmuReadReq[1]),
    .oMmuReadLast1   (oMmuReadLast[1]),
    .iData2          (iData[2]),
    .iMmuRdy2        (iMmuRdy[2]),
    .oBlockAddr2     (oBlockAddr[2]),
    .oBlockAddrVld2  (oBlockAddrVld[2]),
    .oMmuReadReq2    (oMmuReadReq[2]),
    .oMmuReadLast2   (oMmuReadLast[2]),
    .iData3          (iData[3]),
    .iMmuRdy3        (iMmuRdy[3]),
    .oBlockAddr3     (oBlockAddr[3]),
    .oBlockAddrVld3  (oBlockAddrVld[3]),
    .oMmuReadReq3    (oMmuReadReq[3]),
    .oMmuReadLast3   (oMmuReadLast[3]),
    .iPkgFirAddr0    (iPkgFirAddr[0]),
    .iPkgFirAddrVld0 (iPkgFirAddrVld[0]),
    .iPkgBlockNum0   (iPkgBlockNum[0]),
    .iPkgDrop0       (iPkgDrop[0]),
    .oPkgFirAddrRdy0 (oPkgFirAddrRdy[0]),
    .oWrrData0       (oWrrData[0]),
    .oWrrVld0        (oWrrVld[0]),
    .oWrrDataLast0   (oWrrDataLast[0]),
    .iWrrRdy0        (iWrrRdy[0]),
    .iPkgFirAddr1    (iPkgFirAddr[1]),
    .iPkgFirAddrVld1 (iPkgFirAddrVld[1]),
    .iPkgBlockNum1   (iPkgBlockNum[1]),
    .iPkgDrop1       (iPkgDrop[1]),
    .oPkgFirAddrRdy1 (oPkgFirAddrRdy[1]),
    .oWrrData1       (oWrrData[1]),
    .oWrrVld1        (oWrrVld[1]),
    .oWrrDataLast1   (oWrrDataLast[1]),
    .iWrrRdy1        (iWrrRdy[1]),
    .iPkgFirAddr2    (iPkgFirAddr[2]),
    .iPkgFirAddrVld2 (iPkgFirAddrVld[2]),
    .iPkgBlockNum2   (iPkgBlockNum[2]),
    .iPkgDrop2       (iPkgDrop[2]),
    .oPkgFirAddrRdy2 (oPkgFirAddrRdy[2]),
    .oWrrData2       (oWrrData[2]),
    .oWrrVld2        (oWrrVld[2]),
    .oWrrDataLast2   (oWrrDataLast[2]),
    .iWrrRdy2        (iWrrRdy[2]),
    .iPkgFirAddr3    (iPkgFirAddr[3]),
    .iPkgFirAddrVld3 (iPkgFirAddrVld[3]),
    .iPkgBlockNum3   (iPkgBlockNum[3]),
    .iPkgDrop3       (iPkgDrop[3]),
    .oPkgFirAddrRdy3 (oPkgFirAddrRdy[3]),
    .oWrrData3       (oWrrData[3]),
    .oWrrVld3        (oWrrVld[3]),
    .oWrrDataLast3   (oWrrDataLast[3]),
    .iWrrRdy3        (iWrrRdy[3])
  );

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
    .iMst0RdReq  (oMmuReadReq[0]),
    .iMst0RdValid(oBlockAddrVld[0]),
    .iMst0RdAddr (oBlockAddr[0]),
    .iMst0RdSel  ({SW{1'b1}}),
    .iMst0RdLast (oMmuReadLast[0]),
    .oMst0RdReady(iMmuRdy[0]),
    .oMst0RdData (iData[0]),
    .iMst1RdReq  (oMmuReadReq[1]),
    .iMst1RdValid(oBlockAddrVld[1]),
    .iMst1RdAddr (oBlockAddr[1]),
    .iMst1RdSel  ({SW{1'b1}}),
    .iMst1RdLast (oMmuReadLast[1]),
    .oMst1RdReady(iMmuRdy[1]),
    .oMst1RdData (iData[1]),
    .iMst2RdReq  (oMmuReadReq[2]),
    .iMst2RdValid(oBlockAddrVld[2]),
    .iMst2RdAddr (oBlockAddr[2]),
    .iMst2RdSel  ({SW{1'b1}}),
    .iMst2RdLast (oMmuReadLast[2]),
    .oMst2RdReady(iMmuRdy[2]),
    .oMst2RdData (iData[2]),
    .iMst3RdReq  (oMmuReadReq[3]),
    .iMst3RdValid(oBlockAddrVld[3]),
    .iMst3RdAddr (oBlockAddr[3]),
    .iMst3RdSel  ({SW{1'b1}}),
    .iMst3RdLast (oMmuReadLast[3]),
    .oMst3RdReady(iMmuRdy[3]),
    .oMst3RdData (iData[3]),
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



  always #5 iClk = !iClk;


  integer m;
  reg [3:0] rFullBlockNum;
  reg [3:0] rWordNum;
  initial begin
    $fsdbDumpfile("tb_PkgReadToXbar.fsdb");
    $fsdbDumpvars("+all");

    iClk   <= 0;
    iRst_n <= 0;
    for (m = 0; m < 4; m = m + 1) begin
      iLdata[m]         <= 0;
      iLdataVld[m]      <= 0;
      iPkgFirAddr[m]    <= 0;
      iPkgFirAddrVld[m] <= 0;
      iPkgBlockNum[m]   <= 0;
      iWrrRdy[m]        <= 0;
      iPkgDrop[m]       <= 0;
    end
    iDropData <= 0;
    iDropDataVld <= 0;
    #100 iRst_n <= 1;

    repeat (10) @(posedge iClk);
    fork
      begin
        repeat (100) begin
          rFullBlockNum = {$urandom} % 10;
          rWordNum = {$urandom} % 16;
          fork
            WRRSEND(0, rFullBlockNum, rWordNum, 1);
            WRRSEND(1, rFullBlockNum, rWordNum, 1);
            WRRSEND(2, rFullBlockNum, rWordNum, 1);
            WRRSEND(3, rFullBlockNum, rWordNum, 1);
            LSRAM(0, rFullBlockNum, rWordNum, 1);
            LSRAM(1, rFullBlockNum, rWordNum, 1);
            LSRAM(2, rFullBlockNum, rWordNum, 1);
            LSRAM(3, rFullBlockNum, rWordNum, 1);
          join
        end
      end
      WRRREADY(0, 1, 1, 100000);
      WRRREADY(1, 1, 1, 100000);
      WRRREADY(2, 1, 1, 100000);
      WRRREADY(3, 1, 1, 100000);
      //   MMUREADY(0, 1, 1, 100000);
    join

    #1000 $finish;

  end

  initial begin
    repeat (1000000) @(posedge iClk);
    $display("timeout!");
    $finish;
  end


  task automatic WRRSEND;
    input [1:0] inPort;  //0-3
    input [3:0] blockNum;  //0-15, full block 1-16
    input [3:0] wordNum;  //0-15, last block word 0-15
    input [11:0] firstAddr;
    begin
      iPkgFirAddr[inPort] <= firstAddr + inPort;
      iPkgFirAddrVld[inPort] <= 1;
      iPkgBlockNum[inPort] <= blockNum;
      @(posedge iClk);
      while (!oPkgFirAddrRdy[inPort]) @(posedge iClk);
      iPkgFirAddr[inPort] <= 0;
      iPkgFirAddrVld[inPort] <= 0;
      iPkgBlockNum[inPort] <= 0;
    end
  endtask

  integer times [3:0];
  integer cnt [3:0];
  task automatic LSRAM;
    input [1:0] inPort;  //0-3
    input [3:0] blockNum;  //0-15, full block 1-16
    input [3:0] wordNum;  //0-15, last block word 0-15
    input [11:0] firstAddr;
    begin
      times[inPort] = wordNum ? blockNum + 2 : blockNum + 1;
      cnt[inPort]   = 1;
      repeat (times[inPort]) begin
        @(posedge iClk);
        while (!oLaddrVld[inPort]) @(posedge iClk);
        if (cnt[inPort] == times[inPort] ) begin
          iLdata[inPort] <= wordNum;
        end else begin
          iLdata[inPort] <= firstAddr + cnt[inPort] * 4 + inPort;
        end
        iLdataVld[inPort] <= 1;
        cnt[inPort] <= cnt[inPort] + 1;
        @(posedge iClk);
        iLdata[inPort] <= 0;
        iLdataVld[inPort] <= 0;
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
        @(posedge iClk);
        if (rdm_on) begin
          iWrrRdy[inPort] <= $urandom;
        end else begin
          iWrrRdy[inPort] <= ready_on;
        end
      end
    end
  endtask

  //   task automatic MMUREADY;
  // input [1:0] inPort;
  // input ready_on;
  // input rdm_on;
  // input integer max_cyc;
  // begin
  //   repeat (max_cyc) begin
  // @(posedge iClk);
  // if (rdm_on) begin
  //   iMmuRdy[inPort] <= $urandom;
  // end else begin
  //   iMmuRdy[inPort] <= ready_on;
  // end
  //   end
  // end
  //   endtask


  //   integer dataCnt;
  //   integer rdCnt;
  //   task automatic MMUDATA;
  // input [1:0] inPort;
  // input [3:0] blockNum;  //0-15, full block 1-16
  // input [3:0] wordNum;  //0-15, last block word 0-15
  // begin
  //   dataCnt = ((blockNum + 1) << 4) + wordNum;
  //   rdCnt   = 1;
  //   repeat (dataCnt) begin
  // @(posedge iClk);
  // while (!(iMmuRdy[inPort] & oMmuReadReq[inPort] & oBlockAddrVld[inPort])) @(posedge iClk);
  // iData[inPort] <= rdCnt;
  // rdCnt <= rdCnt + 1;
  //   end
  // end
  //   endtask

endmodule
