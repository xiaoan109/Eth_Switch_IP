// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_SwitchTop.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-13
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-06-28
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
module tb_SwitchTop ();

  localparam PRI_DEPTH = 64;
  localparam WRR_WEIGHT_NUM = 8;
  bit                            iClk;
  bit                            iRst_n;
  bit [                    15:0] iWrSop;
  bit [                    15:0] iWrEop;
  bit [                    15:0] iWrVld;
  bit [                    31:0] iWrData        [15:0];
  bit [                    15:0] oFull;
  bit [                     3:0] oAlmostFull;
  bit [                    15:0] iReady;
  bit [                    15:0] oRdSop;
  bit [                    15:0] oRdEop;
  bit [                    15:0] oRdVld;
  bit [                    31:0] oRdData        [15:0];
  bit [                    15:0] oErr;
  bit [$clog2(WRR_WEIGHT_NUM):0] iWrrWeightPld  [ 7:0];
  bit [                     3:0] iWrrWeightIdx;
  bit                            iWrrWeightLoad;


  SwitchTop #(
    .PRI_DEPTH     (PRI_DEPTH),
    .WRR_WEIGHT_NUM(WRR_WEIGHT_NUM)
  ) DUT (
    .iClk          (iClk),
    .iRst_n        (iRst_n),
    // Wr Ports
    .iWrSop0       (iWrSop[0]),
    .iWrEop0       (iWrEop[0]),
    .iWrVld0       (iWrVld[0]),
    .iWrData0      (iWrData[0]),
    .iWrSop1       (iWrSop[1]),
    .iWrEop1       (iWrEop[1]),
    .iWrVld1       (iWrVld[1]),
    .iWrData1      (iWrData[1]),
    .iWrSop2       (iWrSop[2]),
    .iWrEop2       (iWrEop[2]),
    .iWrVld2       (iWrVld[2]),
    .iWrData2      (iWrData[2]),
    .iWrSop3       (iWrSop[3]),
    .iWrEop3       (iWrEop[3]),
    .iWrVld3       (iWrVld[3]),
    .iWrData3      (iWrData[3]),
    .iWrSop4       (iWrSop[4]),
    .iWrEop4       (iWrEop[4]),
    .iWrVld4       (iWrVld[4]),
    .iWrData4      (iWrData[4]),
    .iWrSop5       (iWrSop[5]),
    .iWrEop5       (iWrEop[5]),
    .iWrVld5       (iWrVld[5]),
    .iWrData5      (iWrData[5]),
    .iWrSop6       (iWrSop[6]),
    .iWrEop6       (iWrEop[6]),
    .iWrVld6       (iWrVld[6]),
    .iWrData6      (iWrData[6]),
    .iWrSop7       (iWrSop[7]),
    .iWrEop7       (iWrEop[7]),
    .iWrVld7       (iWrVld[7]),
    .iWrData7      (iWrData[7]),
    .iWrSop8       (iWrSop[8]),
    .iWrEop8       (iWrEop[8]),
    .iWrVld8       (iWrVld[8]),
    .iWrData8      (iWrData[8]),
    .iWrSop9       (iWrSop[9]),
    .iWrEop9       (iWrEop[9]),
    .iWrVld9       (iWrVld[9]),
    .iWrData9      (iWrData[9]),
    .iWrSop10      (iWrSop[10]),
    .iWrEop10      (iWrEop[10]),
    .iWrVld10      (iWrVld[10]),
    .iWrData10     (iWrData[10]),
    .iWrSop11      (iWrSop[11]),
    .iWrEop11      (iWrEop[11]),
    .iWrVld11      (iWrVld[11]),
    .iWrData11     (iWrData[11]),
    .iWrSop12      (iWrSop[12]),
    .iWrEop12      (iWrEop[12]),
    .iWrVld12      (iWrVld[12]),
    .iWrData12     (iWrData[12]),
    .iWrSop13      (iWrSop[13]),
    .iWrEop13      (iWrEop[13]),
    .iWrVld13      (iWrVld[13]),
    .iWrData13     (iWrData[13]),
    .iWrSop14      (iWrSop[14]),
    .iWrEop14      (iWrEop[14]),
    .iWrVld14      (iWrVld[14]),
    .iWrData14     (iWrData[14]),
    .iWrSop15      (iWrSop[15]),
    .iWrEop15      (iWrEop[15]),
    .iWrVld15      (iWrVld[15]),
    .iWrData15     (iWrData[15]),
    .oFull0        (oFull[0]),          //Port 0-15 write fifo full
    .oFull1        (oFull[1]),
    .oFull2        (oFull[2]),
    .oFull3        (oFull[3]),
    .oFull4        (oFull[4]),
    .oFull5        (oFull[5]),
    .oFull6        (oFull[6]),
    .oFull7        (oFull[7]),
    .oFull8        (oFull[8]),
    .oFull9        (oFull[9]),
    .oFull10       (oFull[10]),
    .oFull11       (oFull[11]),
    .oFull12       (oFull[12]),
    .oFull13       (oFull[13]),
    .oFull14       (oFull[14]),
    .oFull15       (oFull[15]),
    .oAlmostFull0  (oAlmostFull[0]),    //inside group 0, shared memory full
    .oAlmostFull1  (oAlmostFull[1]),    //inside group 1, shared memory full
    .oAlmostFull2  (oAlmostFull[2]),    //inside group 2, shared memory full
    .oAlmostFull3  (oAlmostFull[3]),    //inside group 3, shared memory full
    // Rd Ports
    .iReady0       (iReady[0]),
    .iReady1       (iReady[1]),
    .iReady2       (iReady[2]),
    .iReady3       (iReady[3]),
    .iReady4       (iReady[4]),
    .iReady5       (iReady[5]),
    .iReady6       (iReady[6]),
    .iReady7       (iReady[7]),
    .iReady8       (iReady[8]),
    .iReady9       (iReady[9]),
    .iReady10      (iReady[10]),
    .iReady11      (iReady[11]),
    .iReady12      (iReady[12]),
    .iReady13      (iReady[13]),
    .iReady14      (iReady[14]),
    .iReady15      (iReady[15]),
    .oRdSop0       (oRdSop[0]),
    .oRdEop0       (oRdEop[0]),
    .oRdVld0       (oRdVld[0]),
    .oRdData0      (oRdData[0]),
    .oErr0         (oErr[0]),
    .oRdSop1       (oRdSop[1]),
    .oRdEop1       (oRdEop[1]),
    .oRdVld1       (oRdVld[1]),
    .oRdData1      (oRdData[1]),
    .oErr1         (oErr[1]),
    .oRdSop2       (oRdSop[2]),
    .oRdEop2       (oRdEop[2]),
    .oRdVld2       (oRdVld[2]),
    .oRdData2      (oRdData[2]),
    .oErr2         (oErr[2]),
    .oRdSop3       (oRdSop[3]),
    .oRdEop3       (oRdEop[3]),
    .oRdVld3       (oRdVld[3]),
    .oRdData3      (oRdData[3]),
    .oErr3         (oErr[3]),
    .oRdSop4       (oRdSop[4]),
    .oRdEop4       (oRdEop[4]),
    .oRdVld4       (oRdVld[4]),
    .oRdData4      (oRdData[4]),
    .oErr4         (oErr[4]),
    .oRdSop5       (oRdSop[5]),
    .oRdEop5       (oRdEop[5]),
    .oRdVld5       (oRdVld[5]),
    .oRdData5      (oRdData[5]),
    .oErr5         (oErr[5]),
    .oRdSop6       (oRdSop[6]),
    .oRdEop6       (oRdEop[6]),
    .oRdVld6       (oRdVld[6]),
    .oRdData6      (oRdData[6]),
    .oErr6         (oErr[6]),
    .oRdSop7       (oRdSop[7]),
    .oRdEop7       (oRdEop[7]),
    .oRdVld7       (oRdVld[7]),
    .oRdData7      (oRdData[7]),
    .oErr7         (oErr[7]),
    .oRdSop8       (oRdSop[8]),
    .oRdEop8       (oRdEop[8]),
    .oRdVld8       (oRdVld[8]),
    .oRdData8      (oRdData[8]),
    .oErr8         (oErr[8]),
    .oRdSop9       (oRdSop[9]),
    .oRdEop9       (oRdEop[9]),
    .oRdVld9       (oRdVld[9]),
    .oRdData9      (oRdData[9]),
    .oErr9         (oErr[9]),
    .oRdSop10      (oRdSop[10]),
    .oRdEop10      (oRdEop[10]),
    .oRdVld10      (oRdVld[10]),
    .oRdData10     (oRdData[10]),
    .oErr10        (oErr[10]),
    .oRdSop11      (oRdSop[11]),
    .oRdEop11      (oRdEop[11]),
    .oRdVld11      (oRdVld[11]),
    .oRdData11     (oRdData[11]),
    .oErr11        (oErr[11]),
    .oRdSop12      (oRdSop[12]),
    .oRdEop12      (oRdEop[12]),
    .oRdVld12      (oRdVld[12]),
    .oRdData12     (oRdData[12]),
    .oErr12        (oErr[12]),
    .oRdSop13      (oRdSop[13]),
    .oRdEop13      (oRdEop[13]),
    .oRdVld13      (oRdVld[13]),
    .oRdData13     (oRdData[13]),
    .oErr13        (oErr[13]),
    .oRdSop14      (oRdSop[14]),
    .oRdEop14      (oRdEop[14]),
    .oRdVld14      (oRdVld[14]),
    .oRdData14     (oRdData[14]),
    .oErr14        (oErr[14]),
    .oRdSop15      (oRdSop[15]),
    .oRdEop15      (oRdEop[15]),
    .oRdVld15      (oRdVld[15]),
    .oRdData15     (oRdData[15]),
    .oErr15        (oErr[15]),
    .iWrrWeightPld0(iWrrWeightPld[0]),
    .iWrrWeightPld1(iWrrWeightPld[1]),
    .iWrrWeightPld2(iWrrWeightPld[2]),
    .iWrrWeightPld3(iWrrWeightPld[3]),
    .iWrrWeightPld4(iWrrWeightPld[4]),
    .iWrrWeightPld5(iWrrWeightPld[5]),
    .iWrrWeightPld6(iWrrWeightPld[6]),
    .iWrrWeightPld7(iWrrWeightPld[7]),
    .iWrrWeightIdx (iWrrWeightIdx),
    .iWrrWeightLoad(iWrrWeightLoad)
  );


  bit dump;
  bit mda;
  initial begin
    if ($value$plusargs("DUMPWAVE=%d", dump)) begin
      if (dump) begin
        $fsdbDumpfile("tb_SwitchTop.fsdb");
        $fsdbDumpvars(0, tb_SwitchTop);
        if ($value$plusargs("DUMPMDA=%d", mda)) begin
          if (mda) begin
            $fsdbDumpMDA();
          end
        end
      end
    end
  end


  always #5 iClk = !iClk;

  task RESET;
    begin
      iRst_n = 1'b0;
      `DELAY(10, iClk)
      iRst_n = 1'b1;
    end
  endtask


  int pkgCnt[15:0][15:0];
  int dropCnt[15:0][15:0];
  byte pkgStore[15:0];
  int errCnt;
  bit [15:0] waitSop = 16'hffff;
  bit [15:0] waitEop;
  bit [15:0] waitData;  //first data frame
  bit [3:0] srcPort[15:0];
  int debugSum[15:0];
  bit debug;
  event done;

  initial begin
    repeat (2000000) @(posedge iClk);
    INFOPRINT();
    timeOutInfo();
    $fatal;
  end



  bit [10:0] rPkgLen  [15:0];  // 64-1024
  bit [ 4:0] rBlockLen[15:0];  // 1-17
  bit [ 2:0] rPri;
  bit [ 3:0] rDstPort;
  bit [ 3:0] rSrcPort;
  initial begin
    for (int m = 0; m < 16; m = m + 1) begin
      iWrSop[m]  = 1'b0;
      iWrEop[m]  = 1'b0;
      iWrVld[m]  = 1'b0;
      iWrData[m] = 32'bx;
      iReady[m]  = 1'b1;
    end
    for (int m = 0; m < 16; m = m + 1) begin
      rPkgLen[m]   = $urandom_range(64, 1024);
      // rPkgLen[m]   = 124;
      rBlockLen[m] = (rPkgLen[m] + 63 + 4) >> 6;
    end
    RESET();

    fork
      ERRCAPTURE(100);
      RECEIVEPKG();
      RUNTEST();
    join
  end

  task automatic PKGSEND;
    input [3:0] inPort;  // 0-15
    input [2:0] prio;  // 0-7
    input [3:0] destPort;  // 0-15
    input [10:0] pkgLen;  //Byte :64-1024
    input int delay;  //random delay
    bit [9:0] rLen;
    begin
      rLen = pkgLen - 1;
      //Sop
      iWrSop[inPort] = 1'b1;
      `DELAY(1, iClk)
      iWrSop[inPort] = 1'b0;
      //Ctrl frame
      `DELAY(delay, iClk)
      iWrVld[inPort]  = 1'b1;
      iWrData[inPort] = {15'b0, rLen, prio, destPort};
      @(posedge iClk);
      while (oFull[inPort] || oAlmostFull[inPort>>2]) @(posedge iClk);
      #1;
      iWrVld[inPort] = 1'b0;
      //Data frame
      //Use first data frame to indicate some info
      //for better verification
      `DELAY(delay, iClk);
      iWrVld[inPort]  = 1'b1;
      iWrData[inPort] = {11'b0, rLen, prio, destPort, inPort};
      @(posedge iClk);
      while (oFull[inPort] || oAlmostFull[inPort>>2]) @(posedge iClk);
      #1;
      iWrVld[inPort] = 1'b0;
      //repeat (pkgLen >> 2) begin
      repeat ((pkgLen >> 2) - 1) begin
        `DELAY(delay, iClk)
        iWrVld[inPort]  = 1'b1;
        iWrData[inPort] = $urandom;
        @(posedge iClk);
        while (oFull[inPort] || oAlmostFull[inPort>>2]) @(posedge iClk);
        #1;
        iWrVld[inPort] = 1'b0;
      end
      iWrData[inPort] = 32'bx;
      if (pkgLen[1:0]) begin
        `DELAY(delay, iClk)
        iWrVld[inPort] = 1'b1;
        iWrData[inPort][31:24] = 8'b0;
        iWrData[inPort][23:16] = pkgLen[1:0] > 2 ? $urandom : 8'b0;
        iWrData[inPort][15:8] = pkgLen[1:0] > 1 ? $urandom : 8'b0;
        iWrData[inPort][7:0] = $urandom;
        @(posedge iClk);
        while (oFull[inPort] || oAlmostFull[inPort>>2]) @(posedge iClk);
        #1;
        iWrVld[inPort] = 1'b0;
      end
      iWrData[inPort] = 32'bx;
      //Eop
      iWrEop[inPort]  = 1'b1;
      `DELAY(1, iClk)
      iWrEop[inPort] = 1'b0;
      ->done;
    end
  endtask

  task INITWRR;
    input [3:0] weightPld0;
    input [3:0] weightPld1;
    input [3:0] weightPld2;
    input [3:0] weightPld3;
    input [3:0] weightPld4;
    input [3:0] weightPld5;
    input [3:0] weightPld6;
    input [3:0] weightPld7;
    begin
      iWrrWeightPld[0] = weightPld0;
      iWrrWeightPld[1] = weightPld1;
      iWrrWeightPld[2] = weightPld2;
      iWrrWeightPld[3] = weightPld3;
      iWrrWeightPld[4] = weightPld4;
      iWrrWeightPld[5] = weightPld5;
      iWrrWeightPld[6] = weightPld6;
      iWrrWeightPld[7] = weightPld7;
      iWrrWeightIdx = 0;
      iWrrWeightLoad = 0;
      repeat (16) begin
        iWrrWeightLoad = 1;
        `DELAY(1, iClk)
        iWrrWeightLoad = 0;
        iWrrWeightIdx  = iWrrWeightIdx + 1;
        `DELAY(1, iClk)
      end
    end
  endtask

  // Single port to single port
  task S2STEST;
    int pkgNum;
    begin
      $display("-----------------Start single port to single port transfer test:-----------------");
      rDstPort = 0;
      repeat (16) begin
        rPri   = 0;
        pkgNum = $urandom_range(1, 100);
        for (int i = 0; i < 16; i = i + 1) begin
          $display("Port[%2d] sends %d pkg to Port[%2d]", i, pkgNum, 4'(i + rDstPort));
        end
        INITWRR(8, 8, 8, 8, 8, 8, 8, 8);
        repeat (pkgNum) begin
          fork
            PKGSEND(0, rPri, rDstPort + 0, rPkgLen[0], 0);
            PKGSEND(1, rPri, rDstPort + 1, rPkgLen[1], 0);
            PKGSEND(2, rPri, rDstPort + 2, rPkgLen[2], 0);
            PKGSEND(3, rPri, rDstPort + 3, rPkgLen[3], 0);
            PKGSEND(4, rPri, rDstPort + 4, rPkgLen[4], 0);
            PKGSEND(5, rPri, rDstPort + 5, rPkgLen[5], 0);
            PKGSEND(6, rPri, rDstPort + 6, rPkgLen[6], 0);
            PKGSEND(7, rPri, rDstPort + 7, rPkgLen[7], 0);
            PKGSEND(8, rPri, rDstPort + 8, rPkgLen[8], 0);
            PKGSEND(9, rPri, rDstPort + 9, rPkgLen[9], 0);
            PKGSEND(10, rPri, rDstPort + 10, rPkgLen[10], 0);
            PKGSEND(11, rPri, rDstPort + 11, rPkgLen[11], 0);
            PKGSEND(12, rPri, rDstPort + 12, rPkgLen[12], 0);
            PKGSEND(13, rPri, rDstPort + 13, rPkgLen[13], 0);
            PKGSEND(14, rPri, rDstPort + 14, rPkgLen[14], 0);
            PKGSEND(15, rPri, rDstPort + 15, rPkgLen[15], 0);
          join
          rPri = rPri + 1;
        end
        CHECKSEND(pkgNum, 16'hffff);  //TODO: what if we send pkg w/o check send status?
        CHECKCRC();
        rDstPort = rDstPort + 1;
      end
    end
  endtask

  // Multi port to single port
  task M2STEST;
    int pkgNum;
    begin
      $display("-----------------Start multi port to single port transfer test:-----------------");
      rDstPort = 0;
      repeat (16) begin
        rPri   = 0;
        pkgNum = $urandom_range(1, 50);
        for (int i = 0; i < 16; i = i + 1) begin
          $display("Port[%2d] sends %d pkg to Port[%2d]", i, pkgNum, rDstPort);
        end
        INITWRR(8, 8, 8, 8, 8, 8, 8, 8);
        // INITWRR(15, 15, 15, 15, 15, 15, 15, 15);
        // wait (pkgStore[rDstPort-1] == 0);
        repeat (pkgNum) begin
          fork
            PKGSEND(0, rPri, rDstPort, rPkgLen[0], 0);
            PKGSEND(1, rPri, rDstPort, rPkgLen[1], 0);
            PKGSEND(2, rPri, rDstPort, rPkgLen[2], 0);
            PKGSEND(3, rPri, rDstPort, rPkgLen[3], 0);
            PKGSEND(4, rPri, rDstPort, rPkgLen[4], 0);
            PKGSEND(5, rPri, rDstPort, rPkgLen[5], 0);
            PKGSEND(6, rPri, rDstPort, rPkgLen[6], 0);
            PKGSEND(7, rPri, rDstPort, rPkgLen[7], 0);
            PKGSEND(8, rPri, rDstPort, rPkgLen[8], 0);
            PKGSEND(9, rPri, rDstPort, rPkgLen[9], 0);
            PKGSEND(10, rPri, rDstPort, rPkgLen[10], 0);
            PKGSEND(11, rPri, rDstPort, rPkgLen[11], 0);
            PKGSEND(12, rPri, rDstPort, rPkgLen[12], 0);
            PKGSEND(13, rPri, rDstPort, rPkgLen[13], 0);
            PKGSEND(14, rPri, rDstPort, rPkgLen[14], 0);
            PKGSEND(15, rPri, rDstPort, rPkgLen[15], 0);
          join
          rPri = rPri + 1;
        end
        CHECKSEND(pkgNum * 16, 1 << rDstPort);  //TODO: due to pkg drop, pkgNum uncertain
        CHECKCRC();
        rDstPort = rDstPort + 1;
      end
    end
  endtask

  // Single port to multi port
  task S2MTEST;
    int pkgNum;
    begin
      $display("-----------------Start single port to multi port transfer test:-----------------");
      rSrcPort = 0;
      repeat (16) begin
        pkgNum = $urandom_range(1, 50);
        for (int i = 0; i < 16; i = i + 1) begin
          $display("Port[%2d] sends %d pkg to Port[%2d]", rSrcPort, pkgNum, i);
        end
        INITWRR(8, 8, 8, 8, 8, 8, 8, 8);

        for (int i = 0; i < 16; i = i + 1) begin  // TODO:  more complex situation: 1pkg per port
          rPri = 0;
          repeat (pkgNum) begin
            PKGSEND(rSrcPort, rPri, i, rPkgLen[i], 0);
            `DELAY(10, iClk)
            rPri = rPri + 1;
          end
          CHECKSEND(pkgNum, 1 << i);
        end
        // CHECKSEND(pkgNum, 16'hffff);
        CHECKCRC();
        rSrcPort = rSrcPort + 1;
      end
    end
  endtask


  // SRAM Full Test
  task SRAMFULLTEST;
    // int byteCnt;
    // int sendCnt;
    begin
      $display("-----------------Start sram full test:-----------------");
      for (int i = 0; i < 4; i = i + 1) begin
        $display("Bank %d test start", i);
        $display("Deassert ready 0-15");
        iReady = 0;
        rPri   = 0;
        // byteCnt = 0;
        // sendCnt = 0;
        INITWRR(8, 8, 8, 8, 8, 8, 8, 8);
        fork
          begin
            forever begin
              rSrcPort = $urandom_range(i * 4, i * 4 + 3);
              PKGSEND(rSrcPort, rPri, rDstPort, rPkgLen[rSrcPort], 0);
              if (&rPri) begin
                rDstPort = rDstPort + 1;
              end
              rPri = rPri + 1;
              `DELAY(1, iClk)
            end
          end
          begin
            wait (oAlmostFull[i]);
            $display("Assert ready 0-15");
            iReady = 16'hffff;
            @(done);
          end
          // begin
          //   forever begin
          //     @(done);
          //     byteCnt = byteCnt + rPkgLen[rSrcPort];
          //     sendCnt = sendCnt + 1;
          //   end
          // end
        join_any
        disable fork;
        $display("SRAM Bank %d Almost Full Received!", i);
        // $display("Total Pkg Send: %d", sendCnt);
        // $display("Total Bytes Send: %d", byteCnt);
        RESET();
      end
      CHECKCRC();
    end
  endtask

  task RUNTEST;
    begin
      string testname;
      if ($value$plusargs("TESTNAME=%s", testname)) begin
        if (testname == "S2STEST") begin
          S2STEST();
        end else if (testname == "M2STEST") begin
          M2STEST();
        end else if (testname == "S2MTEST") begin
          S2MTEST();
        end else if (testname == "SRAMFULLTEST") begin
          SRAMFULLTEST();
        end else begin
          $display("Error: TESTNAME must be S2STEST/M2STEST/S2MTEST/SRAMFULLTEST");
        end
      end else begin
        $display("WARNING: No TESTNAME");
      end
      $finish;
    end
  endtask

  task ERRCAPTURE;
    input int maxErr;
    begin
      forever
      @(posedge iClk) begin
        for (int i = 0; i < 16; i = i + 1) begin
          if (oErr[i]) begin
            errCnt <= errCnt + 1;
            $display("Port[%2d] Data Check Error, total error: %d", i, errCnt + 1);
            if (errCnt == maxErr - 1) begin
              failInfo();
              $fatal("Crc Check Error Count MAX: %d, EXIT!", maxErr);
            end
          end
        end
      end
    end
  endtask



  task RECEIVEPKG;
    begin
      forever
      @(posedge iClk) begin
        for (int i = 0; i < 16; i = i + 1) begin
          if (!iRst_n) begin
            waitSop[i]  <= 1;
            waitEop[i]  <= 0;
            waitData[i] <= 0;
            for (int j = 0; j < 16; j = j + 1) begin
              pkgCnt[i][j] <= 0;
            end
            srcPort[i] <= 0;
          end else if (waitSop[i] && oRdSop[i]) begin
            waitSop[i]  <= 0;
            waitEop[i]  <= 0;
            waitData[i] <= 1;
            for (int j = 0; j < 16; j = j + 1) begin
              pkgCnt[i][j] <= pkgCnt[i][j];
            end
            srcPort[i] <= srcPort[i];
          end else if (waitData[i] && oRdVld[i]) begin
            waitSop[i]  <= 0;
            waitEop[i]  <= 1;
            waitData[i] <= 0;
            for (int j = 0; j < 16; j = j + 1) begin
              pkgCnt[i][j] <= pkgCnt[i][j];
            end
            srcPort[i] <= oRdData[i][3:0];
          end else if (waitEop[i] && oRdEop[i]) begin
            waitSop[i]  <= 1;
            waitEop[i]  <= 0;
            waitData[i] <= 0;
            for (int j = 0; j < 16; j = j + 1) begin
              pkgCnt[i][j] <= pkgCnt[i][j];
            end
            pkgCnt[i][srcPort[i]] <= pkgCnt[i][srcPort[i]] + 1;
            srcPort[i] <= srcPort[i];
            // $display("Port[%2d] Receive 1 Package From Port[%2d]", i, srcPort[i]);
          end
        end
      end
    end
  endtask

  generate
    for (genvar i = 0; i < 16; i = i + 1) begin : gen_drop
      always @(posedge iClk or negedge iRst_n) begin
        if (!iRst_n) begin
          for (int j = 0; j < 16; j = j + 1) begin
            dropCnt[i][j] <= 0;
          end
        end else if (DUT.U_RdScheTopWrapper.intRdCmd[i].Vld && DUT.U_RdScheTopWrapper.intRdCmd[i].Pld[0]) begin
          dropCnt[DUT.U_RdScheTopWrapper.rdCmdDstPort[i]][i] <= dropCnt[DUT.U_RdScheTopWrapper.rdCmdDstPort[i]][i] + 1;
        end
      end
    end
  endgenerate





  generate
    for (genvar i = 0; i < 16; i = i + 1) begin
      always @(*) begin
        pkgStore[i] = DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[0].U_PRIFIFO.oUsage 
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[1].U_PRIFIFO.oUsage
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[2].U_PRIFIFO.oUsage
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[3].U_PRIFIFO.oUsage
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[4].U_PRIFIFO.oUsage
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[5].U_PRIFIFO.oUsage
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[6].U_PRIFIFO.oUsage
        + DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[7].U_PRIFIFO.oUsage;
      end
      always @(*) begin
        debugSum[i] = pkgCnt[i].sum() + dropCnt[i].sum() + pkgStore[i];
      end
    end
  endgenerate

  task automatic CHECKIDLE;
    input [3:0] port;
    input int idleCycles;
    output idlePulse;
    int cnt;
    begin
      fork
        forever
        @(posedge iClk) begin
          if (!oRdVld[port]) begin
            cnt = cnt + 1;
          end else begin
            cnt = 0;
          end
        end
        begin
          wait (cnt == idleCycles);
          idlePulse = 1;
          $display("@%t, Port[%2d] idle detected!", $time, port);
        end
      join_any
    end
  endtask

  task CHECKSEND;
    input int pkgNum;
    input [15:0] portSel;
    for (int i = 0; i < 16; i = i + 1) begin
      fork
        automatic int j = i;
        bit idle;
        if (portSel[j]) begin
          $display("wait for Port[%2d] receive pkg, exp: %d", j, pkgNum);
          CHECKIDLE(j, 2000, idle);
          wait (debugSum[j] == pkgNum);
        end
      join_none
    end
    wait fork;
    #1 $display("@%t, wait fork finished", $time);
  endtask



  task CHECKCRC;
    begin
      INFOPRINT();
      for (int i = 0; i < 16; i = i + 1) begin
        for (int j = 0; j < 16; j = j + 1) begin
          pkgCnt[i][j]  <= 0;
          dropCnt[i][j] <= 0;
        end
      end
    end
    if (errCnt == 0) begin
      passInfo();
    end else begin
      failInfo();
      $fatal;
    end
  endtask


  task INFOPRINT;
    begin
      // debug = 1;
      for (int i = 0; i < 16; i = i + 1) begin
        $display("Port[%2d] Receive %d Package", i, pkgCnt[i].sum());
        if (debug) begin
          if (pkgCnt[i].sum()) begin
            $display("Details: ");
            for (int j = 0; j < 16; j = j + 1) begin
              $display("From Port[%2d]: %d", j, pkgCnt[i][j]);
            end
          end
        end
      end
      for (int i = 0; i < 16; i = i + 1) begin
        $display("Port[%2d] Drop %d Package", i, dropCnt[i].sum());
        if (debug) begin
          if (dropCnt[i].sum()) begin
            $display("Details: ");
            for (int j = 0; j < 16; j = j + 1) begin
              $display("From Port[%2d]: %d", j, dropCnt[i][j]);
            end
          end
        end
      end
      // Unsupported in VCS 2020
      // $display("Total Drop Pkg: %d", dropCnt.sum());
      for (int i = 0; i < 16; i = i + 1) begin
        if (pkgCnt[i].sum() + dropCnt[i].sum()) begin
          $display("Port[%2d] Receive & Drop %d Package", i, pkgCnt[i].sum() + dropCnt[i].sum());
          if (debug) begin
            $display("Details: ");
            for (int j = 0; j < 16; j = j + 1) begin
              $display("Port[%2d] Send & Drop %d Package to Port[%2d]", j,
                       pkgCnt[i][j] + dropCnt[i][j], i);
            end
          end
        end
      end
      for (int i = 0; i < 16; i = i + 1) begin
        if (pkgStore[i]) begin
          $display("Port[%2d] pkg store in tag fifo and outbuf: %d", i, pkgStore[i]);
        end
      end
    end
  endtask

  task passInfo;
    begin
      $display("~~~~~~~~~~~~~~~~ TEST_PASS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~ #####     ##     ####    #### ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~ #    #   #  #   #       #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~ #    #  #    #   ####    #### ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~ #####   ######       #       #~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~ #       #    #  #    #  #    #~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~ #       #    #   ####    #### ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    end
  endtask

  task failInfo;
    begin
      $display("~~~~~~~~~~~~~~~~ TEST_FAIL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~######    ##       #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#        #  #      #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#####   #    #     #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#       ######     #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#       #    #     #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#       #    #     #    ######~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    end
  endtask

  task timeOutInfo;
    begin
      $display("~~~~~~~~~~~~~~~~ TIME_OUT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~######    ##       #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#        #  #      #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#####   #    #     #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#       ######     #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#       #    #     #    #     ~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~#       #    #     #    ######~~~~~~~~~~~~~~~~");
      $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    end
  endtask


endmodule