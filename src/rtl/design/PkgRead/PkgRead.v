// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/PkgRead/PkgRead.v
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
module PkgRead #(
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
  input  wire [ADDR_LENTH - 1:0] iPkgFirAddr0,     //待读包首地址
  input  wire                    iPkgFirAddrVld0,  //地址有效
  input  wire [           3 : 0] iPkgBlockNum0,    //包块数
  input  wire                    iPkgDrop0,        //丢包信号
  output wire                    oPkgFirAddrRdy0,  //可以接收读请求rdy

  output wire [DATA_WIDTH - 1:0] oWrrData0,
  output wire                    oWrrVld0,
  output wire                    oWrrDataLast0,
  input  wire                    iWrrRdy0,


  input  wire [ADDR_LENTH - 1:0] iPkgFirAddr1,
  input  wire                    iPkgFirAddrVld1,
  input  wire [           3 : 0] iPkgBlockNum1,
  input  wire                    iPkgDrop1,
  output wire                    oPkgFirAddrRdy1,

  output wire [DATA_WIDTH - 1:0] oWrrData1,
  output wire                    oWrrVld1,
  output wire                    oWrrDataLast1,
  input  wire                    iWrrRdy1,


  input  wire [ADDR_LENTH - 1:0] iPkgFirAddr2,
  input  wire                    iPkgFirAddrVld2,
  input  wire [           3 : 0] iPkgBlockNum2,
  input  wire                    iPkgDrop2,
  output wire                    oPkgFirAddrRdy2,

  output wire [DATA_WIDTH - 1:0] oWrrData2,
  output wire                    oWrrVld2,
  output wire                    oWrrDataLast2,
  input  wire                    iWrrRdy2,


  input  wire [ADDR_LENTH - 1:0] iPkgFirAddr3,
  input  wire                    iPkgFirAddrVld3,
  input  wire [           3 : 0] iPkgBlockNum3,
  input  wire                    iPkgDrop3,
  output wire                    oPkgFirAddrRdy3,

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

  wire wPkgDrop;
  wire wPkgFirAddrRdy0, wPkgFirAddrRdy1, wPkgFirAddrRdy2, wPkgFirAddrRdy3;

  reg [ADDR_LENTH-1:0] rPkgFirAddr0, rPkgFirAddr1, rPkgFirAddr2, rPkgFirAddr3;
  reg rPkgFirAddrVld0, rPkgFirAddrVld1, rPkgFirAddrVld2, rPkgFirAddrVld3;
  reg rPkgDrop0, rPkgDrop1, rPkgDrop2, rPkgDrop3;


  PkgReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PkgReadUnit_U0 (
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


    .iPkgFirAddr   (rPkgFirAddr0),
    .iPkgFirAddrVld(rPkgFirAddrVld0),
    .iBlockNum     (iPkgBlockNum0),
    .iPkgDrop      (rPkgDrop0),
    .oPkgFirAddrRdy(wPkgFirAddrRdy0),

    .oWrrData    (oWrrData0),
    .oWrrVld     (oWrrVld0),
    .iWrrRdy     (iWrrRdy0),
    .oWrrDataLast(oWrrDataLast0),

    .iDropChnRdy(wDropChnRdy0)
  );

  PkgReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PkgReadUnit_U1 (
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

    .iPkgFirAddr   (rPkgFirAddr1),
    .iPkgFirAddrVld(rPkgFirAddrVld1),
    .iBlockNum     (iPkgBlockNum1),
    .iPkgDrop      (rPkgDrop1),
    .oPkgFirAddrRdy(wPkgFirAddrRdy1),

    .oWrrData    (oWrrData1),
    .oWrrVld     (oWrrVld1),
    .iWrrRdy     (iWrrRdy1),
    .oWrrDataLast(oWrrDataLast1),

    .iDropChnRdy(wDropChnRdy1)
  );

  PkgReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PkgReadUnit_U2 (
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

    .iPkgFirAddr   (rPkgFirAddr2),
    .iPkgFirAddrVld(rPkgFirAddrVld2),
    .iBlockNum     (iPkgBlockNum2),
    .iPkgDrop      (rPkgDrop2),
    .oPkgFirAddrRdy(wPkgFirAddrRdy2),

    .oWrrData    (oWrrData2),
    .oWrrVld     (oWrrVld2),
    .iWrrRdy     (iWrrRdy2),
    .oWrrDataLast(oWrrDataLast2),

    .iDropChnRdy(wDropChnRdy2)
  );

  PkgReadUnit #(
    .ADDR_LENTH(12),
    .DATA_WIDTH(32)
  ) PkgReadUnit_U3 (
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

    .iPkgFirAddr   (rPkgFirAddr3),
    .iPkgFirAddrVld(rPkgFirAddrVld3),
    .iBlockNum     (iPkgBlockNum3),
    .iPkgDrop      (rPkgDrop3),
    .oPkgFirAddrRdy(wPkgFirAddrRdy3),

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
  assign wPkgDrop = (rPkgDrop0 & rPkgFirAddrVld0) | (rPkgDrop1 & rPkgFirAddrVld1) | (rPkgDrop2 & rPkgFirAddrVld2) | (rPkgDrop3 & rPkgFirAddrVld3);

  assign oPkgFirAddrRdy0 = (!rPkgFirAddrVld0 | wPkgFirAddrRdy0) & !wDropRun & !wPkgDrop;//丢包的时候所有通道不能接收新的读请求
  assign oPkgFirAddrRdy1 = (!rPkgFirAddrVld1 | wPkgFirAddrRdy1) & !wDropRun & !wPkgDrop;
  assign oPkgFirAddrRdy2 = (!rPkgFirAddrVld2 | wPkgFirAddrRdy2) & !wDropRun & !wPkgDrop;
  assign oPkgFirAddrRdy3 = (!rPkgFirAddrVld3 | wPkgFirAddrRdy3) & !wDropRun & !wPkgDrop;

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
      rPkgDrop0 <= 0;
      rPkgFirAddr0 <= 0;
      rPkgFirAddrVld0 <= 0;
    end else if (iPkgFirAddrVld0 & oPkgFirAddrRdy0) begin
      rPkgDrop0 <= iPkgDrop0;
      rPkgFirAddr0 <= iPkgFirAddr0;
      rPkgFirAddrVld0 <= 1;
    end else begin
      rPkgDrop0 <= 0;
      rPkgFirAddr0 <= 0;
      rPkgFirAddrVld0 <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPkgDrop1 <= 0;
      rPkgFirAddr1 <= 0;
      rPkgFirAddrVld1 <= 0;
    end else if (iPkgFirAddrVld1 & oPkgFirAddrRdy1 & !(iPkgDrop0 & iPkgFirAddrVld0)) begin
      rPkgDrop1 <= iPkgDrop1;
      rPkgFirAddr1 <= iPkgFirAddr1;
      rPkgFirAddrVld1 <= 1;
    end else begin
      rPkgDrop1 <= 0;
      rPkgFirAddr1 <= 0;
      rPkgFirAddrVld1 <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPkgDrop2 <= 0;
      rPkgFirAddr2 <= 0;
      rPkgFirAddrVld2 <= 0;
    end else if (iPkgFirAddrVld2 & oPkgFirAddrRdy2 & !(iPkgDrop0 & iPkgFirAddrVld0) & !(iPkgDrop1 & iPkgFirAddrVld1)) begin
      rPkgDrop2 <= iPkgDrop2;
      rPkgFirAddr2 <= iPkgFirAddr2;
      rPkgFirAddrVld2 <= 1;
    end else begin
      rPkgDrop2 <= 0;
      rPkgFirAddr2 <= 0;
      rPkgFirAddrVld2 <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPkgDrop3 <= 0;
      rPkgFirAddr3 <= 0;
      rPkgFirAddrVld3 <= 0;
    end else if (iPkgFirAddrVld3 & oPkgFirAddrRdy3 & !(iPkgDrop0 & iPkgFirAddrVld0) & !(iPkgDrop1 & iPkgFirAddrVld1) & !(iPkgDrop2 & iPkgFirAddrVld2)) begin
      rPkgDrop3 <= iPkgDrop3;
      rPkgFirAddr3 <= iPkgFirAddr3;
      rPkgFirAddrVld3 <= 1;
    end else begin
      rPkgDrop3 <= 0;
      rPkgFirAddr3 <= 0;
      rPkgFirAddrVld3 <= 0;
    end
  end


endmodule
