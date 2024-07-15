// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/SwitchTop.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-13
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-07-06
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
module SwitchTop #(
  parameter PRI_DEPTH = 8,
  parameter WRR_WEIGHT_NUM = 8
) (
  input  wire                            iClk,
  input  wire                            iRst_n,
  // Wr Ports
  input  wire                            iWrSop0,
  input  wire                            iWrEop0,
  input  wire                            iWrVld0,
  input  wire [                    31:0] iWrData0,
  input  wire                            iWrSop1,
  input  wire                            iWrEop1,
  input  wire                            iWrVld1,
  input  wire [                    31:0] iWrData1,
  input  wire                            iWrSop2,
  input  wire                            iWrEop2,
  input  wire                            iWrVld2,
  input  wire [                    31:0] iWrData2,
  input  wire                            iWrSop3,
  input  wire                            iWrEop3,
  input  wire                            iWrVld3,
  input  wire [                    31:0] iWrData3,
  input  wire                            iWrSop4,
  input  wire                            iWrEop4,
  input  wire                            iWrVld4,
  input  wire [                    31:0] iWrData4,
  input  wire                            iWrSop5,
  input  wire                            iWrEop5,
  input  wire                            iWrVld5,
  input  wire [                    31:0] iWrData5,
  input  wire                            iWrSop6,
  input  wire                            iWrEop6,
  input  wire                            iWrVld6,
  input  wire [                    31:0] iWrData6,
  input  wire                            iWrSop7,
  input  wire                            iWrEop7,
  input  wire                            iWrVld7,
  input  wire [                    31:0] iWrData7,
  input  wire                            iWrSop8,
  input  wire                            iWrEop8,
  input  wire                            iWrVld8,
  input  wire [                    31:0] iWrData8,
  input  wire                            iWrSop9,
  input  wire                            iWrEop9,
  input  wire                            iWrVld9,
  input  wire [                    31:0] iWrData9,
  input  wire                            iWrSop10,
  input  wire                            iWrEop10,
  input  wire                            iWrVld10,
  input  wire [                    31:0] iWrData10,
  input  wire                            iWrSop11,
  input  wire                            iWrEop11,
  input  wire                            iWrVld11,
  input  wire [                    31:0] iWrData11,
  input  wire                            iWrSop12,
  input  wire                            iWrEop12,
  input  wire                            iWrVld12,
  input  wire [                    31:0] iWrData12,
  input  wire                            iWrSop13,
  input  wire                            iWrEop13,
  input  wire                            iWrVld13,
  input  wire [                    31:0] iWrData13,
  input  wire                            iWrSop14,
  input  wire                            iWrEop14,
  input  wire                            iWrVld14,
  input  wire [                    31:0] iWrData14,
  input  wire                            iWrSop15,
  input  wire                            iWrEop15,
  input  wire                            iWrVld15,
  input  wire [                    31:0] iWrData15,
  output wire                            oFull0,          //Port 0-15 write fifo full
  output wire                            oFull1,
  output wire                            oFull2,
  output wire                            oFull3,
  output wire                            oFull4,
  output wire                            oFull5,
  output wire                            oFull6,
  output wire                            oFull7,
  output wire                            oFull8,
  output wire                            oFull9,
  output wire                            oFull10,
  output wire                            oFull11,
  output wire                            oFull12,
  output wire                            oFull13,
  output wire                            oFull14,
  output wire                            oFull15,
  output wire                            oAlmostFull0,    //inside group 0, shared memory full
  output wire                            oAlmostFull1,    //inside group 1, shared memory full
  output wire                            oAlmostFull2,    //inside group 2, shared memory full
  output wire                            oAlmostFull3,    //inside group 3, shared memory full
  // Rd Ports
  input  wire                            iReady0,
  input  wire                            iReady1,
  input  wire                            iReady2,
  input  wire                            iReady3,
  input  wire                            iReady4,
  input  wire                            iReady5,
  input  wire                            iReady6,
  input  wire                            iReady7,
  input  wire                            iReady8,
  input  wire                            iReady9,
  input  wire                            iReady10,
  input  wire                            iReady11,
  input  wire                            iReady12,
  input  wire                            iReady13,
  input  wire                            iReady14,
  input  wire                            iReady15,
  output wire                            oRdSop0,
  output wire                            oRdEop0,
  output wire                            oRdVld0,
  output wire [                    31:0] oRdData0,
  output wire                            oErr0,
  output wire                            oRdSop1,
  output wire                            oRdEop1,
  output wire                            oRdVld1,
  output wire [                    31:0] oRdData1,
  output wire                            oErr1,
  output wire                            oRdSop2,
  output wire                            oRdEop2,
  output wire                            oRdVld2,
  output wire [                    31:0] oRdData2,
  output wire                            oErr2,
  output wire                            oRdSop3,
  output wire                            oRdEop3,
  output wire                            oRdVld3,
  output wire [                    31:0] oRdData3,
  output wire                            oErr3,
  output wire                            oRdSop4,
  output wire                            oRdEop4,
  output wire                            oRdVld4,
  output wire [                    31:0] oRdData4,
  output wire                            oErr4,
  output wire                            oRdSop5,
  output wire                            oRdEop5,
  output wire                            oRdVld5,
  output wire [                    31:0] oRdData5,
  output wire                            oErr5,
  output wire                            oRdSop6,
  output wire                            oRdEop6,
  output wire                            oRdVld6,
  output wire [                    31:0] oRdData6,
  output wire                            oErr6,
  output wire                            oRdSop7,
  output wire                            oRdEop7,
  output wire                            oRdVld7,
  output wire [                    31:0] oRdData7,
  output wire                            oErr7,
  output wire                            oRdSop8,
  output wire                            oRdEop8,
  output wire                            oRdVld8,
  output wire [                    31:0] oRdData8,
  output wire                            oErr8,
  output wire                            oRdSop9,
  output wire                            oRdEop9,
  output wire                            oRdVld9,
  output wire [                    31:0] oRdData9,
  output wire                            oErr9,
  output wire                            oRdSop10,
  output wire                            oRdEop10,
  output wire                            oRdVld10,
  output wire [                    31:0] oRdData10,
  output wire                            oErr10,
  output wire                            oRdSop11,
  output wire                            oRdEop11,
  output wire                            oRdVld11,
  output wire [                    31:0] oRdData11,
  output wire                            oErr11,
  output wire                            oRdSop12,
  output wire                            oRdEop12,
  output wire                            oRdVld12,
  output wire [                    31:0] oRdData12,
  output wire                            oErr12,
  output wire                            oRdSop13,
  output wire                            oRdEop13,
  output wire                            oRdVld13,
  output wire [                    31:0] oRdData13,
  output wire                            oErr13,
  output wire                            oRdSop14,
  output wire                            oRdEop14,
  output wire                            oRdVld14,
  output wire [                    31:0] oRdData14,
  output wire                            oErr14,
  output wire                            oRdSop15,
  output wire                            oRdEop15,
  output wire                            oRdVld15,
  output wire [                    31:0] oRdData15,
  output wire                            oErr15,
  // ===================== WRR WEIGHT ======================
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld0,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld1,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld2,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld3,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld4,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld5,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld6,
  input  wire [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld7,
  input  wire [                     3:0] iWrrWeightIdx,
  input  wire                            iWrrWeightLoad
);

  wire [15:0] wWrSop;
  wire [15:0] wWrEop;
  wire [15:0] wWrVld;
  wire [31:0] wWrData[15:0];
  wire [15:0] wFifoFull;
  wire [15:0] wFull;
  wire [3:0] wAlmostFull;
  wire [15:0] wReady;
  wire [15:0] wRdSop;
  wire [15:0] wRdEop;
  wire [15:0] wRdVld;
  wire [31:0] wRdData[15:0];
  wire [15:0] wErr;
  //CRC to Unpack
  wire [15:0] wCrcWrSop;
  wire [15:0] wCrcWrEop;
  wire [15:0] wCrcWrVld;
  wire [31:0] wCrcWrData[15:0];
  //Unpack to AddrCtrl
  wire [11:0] wEptyAddr[15:0];
  wire [15:0] wEptyAddrVld;
  wire [15:0] wEptyAddrRcvRdy;
  //Unpack to WRR
  wire [15:0] wUnpackWrrRdy;
  wire [2:0] wPkgPri[15:0];
  wire [3:0] wPkgDstPort[15:0];
  wire [11:0] wPkgFirAddr[15:0];
  wire [3:0] wPkgLen[15:0];
  wire [15:0] wPkgTagVld;
  //Unpack to Link List Sram
  wire [11:0] wLdata[15:0];
  wire [11:0] wLaddr[15:0];
  wire [15:0] wLaddrVld;
  //Unpack to MMU
  wire [15:0] wPkgDataRdy;
  wire [31:0] wPkgData[15:0];
  wire [15:0] wPkgDataVld;
  wire [11:0] wPkgAddr[15:0];
  wire [15:0] wPkgAddrVld;
  wire [15:0] wPkgWrLast;
  //PkgRead to AddrCtrl
  wire [11:0] wRecAddr[15:0];
  wire [15:0] wRecAddrVld;
  wire [11:0] wDropRcvrAddr[3:0];  //Drop channel
  wire [3:0] wDropRcvrAddrVld;
  //PkgRead to LinkListSram
  wire [11:0] wReadAddr[15:0];
  wire [15:0] wReadAddrReq;
  wire [11:0] wReadLdata[15:0];
  wire [15:0] wReadLdataVld;
  wire [11:0] wDropReadAddr[3:0];  //Drop channel
  wire [3:0] wDropReadAddrReq;
  wire [11:0] wDropReadLdata[3:0];
  wire [3:0] wDropReadLdataVld;
  //PkgRead to MMU
  wire [31:0] wData[15:0];
  wire [15:0] wMmuReadRdy;
  wire [11:0] wBlockAddr[15:0];
  wire [15:0] wBlockAddrVld;
  wire [15:0] wMmuReadReq;
  wire [15:0] wMmuReadLast;
  //PkgRead to WRR
  wire [31:0] wWrrData[15:0];
  wire [15:0] wWrrDataVld;
  wire [15:0] wWrrDataLast;
  wire [15:0] wWrrDataRdy;
  //WRR to PkgRead
  wire [11:0] wWrrFirAddr[15:0];
  wire [15:0] wWrrFirAddrVld;
  wire [3:0] wWrrBlockNum[15:0];
  wire [15:0] wWrrPkgDrop;
  wire [15:0] wWrrFirAddrRdy;
  //WRR to CRC Data Check
  wire [15:0] wWrrRdSop;
  wire [15:0] wWrrRdEop;
  wire [15:0] wWrrRdVld;
  wire [31:0] wWrrRdData[15:0];
  wire [15:0] wWrrRdLast;
  //Xbar to Sram Driver
  wire [15:0] wSlvWrReq;
  wire [15:0] wSlvWrValid;
  wire [11:0] wSlvWrAddr[15:0];
  wire [3:0] wSlvWrSel[15:0];
  wire [15:0] wSlvWrLast;
  wire [31:0] wSlvWrData[15:0];
  wire [15:0] wSlvWrReady;
  wire [15:0] wSlvRdReq;
  wire [15:0] wSlvRdValid;
  wire [11:0] wSlvRdAddr[15:0];
  wire [3:0] wSlvRdSel[15:0];
  wire [15:0] wSlvRdLast;
  wire [15:0] wSlvRdReady;
  wire [31:0] wSlvRdData[15:0];
  //Sram Driver to Sram
  wire [15:0] wCEnA;
  wire [15:0] wCEnB;
  wire [15:0] wWEnA;
  wire [15:0] wWEnB;
  wire [31:0] wBWEnA[15:0];
  wire [31:0] wBWEnB[15:0];
  wire [13:0] wAddrA[15:0];
  wire [13:0] wAddrB[15:0];
  wire [31:0] wWDataA[15:0];
  wire [31:0] wWDataB[15:0];
  wire [31:0] wRDataA[15:0];
  wire [31:0] wRDataB[15:0];


  assign wWrSop[0] = iWrSop0;
  assign wWrSop[1] = iWrSop1;
  assign wWrSop[2] = iWrSop2;
  assign wWrSop[3] = iWrSop3;
  assign wWrSop[4] = iWrSop4;
  assign wWrSop[5] = iWrSop5;
  assign wWrSop[6] = iWrSop6;
  assign wWrSop[7] = iWrSop7;
  assign wWrSop[8] = iWrSop8;
  assign wWrSop[9] = iWrSop9;
  assign wWrSop[10] = iWrSop10;
  assign wWrSop[11] = iWrSop11;
  assign wWrSop[12] = iWrSop12;
  assign wWrSop[13] = iWrSop13;
  assign wWrSop[14] = iWrSop14;
  assign wWrSop[15] = iWrSop15;

  assign wWrEop[0] = iWrEop0;
  assign wWrEop[1] = iWrEop1;
  assign wWrEop[2] = iWrEop2;
  assign wWrEop[3] = iWrEop3;
  assign wWrEop[4] = iWrEop4;
  assign wWrEop[5] = iWrEop5;
  assign wWrEop[6] = iWrEop6;
  assign wWrEop[7] = iWrEop7;
  assign wWrEop[8] = iWrEop8;
  assign wWrEop[9] = iWrEop9;
  assign wWrEop[10] = iWrEop10;
  assign wWrEop[11] = iWrEop11;
  assign wWrEop[12] = iWrEop12;
  assign wWrEop[13] = iWrEop13;
  assign wWrEop[14] = iWrEop14;
  assign wWrEop[15] = iWrEop15;

  assign wWrVld[0] = iWrVld0;
  assign wWrVld[1] = iWrVld1;
  assign wWrVld[2] = iWrVld2;
  assign wWrVld[3] = iWrVld3;
  assign wWrVld[4] = iWrVld4;
  assign wWrVld[5] = iWrVld5;
  assign wWrVld[6] = iWrVld6;
  assign wWrVld[7] = iWrVld7;
  assign wWrVld[8] = iWrVld8;
  assign wWrVld[9] = iWrVld9;
  assign wWrVld[10] = iWrVld10;
  assign wWrVld[11] = iWrVld11;
  assign wWrVld[12] = iWrVld12;
  assign wWrVld[13] = iWrVld13;
  assign wWrVld[14] = iWrVld14;
  assign wWrVld[15] = iWrVld15;

  assign wWrData[0] = iWrData0;
  assign wWrData[1] = iWrData1;
  assign wWrData[2] = iWrData2;
  assign wWrData[3] = iWrData3;
  assign wWrData[4] = iWrData4;
  assign wWrData[5] = iWrData5;
  assign wWrData[6] = iWrData6;
  assign wWrData[7] = iWrData7;
  assign wWrData[8] = iWrData8;
  assign wWrData[9] = iWrData9;
  assign wWrData[10] = iWrData10;
  assign wWrData[11] = iWrData11;
  assign wWrData[12] = iWrData12;
  assign wWrData[13] = iWrData13;
  assign wWrData[14] = iWrData14;
  assign wWrData[15] = iWrData15;

  assign oFull0 = wFull[0];
  assign oFull1 = wFull[1];
  assign oFull2 = wFull[2];
  assign oFull3 = wFull[3];
  assign oFull4 = wFull[4];
  assign oFull5 = wFull[5];
  assign oFull6 = wFull[6];
  assign oFull7 = wFull[7];
  assign oFull8 = wFull[8];
  assign oFull9 = wFull[9];
  assign oFull10 = wFull[10];
  assign oFull11 = wFull[11];
  assign oFull12 = wFull[12];
  assign oFull13 = wFull[13];
  assign oFull14 = wFull[14];
  assign oFull15 = wFull[15];

  assign oAlmostFull0 = wAlmostFull[0];
  assign oAlmostFull1 = wAlmostFull[1];
  assign oAlmostFull2 = wAlmostFull[2];
  assign oAlmostFull3 = wAlmostFull[3];

  assign wReady[0] = iReady0;
  assign wReady[1] = iReady1;
  assign wReady[2] = iReady2;
  assign wReady[3] = iReady3;
  assign wReady[4] = iReady4;
  assign wReady[5] = iReady5;
  assign wReady[6] = iReady6;
  assign wReady[7] = iReady7;
  assign wReady[8] = iReady8;
  assign wReady[9] = iReady9;
  assign wReady[10] = iReady10;
  assign wReady[11] = iReady11;
  assign wReady[12] = iReady12;
  assign wReady[13] = iReady13;
  assign wReady[14] = iReady14;
  assign wReady[15] = iReady15;

  assign oRdSop0 = wRdSop[0];
  assign oRdSop1 = wRdSop[1];
  assign oRdSop2 = wRdSop[2];
  assign oRdSop3 = wRdSop[3];
  assign oRdSop4 = wRdSop[4];
  assign oRdSop5 = wRdSop[5];
  assign oRdSop6 = wRdSop[6];
  assign oRdSop7 = wRdSop[7];
  assign oRdSop8 = wRdSop[8];
  assign oRdSop9 = wRdSop[9];
  assign oRdSop10 = wRdSop[10];
  assign oRdSop11 = wRdSop[11];
  assign oRdSop12 = wRdSop[12];
  assign oRdSop13 = wRdSop[13];
  assign oRdSop14 = wRdSop[14];
  assign oRdSop15 = wRdSop[15];


  assign oRdEop0 = wRdEop[0];
  assign oRdEop1 = wRdEop[1];
  assign oRdEop2 = wRdEop[2];
  assign oRdEop3 = wRdEop[3];
  assign oRdEop4 = wRdEop[4];
  assign oRdEop5 = wRdEop[5];
  assign oRdEop6 = wRdEop[6];
  assign oRdEop7 = wRdEop[7];
  assign oRdEop8 = wRdEop[8];
  assign oRdEop9 = wRdEop[9];
  assign oRdEop10 = wRdEop[10];
  assign oRdEop11 = wRdEop[11];
  assign oRdEop12 = wRdEop[12];
  assign oRdEop13 = wRdEop[13];
  assign oRdEop14 = wRdEop[14];
  assign oRdEop15 = wRdEop[15];

  assign oRdVld0 = wRdVld[0];
  assign oRdVld1 = wRdVld[1];
  assign oRdVld2 = wRdVld[2];
  assign oRdVld3 = wRdVld[3];
  assign oRdVld4 = wRdVld[4];
  assign oRdVld5 = wRdVld[5];
  assign oRdVld6 = wRdVld[6];
  assign oRdVld7 = wRdVld[7];
  assign oRdVld8 = wRdVld[8];
  assign oRdVld9 = wRdVld[9];
  assign oRdVld10 = wRdVld[10];
  assign oRdVld11 = wRdVld[11];
  assign oRdVld12 = wRdVld[12];
  assign oRdVld13 = wRdVld[13];
  assign oRdVld14 = wRdVld[14];
  assign oRdVld15 = wRdVld[15];

  assign oRdData0 = wRdData[0];
  assign oRdData1 = wRdData[1];
  assign oRdData2 = wRdData[2];
  assign oRdData3 = wRdData[3];
  assign oRdData4 = wRdData[4];
  assign oRdData5 = wRdData[5];
  assign oRdData6 = wRdData[6];
  assign oRdData7 = wRdData[7];
  assign oRdData8 = wRdData[8];
  assign oRdData9 = wRdData[9];
  assign oRdData10 = wRdData[10];
  assign oRdData11 = wRdData[11];
  assign oRdData12 = wRdData[12];
  assign oRdData13 = wRdData[13];
  assign oRdData14 = wRdData[14];
  assign oRdData15 = wRdData[15];


  assign oErr0 = wErr[0];
  assign oErr1 = wErr[1];
  assign oErr2 = wErr[2];
  assign oErr3 = wErr[3];
  assign oErr4 = wErr[4];
  assign oErr5 = wErr[5];
  assign oErr6 = wErr[6];
  assign oErr7 = wErr[7];
  assign oErr8 = wErr[8];
  assign oErr9 = wErr[9];
  assign oErr10 = wErr[10];
  assign oErr11 = wErr[11];
  assign oErr12 = wErr[12];
  assign oErr13 = wErr[13];
  assign oErr14 = wErr[14];
  assign oErr15 = wErr[15];


  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_crc
      CrcDataSend U_CrcDataSend (
        .iClk       (iClk),
        .iRst_n     (iRst_n),
        .iWrSop     (wWrSop[i]),
        .iWrEop     (wWrEop[i]),
        .iWrVld     (wWrVld[i]),
        .iWrData    (wWrData[i]),
        .iFifoFull  (wFifoFull[i]),
        .iAlmostFull(wAlmostFull[i>>2]),
        .oWrSop     (wCrcWrSop[i]),
        .oWrEop     (wCrcWrEop[i]),
        .oWrVld     (wCrcWrVld[i]),
        .oWrData    (wCrcWrData[i]),
        .oFull      (wFull[i])
      );
    end

    for (i = 0; i < 4; i = i + 1) begin : gen_upack
      UnpackSgDma U_UnpackSgDma (
        .iClk            (iClk),
        .iRst_n          (iRst_n),
        .iWrSop0         (wCrcWrSop[i*4+0]),
        .iWrSop1         (wCrcWrSop[i*4+1]),
        .iWrSop2         (wCrcWrSop[i*4+2]),
        .iWrSop3         (wCrcWrSop[i*4+3]),
        .iWrEop0         (wCrcWrEop[i*4+0]),
        .iWrEop1         (wCrcWrEop[i*4+1]),
        .iWrEop2         (wCrcWrEop[i*4+2]),
        .iWrEop3         (wCrcWrEop[i*4+3]),
        .iWrVld0         (wCrcWrVld[i*4+0]),
        .iWrVld1         (wCrcWrVld[i*4+1]),
        .iWrVld2         (wCrcWrVld[i*4+2]),
        .iWrVld3         (wCrcWrVld[i*4+3]),
        .iWrData0        (wCrcWrData[i*4+0]),
        .iWrData1        (wCrcWrData[i*4+1]),
        .iWrData2        (wCrcWrData[i*4+2]),
        .iWrData3        (wCrcWrData[i*4+3]),
        .iEptyAddr0      (wEptyAddr[i*4+0]),
        .iEptyAddr1      (wEptyAddr[i*4+1]),
        .iEptyAddr2      (wEptyAddr[i*4+2]),
        .iEptyAddr3      (wEptyAddr[i*4+3]),
        .iEptyAddrVld0   (wEptyAddrVld[i*4+0]),
        .iEptyAddrVld1   (wEptyAddrVld[i*4+1]),
        .iEptyAddrVld2   (wEptyAddrVld[i*4+2]),
        .iEptyAddrVld3   (wEptyAddrVld[i*4+3]),
        .oEptyAddrRcvRdy0(wEptyAddrRcvRdy[i*4+0]),
        .oEptyAddrRcvRdy1(wEptyAddrRcvRdy[i*4+1]),
        .oEptyAddrRcvRdy2(wEptyAddrRcvRdy[i*4+2]),
        .oEptyAddrRcvRdy3(wEptyAddrRcvRdy[i*4+3]),
        .iWrrRdy0        (wUnpackWrrRdy[i*4+0]),
        .iWrrRdy1        (wUnpackWrrRdy[i*4+1]),
        .iWrrRdy2        (wUnpackWrrRdy[i*4+2]),
        .iWrrRdy3        (wUnpackWrrRdy[i*4+3]),
        .oPkgPri0        (wPkgPri[i*4+0]),
        .oPkgPri1        (wPkgPri[i*4+1]),
        .oPkgPri2        (wPkgPri[i*4+2]),
        .oPkgPri3        (wPkgPri[i*4+3]),
        .oPkgDstPort0    (wPkgDstPort[i*4+0]),
        .oPkgDstPort1    (wPkgDstPort[i*4+1]),
        .oPkgDstPort2    (wPkgDstPort[i*4+2]),
        .oPkgDstPort3    (wPkgDstPort[i*4+3]),
        .oPkgFirAddr0    (wPkgFirAddr[i*4+0]),
        .oPkgFirAddr1    (wPkgFirAddr[i*4+1]),
        .oPkgFirAddr2    (wPkgFirAddr[i*4+2]),
        .oPkgFirAddr3    (wPkgFirAddr[i*4+3]),
        .oPkgLen0        (wPkgLen[i*4+0]),
        .oPkgLen1        (wPkgLen[i*4+1]),
        .oPkgLen2        (wPkgLen[i*4+2]),
        .oPkgLen3        (wPkgLen[i*4+3]),
        .oPkgTagVld0     (wPkgTagVld[i*4+0]),
        .oPkgTagVld1     (wPkgTagVld[i*4+1]),
        .oPkgTagVld2     (wPkgTagVld[i*4+2]),
        .oPkgTagVld3     (wPkgTagVld[i*4+3]),
        .oLdata0         (wLdata[i*4+0]),
        .oLdata1         (wLdata[i*4+1]),
        .oLdata2         (wLdata[i*4+2]),
        .oLdata3         (wLdata[i*4+3]),
        .oLaddr0         (wLaddr[i*4+0]),
        .oLaddr1         (wLaddr[i*4+1]),
        .oLaddr2         (wLaddr[i*4+2]),
        .oLaddr3         (wLaddr[i*4+3]),
        .oLaddrVld0      (wLaddrVld[i*4+0]),
        .oLaddrVld1      (wLaddrVld[i*4+1]),
        .oLaddrVld2      (wLaddrVld[i*4+2]),
        .oLaddrVld3      (wLaddrVld[i*4+3]),
        .iMmuRdy0        (wPkgDataRdy[i*4+0]),
        .iMmuRdy1        (wPkgDataRdy[i*4+1]),
        .iMmuRdy2        (wPkgDataRdy[i*4+2]),
        .iMmuRdy3        (wPkgDataRdy[i*4+3]),
        .oPkgData0       (wPkgData[i*4+0]),
        .oPkgData1       (wPkgData[i*4+1]),
        .oPkgData2       (wPkgData[i*4+2]),
        .oPkgData3       (wPkgData[i*4+3]),
        .oPkgDataVld0    (wPkgDataVld[i*4+0]),
        .oPkgDataVld1    (wPkgDataVld[i*4+1]),
        .oPkgDataVld2    (wPkgDataVld[i*4+2]),
        .oPkgDataVld3    (wPkgDataVld[i*4+3]),
        .oPkgAddr0       (wPkgAddr[i*4+0]),
        .oPkgAddr1       (wPkgAddr[i*4+1]),
        .oPkgAddr2       (wPkgAddr[i*4+2]),
        .oPkgAddr3       (wPkgAddr[i*4+3]),
        .oPkgAddrVld0    (wPkgAddrVld[i*4+0]),
        .oPkgAddrVld1    (wPkgAddrVld[i*4+1]),
        .oPkgAddrVld2    (wPkgAddrVld[i*4+2]),
        .oPkgAddrVld3    (wPkgAddrVld[i*4+3]),
        .oPkgWrLast0     (wPkgWrLast[i*4+0]),
        .oPkgWrLast1     (wPkgWrLast[i*4+1]),
        .oPkgWrLast2     (wPkgWrLast[i*4+2]),
        .oPkgWrLast3     (wPkgWrLast[i*4+3]),
        .oFifoFull0      (wFifoFull[i*4+0]),
        .oFifoFull1      (wFifoFull[i*4+1]),
        .oFifoFull2      (wFifoFull[i*4+2]),
        .oFifoFull3      (wFifoFull[i*4+3])
      );
    end

    for (i = 0; i < 4; i = i + 1) begin : gen_addr
      AddrCtrl #(
        .FIFO_DEPTH(4095),
        .DATA_WIDTH(12),
        .ADDR_LENTH(12)
      ) U_AddrCtrl (
        .iClk         (iClk),
        .iRst_n       (iRst_n),
        .iRecAddr0    (wRecAddr[i*4+0]),
        .iRecAddrVld0 (wRecAddrVld[i*4+0]),
        .iRecAddr1    (wRecAddr[i*4+1]),
        .iRecAddrVld1 (wRecAddrVld[i*4+1]),
        .iRecAddr2    (wRecAddr[i*4+2]),
        .iRecAddrVld2 (wRecAddrVld[i*4+2]),
        .iRecAddr3    (wRecAddr[i*4+3]),
        .iRecAddrVld3 (wRecAddrVld[i*4+3]),
        .iEptyAddrRdy0(wEptyAddrRcvRdy[i*4+0]),
        .oEptyAddr0   (wEptyAddr[i*4+0]),
        .oEptyAddrVld0(wEptyAddrVld[i*4+0]),
        .iEptyAddrRdy1(wEptyAddrRcvRdy[i*4+1]),
        .oEptyAddr1   (wEptyAddr[i*4+1]),
        .oEptyAddrVld1(wEptyAddrVld[i*4+1]),
        .iEptyAddrRdy2(wEptyAddrRcvRdy[i*4+2]),
        .oEptyAddr2   (wEptyAddr[i*4+2]),
        .oEptyAddrVld2(wEptyAddrVld[i*4+2]),
        .iEptyAddrRdy3(wEptyAddrRcvRdy[i*4+3]),
        .oEptyAddr3   (wEptyAddr[i*4+3]),
        .oEptyAddrVld3(wEptyAddrVld[i*4+3]),
        .iDropData    (wDropRcvrAddr[i]),
        .iDropDataVld (wDropRcvrAddrVld[i]),
        .oFull        (),
        .oAlmostFull  (wAlmostFull[i])
      );
    end

    for (i = 0; i < 4; i = i + 1) begin : gen_lsram
      LinkListSram #(
        .ADDR_LENTH(12)
      ) U_LinkListSram (
        .iClk           (iClk),
        .iRst_n         (iRst_n),
        //Unpack
        .iWriteLdata0   (wLdata[i*4+0]),
        .iWriteLaddr0   (wLaddr[i*4+0]),
        .iWriteLaddrVld0(wLaddrVld[i*4+0]),
        .iWriteLdata1   (wLdata[i*4+1]),
        .iWriteLaddr1   (wLaddr[i*4+1]),
        .iWriteLaddrVld1(wLaddrVld[i*4+1]),
        .iWriteLdata2   (wLdata[i*4+2]),
        .iWriteLaddr2   (wLaddr[i*4+2]),
        .iWriteLaddrVld2(wLaddrVld[i*4+2]),
        .iWriteLdata3   (wLdata[i*4+3]),
        .iWriteLaddr3   (wLaddr[i*4+3]),
        .iWriteLaddrVld3(wLaddrVld[i*4+3]),
        //PkgRead
        .oLdata0        (wReadLdata[i*4+0]),
        .oLdataVld0     (wReadLdataVld[i*4+0]),
        .iLaddr0        (wReadAddr[i*4+0]),
        .iLNxtAddrReq0  (wReadAddrReq[i*4+0]),
        .oLdata1        (wReadLdata[i*4+1]),
        .oLdataVld1     (wReadLdataVld[i*4+1]),
        .iLaddr1        (wReadAddr[i*4+1]),
        .iLNxtAddrReq1  (wReadAddrReq[i*4+1]),
        .oLdata2        (wReadLdata[i*4+2]),
        .oLdataVld2     (wReadLdataVld[i*4+2]),
        .iLaddr2        (wReadAddr[i*4+2]),
        .iLNxtAddrReq2  (wReadAddrReq[i*4+2]),
        .oLdata3        (wReadLdata[i*4+3]),
        .oLdataVld3     (wReadLdataVld[i*4+3]),
        .iLaddr3        (wReadAddr[i*4+3]),
        .iLNxtAddrReq3  (wReadAddrReq[i*4+3]),
        //drop
        .iDropAddr      (wDropReadAddr[i]),
        .iDropAddrVld   (wDropReadAddrReq[i]),
        .oDropData      (wDropReadLdata[i]),
        .oDropDataVld   (wDropReadLdataVld[i])
      );
    end

    for (i = 0; i < 4; i = i + 1) begin : gen_xbar

      interconnect_4x4 #(
        .AW(12),
        .DW(32),
        .SW(4)
      ) U_interconnect_4x4 (
        .iClk        (iClk),
        .iRst_n      (iRst_n),
        .iMst0WrReq  (wPkgAddrVld[i*4+0]),
        .iMst0WrValid(wPkgDataVld[i*4+0]),
        .iMst0WrAddr (wPkgAddr[i*4+0]),
        .iMst0WrSel  ({4{1'b1}}),
        .iMst0WrLast (wPkgWrLast[i*4+0]),
        .iMst0WrData (wPkgData[i*4+0]),
        .oMst0WrReady(wPkgDataRdy[i*4+0]),
        .iMst1WrReq  (wPkgAddrVld[i*4+1]),
        .iMst1WrValid(wPkgDataVld[i*4+1]),
        .iMst1WrAddr (wPkgAddr[i*4+1]),
        .iMst1WrSel  ({4{1'b1}}),
        .iMst1WrLast (wPkgWrLast[i*4+1]),
        .iMst1WrData (wPkgData[i*4+1]),
        .oMst1WrReady(wPkgDataRdy[i*4+1]),
        .iMst2WrReq  (wPkgAddrVld[i*4+2]),
        .iMst2WrValid(wPkgDataVld[i*4+2]),
        .iMst2WrAddr (wPkgAddr[i*4+2]),
        .iMst2WrSel  ({4{1'b1}}),
        .iMst2WrLast (wPkgWrLast[i*4+2]),
        .iMst2WrData (wPkgData[i*4+2]),
        .oMst2WrReady(wPkgDataRdy[i*4+2]),
        .iMst3WrReq  (wPkgAddrVld[i*4+3]),
        .iMst3WrValid(wPkgDataVld[i*4+3]),
        .iMst3WrAddr (wPkgAddr[i*4+3]),
        .iMst3WrSel  ({4{1'b1}}),
        .iMst3WrLast (wPkgWrLast[i*4+3]),
        .iMst3WrData (wPkgData[i*4+3]),
        .oMst3WrReady(wPkgDataRdy[i*4+3]),
        .iMst0RdReq  (wMmuReadReq[i*4+0]),
        .iMst0RdValid(wBlockAddrVld[i*4+0]),
        .iMst0RdAddr (wBlockAddr[i*4+0]),
        .iMst0RdSel  ({4{1'b1}}),
        .iMst0RdLast (wMmuReadLast[i*4+0]),
        .oMst0RdReady(wMmuReadRdy[i*4+0]),
        .oMst0RdData (wData[i*4+0]),
        .iMst1RdReq  (wMmuReadReq[i*4+1]),
        .iMst1RdValid(wBlockAddrVld[i*4+1]),
        .iMst1RdAddr (wBlockAddr[i*4+1]),
        .iMst1RdSel  ({4{1'b1}}),
        .iMst1RdLast (wMmuReadLast[i*4+1]),
        .oMst1RdReady(wMmuReadRdy[i*4+1]),
        .oMst1RdData (wData[i*4+1]),
        .iMst2RdReq  (wMmuReadReq[i*4+2]),
        .iMst2RdValid(wBlockAddrVld[i*4+2]),
        .iMst2RdAddr (wBlockAddr[i*4+2]),
        .iMst2RdSel  ({4{1'b1}}),
        .iMst2RdLast (wMmuReadLast[i*4+2]),
        .oMst2RdReady(wMmuReadRdy[i*4+2]),
        .oMst2RdData (wData[i*4+2]),
        .iMst3RdReq  (wMmuReadReq[i*4+3]),
        .iMst3RdValid(wBlockAddrVld[i*4+3]),
        .iMst3RdAddr (wBlockAddr[i*4+3]),
        .iMst3RdSel  ({4{1'b1}}),
        .iMst3RdLast (wMmuReadLast[i*4+3]),
        .oMst3RdReady(wMmuReadRdy[i*4+3]),
        .oMst3RdData (wData[i*4+3]),
        .oSlv0WrReq  (wSlvWrReq[i*4+0]),
        .oSlv0WrValid(wSlvWrValid[i*4+0]),
        .oSlv0WrAddr (wSlvWrAddr[i*4+0]),
        .oSlv0WrSel  (wSlvWrSel[i*4+0]),
        .oSlv0WrLast (wSlvWrLast[i*4+0]),
        .oSlv0WrData (wSlvWrData[i*4+0]),
        .iSlv0WrReady(wSlvWrReady[i*4+0]),
        .oSlv1WrReq  (wSlvWrReq[i*4+1]),
        .oSlv1WrValid(wSlvWrValid[i*4+1]),
        .oSlv1WrAddr (wSlvWrAddr[i*4+1]),
        .oSlv1WrSel  (wSlvWrSel[i*4+1]),
        .oSlv1WrLast (wSlvWrLast[i*4+1]),
        .oSlv1WrData (wSlvWrData[i*4+1]),
        .iSlv1WrReady(wSlvWrReady[i*4+1]),
        .oSlv2WrReq  (wSlvWrReq[i*4+2]),
        .oSlv2WrValid(wSlvWrValid[i*4+2]),
        .oSlv2WrAddr (wSlvWrAddr[i*4+2]),
        .oSlv2WrSel  (wSlvWrSel[i*4+2]),
        .oSlv2WrLast (wSlvWrLast[i*4+2]),
        .oSlv2WrData (wSlvWrData[i*4+2]),
        .iSlv2WrReady(wSlvWrReady[i*4+2]),
        .oSlv3WrReq  (wSlvWrReq[i*4+3]),
        .oSlv3WrValid(wSlvWrValid[i*4+3]),
        .oSlv3WrAddr (wSlvWrAddr[i*4+3]),
        .oSlv3WrSel  (wSlvWrSel[i*4+3]),
        .oSlv3WrLast (wSlvWrLast[i*4+3]),
        .oSlv3WrData (wSlvWrData[i*4+3]),
        .iSlv3WrReady(wSlvWrReady[i*4+3]),
        .oSlv0RdReq  (wSlvRdReq[i*4+0]),
        .oSlv0RdValid(wSlvRdValid[i*4+0]),
        .oSlv0RdAddr (wSlvRdAddr[i*4+0]),
        .oSlv0RdSel  (wSlvRdSel[i*4+0]),
        .oSlv0RdLast (wSlvRdLast[i*4+0]),
        .iSlv0RdReady(wSlvRdReady[i*4+0]),
        .iSlv0RdData (wSlvRdData[i*4+0]),
        .oSlv1RdReq  (wSlvRdReq[i*4+1]),
        .oSlv1RdValid(wSlvRdValid[i*4+1]),
        .oSlv1RdAddr (wSlvRdAddr[i*4+1]),
        .oSlv1RdSel  (wSlvRdSel[i*4+1]),
        .oSlv1RdLast (wSlvRdLast[i*4+1]),
        .iSlv1RdReady(wSlvRdReady[i*4+1]),
        .iSlv1RdData (wSlvRdData[i*4+1]),
        .oSlv2RdReq  (wSlvRdReq[i*4+2]),
        .oSlv2RdValid(wSlvRdValid[i*4+2]),
        .oSlv2RdAddr (wSlvRdAddr[i*4+2]),
        .oSlv2RdSel  (wSlvRdSel[i*4+2]),
        .oSlv2RdLast (wSlvRdLast[i*4+2]),
        .iSlv2RdReady(wSlvRdReady[i*4+2]),
        .iSlv2RdData (wSlvRdData[i*4+2]),
        .oSlv3RdReq  (wSlvRdReq[i*4+3]),
        .oSlv3RdValid(wSlvRdValid[i*4+3]),
        .oSlv3RdAddr (wSlvRdAddr[i*4+3]),
        .oSlv3RdSel  (wSlvRdSel[i*4+3]),
        .oSlv3RdLast (wSlvRdLast[i*4+3]),
        .iSlv3RdReady(wSlvRdReady[i*4+3]),
        .iSlv3RdData (wSlvRdData[i*4+3])
      );
    end

    for (i = 0; i < 16; i = i + 1) begin : gen_sram
      sram_block_drv #(
        .DW      (32),
        .PAW     (14),
        .VAW     (12),
        .SW      (4),
        .TRANSLEN(16)
      ) U_sram_block_drv (
        .iClk        (iClk),
        .iRst_n      (iRst_n),
        .iSRAMWrReq  (wSlvWrReq[i]),
        .iSRAMWrValid(wSlvWrValid[i]),
        .iSRAMWrAddr (wSlvWrAddr[i]),
        .iSRAMWrSel  (wSlvWrSel[i]),
        .iSRAMWrLast (wSlvWrLast[i]),
        .iSRAMWrData (wSlvWrData[i]),
        .oSRAMWrReady(wSlvWrReady[i]),
        .iSRAMRdReq  (wSlvRdReq[i]),
        .iSRAMRdValid(wSlvRdValid[i]),
        .iSRAMRdAddr (wSlvRdAddr[i]),
        .iSRAMRdSel  (wSlvRdSel[i]),
        .iSRAMRdLast (wSlvRdLast[i]),
        .oSRAMRdReady(wSlvRdReady[i]),
        .oSRAMRdData (wSlvRdData[i]),
        .oCEnA       (wCEnA[i]),
        .oCEnB       (wCEnB[i]),
        .oWEnA       (wWEnA[i]),
        .oWEnB       (wWEnB[i]),
        .oBWEnA      (wBWEnA[i]),
        .oBWEnB      (wBWEnB[i]),
        .oAddrA      (wAddrA[i]),
        .oAddrB      (wAddrB[i]),
        .oWDataA     (wWDataA[i]),
        .oWDataB     (wWDataB[i]),
        .iRDataA     (wRDataA[i]),
        .iRDataB     (wRDataB[i])
      );

      sram_wrapper sram (
        .iClkA  (iClk),
        .iClkB  (iClk),
        .iRst_n (iRst_n),
        .iCEnA  (wCEnA[i]),
        .iCEnB  (wCEnB[i]),
        .iWEnA  (wWEnA[i]),
        .iWEnB  (wWEnB[i]),
        .iBWEnA (wBWEnA[i]),
        .iBWEnB (wBWEnB[i]),
        .iAddrA (wAddrA[i]),
        .iAddrB (wAddrB[i]),
        .iWDataA(wWDataA[i]),
        .iWDataB(wWDataB[i]),
        .oRDataA(wRDataA[i]),
        .oRDataB(wRDataB[i])
      );
    end

    for (i = 0; i < 4; i = i + 1) begin : gen_pkg_read
      PkgRead #(
        .ADDR_LENTH(12),
        .DATA_WIDTH(32)
      ) U_PkgRead (
        .iClk            (iClk),
        .iRst_n          (iRst_n),
        .oRcvrAddr0      (wRecAddr[i*4+0]),
        .oRcvrAddrVld0   (wRecAddrVld[i*4+0]),
        .oRcvrAddr1      (wRecAddr[i*4+1]),
        .oRcvrAddrVld1   (wRecAddrVld[i*4+1]),
        .oRcvrAddr2      (wRecAddr[i*4+2]),
        .oRcvrAddrVld2   (wRecAddrVld[i*4+2]),
        .oRcvrAddr3      (wRecAddr[i*4+3]),
        .oRcvrAddrVld3   (wRecAddrVld[i*4+3]),
        .oDropRcvrAddr   (wDropRcvrAddr[i]),
        .oDropRcvrAddrVld(wDropRcvrAddrVld[i]),
        .iLdata0         (wReadLdata[i*4+0]),
        .iLdataVld0      (wReadLdataVld[i*4+0]),
        .oLaddr0         (wReadAddr[i*4+0]),
        .oLaddrVld0      (wReadAddrReq[i*4+0]),
        .iLdata1         (wReadLdata[i*4+1]),
        .iLdataVld1      (wReadLdataVld[i*4+1]),
        .oLaddr1         (wReadAddr[i*4+1]),
        .oLaddrVld1      (wReadAddrReq[i*4+1]),
        .iLdata2         (wReadLdata[i*4+2]),
        .iLdataVld2      (wReadLdataVld[i*4+2]),
        .oLaddr2         (wReadAddr[i*4+2]),
        .oLaddrVld2      (wReadAddrReq[i*4+2]),
        .iLdata3         (wReadLdata[i*4+3]),
        .iLdataVld3      (wReadLdataVld[i*4+3]),
        .oLaddr3         (wReadAddr[i*4+3]),
        .oLaddrVld3      (wReadAddrReq[i*4+3]),
        .oDropAddr       (wDropReadAddr[i]),
        .oDropAddrVld    (wDropReadAddrReq[i]),
        .iDropData       (wDropReadLdata[i]),
        .iDropDataVld    (wDropReadLdataVld[i]),
        .iData0          (wData[i*4+0]),
        .iMmuRdy0        (wMmuReadRdy[i*4+0]),
        .oBlockAddr0     (wBlockAddr[i*4+0]),
        .oBlockAddrVld0  (wBlockAddrVld[i*4+0]),
        .oMmuReadReq0    (wMmuReadReq[i*4+0]),
        .oMmuReadLast0   (wMmuReadLast[i*4+0]),
        .iData1          (wData[i*4+1]),
        .iMmuRdy1        (wMmuReadRdy[i*4+1]),
        .oBlockAddr1     (wBlockAddr[i*4+1]),
        .oBlockAddrVld1  (wBlockAddrVld[i*4+1]),
        .oMmuReadReq1    (wMmuReadReq[i*4+1]),
        .oMmuReadLast1   (wMmuReadLast[i*4+1]),
        .iData2          (wData[i*4+2]),
        .iMmuRdy2        (wMmuReadRdy[i*4+2]),
        .oBlockAddr2     (wBlockAddr[i*4+2]),
        .oBlockAddrVld2  (wBlockAddrVld[i*4+2]),
        .oMmuReadReq2    (wMmuReadReq[i*4+2]),
        .oMmuReadLast2   (wMmuReadLast[i*4+2]),
        .iData3          (wData[i*4+3]),
        .iMmuRdy3        (wMmuReadRdy[i*4+3]),
        .oBlockAddr3     (wBlockAddr[i*4+3]),
        .oBlockAddrVld3  (wBlockAddrVld[i*4+3]),
        .oMmuReadReq3    (wMmuReadReq[i*4+3]),
        .oMmuReadLast3   (wMmuReadLast[i*4+3]),
        .iPkgFirAddr0    (wWrrFirAddr[i*4+0]),
        .iPkgFirAddrVld0 (wWrrFirAddrVld[i*4+0]),
        .iPkgBlockNum0   (wWrrBlockNum[i*4+0]),
        .iPkgDrop0       (wWrrPkgDrop[i*4+0]),
        .oPkgFirAddrRdy0 (wWrrFirAddrRdy[i*4+0]),
        .iPkgFirAddr1    (wWrrFirAddr[i*4+1]),
        .iPkgFirAddrVld1 (wWrrFirAddrVld[i*4+1]),
        .iPkgBlockNum1   (wWrrBlockNum[i*4+1]),
        .iPkgDrop1       (wWrrPkgDrop[i*4+1]),
        .oPkgFirAddrRdy1 (wWrrFirAddrRdy[i*4+1]),
        .iPkgFirAddr2    (wWrrFirAddr[i*4+2]),
        .iPkgFirAddrVld2 (wWrrFirAddrVld[i*4+2]),
        .iPkgBlockNum2   (wWrrBlockNum[i*4+2]),
        .iPkgDrop2       (wWrrPkgDrop[i*4+2]),
        .oPkgFirAddrRdy2 (wWrrFirAddrRdy[i*4+2]),
        .iPkgFirAddr3    (wWrrFirAddr[i*4+3]),
        .iPkgFirAddrVld3 (wWrrFirAddrVld[i*4+3]),
        .iPkgBlockNum3   (wWrrBlockNum[i*4+3]),
        .iPkgDrop3       (wWrrPkgDrop[i*4+3]),
        .oPkgFirAddrRdy3 (wWrrFirAddrRdy[i*4+3]),
        .oWrrData0       (wWrrData[i*4+0]),
        .oWrrVld0        (wWrrDataVld[i*4+0]),
        .oWrrDataLast0   (wWrrDataLast[i*4+0]),
        .iWrrRdy0        (wWrrDataRdy[i*4+0]),
        .oWrrData1       (wWrrData[i*4+1]),
        .oWrrVld1        (wWrrDataVld[i*4+1]),
        .oWrrDataLast1   (wWrrDataLast[i*4+1]),
        .iWrrRdy1        (wWrrDataRdy[i*4+1]),
        .oWrrData2       (wWrrData[i*4+2]),
        .oWrrVld2        (wWrrDataVld[i*4+2]),
        .oWrrDataLast2   (wWrrDataLast[i*4+2]),
        .iWrrRdy2        (wWrrDataRdy[i*4+2]),
        .oWrrData3       (wWrrData[i*4+3]),
        .oWrrVld3        (wWrrDataVld[i*4+3]),
        .oWrrDataLast3   (wWrrDataLast[i*4+3]),
        .iWrrRdy3        (wWrrDataRdy[i*4+3])
      );
    end
  endgenerate


  RdScheTopWrapper #(
    .PRI_DEPTH(PRI_DEPTH),
    .WRR_WEIGHT_NUM(WRR_WEIGHT_NUM)
  ) U_RdScheTopWrapper (
    .iClk            (iClk),
    .iRst_n          (iRst_n),
    .oPkgRdy0        (wUnpackWrrRdy[0]),
    .iPkgPri0        (wPkgPri[0]),
    .iPkgDstPort0    (wPkgDstPort[0]),
    .iPkgFirAddr0    (wPkgFirAddr[0]),
    .iPkgLen0        (wPkgLen[0]),
    .iPkgTagVld0     (wPkgTagVld[0]),
    .oPkgRdy1        (wUnpackWrrRdy[1]),
    .iPkgPri1        (wPkgPri[1]),
    .iPkgDstPort1    (wPkgDstPort[1]),
    .iPkgFirAddr1    (wPkgFirAddr[1]),
    .iPkgLen1        (wPkgLen[1]),
    .iPkgTagVld1     (wPkgTagVld[1]),
    .oPkgRdy2        (wUnpackWrrRdy[2]),
    .iPkgPri2        (wPkgPri[2]),
    .iPkgDstPort2    (wPkgDstPort[2]),
    .iPkgFirAddr2    (wPkgFirAddr[2]),
    .iPkgLen2        (wPkgLen[2]),
    .iPkgTagVld2     (wPkgTagVld[2]),
    .oPkgRdy3        (wUnpackWrrRdy[3]),
    .iPkgPri3        (wPkgPri[3]),
    .iPkgDstPort3    (wPkgDstPort[3]),
    .iPkgFirAddr3    (wPkgFirAddr[3]),
    .iPkgLen3        (wPkgLen[3]),
    .iPkgTagVld3     (wPkgTagVld[3]),
    .oPkgRdy4        (wUnpackWrrRdy[4]),
    .iPkgPri4        (wPkgPri[4]),
    .iPkgDstPort4    (wPkgDstPort[4]),
    .iPkgFirAddr4    (wPkgFirAddr[4]),
    .iPkgLen4        (wPkgLen[4]),
    .iPkgTagVld4     (wPkgTagVld[4]),
    .oPkgRdy5        (wUnpackWrrRdy[5]),
    .iPkgPri5        (wPkgPri[5]),
    .iPkgDstPort5    (wPkgDstPort[5]),
    .iPkgFirAddr5    (wPkgFirAddr[5]),
    .iPkgLen5        (wPkgLen[5]),
    .iPkgTagVld5     (wPkgTagVld[5]),
    .oPkgRdy6        (wUnpackWrrRdy[6]),
    .iPkgPri6        (wPkgPri[6]),
    .iPkgDstPort6    (wPkgDstPort[6]),
    .iPkgFirAddr6    (wPkgFirAddr[6]),
    .iPkgLen6        (wPkgLen[6]),
    .iPkgTagVld6     (wPkgTagVld[6]),
    .oPkgRdy7        (wUnpackWrrRdy[7]),
    .iPkgPri7        (wPkgPri[7]),
    .iPkgDstPort7    (wPkgDstPort[7]),
    .iPkgFirAddr7    (wPkgFirAddr[7]),
    .iPkgLen7        (wPkgLen[7]),
    .iPkgTagVld7     (wPkgTagVld[7]),
    .oPkgRdy8        (wUnpackWrrRdy[8]),
    .iPkgPri8        (wPkgPri[8]),
    .iPkgDstPort8    (wPkgDstPort[8]),
    .iPkgFirAddr8    (wPkgFirAddr[8]),
    .iPkgLen8        (wPkgLen[8]),
    .iPkgTagVld8     (wPkgTagVld[8]),
    .oPkgRdy9        (wUnpackWrrRdy[9]),
    .iPkgPri9        (wPkgPri[9]),
    .iPkgDstPort9    (wPkgDstPort[9]),
    .iPkgFirAddr9    (wPkgFirAddr[9]),
    .iPkgLen9        (wPkgLen[9]),
    .iPkgTagVld9     (wPkgTagVld[9]),
    .oPkgRdy10       (wUnpackWrrRdy[10]),
    .iPkgPri10       (wPkgPri[10]),
    .iPkgDstPort10   (wPkgDstPort[10]),
    .iPkgFirAddr10   (wPkgFirAddr[10]),
    .iPkgLen10       (wPkgLen[10]),
    .iPkgTagVld10    (wPkgTagVld[10]),
    .oPkgRdy11       (wUnpackWrrRdy[11]),
    .iPkgPri11       (wPkgPri[11]),
    .iPkgDstPort11   (wPkgDstPort[11]),
    .iPkgFirAddr11   (wPkgFirAddr[11]),
    .iPkgLen11       (wPkgLen[11]),
    .iPkgTagVld11    (wPkgTagVld[11]),
    .oPkgRdy12       (wUnpackWrrRdy[12]),
    .iPkgPri12       (wPkgPri[12]),
    .iPkgDstPort12   (wPkgDstPort[12]),
    .iPkgFirAddr12   (wPkgFirAddr[12]),
    .iPkgLen12       (wPkgLen[12]),
    .iPkgTagVld12    (wPkgTagVld[12]),
    .oPkgRdy13       (wUnpackWrrRdy[13]),
    .iPkgPri13       (wPkgPri[13]),
    .iPkgDstPort13   (wPkgDstPort[13]),
    .iPkgFirAddr13   (wPkgFirAddr[13]),
    .iPkgLen13       (wPkgLen[13]),
    .iPkgTagVld13    (wPkgTagVld[13]),
    .oPkgRdy14       (wUnpackWrrRdy[14]),
    .iPkgPri14       (wPkgPri[14]),
    .iPkgDstPort14   (wPkgDstPort[14]),
    .iPkgFirAddr14   (wPkgFirAddr[14]),
    .iPkgLen14       (wPkgLen[14]),
    .iPkgTagVld14    (wPkgTagVld[14]),
    .oPkgRdy15       (wUnpackWrrRdy[15]),
    .iPkgPri15       (wPkgPri[15]),
    .iPkgDstPort15   (wPkgDstPort[15]),
    .iPkgFirAddr15   (wPkgFirAddr[15]),
    .iPkgLen15       (wPkgLen[15]),
    .iPkgTagVld15    (wPkgTagVld[15]),
    .oPkgFirAddr0    (wWrrFirAddr[0]),
    .oPkgFirAddrVld0 (wWrrFirAddrVld[0]),
    .oPkgBlockNum0   (wWrrBlockNum[0]),
    .oPkgDrop0       (wWrrPkgDrop[0]),
    .iPkgFirAddrRdy0 (wWrrFirAddrRdy[0]),
    .oPkgFirAddr1    (wWrrFirAddr[1]),
    .oPkgFirAddrVld1 (wWrrFirAddrVld[1]),
    .oPkgBlockNum1   (wWrrBlockNum[1]),
    .oPkgDrop1       (wWrrPkgDrop[1]),
    .iPkgFirAddrRdy1 (wWrrFirAddrRdy[1]),
    .oPkgFirAddr2    (wWrrFirAddr[2]),
    .oPkgFirAddrVld2 (wWrrFirAddrVld[2]),
    .oPkgBlockNum2   (wWrrBlockNum[2]),
    .oPkgDrop2       (wWrrPkgDrop[2]),
    .iPkgFirAddrRdy2 (wWrrFirAddrRdy[2]),
    .oPkgFirAddr3    (wWrrFirAddr[3]),
    .oPkgFirAddrVld3 (wWrrFirAddrVld[3]),
    .oPkgBlockNum3   (wWrrBlockNum[3]),
    .oPkgDrop3       (wWrrPkgDrop[3]),
    .iPkgFirAddrRdy3 (wWrrFirAddrRdy[3]),
    .oPkgFirAddr4    (wWrrFirAddr[4]),
    .oPkgFirAddrVld4 (wWrrFirAddrVld[4]),
    .oPkgBlockNum4   (wWrrBlockNum[4]),
    .oPkgDrop4       (wWrrPkgDrop[4]),
    .iPkgFirAddrRdy4 (wWrrFirAddrRdy[4]),
    .oPkgFirAddr5    (wWrrFirAddr[5]),
    .oPkgFirAddrVld5 (wWrrFirAddrVld[5]),
    .oPkgBlockNum5   (wWrrBlockNum[5]),
    .oPkgDrop5       (wWrrPkgDrop[5]),
    .iPkgFirAddrRdy5 (wWrrFirAddrRdy[5]),
    .oPkgFirAddr6    (wWrrFirAddr[6]),
    .oPkgFirAddrVld6 (wWrrFirAddrVld[6]),
    .oPkgBlockNum6   (wWrrBlockNum[6]),
    .oPkgDrop6       (wWrrPkgDrop[6]),
    .iPkgFirAddrRdy6 (wWrrFirAddrRdy[6]),
    .oPkgFirAddr7    (wWrrFirAddr[7]),
    .oPkgFirAddrVld7 (wWrrFirAddrVld[7]),
    .oPkgBlockNum7   (wWrrBlockNum[7]),
    .oPkgDrop7       (wWrrPkgDrop[7]),
    .iPkgFirAddrRdy7 (wWrrFirAddrRdy[7]),
    .oPkgFirAddr8    (wWrrFirAddr[8]),
    .oPkgFirAddrVld8 (wWrrFirAddrVld[8]),
    .oPkgBlockNum8   (wWrrBlockNum[8]),
    .oPkgDrop8       (wWrrPkgDrop[8]),
    .iPkgFirAddrRdy8 (wWrrFirAddrRdy[8]),
    .oPkgFirAddr9    (wWrrFirAddr[9]),
    .oPkgFirAddrVld9 (wWrrFirAddrVld[9]),
    .oPkgBlockNum9   (wWrrBlockNum[9]),
    .oPkgDrop9       (wWrrPkgDrop[9]),
    .iPkgFirAddrRdy9 (wWrrFirAddrRdy[9]),
    .oPkgFirAddr10   (wWrrFirAddr[10]),
    .oPkgFirAddrVld10(wWrrFirAddrVld[10]),
    .oPkgBlockNum10  (wWrrBlockNum[10]),
    .oPkgDrop10      (wWrrPkgDrop[10]),
    .iPkgFirAddrRdy10(wWrrFirAddrRdy[10]),
    .oPkgFirAddr11   (wWrrFirAddr[11]),
    .oPkgFirAddrVld11(wWrrFirAddrVld[11]),
    .oPkgBlockNum11  (wWrrBlockNum[11]),
    .oPkgDrop11      (wWrrPkgDrop[11]),
    .iPkgFirAddrRdy11(wWrrFirAddrRdy[11]),
    .oPkgFirAddr12   (wWrrFirAddr[12]),
    .oPkgFirAddrVld12(wWrrFirAddrVld[12]),
    .oPkgBlockNum12  (wWrrBlockNum[12]),
    .oPkgDrop12      (wWrrPkgDrop[12]),
    .iPkgFirAddrRdy12(wWrrFirAddrRdy[12]),
    .oPkgFirAddr13   (wWrrFirAddr[13]),
    .oPkgFirAddrVld13(wWrrFirAddrVld[13]),
    .oPkgBlockNum13  (wWrrBlockNum[13]),
    .oPkgDrop13      (wWrrPkgDrop[13]),
    .iPkgFirAddrRdy13(wWrrFirAddrRdy[13]),
    .oPkgFirAddr14   (wWrrFirAddr[14]),
    .oPkgFirAddrVld14(wWrrFirAddrVld[14]),
    .oPkgBlockNum14  (wWrrBlockNum[14]),
    .oPkgDrop14      (wWrrPkgDrop[14]),
    .iPkgFirAddrRdy14(wWrrFirAddrRdy[14]),
    .oPkgFirAddr15   (wWrrFirAddr[15]),
    .oPkgFirAddrVld15(wWrrFirAddrVld[15]),
    .oPkgBlockNum15  (wWrrBlockNum[15]),
    .oPkgDrop15      (wWrrPkgDrop[15]),
    .iPkgFirAddrRdy15(wWrrFirAddrRdy[15]),
    .iWrrData0       (wWrrData[0]),
    .iWrrVld0        (wWrrDataVld[0]),
    .iWrrLast0       (wWrrDataLast[0]),
    .oWrrRdy0        (wWrrDataRdy[0]),
    .iWrrData1       (wWrrData[1]),
    .iWrrVld1        (wWrrDataVld[1]),
    .iWrrLast1       (wWrrDataLast[1]),
    .oWrrRdy1        (wWrrDataRdy[1]),
    .iWrrData2       (wWrrData[2]),
    .iWrrVld2        (wWrrDataVld[2]),
    .iWrrLast2       (wWrrDataLast[2]),
    .oWrrRdy2        (wWrrDataRdy[2]),
    .iWrrData3       (wWrrData[3]),
    .iWrrVld3        (wWrrDataVld[3]),
    .iWrrLast3       (wWrrDataLast[3]),
    .oWrrRdy3        (wWrrDataRdy[3]),
    .iWrrData4       (wWrrData[4]),
    .iWrrVld4        (wWrrDataVld[4]),
    .iWrrLast4       (wWrrDataLast[4]),
    .oWrrRdy4        (wWrrDataRdy[4]),
    .iWrrData5       (wWrrData[5]),
    .iWrrVld5        (wWrrDataVld[5]),
    .iWrrLast5       (wWrrDataLast[5]),
    .oWrrRdy5        (wWrrDataRdy[5]),
    .iWrrData6       (wWrrData[6]),
    .iWrrVld6        (wWrrDataVld[6]),
    .iWrrLast6       (wWrrDataLast[6]),
    .oWrrRdy6        (wWrrDataRdy[6]),
    .iWrrData7       (wWrrData[7]),
    .iWrrVld7        (wWrrDataVld[7]),
    .iWrrLast7       (wWrrDataLast[7]),
    .oWrrRdy7        (wWrrDataRdy[7]),
    .iWrrData8       (wWrrData[8]),
    .iWrrVld8        (wWrrDataVld[8]),
    .iWrrLast8       (wWrrDataLast[8]),
    .oWrrRdy8        (wWrrDataRdy[8]),
    .iWrrData9       (wWrrData[9]),
    .iWrrVld9        (wWrrDataVld[9]),
    .iWrrLast9       (wWrrDataLast[9]),
    .oWrrRdy9        (wWrrDataRdy[9]),
    .iWrrData10      (wWrrData[10]),
    .iWrrVld10       (wWrrDataVld[10]),
    .iWrrLast10      (wWrrDataLast[10]),
    .oWrrRdy10       (wWrrDataRdy[10]),
    .iWrrData11      (wWrrData[11]),
    .iWrrVld11       (wWrrDataVld[11]),
    .iWrrLast11      (wWrrDataLast[11]),
    .oWrrRdy11       (wWrrDataRdy[11]),
    .iWrrData12      (wWrrData[12]),
    .iWrrVld12       (wWrrDataVld[12]),
    .iWrrLast12      (wWrrDataLast[12]),
    .oWrrRdy12       (wWrrDataRdy[12]),
    .iWrrData13      (wWrrData[13]),
    .iWrrVld13       (wWrrDataVld[13]),
    .iWrrLast13      (wWrrDataLast[13]),
    .oWrrRdy13       (wWrrDataRdy[13]),
    .iWrrData14      (wWrrData[14]),
    .iWrrVld14       (wWrrDataVld[14]),
    .iWrrLast14      (wWrrDataLast[14]),
    .oWrrRdy14       (wWrrDataRdy[14]),
    .iWrrData15      (wWrrData[15]),
    .iWrrVld15       (wWrrDataVld[15]),
    .iWrrLast15      (wWrrDataLast[15]),
    .oWrrRdy15       (wWrrDataRdy[15]),
    .oRdSop0         (wWrrRdSop[0]),
    .oRdEop0         (wWrrRdEop[0]),
    .oRdVld0         (wWrrRdVld[0]),
    .oRdData0        (wWrrRdData[0]),
    .iRdRdy0         (wReady[0]),
    .oRdLast0        (wWrrRdLast[0]),
    .oRdSop1         (wWrrRdSop[1]),
    .oRdEop1         (wWrrRdEop[1]),
    .oRdVld1         (wWrrRdVld[1]),
    .oRdData1        (wWrrRdData[1]),
    .iRdRdy1         (wReady[1]),
    .oRdLast1        (wWrrRdLast[1]),
    .oRdSop2         (wWrrRdSop[2]),
    .oRdEop2         (wWrrRdEop[2]),
    .oRdVld2         (wWrrRdVld[2]),
    .oRdData2        (wWrrRdData[2]),
    .iRdRdy2         (wReady[2]),
    .oRdLast2        (wWrrRdLast[2]),
    .oRdSop3         (wWrrRdSop[3]),
    .oRdEop3         (wWrrRdEop[3]),
    .oRdVld3         (wWrrRdVld[3]),
    .oRdData3        (wWrrRdData[3]),
    .iRdRdy3         (wReady[3]),
    .oRdLast3        (wWrrRdLast[3]),
    .oRdSop4         (wWrrRdSop[4]),
    .oRdEop4         (wWrrRdEop[4]),
    .oRdVld4         (wWrrRdVld[4]),
    .oRdData4        (wWrrRdData[4]),
    .iRdRdy4         (wReady[4]),
    .oRdLast4        (wWrrRdLast[4]),
    .oRdSop5         (wWrrRdSop[5]),
    .oRdEop5         (wWrrRdEop[5]),
    .oRdVld5         (wWrrRdVld[5]),
    .oRdData5        (wWrrRdData[5]),
    .iRdRdy5         (wReady[5]),
    .oRdLast5        (wWrrRdLast[5]),
    .oRdSop6         (wWrrRdSop[6]),
    .oRdEop6         (wWrrRdEop[6]),
    .oRdVld6         (wWrrRdVld[6]),
    .oRdData6        (wWrrRdData[6]),
    .iRdRdy6         (wReady[6]),
    .oRdLast6        (wWrrRdLast[6]),
    .oRdSop7         (wWrrRdSop[7]),
    .oRdEop7         (wWrrRdEop[7]),
    .oRdVld7         (wWrrRdVld[7]),
    .oRdData7        (wWrrRdData[7]),
    .iRdRdy7         (wReady[7]),
    .oRdLast7        (wWrrRdLast[7]),
    .oRdSop8         (wWrrRdSop[8]),
    .oRdEop8         (wWrrRdEop[8]),
    .oRdVld8         (wWrrRdVld[8]),
    .oRdData8        (wWrrRdData[8]),
    .iRdRdy8         (wReady[8]),
    .oRdLast8        (wWrrRdLast[8]),
    .oRdSop9         (wWrrRdSop[9]),
    .oRdEop9         (wWrrRdEop[9]),
    .oRdVld9         (wWrrRdVld[9]),
    .oRdData9        (wWrrRdData[9]),
    .iRdRdy9         (wReady[9]),
    .oRdLast9        (wWrrRdLast[9]),
    .oRdSop10        (wWrrRdSop[10]),
    .oRdEop10        (wWrrRdEop[10]),
    .oRdVld10        (wWrrRdVld[10]),
    .oRdData10       (wWrrRdData[10]),
    .iRdRdy10        (wReady[10]),
    .oRdLast10       (wWrrRdLast[10]),
    .oRdSop11        (wWrrRdSop[11]),
    .oRdEop11        (wWrrRdEop[11]),
    .oRdVld11        (wWrrRdVld[11]),
    .oRdData11       (wWrrRdData[11]),
    .iRdRdy11        (wReady[11]),
    .oRdLast11       (wWrrRdLast[11]),
    .oRdSop12        (wWrrRdSop[12]),
    .oRdEop12        (wWrrRdEop[12]),
    .oRdVld12        (wWrrRdVld[12]),
    .oRdData12       (wWrrRdData[12]),
    .iRdRdy12        (wReady[12]),
    .oRdLast12       (wWrrRdLast[12]),
    .oRdSop13        (wWrrRdSop[13]),
    .oRdEop13        (wWrrRdEop[13]),
    .oRdVld13        (wWrrRdVld[13]),
    .oRdData13       (wWrrRdData[13]),
    .iRdRdy13        (wReady[13]),
    .oRdLast13       (wWrrRdLast[13]),
    .oRdSop14        (wWrrRdSop[14]),
    .oRdEop14        (wWrrRdEop[14]),
    .oRdVld14        (wWrrRdVld[14]),
    .oRdData14       (wWrrRdData[14]),
    .iRdRdy14        (wReady[14]),
    .oRdLast14       (wWrrRdLast[14]),
    .oRdSop15        (wWrrRdSop[15]),
    .oRdEop15        (wWrrRdEop[15]),
    .oRdVld15        (wWrrRdVld[15]),
    .oRdData15       (wWrrRdData[15]),
    .iRdRdy15        (wReady[15]),
    .oRdLast15       (wWrrRdLast[15]),
    .iWrrWeightPld0  (iWrrWeightPld0),
    .iWrrWeightPld1  (iWrrWeightPld1),
    .iWrrWeightPld2  (iWrrWeightPld2),
    .iWrrWeightPld3  (iWrrWeightPld3),
    .iWrrWeightPld4  (iWrrWeightPld4),
    .iWrrWeightPld5  (iWrrWeightPld5),
    .iWrrWeightPld6  (iWrrWeightPld6),
    .iWrrWeightPld7  (iWrrWeightPld7),
    .iWrrWeightIdx   (iWrrWeightIdx),
    .iWrrWeightLoad  (iWrrWeightLoad)
  );


  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_crc_data_check
      CrcDataCheck U_CrcDataCheck (
        .iClk   (iClk),
        .iRst_n (iRst_n),
        .iRdSop (wWrrRdSop[i]),
        .iRdEop (wWrrRdEop[i]),
        .iRdVld (wWrrRdVld[i]),
        .iRdLast(wWrrRdLast[i]),
        .iRdData(wWrrRdData[i]),
        .oRdSop (wRdSop[i]),
        .oRdEop (wRdEop[i]),
        .oRdVld (wRdVld[i]),
        .oRdData(wRdData[i]),
        .oErr   (wErr[i]),
        .iReady (wReady[i])
      );
    end
  endgenerate

endmodule
