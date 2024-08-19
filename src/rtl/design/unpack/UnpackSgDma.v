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
  output wire [11:0] oPktFirAddr0,
  output wire [11:0] oPktFirAddr1,
  output wire [11:0] oPktFirAddr2,
  output wire [11:0] oPktFirAddr3,
  output wire [ 3:0] oPktLen0,          // 0-15, full Block, 0 represents 1, 15 represents 16
  output wire [ 3:0] oPktLen1,
  output wire [ 3:0] oPktLen2,
  output wire [ 3:0] oPktLen3,
  output wire [ 2:0] oPktPri0,
  output wire [ 2:0] oPktPri1,
  output wire [ 2:0] oPktPri2,
  output wire [ 2:0] oPktPri3,
  output wire [ 3:0] oPktDstPort0,
  output wire [ 3:0] oPktDstPort1,
  output wire [ 3:0] oPktDstPort2,
  output wire [ 3:0] oPktDstPort3,
  output wire        oPktTagVld0,
  output wire        oPktTagVld1,
  output wire        oPktTagVld2,
  output wire        oPktTagVld3,
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
  output wire [31:0] oPktData0,
  output wire [31:0] oPktData1,
  output wire [31:0] oPktData2,
  output wire [31:0] oPktData3,
  output wire        oPktDataVld0,
  output wire        oPktDataVld1,
  output wire        oPktDataVld2,
  output wire        oPktDataVld3,
  output wire [11:0] oPktAddr0,
  output wire [11:0] oPktAddr1,
  output wire [11:0] oPktAddr2,
  output wire [11:0] oPktAddr3,
  output wire        oPktAddrVld0,
  output wire        oPktAddrVld1,
  output wire        oPktAddrVld2,
  output wire        oPktAddrVld3,
  output wire        oPktWrLast0,
  output wire        oPktWrLast1,
  output wire        oPktWrLast2,
  output wire        oPktWrLast3,
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
  wire [3:0] wAllLastNegedge;
  wire [3:0] wAllLastNegedge_latch;
  wire [11:0] wPktFirAddr[3:0];
  wire [3:0] wPktLen[3:0];
  wire [2:0] wPktPri[3:0];
  wire [3:0] wPktDstPort[3:0];
  wire [3:0] wPktTagVld;
  wire [3:0] wTagFifoFull;
  wire [3:0] wTagFifoEmpty;

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
        .pulse_negedge_out(wAllLastNegedge[i]),
        .pulse_anyedge_out()
      );

      Pulse_Latch #(
        .RESET_VALUE(1'b0)
      ) Pulse_Latch_inst (
        .clock(iClk),
        .clear(wAllLastNegedge_latch[i] && wTagFifoFull[i]),
        .pulse_in(wAllLastNegedge[i]),
        .level_out(wAllLastNegedge_latch[i])
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
    .oPktPri        (wPktPri[0]),
    .oPktDstPort    (wPktDstPort[0]),
    .oPktFirAddr    (wPktFirAddr[0]),
    .oPktLen        (wPktLen[0]),
    .oPktTagVld     (wPktTagVld[0]),
    .oLdata         (oLdata0),
    .oLaddr         (oLaddr0),
    .oLaddrVld      (oLaddrVld0),
    .iPktDataRdy    (iMmuRdy0),
    .oPktData       (oPktData0),
    .oPktDataVld    (oPktDataVld0),
    .oPktAddr       (oPktAddr0),
    .oPktAddrVld    (oPktAddrVld0),
    .oPktWrLast     (oPktWrLast0),
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
    .oPktPri        (wPktPri[1]),
    .oPktDstPort    (wPktDstPort[1]),
    .oPktFirAddr    (wPktFirAddr[1]),
    .oPktLen        (wPktLen[1]),
    .oPktTagVld     (wPktTagVld[1]),
    .oLdata         (oLdata1),
    .oLaddr         (oLaddr1),
    .oLaddrVld      (oLaddrVld1),
    .iPktDataRdy    (iMmuRdy1),
    .oPktData       (oPktData1),
    .oPktDataVld    (oPktDataVld1),
    .oPktAddr       (oPktAddr1),
    .oPktAddrVld    (oPktAddrVld1),
    .oPktWrLast     (oPktWrLast1),
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
    .oPktPri        (wPktPri[2]),
    .oPktDstPort    (wPktDstPort[2]),
    .oPktFirAddr    (wPktFirAddr[2]),
    .oPktLen        (wPktLen[2]),
    .oPktTagVld     (wPktTagVld[2]),
    .oLdata         (oLdata2),
    .oLaddr         (oLaddr2),
    .oLaddrVld      (oLaddrVld2),
    .iPktDataRdy    (iMmuRdy2),
    .oPktData       (oPktData2),
    .oPktDataVld    (oPktDataVld2),
    .oPktAddr       (oPktAddr2),
    .oPktAddrVld    (oPktAddrVld2),
    .oPktWrLast     (oPktWrLast2),
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
    .oPktPri        (wPktPri[3]),
    .oPktDstPort    (wPktDstPort[3]),
    .oPktFirAddr    (wPktFirAddr[3]),
    .oPktLen        (wPktLen[3]),
    .oPktTagVld     (wPktTagVld[3]),
    .oLdata         (oLdata3),
    .oLaddr         (oLaddr3),
    .oLaddrVld      (oLaddrVld3),
    .iPktDataRdy    (iMmuRdy3),
    .oPktData       (oPktData3),
    .oPktDataVld    (oPktDataVld3),
    .oPktAddr       (oPktAddr3),
    .oPktAddrVld    (oPktAddrVld3),
    .oPktWrLast     (oPktWrLast3),
    .oIdleState     (wIdleState[3]),
    .oAllLast       (wAllLast[3])
  );

  Fifo #(
    .FIFO_DEPTH(1),
    .DATA_WIDTH(23)  //12bit addr, 4bit block len, 3bit prio, 4bit dstport 
  ) U0_TagFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      ({wPktFirAddr[0], wPktLen[0], wPktPri[0], wPktDstPort[0]}),
    .iWEn        (wPktTagVld[0] && iWrrRdy0),
    .iREn        (wAllLastNegedge_latch[0]),
    .oReadData   ({oPktFirAddr0, oPktLen0, oPktPri0, oPktDstPort0}),
    .oReadDataVld(),
    .oFull       (wTagFifoFull[0]),
    .oEmpty      (wTagFifoEmpty[0])
  );

  Fifo #(
    .FIFO_DEPTH(1),
    .DATA_WIDTH(23)  //12bit addr, 4bit block len, 3bit prio, 4bit dstport 
  ) U1_TagFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      ({wPktFirAddr[1], wPktLen[1], wPktPri[1], wPktDstPort[1]}),
    .iWEn        (wPktTagVld[1] && iWrrRdy1),
    .iREn        (wAllLastNegedge_latch[1]),
    .oReadData   ({oPktFirAddr1, oPktLen1, oPktPri1, oPktDstPort1}),
    .oReadDataVld(),
    .oFull       (wTagFifoFull[1]),
    .oEmpty      (wTagFifoEmpty[1])
  );

  Fifo #(
    .FIFO_DEPTH(1),
    .DATA_WIDTH(23)  //12bit addr, 4bit block len, 3bit prio, 4bit dstport 
  ) U2_TagFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      ({wPktFirAddr[2], wPktLen[2], wPktPri[2], wPktDstPort[2]}),
    .iWEn        (wPktTagVld[2] && iWrrRdy2),
    .iREn        (wAllLastNegedge_latch[2]),
    .oReadData   ({oPktFirAddr2, oPktLen2, oPktPri2, oPktDstPort2}),
    .oReadDataVld(),
    .oFull       (wTagFifoFull[2]),
    .oEmpty      (wTagFifoEmpty[2])
  );

  Fifo #(
    .FIFO_DEPTH(1),
    .DATA_WIDTH(23)  //12bit addr, 4bit block len, 3bit prio, 4bit dstport 
  ) U3_TagFifo (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iWData      ({wPktFirAddr[3], wPktLen[3], wPktPri[3], wPktDstPort[3]}),
    .iWEn        (wPktTagVld[3] && iWrrRdy3),
    .iREn        (wAllLastNegedge_latch[3]),
    .oReadData   ({oPktFirAddr3, oPktLen3, oPktPri3, oPktDstPort3}),
    .oReadDataVld(),
    .oFull       (wTagFifoFull[3]),
    .oEmpty      (wTagFifoEmpty[3])
  );

  assign oPktTagVld0 = !wTagFifoEmpty[0];
  assign oPktTagVld1 = !wTagFifoEmpty[1];
  assign oPktTagVld2 = !wTagFifoEmpty[2];
  assign oPktTagVld3 = !wTagFifoEmpty[3];

endmodule
