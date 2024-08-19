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
`include "SwitchTop_intf.sv"

module tb_SwitchTop ();

  import SwitchTop_pkg::*;

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

  wrPortIntf wrPort[16] (
    .iClk  (iClk),
    .iRst_n(iRst_n)
  );

  generate
    for (genvar i = 0; i < 16; i = i + 1) begin
      assign wrPort[i].sramAlmostFull = oAlmostFull[i>>2];
    end
  endgenerate

  rdPortIntf rdPort[16] (
    .iClk  (iClk),
    .iRst_n(iRst_n)
  );

  wrrCfgIntf #(
    .WRR_WEIGHT_NUM(WRR_WEIGHT_NUM)
  ) wrrCfg (
    .iClk  (iClk),
    .iRst_n(iRst_n)
  );

  pktDropIntf pktDrop[16] (
    .iClk  (iClk),
    .iRst_n(iRst_n)
  );


  generate
    for (genvar i = 0; i < 16; i = i + 1) begin : bind_drop
      assign pktDrop[i].vld = DUT.U_RdScheTopWrapper.intRdCmd[i].Vld;
      assign pktDrop[i].rdy = DUT.U_RdScheTopWrapper.intRdCmd[i].Rdy;
      assign pktDrop[i].drop = DUT.U_RdScheTopWrapper.intRdCmd[i].Pld[0];
      assign pktDrop[i].srcPort = i;
      assign pktDrop[i].dstPort = DUT.U_RdScheTopWrapper.rdCmdDstPort[i];
    end
  endgenerate

  fifoUsageIntf fifoUsage[16] (
    .iClk  (iClk),
    .iRst_n(iRst_n)
  );

  generate
    for (genvar i = 0; i < 16; i = i + 1) begin : bind_fifoUsage
      for (genvar j = 0; j < 8; j = j + 1) begin : bind_num
        assign fifoUsage[i].num[j] = DUT.U_RdScheTopWrapper.U_RD_SCHE_TOP_SV.U_RDCTRLTOP16.genblk1[i].U_RD_CHN.GEN_PRI_FIFO[j].U_PRIFIFO.oUsage;
      end
    end
  endgenerate



  SwitchTop #(
    .PRI_DEPTH     (PRI_DEPTH),
    .WRR_WEIGHT_NUM(WRR_WEIGHT_NUM)
  ) DUT (
    .iClk          (iClk),
    .iRst_n        (iRst_n),
    // Wr Ports
    .iWrSop0       (wrPort[0].wrSop),
    .iWrEop0       (wrPort[0].wrEop),
    .iWrVld0       (wrPort[0].wrVld),
    .iWrData0      (wrPort[0].wrData),
    .iWrSop1       (wrPort[1].wrSop),
    .iWrEop1       (wrPort[1].wrEop),
    .iWrVld1       (wrPort[1].wrVld),
    .iWrData1      (wrPort[1].wrData),
    .iWrSop2       (wrPort[2].wrSop),
    .iWrEop2       (wrPort[2].wrEop),
    .iWrVld2       (wrPort[2].wrVld),
    .iWrData2      (wrPort[2].wrData),
    .iWrSop3       (wrPort[3].wrSop),
    .iWrEop3       (wrPort[3].wrEop),
    .iWrVld3       (wrPort[3].wrVld),
    .iWrData3      (wrPort[3].wrData),
    .iWrSop4       (wrPort[4].wrSop),
    .iWrEop4       (wrPort[4].wrEop),
    .iWrVld4       (wrPort[4].wrVld),
    .iWrData4      (wrPort[4].wrData),
    .iWrSop5       (wrPort[5].wrSop),
    .iWrEop5       (wrPort[5].wrEop),
    .iWrVld5       (wrPort[5].wrVld),
    .iWrData5      (wrPort[5].wrData),
    .iWrSop6       (wrPort[6].wrSop),
    .iWrEop6       (wrPort[6].wrEop),
    .iWrVld6       (wrPort[6].wrVld),
    .iWrData6      (wrPort[6].wrData),
    .iWrSop7       (wrPort[7].wrSop),
    .iWrEop7       (wrPort[7].wrEop),
    .iWrVld7       (wrPort[7].wrVld),
    .iWrData7      (wrPort[7].wrData),
    .iWrSop8       (wrPort[8].wrSop),
    .iWrEop8       (wrPort[8].wrEop),
    .iWrVld8       (wrPort[8].wrVld),
    .iWrData8      (wrPort[8].wrData),
    .iWrSop9       (wrPort[9].wrSop),
    .iWrEop9       (wrPort[9].wrEop),
    .iWrVld9       (wrPort[9].wrVld),
    .iWrData9      (wrPort[9].wrData),
    .iWrSop10      (wrPort[10].wrSop),
    .iWrEop10      (wrPort[10].wrEop),
    .iWrVld10      (wrPort[10].wrVld),
    .iWrData10     (wrPort[10].wrData),
    .iWrSop11      (wrPort[11].wrSop),
    .iWrEop11      (wrPort[11].wrEop),
    .iWrVld11      (wrPort[11].wrVld),
    .iWrData11     (wrPort[11].wrData),
    .iWrSop12      (wrPort[12].wrSop),
    .iWrEop12      (wrPort[12].wrEop),
    .iWrVld12      (wrPort[12].wrVld),
    .iWrData12     (wrPort[12].wrData),
    .iWrSop13      (wrPort[13].wrSop),
    .iWrEop13      (wrPort[13].wrEop),
    .iWrVld13      (wrPort[13].wrVld),
    .iWrData13     (wrPort[13].wrData),
    .iWrSop14      (wrPort[14].wrSop),
    .iWrEop14      (wrPort[14].wrEop),
    .iWrVld14      (wrPort[14].wrVld),
    .iWrData14     (wrPort[14].wrData),
    .iWrSop15      (wrPort[15].wrSop),
    .iWrEop15      (wrPort[15].wrEop),
    .iWrVld15      (wrPort[15].wrVld),
    .iWrData15     (wrPort[15].wrData),
    .oFull0        (wrPort[0].fifoFull),      //Port 0-15 write fifo full
    .oFull1        (wrPort[1].fifoFull),
    .oFull2        (wrPort[2].fifoFull),
    .oFull3        (wrPort[3].fifoFull),
    .oFull4        (wrPort[4].fifoFull),
    .oFull5        (wrPort[5].fifoFull),
    .oFull6        (wrPort[6].fifoFull),
    .oFull7        (wrPort[7].fifoFull),
    .oFull8        (wrPort[8].fifoFull),
    .oFull9        (wrPort[9].fifoFull),
    .oFull10       (wrPort[10].fifoFull),
    .oFull11       (wrPort[11].fifoFull),
    .oFull12       (wrPort[12].fifoFull),
    .oFull13       (wrPort[13].fifoFull),
    .oFull14       (wrPort[14].fifoFull),
    .oFull15       (wrPort[15].fifoFull),
    .oAlmostFull0  (oAlmostFull[0]),          //inside group 0, shared memory full
    .oAlmostFull1  (oAlmostFull[1]),          //inside group 1, shared memory full
    .oAlmostFull2  (oAlmostFull[2]),          //inside group 2, shared memory full
    .oAlmostFull3  (oAlmostFull[3]),          //inside group 3, shared memory full
    // Rd Ports
    .iReady0       (rdPort[0].ready),
    .iReady1       (rdPort[1].ready),
    .iReady2       (rdPort[2].ready),
    .iReady3       (rdPort[3].ready),
    .iReady4       (rdPort[4].ready),
    .iReady5       (rdPort[5].ready),
    .iReady6       (rdPort[6].ready),
    .iReady7       (rdPort[7].ready),
    .iReady8       (rdPort[8].ready),
    .iReady9       (rdPort[9].ready),
    .iReady10      (rdPort[10].ready),
    .iReady11      (rdPort[11].ready),
    .iReady12      (rdPort[12].ready),
    .iReady13      (rdPort[13].ready),
    .iReady14      (rdPort[14].ready),
    .iReady15      (rdPort[15].ready),
    .oRdSop0       (rdPort[0].rdSop),
    .oRdEop0       (rdPort[0].rdEop),
    .oRdVld0       (rdPort[0].rdVld),
    .oRdData0      (rdPort[0].rdData),
    .oErr0         (rdPort[0].err),
    .oRdSop1       (rdPort[1].rdSop),
    .oRdEop1       (rdPort[1].rdEop),
    .oRdVld1       (rdPort[1].rdVld),
    .oRdData1      (rdPort[1].rdData),
    .oErr1         (rdPort[1].err),
    .oRdSop2       (rdPort[2].rdSop),
    .oRdEop2       (rdPort[2].rdEop),
    .oRdVld2       (rdPort[2].rdVld),
    .oRdData2      (rdPort[2].rdData),
    .oErr2         (rdPort[2].err),
    .oRdSop3       (rdPort[3].rdSop),
    .oRdEop3       (rdPort[3].rdEop),
    .oRdVld3       (rdPort[3].rdVld),
    .oRdData3      (rdPort[3].rdData),
    .oErr3         (rdPort[3].err),
    .oRdSop4       (rdPort[4].rdSop),
    .oRdEop4       (rdPort[4].rdEop),
    .oRdVld4       (rdPort[4].rdVld),
    .oRdData4      (rdPort[4].rdData),
    .oErr4         (rdPort[4].err),
    .oRdSop5       (rdPort[5].rdSop),
    .oRdEop5       (rdPort[5].rdEop),
    .oRdVld5       (rdPort[5].rdVld),
    .oRdData5      (rdPort[5].rdData),
    .oErr5         (rdPort[5].err),
    .oRdSop6       (rdPort[6].rdSop),
    .oRdEop6       (rdPort[6].rdEop),
    .oRdVld6       (rdPort[6].rdVld),
    .oRdData6      (rdPort[6].rdData),
    .oErr6         (rdPort[6].err),
    .oRdSop7       (rdPort[7].rdSop),
    .oRdEop7       (rdPort[7].rdEop),
    .oRdVld7       (rdPort[7].rdVld),
    .oRdData7      (rdPort[7].rdData),
    .oErr7         (rdPort[7].err),
    .oRdSop8       (rdPort[8].rdSop),
    .oRdEop8       (rdPort[8].rdEop),
    .oRdVld8       (rdPort[8].rdVld),
    .oRdData8      (rdPort[8].rdData),
    .oErr8         (rdPort[8].err),
    .oRdSop9       (rdPort[9].rdSop),
    .oRdEop9       (rdPort[9].rdEop),
    .oRdVld9       (rdPort[9].rdVld),
    .oRdData9      (rdPort[9].rdData),
    .oErr9         (rdPort[9].err),
    .oRdSop10      (rdPort[10].rdSop),
    .oRdEop10      (rdPort[10].rdEop),
    .oRdVld10      (rdPort[10].rdVld),
    .oRdData10     (rdPort[10].rdData),
    .oErr10        (rdPort[10].err),
    .oRdSop11      (rdPort[11].rdSop),
    .oRdEop11      (rdPort[11].rdEop),
    .oRdVld11      (rdPort[11].rdVld),
    .oRdData11     (rdPort[11].rdData),
    .oErr11        (rdPort[11].err),
    .oRdSop12      (rdPort[12].rdSop),
    .oRdEop12      (rdPort[12].rdEop),
    .oRdVld12      (rdPort[12].rdVld),
    .oRdData12     (rdPort[12].rdData),
    .oErr12        (rdPort[12].err),
    .oRdSop13      (rdPort[13].rdSop),
    .oRdEop13      (rdPort[13].rdEop),
    .oRdVld13      (rdPort[13].rdVld),
    .oRdData13     (rdPort[13].rdData),
    .oErr13        (rdPort[13].err),
    .oRdSop14      (rdPort[14].rdSop),
    .oRdEop14      (rdPort[14].rdEop),
    .oRdVld14      (rdPort[14].rdVld),
    .oRdData14     (rdPort[14].rdData),
    .oErr14        (rdPort[14].err),
    .oRdSop15      (rdPort[15].rdSop),
    .oRdEop15      (rdPort[15].rdEop),
    .oRdVld15      (rdPort[15].rdVld),
    .oRdData15     (rdPort[15].rdData),
    .oErr15        (rdPort[15].err),
    .iWrrWeightPld0(wrrCfg.wrrWeightPld[0]),
    .iWrrWeightPld1(wrrCfg.wrrWeightPld[1]),
    .iWrrWeightPld2(wrrCfg.wrrWeightPld[2]),
    .iWrrWeightPld3(wrrCfg.wrrWeightPld[3]),
    .iWrrWeightPld4(wrrCfg.wrrWeightPld[4]),
    .iWrrWeightPld5(wrrCfg.wrrWeightPld[5]),
    .iWrrWeightPld6(wrrCfg.wrrWeightPld[6]),
    .iWrrWeightPld7(wrrCfg.wrrWeightPld[7]),
    .iWrrWeightIdx (wrrCfg.wrrWeightIdx),
    .iWrrWeightLoad(wrrCfg.wrrWeightLoad)
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

  root_test root_test_h;
  s2s_test s2s_test_h;
  m2s_test m2s_test_h;
  random_test random_test_h;
  sram_full_test sram_full_test_h;
  max_test max_test_h;
  root_test tests[string];
  string name;
  initial begin
    root_test_h = new();
    s2s_test_h = new();
    m2s_test_h = new();
    random_test_h = new();
    sram_full_test_h = new();
    max_test_h = new();
    tests["ROOTTEST"] = root_test_h;
    tests["S2STEST"] = s2s_test_h;
    tests["M2STEST"] = m2s_test_h;
    tests["RANDOMTEST"] = random_test_h;
    tests["SRAMFULLTEST"] = sram_full_test_h;
    tests["MAXTEST"] = max_test_h;

    fork
      RESET();
      begin
        if ($value$plusargs("TESTNAME=%s", name)) begin
          if (tests.exists(name)) begin
            tests[name].set_interface(wrPort, rdPort, pktDrop, fifoUsage, wrrCfg);
            tests[name].run();
          end else begin
            $fatal($sformatf("[ERRTEST], test name %s is invalid, please specify a valid name!",
                             name));
          end
        end else begin
          $display(
            "NO runtime optiont +TESTNAME=xxx is configured, and run default test root_test");
          tests["ROOTTEST"].set_interface(wrPort, rdPort, pktDrop, fifoUsage, wrrCfg);
          tests["ROOTTEST"].run();
        end
      end
    join
  end
endmodule
