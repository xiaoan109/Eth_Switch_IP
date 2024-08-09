// +FHEADER =====================================================================
// FilePath       : /src/tb/tb_PktWriteAndDrop.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-05-09
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-20
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
//  24-5-9   |  liuyanlong|     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module tb_PktWriteAndDrop ();
  localparam ADDR_LENTH = 12;
  localparam DATA_WIDTH = 32;


  defparam LinkListSram_u0.LinkListSram_U0.DEPTH = 4095; 
  defparam LinkListSram_u0.LinkListSram_U0.USE_INIT_FILE = 1; 
  defparam LinkListSram_u0.LinkListSram_U0.INIT_FILE = "../../src/rtl/design/AddrCtrl/addr.mem";

  reg                       iClk;
  reg                       iRst_n;

  reg  [ADDR_LENTH - 1 : 0] iWriteLdata0;
  reg  [ADDR_LENTH - 1 : 0] iWriteLaddr0;
  reg                       iWriteLaddrVld0;
  reg                       iEptyAddrRdy0;

  reg  [ADDR_LENTH - 1 : 0] iPktFirAddr1;
  reg                       iPktFirAddrVld1;
  reg  [               3:0] iPktBlockNum1;
  reg                       iPktDrop1;

  reg  [ADDR_LENTH - 1 : 0] iPktFirAddr0;
  reg                       iPktFirAddrVld0;
  reg  [               3:0] iPktBlockNum0;
  reg                       iPktDrop0;

  reg  [ADDR_LENTH - 1 : 0] iPktFirAddr2;
  reg                       iPktFirAddrVld2;
  reg  [               3:0] iPktBlockNum2;
  reg                       iPktDrop2;

  reg  [ADDR_LENTH - 1 : 0] iPktFirAddr3;
  reg                       iPktFirAddrVld3;
  reg  [               3:0] iPktBlockNum3;
  reg                       iPktDrop3;

  reg  [ADDR_LENTH - 1 : 0] iDropData;
  reg                       iDropDataVld;
  reg  [ADDR_LENTH - 1 : 0] rCurAddr;
  reg                       rCurAddrVld;
  reg  [ADDR_LENTH - 1 : 0] rAddrCnt;

  wire [ADDR_LENTH - 1 : 0] oEptyAddr0;
  wire                      oEptyAddrVld0;
  wire                      oPktFirAddrRdy1;
  reg  [ADDR_LENTH - 1 : 0] rRecAddr2;
  reg                       rRecAddrVld2;
  wire [ADDR_LENTH - 1 : 0] wDropData, wDropAddr;
  wire wDropDataVld, wDropAddrVld;



  initial begin
    $fsdbDumpfile("tb_PktWriteAndDrop.fsdb");
    $fsdbDumpvars("+all");

    iWriteLdata0    <= 0;
    iWriteLaddr0    <= 0;
    iWriteLaddrVld0 <= 0;
    iEptyAddrRdy0   <= 0;

    iPktFirAddr0    <= 0;
    iPktFirAddrVld0 <= 0;
    iPktBlockNum0   <= 0;
    iPktDrop0       <= 0;

    iPktFirAddr1    <= 0;
    iPktFirAddrVld1 <= 0;
    iPktBlockNum1   <= 0;
    iPktDrop1       <= 0;

    iPktFirAddr2    <= 0;
    iPktFirAddrVld2 <= 0;
    iPktBlockNum2   <= 0;
    iPktDrop2       <= 0;

    iPktFirAddr3    <= 0;
    iPktFirAddrVld3 <= 0;
    iPktBlockNum3   <= 0;
    iPktDrop3       <= 0;

    iDropData       <= 0;
    iDropDataVld    <= 0;
    iRst_n          <= 0;
    rAddrCnt        <= 0;
    iClk            <= 0;
    rRecAddrVld2    <= 0;
    rRecAddr2       <= 0;

    rCurAddr        <= 0;
    rCurAddrVld     <= 0;
    #20 iRst_n <= 1;

    repeat (10) @(posedge iClk);
    //ADDRCTRL_INIT();        //先把Addrctrl填满

    repeat (10) @(posedge iClk);
    // TAKEADDR_TO_LSRAM();  //再将需要丢的包写入链表sram

    repeat (10) @(posedge iClk);
    DROP();  //丢包

    repeat (1000) @(posedge iClk);
    $finish;
  end

  task DROP();
    fork
      begin
        iPktFirAddr1    <= 20;
        iPktFirAddrVld1 <= 1;
        iPktBlockNum1   <= 10;  //num
        iPktDrop1       <= 1;
        @(posedge iClk);
        iPktFirAddr1    <= 0;
        iPktFirAddrVld1 <= 0;
        iPktBlockNum1   <= 0;
        iPktDrop1       <= 0;
        @(posedge iClk);
      end

      begin
        iPktFirAddr0    <= 1;
        iPktFirAddrVld0 <= 1;
        iPktBlockNum0   <= 9;  //num
        iPktDrop0       <= 1;
        @(posedge iClk);
        iPktFirAddr0    <= 0;
        iPktFirAddrVld0 <= 0;
        iPktBlockNum0   <= 0;
        iPktDrop0       <= 0;
        @(posedge iClk);
      end

      begin
        iPktFirAddr2    <= 35;
        iPktFirAddrVld2 <= 1;
        iPktBlockNum2   <= 15;  //num
        iPktDrop2       <= 1;
        @(posedge iClk);
        iPktFirAddr2    <= 0;
        iPktFirAddrVld2 <= 0;
        iPktBlockNum2   <= 0;
        iPktDrop2       <= 0;
        @(posedge iClk);
      end

      begin
        iPktFirAddr3    <= 70;
        iPktFirAddrVld3 <= 1;
        iPktBlockNum3   <= 0;  //num
        iPktDrop3       <= 1;
        @(posedge iClk);
        iPktFirAddr3    <= 0;
        iPktFirAddrVld3 <= 0;
        iPktBlockNum3   <= 0;
        iPktDrop3       <= 0;
        @(posedge iClk);
      end
    join
  endtask


  always begin
    #5 iClk = ~iClk;
  end

  LinkListSram #(
    .ADDR_LENTH(ADDR_LENTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) LinkListSram_u0 (
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    .iWriteLdata0   (iWriteLdata0),
    .iWriteLaddr0   (iWriteLaddr0),
    .iWriteLaddrVld0(iWriteLaddrVld0),
    .iWriteLdata1   (0),
    .iWriteLaddr1   (0),
    .iWriteLaddrVld1(0),
    .iWriteLdata2   (0),
    .iWriteLaddr2   (0),
    .iWriteLaddrVld2(0),
    .iWriteLdata3   (0),
    .iWriteLaddr3   (0),
    .iWriteLaddrVld3(0),
    .oLdata0        (),
    .oLdataVld0     (),
    .iLaddr0        (),
    .iLNxtAddrReq0  (0),
    .oLdata1        (),
    .oLdataVld1     (),
    .iLaddr1        (0),
    .iLNxtAddrReq1  (0),
    .oLdata2        (),
    .oLdataVld2     (),
    .iLaddr2        (0),
    .iLNxtAddrReq2  (0),
    .oLdata3        (),
    .oLdataVld3     (),
    .iLaddr3        (0),
    .iLNxtAddrReq3  (0),
    .iDropAddr      (wDropAddr),
    .iDropAddrVld   (wDropAddrVld),
    .oDropData      (wDropData),
    .oDropDataVld   (wDropDataVld)
  );

  AddrCtrl #(
    .ADDR_LENTH(ADDR_LENTH)
  ) AddrCtrl_u0 (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iRecAddr0   (0),
    .iRecAddrVld0(0),
    .iRecAddr1   (0),
    .iRecAddrVld1(0),
    .iRecAddr2   (rRecAddr2),
    .iRecAddrVld2(rRecAddrVld2),
    .iRecAddr3   (0),
    .iRecAddrVld3(0),

    .iEptyAddrRdy0(iEptyAddrRdy0),
    .oEptyAddr0   (oEptyAddr0),
    .oEptyAddrVld0(oEptyAddrVld0),

    .iEptyAddrRdy1(0),
    .oEptyAddr1   (),
    .oEptyAddrVld1(),
    .iEptyAddrRdy2(0),
    .oEptyAddr2   (),
    .oEptyAddrVld2(),
    .iEptyAddrRdy3(0),
    .oEptyAddr3   (),
    .oEptyAddrVld3(),
    .iDropData    (wDropAddr),
    .iDropDataVld (wDropAddrVld),

    .oFull      (),
    .oAlmostFull()
  );

  PktRead #(
    .ADDR_LENTH(ADDR_LENTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) PktRead_u0 (
    .iClk            (iClk),
    .iRst_n          (iRst_n),
    .oRcvrAddr0      (),
    .oRcvrAddrVld0   (),
    .oRcvrAddr1      (),
    .oRcvrAddrVld1   (),
    .oRcvrAddr2      (),
    .oRcvrAddrVld2   (),
    .oRcvrAddr3      (),
    .oRcvrAddrVld3   (),
    .oDropRcvrAddr   (wDropAddr),
    .oDropRcvrAddrVld(wDropAddrVld),
    .iLdata0         (0),
    .iLdataVld0      (0),
    .oLaddr0         (),
    .oLaddrVld0      (),
    .iLdata1         (0),
    .iLdataVld1      (0),
    .oLaddr1         (),
    .oLaddrVld1      (),
    .iLdata2         (0),
    .iLdataVld2      (0),
    .oLaddr2         (),
    .oLaddrVld2      (),
    .iLdata3         (0),
    .iLdataVld3      (0),
    .oLaddr3         (),
    .oLaddrVld3      (),

    .oDropAddr   (wDropAddr),
    .oDropAddrVld(wDropAddrVld),

    .iData0         (0),
    .iMmuRdy0       (0),
    .oBlockAddr0    (),
    .oBlockAddrVld0 (),
    .oMmuReadReq0   (),
    .iData1         (0),
    .iMmuRdy1       (0),
    .oBlockAddr1    (),
    .oBlockAddrVld1 (),
    .oMmuReadReq1   (),
    .iData2         (0),
    .iMmuRdy2       (0),
    .oBlockAddr2    (),
    .oBlockAddrVld2 (),
    .oMmuReadReq2   (),
    .iData3         (0),
    .iMmuRdy3       (0),
    .oBlockAddr3    (),
    .oBlockAddrVld3 (),
    .oMmuReadReq3   (),
    .iPktFirAddr0   (iPktFirAddr0),
    .iPktFirAddrVld0(iPktFirAddrVld0),
    .iPktBlockNum0  (iPktBlockNum0),
    .iPktDrop0      (iPktDrop0),
    .oPktFirAddrRdy0(),
    .oWrrData0      (),
    .oWrrVld0       (),
    .iWrrRdy0       (0),
    .iPktFirAddr1   (iPktFirAddr1),
    .iPktFirAddrVld1(iPktFirAddrVld1),
    .iPktBlockNum1  (iPktBlockNum1),
    .iPktDrop1      (iPktDrop1),
    .oPktFirAddrRdy1(oPktFirAddrRdy1),
    .oWrrData1      (),
    .oWrrVld1       (),
    .iWrrRdy1       (0),
    .iPktFirAddr2   (iPktFirAddr2),
    .iPktFirAddrVld2(iPktFirAddrVld2),
    .iPktBlockNum2  (iPktBlockNum2),
    .iPktDrop2      (iPktDrop2),
    .oPktFirAddrRdy2(),
    .oWrrData2      (),
    .oWrrVld2       (),
    .iWrrRdy2       (0),
    .iPktFirAddr3   (iPktFirAddr3),
    .iPktFirAddrVld3(iPktFirAddrVld3),
    .iPktBlockNum3  (iPktBlockNum3),
    .iPktDrop3      (iPktDrop3),
    .oPktFirAddrRdy3(),
    .oWrrData3      (),
    .oWrrVld3       (),
    .iWrrRdy3       (0),
    .iDropData      (wDropData),
    .iDropDataVld   (wDropDataVld),
    .oWrrDataLast0  (),
    .oWrrDataLast1  (),
    .oWrrDataLast2  (),
    .oWrrDataLast3  ()
  );

endmodule
