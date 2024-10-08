// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_PktRead.v
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

module tb_PktRead;

  // Parameters
  localparam ADDR_LENTH = 12;
  localparam DATA_WIDTH = 32;

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
  reg  [DATA_WIDTH - 1:0] iData            [3:0];
  reg                     iMmuRdy          [3:0];
  wire [ADDR_LENTH - 1:0] oBlockAddr       [3:0];
  wire                    oBlockAddrVld    [3:0];
  wire                    oMmuReadReq      [3:0];
  wire                    oMmuReadLast     [3:0];
  reg  [ADDR_LENTH - 1:0] iPktFirAddr      [3:0];
  reg                     iPktFirAddrVld   [3:0];
  reg  [           3 : 0] iPktBlockNum     [3:0];
  reg                     iPktDrop         [3:0];
  wire                    oPktFirAddrRdy   [3:0];
  wire [DATA_WIDTH - 1:0] oWrrData         [3:0];
  wire                    oWrrVld          [3:0];
  wire                    oWrrDataLast     [3:0];
  reg                     iWrrRdy          [3:0];

  PktRead #(
    .ADDR_LENTH(ADDR_LENTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) PktRead_inst (
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
    .iPktFirAddr0    (iPktFirAddr[0]),
    .iPktFirAddrVld0 (iPktFirAddrVld[0]),
    .iPktBlockNum0   (iPktBlockNum[0]),
    .iPktDrop0       (iPktDrop[0]),
    .oPktFirAddrRdy0 (oPktFirAddrRdy[0]),
    .oWrrData0       (oWrrData[0]),
    .oWrrVld0        (oWrrVld[0]),
    .oWrrDataLast0   (oWrrDataLast[0]),
    .iWrrRdy0        (iWrrRdy[0]),
    .iPktFirAddr1    (iPktFirAddr[1]),
    .iPktFirAddrVld1 (iPktFirAddrVld[1]),
    .iPktBlockNum1   (iPktBlockNum[1]),
    .iPktDrop1       (iPktDrop[1]),
    .oPktFirAddrRdy1 (oPktFirAddrRdy[1]),
    .oWrrData1       (oWrrData[1]),
    .oWrrVld1        (oWrrVld[1]),
    .oWrrDataLast1   (oWrrDataLast[1]),
    .iWrrRdy1        (iWrrRdy[1]),
    .iPktFirAddr2    (iPktFirAddr[2]),
    .iPktFirAddrVld2 (iPktFirAddrVld[2]),
    .iPktBlockNum2   (iPktBlockNum[2]),
    .iPktDrop2       (iPktDrop[2]),
    .oPktFirAddrRdy2 (oPktFirAddrRdy[2]),
    .oWrrData2       (oWrrData[2]),
    .oWrrVld2        (oWrrVld[2]),
    .oWrrDataLast2   (oWrrDataLast[2]),
    .iWrrRdy2        (iWrrRdy[2]),
    .iPktFirAddr3    (iPktFirAddr[3]),
    .iPktFirAddrVld3 (iPktFirAddrVld[3]),
    .iPktBlockNum3   (iPktBlockNum[3]),
    .iPktDrop3       (iPktDrop[3]),
    .oPktFirAddrRdy3 (oPktFirAddrRdy[3]),
    .oWrrData3       (oWrrData[3]),
    .oWrrVld3        (oWrrVld[3]),
    .oWrrDataLast3   (oWrrDataLast[3]),
    .iWrrRdy3        (iWrrRdy[3])
  );

  always #5 iClk = !iClk;


  integer m;
  reg [3:0] rFullBlockNum;
  reg [3:0] rWordNum;
  initial begin
    $fsdbDumpfile("tb_PktRead.fsdb");
    $fsdbDumpvars("+all");

    iClk   <= 0;
    iRst_n <= 0;
    for (m = 0; m < 4; m = m + 1) begin
      iLdata[m]         <= 0;
      iLdataVld[m]      <= 0;
      iMmuRdy[m]        <= 0;
      iData[m]          <= 0;
      iPktFirAddr[m]    <= 0;
      iPktFirAddrVld[m] <= 0;
      iPktBlockNum[m]   <= 0;
      iWrrRdy[m]        <= 0;
      iPktDrop[m]       <= 0;
    end
    iDropData <= 0;
    iDropDataVld <= 0;
    #100 iRst_n <= 1;

    repeat (10) @(posedge iClk);
    fork
      begin
        repeat (100) begin
          rFullBlockNum = {$urandom} % 10;
          rWordNum = {$urandom} % 3;
          fork
            WRRSEND(0, rFullBlockNum, rWordNum, 1);
            LSRAM(0, rFullBlockNum, rWordNum, 1);
            MMUDATA(0, rFullBlockNum, rWordNum);
          join
        end
      end
      WRRREADY(0, 1, 1, 100000);
      MMUREADY(0, 1, 1, 100000);
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
      iPktFirAddr[inPort] <= firstAddr;
      iPktFirAddrVld[inPort] <= 1;
      iPktBlockNum[inPort] <= blockNum;
      @(posedge iClk);
      while (!oPktFirAddrRdy[inPort]) @(posedge iClk);
      iPktFirAddr[inPort] <= 0;
      iPktFirAddrVld[inPort] <= 0;
      iPktBlockNum[inPort] <= 0;
    end
  endtask

  integer times;
  integer cnt;
  task automatic LSRAM;
    input [1:0] inPort;  //0-3
    input [3:0] blockNum;  //0-15, full block 1-16
    input [3:0] wordNum;  //0-15, last block word 0-15
    input [11:0] firstAddr;
    begin
      times = wordNum ? blockNum + 2 : blockNum + 1;
      cnt   = 1;
      repeat (times) begin
        @(posedge iClk);
        while (!oLaddrVld[inPort]) @(posedge iClk);
        if (cnt == times) begin
          iLdata[inPort] <= wordNum;
        end else begin
          iLdata[inPort] <= firstAddr + cnt;
        end
        iLdataVld[inPort] <= 1;
        cnt <= cnt + 1;
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

  task automatic MMUREADY;
    input [1:0] inPort;
    input ready_on;
    input rdm_on;
    input integer max_cyc;
    begin
      repeat (max_cyc) begin
        @(posedge iClk);
        if (rdm_on) begin
          iMmuRdy[inPort] <= $urandom;
        end else begin
          iMmuRdy[inPort] <= ready_on;
        end
      end
    end
  endtask


  integer dataCnt;
  integer rdCnt;
  task automatic MMUDATA;
    input [1:0] inPort;
    input [3:0] blockNum;  //0-15, full block 1-16
    input [3:0] wordNum;  //0-15, last block word 0-15
    begin
      dataCnt = ((blockNum + 1) << 4) + wordNum;
      rdCnt   = 1;
      repeat (dataCnt) begin
        @(posedge iClk);
        while (!(iMmuRdy[inPort] & oMmuReadReq[inPort] & oBlockAddrVld[inPort])) @(posedge iClk);
        iData[inPort] <= rdCnt;
        rdCnt <= rdCnt + 1;
      end
    end
  endtask







endmodule
