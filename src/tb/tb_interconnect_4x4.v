// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_interconnect_4x4.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-17
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-19
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
//  23-08-24 |     NJU    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================

module tb_interconnect_4x4;

  // Parameters
  localparam AW = 12;
  localparam DW = 32;
  localparam SW = 4;
  localparam MEM_SIZE = 4096;

  //Ports
  reg iClk;
  reg iRst_n;
  wire iMst0WrReq;
  wire iMst0WrValid;
  wire [AW-1:0] iMst0WrAddr;
  wire [SW-1:0] iMst0WrSel;
  wire [DW-1:0] iMst0WrData;
  wire oMst0WrReady;
  wire iMst1WrReq;
  wire iMst1WrValid;
  wire [AW-1:0] iMst1WrAddr;
  wire [SW-1:0] iMst1WrSel;
  wire [DW-1:0] iMst1WrData;
  wire oMst1WrReady;
  wire iMst2WrReq;
  wire iMst2WrValid;
  wire [AW-1:0] iMst2WrAddr;
  wire [SW-1:0] iMst2WrSel;
  wire [DW-1:0] iMst2WrData;
  wire oMst2WrReady;
  wire iMst3WrReq;
  wire iMst3WrValid;
  wire [AW-1:0] iMst3WrAddr;
  wire [SW-1:0] iMst3WrSel;
  wire [DW-1:0] iMst3WrData;
  wire oMst3WrReady;
  wire iMst0RdReq;
  wire iMst0RdValid;
  wire [AW-1:0] iMst0RdAddr;
  wire [SW-1:0] iMst0RdSel;
  wire oMst0RdReady;
  wire [DW-1:0] oMst0RdData;
  wire iMst1RdReq;
  wire iMst1RdValid;
  wire [AW-1:0] iMst1RdAddr;
  wire [SW-1:0] iMst1RdSel;
  wire oMst1RdReady;
  wire [DW-1:0] oMst1RdData;
  wire iMst2RdReq;
  wire iMst2RdValid;
  wire [AW-1:0] iMst2RdAddr;
  wire [SW-1:0] iMst2RdSel;
  wire oMst2RdReady;
  wire [DW-1:0] oMst2RdData;
  wire iMst3RdReq;
  wire iMst3RdValid;
  wire [AW-1:0] iMst3RdAddr;
  wire [SW-1:0] iMst3RdSel;
  wire oMst3RdReady;
  wire [DW-1:0] oMst3RdData;
  wire oSlv0WrReq;
  wire oSlv0WrValid;
  wire [AW-1:0] oSlv0WrAddr;
  wire [SW-1:0] oSlv0WrSel;
  wire [DW-1:0] oSlv0WrData;
  wire iSlv0WrReady;
  wire oSlv1WrReq;
  wire oSlv1WrValid;
  wire [AW-1:0] oSlv1WrAddr;
  wire [SW-1:0] oSlv1WrSel;
  wire [DW-1:0] oSlv1WrData;
  wire iSlv1WrReady;
  wire oSlv2WrReq;
  wire oSlv2WrValid;
  wire [AW-1:0] oSlv2WrAddr;
  wire [SW-1:0] oSlv2WrSel;
  wire [DW-1:0] oSlv2WrData;
  wire iSlv2WrReady;
  wire oSlv3WrReq;
  wire oSlv3WrValid;
  wire [AW-1:0] oSlv3WrAddr;
  wire [SW-1:0] oSlv3WrSel;
  wire [DW-1:0] oSlv3WrData;
  wire iSlv3WrReady;
  wire oSlv0RdReq;
  wire oSlv0RdValid;
  wire [AW-1:0] oSlv0RdAddr;
  wire [SW-1:0] oSlv0RdSel;
  wire iSlv0RdReady;
  wire [DW-1:0] iSlv0RdData;
  wire oSlv1RdReq;
  wire oSlv1RdValid;
  wire [AW-1:0] oSlv1RdAddr;
  wire [SW-1:0] oSlv1RdSel;
  wire iSlv1RdReady;
  wire [DW-1:0] iSlv1RdData;
  wire oSlv2RdReq;
  wire oSlv2RdValid;
  wire [AW-1:0] oSlv2RdAddr;
  wire [SW-1:0] oSlv2RdSel;
  wire iSlv2RdReady;
  wire [DW-1:0] iSlv2RdData;
  wire oSlv3RdReq;
  wire oSlv3RdValid;
  wire [AW-1:0] oSlv3RdAddr;
  wire [SW-1:0] oSlv3RdSel;
  wire iSlv3RdReady;
  wire [DW-1:0] iSlv3RdData;

  interconnect_4x4 #(
    .AW(AW),
    .DW(DW),
    .SW(SW)
  ) U_interconnect_4x4 (
    .iClk        (iClk),
    .iRst_n      (iRst_n),
    .iMst0WrReq  (iMst0WrReq),
    .iMst0WrValid(iMst0WrValid),
    .iMst0WrAddr (iMst0WrAddr),
    .iMst0WrSel  (iMst0WrSel),
    .iMst0WrData (iMst0WrData),
    .oMst0WrReady(oMst0WrReady),
    .iMst1WrReq  (iMst1WrReq),
    .iMst1WrValid(iMst1WrValid),
    .iMst1WrAddr (iMst1WrAddr),
    .iMst1WrSel  (iMst1WrSel),
    .iMst1WrData (iMst1WrData),
    .oMst1WrReady(oMst1WrReady),
    .iMst2WrReq  (iMst2WrReq),
    .iMst2WrValid(iMst2WrValid),
    .iMst2WrAddr (iMst2WrAddr),
    .iMst2WrSel  (iMst2WrSel),
    .iMst2WrData (iMst2WrData),
    .oMst2WrReady(oMst2WrReady),
    .iMst3WrReq  (iMst3WrReq),
    .iMst3WrValid(iMst3WrValid),
    .iMst3WrAddr (iMst3WrAddr),
    .iMst3WrSel  (iMst3WrSel),
    .iMst3WrData (iMst3WrData),
    .oMst3WrReady(oMst3WrReady),
    .iMst0RdReq  (iMst0RdReq),
    .iMst0RdValid(iMst0RdValid),
    .iMst0RdAddr (iMst0RdAddr),
    .iMst0RdSel  (iMst0RdSel),
    .oMst0RdReady(oMst0RdReady),
    .oMst0RdData (oMst0RdData),
    .iMst1RdReq  (iMst1RdReq),
    .iMst1RdValid(iMst1RdValid),
    .iMst1RdAddr (iMst1RdAddr),
    .iMst1RdSel  (iMst1RdSel),
    .oMst1RdReady(oMst1RdReady),
    .oMst1RdData (oMst1RdData),
    .iMst2RdReq  (iMst2RdReq),
    .iMst2RdValid(iMst2RdValid),
    .iMst2RdAddr (iMst2RdAddr),
    .iMst2RdSel  (iMst2RdSel),
    .oMst2RdReady(oMst2RdReady),
    .oMst2RdData (oMst2RdData),
    .iMst3RdReq  (iMst3RdReq),
    .iMst3RdValid(iMst3RdValid),
    .iMst3RdAddr (iMst3RdAddr),
    .iMst3RdSel  (iMst3RdSel),
    .oMst3RdReady(oMst3RdReady),
    .oMst3RdData (oMst3RdData),
    .oSlv0WrReq  (oSlv0WrReq),
    .oSlv0WrValid(oSlv0WrValid),
    .oSlv0WrAddr (oSlv0WrAddr),
    .oSlv0WrSel  (oSlv0WrSel),
    .oSlv0WrData (oSlv0WrData),
    .iSlv0WrReady(iSlv0WrReady),
    .oSlv1WrReq  (oSlv1WrReq),
    .oSlv1WrValid(oSlv1WrValid),
    .oSlv1WrAddr (oSlv1WrAddr),
    .oSlv1WrSel  (oSlv1WrSel),
    .oSlv1WrData (oSlv1WrData),
    .iSlv1WrReady(iSlv1WrReady),
    .oSlv2WrReq  (oSlv2WrReq),
    .oSlv2WrValid(oSlv2WrValid),
    .oSlv2WrAddr (oSlv2WrAddr),
    .oSlv2WrSel  (oSlv2WrSel),
    .oSlv2WrData (oSlv2WrData),
    .iSlv2WrReady(iSlv2WrReady),
    .oSlv3WrReq  (oSlv3WrReq),
    .oSlv3WrValid(oSlv3WrValid),
    .oSlv3WrAddr (oSlv3WrAddr),
    .oSlv3WrSel  (oSlv3WrSel),
    .oSlv3WrData (oSlv3WrData),
    .iSlv3WrReady(iSlv3WrReady),
    .oSlv0RdReq  (oSlv0RdReq),
    .oSlv0RdValid(oSlv0RdValid),
    .oSlv0RdAddr (oSlv0RdAddr),
    .oSlv0RdSel  (oSlv0RdSel),
    .iSlv0RdReady(iSlv0RdReady),
    .iSlv0RdData (iSlv0RdData),
    .oSlv1RdReq  (oSlv1RdReq),
    .oSlv1RdValid(oSlv1RdValid),
    .oSlv1RdAddr (oSlv1RdAddr),
    .oSlv1RdSel  (oSlv1RdSel),
    .iSlv1RdReady(iSlv1RdReady),
    .iSlv1RdData (iSlv1RdData),
    .oSlv2RdReq  (oSlv2RdReq),
    .oSlv2RdValid(oSlv2RdValid),
    .oSlv2RdAddr (oSlv2RdAddr),
    .oSlv2RdSel  (oSlv2RdSel),
    .iSlv2RdReady(iSlv2RdReady),
    .iSlv2RdData (iSlv2RdData),
    .oSlv3RdReq  (oSlv3RdReq),
    .oSlv3RdValid(oSlv3RdValid),
    .oSlv3RdAddr (oSlv3RdAddr),
    .oSlv3RdSel  (oSlv3RdSel),
    .iSlv3RdReady(iSlv3RdReady),
    .iSlv3RdData (iSlv3RdData)
  );

  master_wr_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m0_wr (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst0WrReq),
    .oMstWrValid(iMst0WrValid),
    .oMstWrAddr (iMst0WrAddr),
    .oMstWrSel  (iMst0WrSel),
    .oMstWrData (iMst0WrData),
    .iMstWrReady(oMst0WrReady)
  );

  master_wr_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m1_wr (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst1WrReq),
    .oMstWrValid(iMst1WrValid),
    .oMstWrAddr (iMst1WrAddr),
    .oMstWrSel  (iMst1WrSel),
    .oMstWrData (iMst1WrData),
    .iMstWrReady(oMst1WrReady)
  );

  master_wr_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m2_wr (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst2WrReq),
    .oMstWrValid(iMst2WrValid),
    .oMstWrAddr (iMst2WrAddr),
    .oMstWrSel  (iMst2WrSel),
    .oMstWrData (iMst2WrData),
    .iMstWrReady(oMst2WrReady)
  );

  master_wr_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m3_wr (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstWrReq  (iMst3WrReq),
    .oMstWrValid(iMst3WrValid),
    .oMstWrAddr (iMst3WrAddr),
    .oMstWrSel  (iMst3WrSel),
    .oMstWrData (iMst3WrData),
    .iMstWrReady(oMst3WrReady)
  );

  master_rd_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m0_rd (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstRdReq  (iMst0RdReq),
    .oMstRdValid(iMst0RdValid),
    .oMstRdAddr (iMst0RdAddr),
    .oMstRdSel  (iMst0RdSel),
    .iMstRdReady(oMst0RdReady),
    .iMstRdData (oMst0RdData)
  );

  master_rd_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m1_rd (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstRdReq  (iMst1RdReq),
    .oMstRdValid(iMst1RdValid),
    .oMstRdAddr (iMst1RdAddr),
    .oMstRdSel  (iMst1RdSel),
    .iMstRdReady(oMst1RdReady),
    .iMstRdData (oMst1RdData)
  );

  master_rd_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m2_rd (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstRdReq  (iMst2RdReq),
    .oMstRdValid(iMst2RdValid),
    .oMstRdAddr (iMst2RdAddr),
    .oMstRdSel  (iMst2RdSel),
    .iMstRdReady(oMst2RdReady),
    .iMstRdData (oMst2RdData)
  );

  master_rd_model #(
    .AW(AW),
    .DW(DW),
    .SW(SW),
    .MEM_SIZE(MEM_SIZE)
  ) m3_rd (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .oMstRdReq  (iMst3RdReq),
    .oMstRdValid(iMst3RdValid),
    .oMstRdAddr (iMst3RdAddr),
    .oMstRdSel  (iMst3RdSel),
    .iMstRdReady(oMst3RdReady),
    .iMstRdData (oMst3RdData)
  );

  slave_mem_model #(
    .AW(AW - 2),
    .DW(DW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) s0 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .iSlvWrReq  (oSlv0WrReq),
    .iSlvWrValid(oSlv0WrValid),
    .iSlvWrAddr (oSlv0WrAddr),
    .iSlvWrSel  (oSlv0WrSel),
    .iSlvWrData (oSlv0WrData),
    .oSlvWrReady(iSlv0WrReady),
    .iSlvRdReq  (oSlv0RdReq),
    .iSlvRdValid(oSlv0RdValid),
    .iSlvRdAddr (oSlv0RdAddr),
    .iSlvRdSel  (oSlv0RdSel),
    .oSlvRdReady(iSlv0RdReady),
    .oSlvRdData (iSlv0RdData)
  );

  slave_mem_model #(
    .AW(AW - 2),
    .DW(DW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) s1 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .iSlvWrReq  (oSlv1WrReq),
    .iSlvWrValid(oSlv1WrValid),
    .iSlvWrAddr (oSlv1WrAddr),
    .iSlvWrSel  (oSlv1WrSel),
    .iSlvWrData (oSlv1WrData),
    .oSlvWrReady(iSlv1WrReady),
    .iSlvRdReq  (oSlv1RdReq),
    .iSlvRdValid(oSlv1RdValid),
    .iSlvRdAddr (oSlv1RdAddr),
    .iSlvRdSel  (oSlv1RdSel),
    .oSlvRdReady(iSlv1RdReady),
    .oSlvRdData (iSlv1RdData)
  );

  slave_mem_model #(
    .AW(AW - 2),
    .DW(DW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) s2 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .iSlvWrReq  (oSlv2WrReq),
    .iSlvWrValid(oSlv2WrValid),
    .iSlvWrAddr (oSlv2WrAddr),
    .iSlvWrSel  (oSlv2WrSel),
    .iSlvWrData (oSlv2WrData),
    .oSlvWrReady(iSlv2WrReady),
    .iSlvRdReq  (oSlv2RdReq),
    .iSlvRdValid(oSlv2RdValid),
    .iSlvRdAddr (oSlv2RdAddr),
    .iSlvRdSel  (oSlv2RdSel),
    .oSlvRdReady(iSlv2RdReady),
    .oSlvRdData (iSlv2RdData)
  );

  slave_mem_model #(
    .AW(AW - 2),
    .DW(DW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) s3 (
    .iClk       (iClk),
    .iRst_n     (iRst_n),
    .iSlvWrReq  (oSlv3WrReq),
    .iSlvWrValid(oSlv3WrValid),
    .iSlvWrAddr (oSlv3WrAddr),
    .iSlvWrSel  (oSlv3WrSel),
    .iSlvWrData (oSlv3WrData),
    .oSlvWrReady(iSlv3WrReady),
    .iSlvRdReq  (oSlv3RdReq),
    .iSlvRdValid(oSlv3RdValid),
    .iSlvRdAddr (oSlv3RdAddr),
    .iSlvRdSel  (oSlv3RdSel),
    .oSlvRdReady(iSlv3RdReady),
    .oSlvRdData (iSlv3RdData)
  );


  initial begin
    $fsdbDumpfile("tb_interconnect_4x4.fsdb");
    $fsdbDumpvars(0, tb_interconnect_4x4);
    $fsdbDumpMDA();
  end

  initial begin
    iClk = 1'b0;
    forever begin
      #5 iClk = !iClk;
    end
  end

  initial begin
    repeat (10000) @(posedge iClk);
    $display("timeout!");
    $finish;
  end

  reg [DW-1:0] rdata;
  initial begin
    iRst_n = 1'b0;
    repeat (5) @(posedge iClk);
    s0.delay = 1;
    s1.delay = 1;
    s2.delay = 1;
    s3.delay = 1;
    #1 iRst_n = 1'b1;
    repeat (10) @(posedge iClk);
    test_dp;
    test_arb;

    // init_all_mem;
    // m0_wr.wr1('h000 + 0, 4'hf, 32'hdeadbeef);
    // repeat (5) @(posedge iClk);
    // m0_rd.rd1('h000 + 0, 4'hf, rdata);

    // m0_wr.wr1('h010 + 0, 4'hf, 32'hdeadbeef);
    // repeat (2) @(posedge iClk);
    // m0_rd.rd1('h000 + 0, 4'hf, rdata);

    // m0_wr.wr1('h020 + 0, 4'hf, 32'hdeadbeef);
    // repeat (1) @(posedge iClk);
    // m0_rd.rd1('h020 + 0, 4'hf, rdata);

    // m0_wr.wr1('h030 + 0, 4'hf, 32'hdeadbeef);
    // repeat (0) @(posedge iClk);
    // m0_rd.rd1('h030 + 0, 4'hf, rdata);

    // repeat (2) @(posedge iClk);
    // fork
    //   m0_wr.wr1('h040 + 0, 4'hf, 32'hdeadbeef);
    //   m0_rd.rd1('h050 + 0, 4'hf, rdata);
    // join


    #100 $finish;
  end


  task init_all_mem;
    begin
      m0_wr.mem_fill;
      m1_wr.mem_fill;
      m2_wr.mem_fill;
      m3_wr.mem_fill;
      m0_rd.mem_fill;
      m1_rd.mem_fill;
      m2_rd.mem_fill;
      m3_rd.mem_fill;
      s0.fill_mem(1);
      s1.fill_mem(1);
      s2.fill_mem(1);
      s3.fill_mem(1);
    end
  endtask

  task verify;
    input master;
    input slave;
    input count;
    integer master, slave, count;
    begin
      verify_sub(master, slave, count, 0, 0);
    end
  endtask


  task verify_sub;
    input master;
    input slave;
    input count;
    input mo;
    input so;

    integer master, slave, count;
    integer mo, so;
    integer o;
    integer n;
    reg [DW-1:0] mdata_wr, mdata_rd, sdata;

    begin

      //$display("V2: %0d %0d %0d %0d %0d",master, slave, count, mo,so);

      for (n = 0; n < count; n = n + 1) begin
        o = 0;
        case (master)
          0: o = 16'h000;
          1: o = 16'h100;
          2: o = 16'h200;
          3: o = 16'h300;
        endcase

        case (master)
          0: begin
            mdata_wr = m0_wr.mem[(n<<2)+o+mo+slave];
            mdata_rd = m0_rd.mem[(n<<2)+o+mo+slave];
          end
          1: begin
            mdata_wr = m1_wr.mem[(n<<2)+o+mo+slave];
            mdata_rd = m1_rd.mem[(n<<2)+o+mo+slave];
          end
          2: begin
            mdata_wr = m2_wr.mem[(n<<2)+o+mo+slave];
            mdata_rd = m2_rd.mem[(n<<2)+o+mo+slave];
          end
          3: begin
            mdata_wr = m3_wr.mem[(n<<2)+o+mo+slave];
            mdata_rd = m3_rd.mem[(n<<2)+o+mo+slave];
          end
          default: begin
            $display("ERROR: Illegal Master %0d", master);
            $finish;
          end
        endcase



        case (slave)
          0: sdata = s0.mem[n+(o>>2)+so];
          1: sdata = s1.mem[n+(o>>2)+so];
          2: sdata = s2.mem[n+(o>>2)+so];
          3: sdata = s3.mem[n+(o>>2)+so];
          default: begin
            $display("ERROR: Illegal Slave %0d", slave);
            $finish;
          end
        endcase
        //$display("INFO: Master[%0d]: %h - Slave[%0d]: %h (%0t)",
        //	master, mdata, slave, sdata, $time);
        if ((mdata_wr !== sdata) && (mdata_rd != sdata)) begin
          $display("ERROR: Master_WR[%0d][%0d]: %h - Master_Rd[%0d][%0d]: %h- Slave[%0d]: %h (%0t)",
                   master, n, mdata_wr, master, n, mdata_rd, slave, sdata, $time);
          // error_cnt = error_cnt + 1;
        end
      end
    end
  endtask

  task test_dp;
    integer n;
    reg [1:0] s0;
    reg [1:0] s1;
    reg [1:0] s2;
    reg [1:0] s3;
    begin
      $display("\n\n");
      $display("*****************************************************");
      $display("*** Datapath Test ...                             ***");
      $display("*****************************************************\n");

      s0 = 0;
      s1 = 1;
      s2 = 2;
      s3 = 3;
      for (n = 0; n < 4; n = n + 1) begin
        init_all_mem;
        $display("Mode: %0d", n);
        fork
          begin
            m0_wr.wr_mult('h000 + s0, 4'hf, 0, 4, "FIXED");
            m0_rd.rd_mult('h010 + s0, 4'hf, 0, 4, "FIXED");
            m0_wr.wr_mult('h020 + s0, 4'hf, 0, 4, "FIXED");
            m0_rd.rd_mult('h030 + s0, 4'hf, 0, 4, "FIXED");

          end
          begin
            m1_wr.wr_mult('h100 + s1, 4'hf, 0, 4, "INCR");
            m1_rd.rd_mult('h110 + s1, 4'hf, 0, 4, "INCR");
            m1_wr.wr_mult('h120 + s1, 4'hf, 0, 4, "INCR");
            m1_rd.rd_mult('h130 + s1, 4'hf, 0, 4, "INCR");
          end
          begin
            m2_wr.wr_mult('h200 + s2, 4'hf, 0, 4, "INCR");
            m2_rd.rd_mult('h210 + s2, 4'hf, 0, 4, "INCR");
            m2_wr.wr_mult('h220 + s2, 4'hf, 0, 4, "INCR");
            m2_rd.rd_mult('h230 + s2, 4'hf, 0, 4, "INCR");
          end
          begin
            m3_wr.wr_mult('h300 + s3, 4'hf, 0, 4, "INCR");
            m3_rd.rd_mult('h310 + s3, 4'hf, 0, 4, "INCR");
            m3_wr.wr_mult('h320 + s3, 4'hf, 0, 4, "INCR");
            m3_rd.rd_mult('h330 + s3, 4'hf, 0, 4, "INCR");
          end
        join
        verify(0, s0, 16);
        verify(1, s1, 16);
        verify(2, s2, 16);
        verify(3, s3, 16);
        @(posedge iClk);
        s0 = s0 + 1;
        s1 = s1 + 1;
        s2 = s2 + 1;
        s3 = s3 + 1;
        @(posedge iClk);

      end

      $display("*****************************************************");
      $display("*** Test DONE ...                                 ***");
      $display("*****************************************************\n\n");

    end
  endtask


  task test_arb;
    integer n, del;
    begin
      $display("\n\n");
      $display("*****************************************************");
      $display("*** Arb Test ...                                  ***");
      $display("*****************************************************\n");

      for (del = 0; del < 5; del = del + 1) begin
        $display("Delay: %0d", del);
        init_all_mem;
        fork
          begin
            m0_rd.rd_mult('h000 + 0, 4'hf, del, 4, "INCR");
            m0_wr.wr_mult('h010 + 0, 4'hf, del, 4, "INCR");
            m0_rd.rd_mult('h020 + 0, 4'hf, del, 4, "INCR");
            m0_wr.wr_mult('h030 + 0, 4'hf, del, 4, "INCR");
          end
          begin
            m1_wr.wr_mult('h100 + 0, 4'hf, del, 4, "INCR");
            m1_rd.rd_mult('h110 + 0, 4'hf, del, 4, "INCR");
            m1_wr.wr_mult('h120 + 0, 4'hf, del, 4, "INCR");
            m1_rd.rd_mult('h130 + 0, 4'hf, del, 4, "INCR");
          end
          begin
            m2_rd.rd_mult('h200 + 0, 4'hf, del, 4, "INCR");
            m2_wr.wr_mult('h210 + 0, 4'hf, del, 4, "INCR");
            m2_rd.rd_mult('h220 + 0, 4'hf, del, 4, "INCR");
            m2_wr.wr_mult('h230 + 0, 4'hf, del, 4, "INCR");
          end
          begin
            m3_wr.wr_mult('h300 + 0, 4'hf, del, 4, "INCR");
            m3_rd.rd_mult('h310 + 0, 4'hf, del, 4, "INCR");
            m3_wr.wr_mult('h320 + 0, 4'hf, del, 4, "INCR");
            m3_rd.rd_mult('h330 + 0, 4'hf, del, 4, "INCR");
          end
        join

        verify(0, 0, 16);
        verify(1, 0, 16);
        verify(2, 0, 16);
        verify(3, 0, 16);
      end

      $display("*****************************************************");
      $display("*** Test DONE ...                                 ***");
      $display("*****************************************************\n\n");
    end

  endtask

endmodule
