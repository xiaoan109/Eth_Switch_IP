// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/PktRead/PktRead.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-16
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-21
// Version        :
// Description    : 接收需要读出的包首地址将包读出，同时回收掉已经读出的地址
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
//  24-4-16  | liuyanlong |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module PktRead #(
  parameter ADDR_LENTH = 12,
  parameter DATA_WIDTH = 32
) (
  input wire iClk,
  input wire iRst_n,

  //AddrCtrl
  output wire [ADDR_LENTH - 1:0] oRcvrAddr0,    //需要回收的地址
  output wire                    oRcvrAddrVld0,

  output wire [ADDR_LENTH - 1:0] oRcvrAddr1,
  output wire                    oRcvrAddrVld1,

  output wire [ADDR_LENTH - 1:0] oRcvrAddr2,
  output wire                    oRcvrAddrVld2,

  output wire [ADDR_LENTH - 1:0] oRcvrAddr3,
  output wire                    oRcvrAddrVld3,

  output reg  [ADDR_LENTH - 1:0] oDropRcvrAddr,     //需要回收的地址，给到AddrCtrl
  output reg                     oDropRcvrAddrVld,
  //链表SRAM
  input  wire [ADDR_LENTH - 1:0] iLdata0,           //链表sram数据（指针）
  input  wire                    iLdataVld0,
  output wire [ADDR_LENTH - 1:0] oLaddr0,
  output wire                    oLaddrVld0,

  input  wire [ADDR_LENTH - 1:0] iLdata1,     //链表sram数据（指针）
  input  wire                    iLdataVld1,
  output wire [ADDR_LENTH - 1:0] oLaddr1,
  output wire                    oLaddrVld1,

  input  wire [ADDR_LENTH - 1:0] iLdata2,     //链表sram数据（指针）
  input  wire                    iLdataVld2,
  output wire [ADDR_LENTH - 1:0] oLaddr2,
  output wire                    oLaddrVld2,

  input  wire [ADDR_LENTH - 1:0] iLdata3,     //链表sram数据（指针）
  input  wire                    iLdataVld3,
  output wire [ADDR_LENTH - 1:0] oLaddr3,
  output wire                    oLaddrVld3,

  output wire [ADDR_LENTH - 1:0] oDropAddr,    //oDropRcvrAddr既需要发送到链表接收下一个地址又需要发给addrctrl进行回收     
  output wire oDropAddrVld,  //给到链表sram  

  input wire [ADDR_LENTH - 1:0] iDropData,
  input wire                    iDropDataVld,
  //MMU
  input wire [DATA_WIDTH - 1:0] iData0,        //读数据

  input  wire                    iMmuRdy0,
  output wire [ADDR_LENTH - 1:0] oBlockAddr0,     //读地址
  output wire                    oBlockAddrVld0,  //读请求
  output wire                    oMmuReadReq0,
  output wire                    oMmuReadLast0,

  input wire [DATA_WIDTH - 1:0] iData1,

  input  wire                    iMmuRdy1,
  output wire [ADDR_LENTH - 1:0] oBlockAddr1,
  output wire                    oBlockAddrVld1,
  output wire                    oMmuReadReq1,
  output wire                    oMmuReadLast1,

  input wire [DATA_WIDTH - 1:0] iData2,

  input  wire                    iMmuRdy2,
  output wire [ADDR_LENTH - 1:0] oBlockAddr2,
  output wire                    oBlockAddrVld2,
  output wire                    oMmuReadReq2,
  output wire                    oMmuReadLast2,

  input wire [DATA_WIDTH - 1:0] iData3,

  input  wire                    iMmuRdy3,
  output wire [ADDR_LENTH - 1:0] oBlockAddr3,
  output wire                    oBlockAddrVld3,
  output wire                    oMmuReadReq3,
  output wire                    oMmuReadLast3,

  //WRR
  input  wire [ADDR_LENTH - 1:0] iPktFirAddr0,     //待读包首地址
  input  wire                    iPktFirAddrVld0,  //地址有效
  input  wire [           3 : 0] iPktBlockNum0,    //包块数
  input  wire                    iPktDrop0,        //丢包信号
  output wire                    oPktFirAddrRdy0,  //可以接收读请求rdy

  output wire [DATA_WIDTH - 1:0] oWrrData0,
  output wire                    oWrrVld0,
  output wire                    oWrrDataLast0,
  input  wire                    iWrrRdy0,


  input  wire [ADDR_LENTH - 1:0] iPktFirAddr1,
  input  wire                    iPktFirAddrVld1,
  input  wire [           3 : 0] iPktBlockNum1,
  input  wire                    iPktDrop1,
  output wire                    oPktFirAddrRdy1,

  output wire [DATA_WIDTH - 1:0] oWrrData1,
  output wire                    oWrrVld1,
  output wire                    oWrrDataLast1,
  input  wire                    iWrrRdy1,


  input  wire [ADDR_LENTH - 1:0] iPktFirAddr2,
  input  wire                    iPktFirAddrVld2,
  input  wire [           3 : 0] iPktBlockNum2,
  input  wire                    iPktDrop2,
  output wire                    oPktFirAddrRdy2,

  output wire [DATA_WIDTH - 1:0] oWrrData2,
  output wire                    oWrrVld2,
  output wire                    oWrrDataLast2,
  input  wire                    iWrrRdy2,


  input  wire [ADDR_LENTH - 1:0] iPktFirAddr3,
  input  wire                    iPktFirAddrVld3,
  input  wire [           3 : 0] iPktBlockNum3,
  input  wire                    iPktDrop3,
  output wire                    oPktFirAddrRdy3,

  output wire [DATA_WIDTH - 1:0] oWrrData3,
  output wire                    oWrrVld3,
  output wire                    oWrrDataLast3,
  input  wire                    iWrrRdy3
);

  wire [ADDR_LENTH - 1:0] wLdata0, wLdata1, wLdata2, wLdata3;
  wire wLdataVld0, wLdataVld1, wLdataVld2, wLdataVld3;

  wire [ADDR_LENTH - 1:0] wDropRcvrAddr0, wDropRcvrAddr1, wDropRcvrAddr2, wDropRcvrAddr3;
  wire wDropRcvrAddrVld0, wDropRcvrAddrVld1, wDropRcvrAddrVld2, wDropRcvrAddrVld3;

  //用于指示那个通道正在开放，可以接收数据
  reg wDropChnRdy0, wDropChnRdy1, wDropChnRdy2, wDropChnRdy3;

  //用于指示那个通道正在想要丢包
  wire wDropRun, wDropRun0, wDropRun1, wDropRun2, wDropRun3;

  wire wPktDrop;
  wire wPktFirAddrRdy0, wPktFirAddrRdy1, wPktFirAddrRdy2, wPktFirAddrRdy3;

  reg [ADDR_LENTH-1:0] rPktFirAddr0, rPktFirAddr1, rPktFirAddr2, rPktFirAddr3;
  reg rPktFirAddrVld0, rPktFirAddrVld1, rPktFirAddrVld2, rPktFirAddrVld3;
  reg [3:0] rPktBlockNum0, rPktBlockNum1, rPktBlockNum2, rPktBlockNum3;
  reg rPktDrop0, rPktDrop1, rPktDrop2, rPktDrop3;


  PktReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PktReadUnit_U0 (
    .iClk  (iClk),
    .iRst_n(iRst_n),

    .oRcvrAddr   (oRcvrAddr0),
    .oRcvrAddrVld(oRcvrAddrVld0),
    .oDropRun    (wDropRun0),


    .iLdata          (wLdata0),
    .iLdataVld       (wLdataVld0),
    .oLaddr          (oLaddr0),
    .oLNxtAddrReq    (oLaddrVld0),
    .oDropRcvrAddr   (wDropRcvrAddr0),
    .oDropRcvrAddrVld(wDropRcvrAddrVld0),

    .iMmuRdy      (iMmuRdy0),
    .oBlockAddr   (oBlockAddr0),
    .oBlockAddrVld(oBlockAddrVld0),
    .oMmuReadReq  (oMmuReadReq0),
    .oMmuReadLast (oMmuReadLast0),
    .iData        (iData0),


    .iPktFirAddr   (rPktFirAddr0),
    .iPktFirAddrVld(rPktFirAddrVld0),
    .iBlockNum     (rPktBlockNum0),
    .iPktDrop      (rPktDrop0),
    .oPktFirAddrRdy(wPktFirAddrRdy0),

    .oWrrData    (oWrrData0),
    .oWrrVld     (oWrrVld0),
    .iWrrRdy     (iWrrRdy0),
    .oWrrDataLast(oWrrDataLast0),

    .iDropChnRdy(wDropChnRdy0)
  );

  PktReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PktReadUnit_U1 (
    .iClk  (iClk),
    .iRst_n(iRst_n),

    .oRcvrAddr   (oRcvrAddr1),
    .oRcvrAddrVld(oRcvrAddrVld1),
    .oDropRun    (wDropRun1),

    .iLdata          (wLdata1),
    .iLdataVld       (wLdataVld1),
    .oLaddr          (oLaddr1),
    .oLNxtAddrReq    (oLaddrVld1),
    .oDropRcvrAddr   (wDropRcvrAddr1),
    .oDropRcvrAddrVld(wDropRcvrAddrVld1),

    .iMmuRdy      (iMmuRdy1),
    .oBlockAddr   (oBlockAddr1),
    .oBlockAddrVld(oBlockAddrVld1),
    .oMmuReadReq  (oMmuReadReq1),
    .oMmuReadLast (oMmuReadLast1),
    .iData        (iData1),

    .iPktFirAddr   (rPktFirAddr1),
    .iPktFirAddrVld(rPktFirAddrVld1),
    .iBlockNum     (rPktBlockNum1),
    .iPktDrop      (rPktDrop1),
    .oPktFirAddrRdy(wPktFirAddrRdy1),

    .oWrrData    (oWrrData1),
    .oWrrVld     (oWrrVld1),
    .iWrrRdy     (iWrrRdy1),
    .oWrrDataLast(oWrrDataLast1),

    .iDropChnRdy(wDropChnRdy1)
  );

  PktReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PktReadUnit_U2 (
    .iClk  (iClk),
    .iRst_n(iRst_n),

    .oRcvrAddr   (oRcvrAddr2),
    .oRcvrAddrVld(oRcvrAddrVld2),
    .oDropRun    (wDropRun2),

    .iLdata          (wLdata2),
    .iLdataVld       (wLdataVld2),
    .oLaddr          (oLaddr2),
    .oLNxtAddrReq    (oLaddrVld2),
    .oDropRcvrAddr   (wDropRcvrAddr2),
    .oDropRcvrAddrVld(wDropRcvrAddrVld2),

    .iMmuRdy      (iMmuRdy2),
    .oBlockAddr   (oBlockAddr2),
    .oBlockAddrVld(oBlockAddrVld2),
    .oMmuReadReq  (oMmuReadReq2),
    .oMmuReadLast (oMmuReadLast2),
    .iData        (iData2),

    .iPktFirAddr   (rPktFirAddr2),
    .iPktFirAddrVld(rPktFirAddrVld2),
    .iBlockNum     (rPktBlockNum2),
    .iPktDrop      (rPktDrop2),
    .oPktFirAddrRdy(wPktFirAddrRdy2),

    .oWrrData    (oWrrData2),
    .oWrrVld     (oWrrVld2),
    .iWrrRdy     (iWrrRdy2),
    .oWrrDataLast(oWrrDataLast2),

    .iDropChnRdy(wDropChnRdy2)
  );

  PktReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PktReadUnit_U3 (
    .iClk  (iClk),
    .iRst_n(iRst_n),

    .oRcvrAddr   (oRcvrAddr3),
    .oRcvrAddrVld(oRcvrAddrVld3),
    .oDropRun    (wDropRun3),

    .iLdata          (wLdata3),
    .iLdataVld       (wLdataVld3),
    .oLaddr          (oLaddr3),
    .oLNxtAddrReq    (oLaddrVld3),
    .oDropRcvrAddr   (wDropRcvrAddr3),
    .oDropRcvrAddrVld(wDropRcvrAddrVld3),

    .iMmuRdy      (iMmuRdy3),
    .oBlockAddr   (oBlockAddr3),
    .oBlockAddrVld(oBlockAddrVld3),
    .oMmuReadReq  (oMmuReadReq3),
    .oMmuReadLast (oMmuReadLast3),
    .iData        (iData3),

    .iPktFirAddr   (rPktFirAddr3),
    .iPktFirAddrVld(rPktFirAddrVld3),
    .iBlockNum     (rPktBlockNum3),
    .iPktDrop      (rPktDrop3),
    .oPktFirAddrRdy(wPktFirAddrRdy3),

    .oWrrData    (oWrrData3),
    .oWrrVld     (oWrrVld3),
    .iWrrRdy     (iWrrRdy3),
    .oWrrDataLast(oWrrDataLast3),

    .iDropChnRdy(wDropChnRdy3)
  );

  //-----------------------------丢包通道仲裁------------------------//

  always @(*) begin
    if (wDropRun0) begin
      wDropChnRdy0 = 1'b1;
      wDropChnRdy1 = 1'b0;
      wDropChnRdy2 = 1'b0;
      wDropChnRdy3 = 1'b0;
    end else if (wDropRun1) begin
      wDropChnRdy0 = 1'b0;
      wDropChnRdy1 = 1'b1;
      wDropChnRdy2 = 1'b0;
      wDropChnRdy3 = 1'b0;
    end else if (wDropRun2) begin
      wDropChnRdy0 = 1'b0;
      wDropChnRdy1 = 1'b0;
      wDropChnRdy2 = 1'b1;
      wDropChnRdy3 = 1'b0;
    end else if (wDropRun3) begin
      wDropChnRdy0 = 1'b0;
      wDropChnRdy1 = 1'b0;
      wDropChnRdy2 = 1'b0;
      wDropChnRdy3 = 1'b1;
    end else begin
      wDropChnRdy0 = 1'b0;
      wDropChnRdy1 = 1'b0;
      wDropChnRdy2 = 1'b0;
      wDropChnRdy3 = 1'b0;
    end
  end

  always @(*) begin
    if (wDropRun0) begin
      oDropRcvrAddr    = wDropRcvrAddr0;
      oDropRcvrAddrVld = wDropRcvrAddrVld0 && wDropRcvrAddr0;
    end else if (wDropRun1) begin
      oDropRcvrAddr    = wDropRcvrAddr1;
      oDropRcvrAddrVld = wDropRcvrAddrVld1 && wDropRcvrAddr1;
    end else if (wDropRun2) begin
      oDropRcvrAddr    = wDropRcvrAddr2;
      oDropRcvrAddrVld = wDropRcvrAddrVld2 && wDropRcvrAddr2;
    end else if (wDropRun3) begin
      oDropRcvrAddr    = wDropRcvrAddr3;
      oDropRcvrAddrVld = wDropRcvrAddrVld3 && wDropRcvrAddr3;
    end else begin
      oDropRcvrAddr    = 0;
      oDropRcvrAddrVld = 0;
    end
  end

  //oDropRcvrAddr既需要发送到链表接收下一个地址又需要发给addrctrl进行回收
  assign oDropAddr = oDropRcvrAddr;
  assign oDropAddrVld = oDropRcvrAddrVld;

  assign wDropRun = wDropRun0 | wDropRun1 | wDropRun2 | wDropRun3;
  assign wPktDrop = (rPktDrop0 & rPktFirAddrVld0) | (rPktDrop1 & rPktFirAddrVld1) | (rPktDrop2 & rPktFirAddrVld2) | (rPktDrop3 & rPktFirAddrVld3);

  assign oPktFirAddrRdy0 = (!rPktFirAddrVld0 | wPktFirAddrRdy0) & !wDropRun & !wPktDrop;//丢包的时候所有通道不能接收新的读请求
  assign oPktFirAddrRdy1 = (!rPktFirAddrVld1 | wPktFirAddrRdy1) & !wDropRun & !wPktDrop;
  assign oPktFirAddrRdy2 = (!rPktFirAddrVld2 | wPktFirAddrRdy2) & !wDropRun & !wPktDrop;
  assign oPktFirAddrRdy3 = (!rPktFirAddrVld3 | wPktFirAddrRdy3) & !wDropRun & !wPktDrop;

  assign wLdata0 = wDropRun0 ? iDropData : iLdata0;
  assign wLdata1 = wDropRun1 ? iDropData : iLdata1;
  assign wLdata2 = wDropRun2 ? iDropData : iLdata2;
  assign wLdata3 = wDropRun3 ? iDropData : iLdata3;

  assign wLdataVld0 = wDropRun0 ? iDropDataVld : iLdataVld0;
  assign wLdataVld1 = wDropRun1 ? iDropDataVld : iLdataVld1;
  assign wLdataVld2 = wDropRun2 ? iDropDataVld : iLdataVld2;
  assign wLdataVld3 = wDropRun3 ? iDropDataVld : iLdataVld3;

  // strict priority 0-3
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPktDrop0 <= 0;
      rPktFirAddr0 <= 0;
      rPktFirAddrVld0 <= 0;
      rPktBlockNum0 <= 0;
    end else if (iPktFirAddrVld0 & oPktFirAddrRdy0) begin
      rPktDrop0 <= iPktDrop0;
      rPktFirAddr0 <= iPktFirAddr0;
      rPktFirAddrVld0 <= 1;
      rPktBlockNum0 <= iPktBlockNum0;
    end else begin
      rPktDrop0 <= 0;
      rPktFirAddr0 <= 0;
      rPktFirAddrVld0 <= 0;
      rPktBlockNum0 <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPktDrop1 <= 0;
      rPktFirAddr1 <= 0;
      rPktFirAddrVld1 <= 0;
      rPktBlockNum1 <= 0;
    end else if (iPktFirAddrVld1 & oPktFirAddrRdy1) begin
      rPktDrop1 <= iPktDrop1;
      rPktFirAddr1 <= iPktFirAddr1;
      rPktFirAddrVld1 <= 1;
      rPktBlockNum1 <= iPktBlockNum1;
    end else begin
      rPktDrop1 <= 0;
      rPktFirAddr1 <= 0;
      rPktFirAddrVld1 <= 0;
      rPktBlockNum1 <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPktDrop2 <= 0;
      rPktFirAddr2 <= 0;
      rPktFirAddrVld2 <= 0;
      rPktBlockNum2 <= 0;
    end else if (iPktFirAddrVld2 & oPktFirAddrRdy2) begin
      rPktDrop2 <= iPktDrop2;
      rPktFirAddr2 <= iPktFirAddr2;
      rPktFirAddrVld2 <= 1;
      rPktBlockNum2 <= iPktBlockNum2;
    end else begin
      rPktDrop2 <= 0;
      rPktFirAddr2 <= 0;
      rPktFirAddrVld2 <= 0;
      rPktBlockNum2 <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPktDrop3 <= 0;
      rPktFirAddr3 <= 0;
      rPktFirAddrVld3 <= 0;
      rPktBlockNum3 <= 0;
    end else if (iPktFirAddrVld3 & oPktFirAddrRdy3) begin
      rPktDrop3 <= iPktDrop3;
      rPktFirAddr3 <= iPktFirAddr3;
      rPktFirAddrVld3 <= 1;
      rPktBlockNum3 <= iPktBlockNum3;
    end else begin
      rPktDrop3 <= 0;
      rPktFirAddr3 <= 0;
      rPktFirAddrVld3 <= 0;
      rPktBlockNum3 <= 0;
    end
  end


endmodule
