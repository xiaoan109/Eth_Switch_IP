// +FHEADER =====================================================================
// FilePath       : /src/tb/tb_PkgWriteAndDrop.v
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
module tb_PkgWriteAndDrop ();
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

  reg  [ADDR_LENTH - 1 : 0] iPkgFirAddr1;
  reg                       iPkgFirAddrVld1;
  reg  [               3:0] iPkgBlockNum1;
  reg                       iPkgDrop1;

  reg  [ADDR_LENTH - 1 : 0] iPkgFirAddr0;
  reg                       iPkgFirAddrVld0;
  reg  [               3:0] iPkgBlockNum0;
  reg                       iPkgDrop0;

  reg  [ADDR_LENTH - 1 : 0] iPkgFirAddr2;
  reg                       iPkgFirAddrVld2;
  reg  [               3:0] iPkgBlockNum2;
  reg                       iPkgDrop2;

  reg  [ADDR_LENTH - 1 : 0] iPkgFirAddr3;
  reg                       iPkgFirAddrVld3;
  reg  [               3:0] iPkgBlockNum3;
  reg                       iPkgDrop3;

  reg  [ADDR_LENTH - 1 : 0] iDropData;
  reg                       iDropDataVld;
  reg  [ADDR_LENTH - 1 : 0] rCurAddr;
  reg                       rCurAddrVld;
  reg  [ADDR_LENTH - 1 : 0] rAddrCnt;

  wire [ADDR_LENTH - 1 : 0] oEptyAddr0;
  wire                      oEptyAddrVld0;
  wire                      oPkgFirAddrRdy1;
  reg  [ADDR_LENTH - 1 : 0] rRecAddr2;
  reg                       rRecAddrVld2;
  wire [ADDR_LENTH - 1 : 0] wDropData, wDropAddr;
  wire wDropDataVld, wDropAddrVld;



  initial begin
    $fsdbDumpfile("tb_PkgWriteAndDrop.fsdb");
    $fsdbDumpvars("+all");

    iWriteLdata0    <= 0;
    iWriteLaddr0    <= 0;
    iWriteLaddrVld0 <= 0;
    iEptyAddrRdy0   <= 0;

    iPkgFirAddr0    <= 0;
    iPkgFirAddrVld0 <= 0;
    iPkgBlockNum0   <= 0;
    iPkgDrop0       <= 0;

    iPkgFirAddr1    <= 0;
    iPkgFirAddrVld1 <= 0;
    iPkgBlockNum1   <= 0;
    iPkgDrop1       <= 0;

    iPkgFirAddr2    <= 0;
    iPkgFirAddrVld2 <= 0;
    iPkgBlockNum2   <= 0;
    iPkgDrop2       <= 0;

    iPkgFirAddr3    <= 0;
    iPkgFirAddrVld3 <= 0;
    iPkgBlockNum3   <= 0;
    iPkgDrop3       <= 0;

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
        iPkgFirAddr1    <= 20;
        iPkgFirAddrVld1 <= 1;
        iPkgBlockNum1   <= 10;  //num
        iPkgDrop1       <= 1;
        @(posedge iClk);
        iPkgFirAddr1    <= 0;
        iPkgFirAddrVld1 <= 0;
        iPkgBlockNum1   <= 0;
        iPkgDrop1       <= 0;
        @(posedge iClk);
      end

      begin
        iPkgFirAddr0    <= 1;
        iPkgFirAddrVld0 <= 1;
        iPkgBlockNum0   <= 9;  //num
        iPkgDrop0       <= 1;
        @(posedge iClk);
        iPkgFirAddr0    <= 0;
        iPkgFirAddrVld0 <= 0;
        iPkgBlockNum0   <= 0;
        iPkgDrop0       <= 0;
        @(posedge iClk);
      end

      begin
        iPkgFirAddr2    <= 35;
        iPkgFirAddrVld2 <= 1;
        iPkgBlockNum2   <= 15;  //num
        iPkgDrop2       <= 1;
        @(posedge iClk);
        iPkgFirAddr2    <= 0;
        iPkgFirAddrVld2 <= 0;
        iPkgBlockNum2   <= 0;
        iPkgDrop2       <= 0;
        @(posedge iClk);
      end

      begin
        iPkgFirAddr3    <= 70;
        iPkgFirAddrVld3 <= 1;
        iPkgBlockNum3   <= 0;  //num
        iPkgDrop3       <= 1;
        @(posedge iClk);
        iPkgFirAddr3    <= 0;
        iPkgFirAddrVld3 <= 0;
        iPkgBlockNum3   <= 0;
        iPkgDrop3       <= 0;
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

  PkgRead #(
    .ADDR_LENTH(ADDR_LENTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) PkgRead_u0 (
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
    .iPkgFirAddr0   (iPkgFirAddr0),
    .iPkgFirAddrVld0(iPkgFirAddrVld0),
    .iPkgBlockNum0  (iPkgBlockNum0),
    .iPkgDrop0      (iPkgDrop0),
    .oPkgFirAddrRdy0(),
    .oWrrData0      (),
    .oWrrVld0       (),
    .iWrrRdy0       (0),
    .iPkgFirAddr1   (iPkgFirAddr1),
    .iPkgFirAddrVld1(iPkgFirAddrVld1),
    .iPkgBlockNum1  (iPkgBlockNum1),
    .iPkgDrop1      (iPkgDrop1),
    .oPkgFirAddrRdy1(oPkgFirAddrRdy1),
    .oWrrData1      (),
    .oWrrVld1       (),
    .iWrrRdy1       (0),
    .iPkgFirAddr2   (iPkgFirAddr2),
    .iPkgFirAddrVld2(iPkgFirAddrVld2),
    .iPkgBlockNum2  (iPkgBlockNum2),
    .iPkgDrop2      (iPkgDrop2),
    .oPkgFirAddrRdy2(),
    .oWrrData2      (),
    .oWrrVld2       (),
    .iWrrRdy2       (0),
    .iPkgFirAddr3   (iPkgFirAddr3),
    .iPkgFirAddrVld3(iPkgFirAddrVld3),
    .iPkgBlockNum3  (iPkgBlockNum3),
    .iPkgDrop3      (iPkgDrop3),
    .oPkgFirAddrRdy3(),
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
