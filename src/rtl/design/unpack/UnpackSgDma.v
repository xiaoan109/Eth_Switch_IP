// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/unpack/UnpackSgDma.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-07
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-14
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
//  2024-4-7 |  liuyanlong |     1.0     | Original Version
//                  
// 
// -FHEADER =====================================================================
module UnpackSgDma #(
) (
  input  wire        iClk,
  input  wire        iRst_n,
  //outside
  input  wire        iWrSop0,
  input  wire        iWrSop1,
  input  wire        iWrSop2,
  input  wire        iWrSop3,
  input  wire        iWrEop0,
  input  wire        iWrEop1,
  input  wire        iWrEop2,
  input  wire        iWrEop3,
  input  wire        iWrVld0,
  input  wire        iWrVld1,
  input  wire        iWrVld2,
  input  wire        iWrVld3,
  input  wire [31:0] iWrData0,
  input  wire [31:0] iWrData1,
  input  wire [31:0] iWrData2,
  input  wire [31:0] iWrData3,
  output wire        oFifoFull0,
  output wire        oFifoFull1,
  output wire        oFifoFull2,
  output wire        oFifoFull3,
  // addr ctrl
  input  wire [11:0] iEptyAddr0,
  input  wire [11:0] iEptyAddr1,
  input  wire [11:0] iEptyAddr2,
  input  wire [11:0] iEptyAddr3,
  input  wire        iEptyAddrVld0,
  input  wire        iEptyAddrVld1,
  input  wire        iEptyAddrVld2,
  input  wire        iEptyAddrVld3,
  output wire        oEptyAddrRcvRdy0,
  output wire        oEptyAddrRcvRdy1,
  output wire        oEptyAddrRcvRdy2,
  output wire        oEptyAddrRcvRdy3,
  // wrr
  input  wire        iWrrRdy0,
  input  wire        iWrrRdy1,
  input  wire        iWrrRdy2,
  input  wire        iWrrRdy3,
  output wire [11:0] oPkgFirAddr0,
  output wire [11:0] oPkgFirAddr1,
  output wire [11:0] oPkgFirAddr2,
  output wire [11:0] oPkgFirAddr3,
  output wire [ 3:0] oPkgLen0,          // 0-15, full Block, 0 represents 1, 15 represents 16
  output wire [ 3:0] oPkgLen1,
  output wire [ 3:0] oPkgLen2,
  output wire [ 3:0] oPkgLen3,
  output wire [ 2:0] oPkgPri0,
  output wire [ 2:0] oPkgPri1,
  output wire [ 2:0] oPkgPri2,
  output wire [ 2:0] oPkgPri3,
  output wire [ 3:0] oPkgDstPort0,
  output wire [ 3:0] oPkgDstPort1,
  output wire [ 3:0] oPkgDstPort2,
  output wire [ 3:0] oPkgDstPort3,
  output wire        oPkgTagVld0,
  output wire        oPkgTagVld1,
  output wire        oPkgTagVld2,
  output wire        oPkgTagVld3,
  //Lsram
  output wire [11:0] oLdata0,           //link list data(next addr)
  output wire [11:0] oLdata1,
  output wire [11:0] oLdata2,
  output wire [11:0] oLdata3,
  output wire [11:0] oLaddr0,           //link list addr(current addr)
  output wire [11:0] oLaddr1,
  output wire [11:0] oLaddr2,
  output wire [11:0] oLaddr3,
  output wire        oLaddrVld0,
  output wire        oLaddrVld1,
  output wire        oLaddrVld2,
  output wire        oLaddrVld3,
  //mmu
  output wire [31:0] oPkgData0,
  output wire [31:0] oPkgData1,
  output wire [31:0] oPkgData2,
  output wire [31:0] oPkgData3,
  output wire        oPkgDataVld0,
  output wire        oPkgDataVld1,
  output wire        oPkgDataVld2,
  output wire        oPkgDataVld3,
  output wire [11:0] oPkgAddr0,
  output wire [11:0] oPkgAddr1,
  output wire [11:0] oPkgAddr2,
  output wire [11:0] oPkgAddr3,
  output wire        oPkgAddrVld0,
  output wire        oPkgAddrVld1,
  output wire        oPkgAddrVld2,
  output wire        oPkgAddrVld3,
  output wire        oPkgWrLast0,
  output wire        oPkgWrLast1,
  output wire        oPkgWrLast2,
  output wire        oPkgWrLast3,
  input  wire        iMmuRdy0,
  input  wire        iMmuRdy1,
  input  wire        iMmuRdy2,
  input  wire        iMmuRdy3
);

  wire [3:0] wWrSop;
  wire [3:0] wWrEop;
  wire [3:0] wWrRdy;
  wire [31:0] wWrData[3:0];
  wire [3:0] wWrVld;
  wire [3:0] wIdleState;
  wire [3:0] wAllLast;
  wire [3:0] wAllLastPosedge;

  //--------------------Fifo--------------------//
  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(32)   //31:0:data
  ) U0_UnpackFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (iWrData0),
    .iWEn        (iWrVld0),
    .iREn        (wWrRdy[0]),
    .oReadData   (wWrData[0]),
    .oReadDataVld(wWrVld[0]),
    .oFull       (oFifoFull0),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(32)   //31:0:data
  ) U1_UnpackFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (iWrData1),
    .iWEn        (iWrVld1),
    .iREn        (wWrRdy[1]),
    .oReadData   (wWrData[1]),
    .oReadDataVld(wWrVld[1]),
    .oFull       (oFifoFull1),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(32)   //31:0:data
  ) U2_UnpackFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (iWrData2),
    .iWEn        (iWrVld2),
    .iREn        (wWrRdy[2]),
    .oReadData   (wWrData[2]),
    .oReadDataVld(wWrVld[2]),
    .oFull       (oFifoFull2),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(32)   //31:0:data
  ) U3_UnpackFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (iWrData3),
    .iWEn        (iWrVld3),
    .iREn        (wWrRdy[3]),
    .oReadData   (wWrData[3]),
    .oReadDataVld(wWrVld[3]),
    .oFull       (oFifoFull3),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U0_SopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrSop0),
    .iREn        (wIdleState[0]),
    .oReadData   (wWrSop[0]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U1_SopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrSop1),
    .iREn        (wIdleState[1]),
    .oReadData   (wWrSop[1]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U2_SopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrSop2),
    .iREn        (wIdleState[2]),
    .oReadData   (wWrSop[2]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U3_SopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrSop3),
    .iREn        (wIdleState[3]),
    .oReadData   (wWrSop[3]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin
      Pulse_Generator U_Pulse_Generator (
        .clock(iClk),
        .level_in(wAllLast[i]),
        .pulse_posedge_out(wAllLastPosedge[i]),
        .pulse_negedge_out(),
        .pulse_anyedge_out()
      );
    end
  endgenerate

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U0_EopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrEop0),
    .iREn        (wAllLastPosedge[0]),
    .oReadData   (wWrEop[0]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U1_EopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrEop1),
    .iREn        (wAllLastPosedge[1]),
    .oReadData   (wWrEop[1]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U2_EopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrEop2),
    .iREn        (wAllLastPosedge[2]),
    .oReadData   (wWrEop[2]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  Fifo #(
    .FIFO_DEPTH(32),
    .DATA_WIDTH(1)
  ) U3_EopFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      (1'b1),
    .iWEn        (iWrEop3),
    .iREn        (wAllLastPosedge[3]),
    .oReadData   (wWrEop[3]),
    .oReadDataVld(),
    .oFull       (),
    .oEmpty      ()
  );

  //--------------------Unpack--------------------//
  Unpack U0_Unpack (
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    .iWrSop         (wWrSop[0]),
    .iWrEop         (wWrEop[0]),
    .iWrVld         (wWrVld[0]),
    .iWrData        (wWrData[0]),
    .oWrRdy         (wWrRdy[0]),
    .iEptyAddr      (iEptyAddr0),
    .iEptyAddrVld   (iEptyAddrVld0),
    .oEptyAddrRcvRdy(oEptyAddrRcvRdy0),
    .iWrrRdy        (iWrrRdy0),
    .oPkgPri        (oPkgPri0),
    .oPkgDstPort    (oPkgDstPort0),
    .oPkgFirAddr    (oPkgFirAddr0),
    .oPkgLen        (oPkgLen0),
    .oPkgTagVld     (oPkgTagVld0),
    .oLdata         (oLdata0),
    .oLaddr         (oLaddr0),
    .oLaddrVld      (oLaddrVld0),
    .iPkgDataRdy    (iMmuRdy0),
    .oPkgData       (oPkgData0),
    .oPkgDataVld    (oPkgDataVld0),
    .oPkgAddr       (oPkgAddr0),
    .oPkgAddrVld    (oPkgAddrVld0),
    .oPkgWrLast     (oPkgWrLast0),
    .oIdleState     (wIdleState[0]),
    .oAllLast       (wAllLast[0])
  );

  Unpack U1_Unpack (
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    .iWrSop         (wWrSop[1]),
    .iWrEop         (wWrEop[1]),
    .iWrVld         (wWrVld[1]),
    .iWrData        (wWrData[1]),
    .oWrRdy         (wWrRdy[1]),
    .iEptyAddr      (iEptyAddr1),
    .iEptyAddrVld   (iEptyAddrVld1),
    .oEptyAddrRcvRdy(oEptyAddrRcvRdy1),
    .iWrrRdy        (iWrrRdy1),
    .oPkgPri        (oPkgPri1),
    .oPkgDstPort    (oPkgDstPort1),
    .oPkgFirAddr    (oPkgFirAddr1),
    .oPkgLen        (oPkgLen1),
    .oPkgTagVld     (oPkgTagVld1),
    .oLdata         (oLdata1),
    .oLaddr         (oLaddr1),
    .oLaddrVld      (oLaddrVld1),
    .iPkgDataRdy    (iMmuRdy1),
    .oPkgData       (oPkgData1),
    .oPkgDataVld    (oPkgDataVld1),
    .oPkgAddr       (oPkgAddr1),
    .oPkgAddrVld    (oPkgAddrVld1),
    .oPkgWrLast     (oPkgWrLast1),
    .oIdleState     (wIdleState[1]),
    .oAllLast       (wAllLast[1])
  );

  Unpack U2_Unpack (
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    .iWrSop         (wWrSop[2]),
    .iWrEop         (wWrEop[2]),
    .iWrVld         (wWrVld[2]),
    .iWrData        (wWrData[2]),
    .oWrRdy         (wWrRdy[2]),
    .iEptyAddr      (iEptyAddr2),
    .iEptyAddrVld   (iEptyAddrVld2),
    .oEptyAddrRcvRdy(oEptyAddrRcvRdy2),
    .iWrrRdy        (iWrrRdy2),
    .oPkgPri        (oPkgPri2),
    .oPkgDstPort    (oPkgDstPort2),
    .oPkgFirAddr    (oPkgFirAddr2),
    .oPkgLen        (oPkgLen2),
    .oPkgTagVld     (oPkgTagVld2),
    .oLdata         (oLdata2),
    .oLaddr         (oLaddr2),
    .oLaddrVld      (oLaddrVld2),
    .iPkgDataRdy    (iMmuRdy2),
    .oPkgData       (oPkgData2),
    .oPkgDataVld    (oPkgDataVld2),
    .oPkgAddr       (oPkgAddr2),
    .oPkgAddrVld    (oPkgAddrVld2),
    .oPkgWrLast     (oPkgWrLast2),
    .oIdleState     (wIdleState[2]),
    .oAllLast       (wAllLast[2])
  );

  Unpack U3_Unpack (
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    .iWrSop         (wWrSop[3]),
    .iWrEop         (wWrEop[3]),
    .iWrVld         (wWrVld[3]),
    .iWrData        (wWrData[3]),
    .oWrRdy         (wWrRdy[3]),
    .iEptyAddr      (iEptyAddr3),
    .iEptyAddrVld   (iEptyAddrVld3),
    .oEptyAddrRcvRdy(oEptyAddrRcvRdy3),
    .iWrrRdy        (iWrrRdy3),
    .oPkgPri        (oPkgPri3),
    .oPkgDstPort    (oPkgDstPort3),
    .oPkgFirAddr    (oPkgFirAddr3),
    .oPkgLen        (oPkgLen3),
    .oPkgTagVld     (oPkgTagVld3),
    .oLdata         (oLdata3),
    .oLaddr         (oLaddr3),
    .oLaddrVld      (oLaddrVld3),
    .iPkgDataRdy    (iMmuRdy3),
    .oPkgData       (oPkgData3),
    .oPkgDataVld    (oPkgDataVld3),
    .oPkgAddr       (oPkgAddr3),
    .oPkgAddrVld    (oPkgAddrVld3),
    .oPkgWrLast     (oPkgWrLast3),
    .oIdleState     (wIdleState[3]),
    .oAllLast       (wAllLast[3])
  );
endmodule
