interface wrPortIntf (
  input iClk,
  input iRst_n
);
  logic wrSop;
  logic wrEop;
  logic wrVld;
  logic [31:0] wrData;
  logic fifoFull;
  logic sramAlmostFull;

  clocking drv_ck @(posedge iClk);
    default input #1ns output #1ns;
    output wrSop, wrEop, wrVld, wrData;
    input fifoFull, sramAlmostFull;
  endclocking

  clocking mon_ck @(posedge iClk);
    default input #1ns output #1ns;
    input wrSop, wrEop, wrVld, wrData, fifoFull, sramAlmostFull;
  endclocking
endinterface
interface rdPortIntf (
  input iClk,
  input iRst_n
);
  logic rdSop;
  logic rdEop;
  logic rdVld;
  logic [31:0] rdData;
  logic err;
  logic ready;

  clocking mon_ck @(posedge iClk);
    default input #1ns output #1ns;
    input rdSop, rdEop, rdVld, rdData, err, ready;
  endclocking

  task READREADY;
    input rdm_rdy;
    input rdm_val; // when rdm_rdy == 0
    begin
      forever begin
        @(posedge iClk);
        if (rdm_rdy) begin
          ready = $urandom_range(0, 1);
        end else begin
          ready = rdm_val;
        end
      end
    end
  endtask
endinterface
interface wrrCfgIntf #(
  parameter WRR_WEIGHT_NUM = 8
) (
  input iClk,
  input iRst_n
);
  logic wrrWeightLoad;
  logic [3:0] wrrWeightIdx;
  logic [$clog2(WRR_WEIGHT_NUM):0] wrrWeightPld[7:0];

  clocking drv_ck @(posedge iClk);
    default input #1ns output #1ns;
    output wrrWeightLoad, wrrWeightIdx, wrrWeightPld;
  endclocking

  task INITWRR;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld0;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld1;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld2;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld3;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld4;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld5;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld6;
    input [$clog2(WRR_WEIGHT_NUM):0] weightPld7;
    begin
      @(posedge iClk);
      drv_ck.wrrWeightPld[0] <= weightPld0;
      drv_ck.wrrWeightPld[1] <= weightPld1;
      drv_ck.wrrWeightPld[2] <= weightPld2;
      drv_ck.wrrWeightPld[3] <= weightPld3;
      drv_ck.wrrWeightPld[4] <= weightPld4;
      drv_ck.wrrWeightPld[5] <= weightPld5;
      drv_ck.wrrWeightPld[6] <= weightPld6;
      drv_ck.wrrWeightPld[7] <= weightPld7;
      drv_ck.wrrWeightIdx <= 0;
      repeat (16) begin
        drv_ck.wrrWeightLoad <= 1;
        @(posedge iClk);
        drv_ck.wrrWeightIdx <= wrrWeightIdx + 1;
      end
      drv_ck.wrrWeightLoad <= 0;
    end
  endtask

endinterface

interface pktDropIntf (
  input iClk,
  input iRst_n
);
  logic vld;
  logic rdy;
  logic drop;
  logic [3:0] srcPort;
  logic [3:0] dstPort;

  clocking mon_ck @(posedge iClk);
    default input #1ns output #1ns;
    input vld, rdy, drop, srcPort, dstPort;
  endclocking

endinterface

interface fifoUsageIntf (
  input iClk,
  input iRst_n
);

  logic [31:0] num[7:0];

  clocking mon_ck @(posedge iClk);
    default input #1ns output #1ns;
    input num;
  endclocking
endinterface
