// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_interconnect_4W4R.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-11
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-14
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
module tb_interconnect_4W4R ();

  parameter CMD_W = 1;
  parameter AW = 12;
  parameter DW = 32;
  parameter SW = 4;
  parameter MEM_SIZE = 4096;

  reg              iClk;
  reg              iRst_n;

  wire             iMst0Req;
  wire [CMD_W-1:0] iMst0Cmd;
  wire [   AW-1:0] iMst0Addr;
  wire [   SW-1:0] iMst0Sel;
  wire [   DW-1:0] iMst0WData;
  wire             oMst0Ack;
  wire [   DW-1:0] oMst0RData;
  wire             iMst1Req;
  wire [CMD_W-1:0] iMst1Cmd;
  wire [   AW-1:0] iMst1Addr;
  wire [   SW-1:0] iMst1Sel;
  wire [   DW-1:0] iMst1WData;
  wire             oMst1Ack;
  wire [   DW-1:0] oMst1RData;
  wire             iMst2Req;
  wire [CMD_W-1:0] iMst2Cmd;
  wire [   AW-1:0] iMst2Addr;
  wire [   SW-1:0] iMst2Sel;
  wire [   DW-1:0] iMst2WData;
  wire             oMst2Ack;
  wire [   DW-1:0] oMst2RData;
  wire             iMst3Req;
  wire [CMD_W-1:0] iMst3Cmd;
  wire [   AW-1:0] iMst3Addr;
  wire [   SW-1:0] iMst3Sel;
  wire [   DW-1:0] iMst3WData;
  wire             oMst3Ack;
  wire [   DW-1:0] oMst3RData;

  wire             oSlv0Req;
  wire [CMD_W-1:0] oSlv0Cmd;
  wire [   AW-1:0] oSlv0Addr;
  wire [   SW-1:0] oSlv0Sel;
  wire [   DW-1:0] oSlv0WData;
  wire             iSlv0Ack;
  wire [   DW-1:0] iSlv0RData;
  wire             oSlv1Req;
  wire [CMD_W-1:0] oSlv1Cmd;
  wire [   AW-1:0] oSlv1Addr;
  wire [   SW-1:0] oSlv1Sel;
  wire [   DW-1:0] oSlv1WData;
  wire             iSlv1Ack;
  wire [   DW-1:0] iSlv1RData;
  wire             oSlv2Req;
  wire [CMD_W-1:0] oSlv2Cmd;
  wire [   AW-1:0] oSlv2Addr;
  wire [   SW-1:0] oSlv2Sel;
  wire [   DW-1:0] oSlv2WData;
  wire             iSlv2Ack;
  wire [   DW-1:0] iSlv2RData;
  wire             oSlv3Req;
  wire [CMD_W-1:0] oSlv3Cmd;
  wire [   AW-1:0] oSlv3Addr;
  wire [   SW-1:0] oSlv3Sel;
  wire [   DW-1:0] oSlv3WData;
  wire             iSlv3Ack;
  wire [   DW-1:0] iSlv3RData;

  interconnect_4W4R #(
    .CMD_W(CMD_W),
    .AW   (AW),
    .DW   (DW),
    .SW   (SW)
  ) U_interconnect_4W4R (
    .iClk      (iClk),
    .iRst_n    (iRst_n),
    .iMst0Req  (iMst0Req),
    .iMst0Cmd  (iMst0Cmd),
    .iMst0Addr (iMst0Addr),
    .iMst0Sel  (iMst0Sel),
    .iMst0WData(iMst0WData),
    .oMst0Ack  (oMst0Ack),
    .oMst0RData(oMst0RData),
    .iMst1Req  (iMst1Req),
    .iMst1Cmd  (iMst1Cmd),
    .iMst1Addr (iMst1Addr),
    .iMst1Sel  (iMst1Sel),
    .iMst1WData(iMst1WData),
    .oMst1Ack  (oMst1Ack),
    .oMst1RData(oMst1RData),
    .iMst2Req  (iMst2Req),
    .iMst2Cmd  (iMst2Cmd),
    .iMst2Addr (iMst2Addr),
    .iMst2Sel  (iMst2Sel),
    .iMst2WData(iMst2WData),
    .oMst2Ack  (oMst2Ack),
    .oMst2RData(oMst2RData),
    .iMst3Req  (iMst3Req),
    .iMst3Cmd  (iMst3Cmd),
    .iMst3Addr (iMst3Addr),
    .iMst3Sel  (iMst3Sel),
    .iMst3WData(iMst3WData),
    .oMst3Ack  (oMst3Ack),
    .oMst3RData(oMst3RData),
    .oSlv0Req  (oSlv0Req),
    .oSlv0Cmd  (oSlv0Cmd),
    .oSlv0Addr (oSlv0Addr),
    .oSlv0Sel  (oSlv0Sel),
    .oSlv0WData(oSlv0WData),
    .iSlv0Ack  (iSlv0Ack),
    .iSlv0RData(iSlv0RData),
    .oSlv1Req  (oSlv1Req),
    .oSlv1Cmd  (oSlv1Cmd),
    .oSlv1Addr (oSlv1Addr),
    .oSlv1Sel  (oSlv1Sel),
    .oSlv1WData(oSlv1WData),
    .iSlv1Ack  (iSlv1Ack),
    .iSlv1RData(iSlv1RData),
    .oSlv2Req  (oSlv2Req),
    .oSlv2Cmd  (oSlv2Cmd),
    .oSlv2Addr (oSlv2Addr),
    .oSlv2Sel  (oSlv2Sel),
    .oSlv2WData(oSlv2WData),
    .iSlv2Ack  (iSlv2Ack),
    .iSlv2RData(iSlv2RData),
    .oSlv3Req  (oSlv3Req),
    .oSlv3Cmd  (oSlv3Cmd),
    .oSlv3Addr (oSlv3Addr),
    .oSlv3Sel  (oSlv3Sel),
    .oSlv3WData(oSlv3WData),
    .iSlv3Ack  (iSlv3Ack),
    .iSlv3RData(iSlv3RData)
  );

  master_model #(
    .CMD_W   (CMD_W),
    .AW      (AW),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE)
  ) U0_master_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .oMstReq  (iMst0Req),
    .oMstCmd  (iMst0Cmd),
    .oMstAddr (iMst0Addr),
    .oMstSel  (iMst0Sel),
    .oMstWData(iMst0WData),
    .iMstAck  (oMst0Ack),
    .iMstRData(oMst0RData)
  );

  master_model #(
    .CMD_W   (CMD_W),
    .AW      (AW),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE)
  ) U1_master_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .oMstReq  (iMst1Req),
    .oMstCmd  (iMst1Cmd),
    .oMstAddr (iMst1Addr),
    .oMstSel  (iMst1Sel),
    .oMstWData(iMst1WData),
    .iMstAck  (oMst1Ack),
    .iMstRData(oMst1RData)
  );

  master_model #(
    .CMD_W   (CMD_W),
    .AW      (AW),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE)
  ) U2_master_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .oMstReq  (iMst2Req),
    .oMstCmd  (iMst2Cmd),
    .oMstAddr (iMst2Addr),
    .oMstSel  (iMst2Sel),
    .oMstWData(iMst2WData),
    .iMstAck  (oMst2Ack),
    .iMstRData(oMst2RData)
  );

  master_model #(
    .CMD_W   (CMD_W),
    .AW      (AW),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE)
  ) U3_master_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .oMstReq  (iMst3Req),
    .oMstCmd  (iMst3Cmd),
    .oMstAddr (iMst3Addr),
    .oMstSel  (iMst3Sel),
    .oMstWData(iMst3WData),
    .iMstAck  (oMst3Ack),
    .iMstRData(oMst3RData)
  );

  slave_model #(
    .CMD_W   (CMD_W),
    .AW      (AW - 2),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) U0_slave_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .iSlvReq  (oSlv0Req),
    .iSlvCmd  (oSlv0Cmd),
    .iSlvAddr (oSlv0Addr),
    .iSlvSel  (oSlv0Sel),
    .iSlvWData(oSlv0WData),
    .oSlvAck  (iSlv0Ack),
    .oSlvRData(iSlv0RData)
  );

  slave_model #(
    .CMD_W   (CMD_W),
    .AW      (AW - 2),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) U1_slave_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .iSlvReq  (oSlv1Req),
    .iSlvCmd  (oSlv1Cmd),
    .iSlvAddr (oSlv1Addr),
    .iSlvSel  (oSlv1Sel),
    .iSlvWData(oSlv1WData),
    .oSlvAck  (iSlv1Ack),
    .oSlvRData(iSlv1RData)
  );

  slave_model #(
    .CMD_W   (CMD_W),
    .AW      (AW - 2),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) U2_slave_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .iSlvReq  (oSlv2Req),
    .iSlvCmd  (oSlv2Cmd),
    .iSlvAddr (oSlv2Addr),
    .iSlvSel  (oSlv2Sel),
    .iSlvWData(oSlv2WData),
    .oSlvAck  (iSlv2Ack),
    .oSlvRData(iSlv2RData)
  );

  slave_model #(
    .CMD_W   (CMD_W),
    .AW      (AW - 2),
    .DW      (DW),
    .SW      (SW),
    .MEM_SIZE(MEM_SIZE >> 2)
  ) U3_slave_model (
    .iClk     (iClk),
    .iRst_n   (iRst_n),
    .iSlvReq  (oSlv3Req),
    .iSlvCmd  (oSlv3Cmd),
    .iSlvAddr (oSlv3Addr),
    .iSlvSel  (oSlv3Sel),
    .iSlvWData(oSlv3WData),
    .oSlvAck  (iSlv3Ack),
    .oSlvRData(iSlv3RData)
  );

  initial begin
    $fsdbDumpfile("tb_interconnect_4W4R.fsdb");
    $fsdbDumpvars(0, tb_interconnect_4W4R);
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

  initial begin
    iRst_n = 1'b0;
    repeat (5) @(posedge iClk);
    U0_slave_model.delay = 1;
    U1_slave_model.delay = 1;
    U2_slave_model.delay = 1;
    U3_slave_model.delay = 1;
    #1 iRst_n = 1'b1;
    repeat (10) @(posedge iClk);
    test_dp;
    test_arb;


    #100 $finish;
  end

  task init_all_mem;
    begin
      U0_master_model.mem_fill;
      U1_master_model.mem_fill;
      U2_master_model.mem_fill;
      U3_master_model.mem_fill;
      U0_slave_model.fill_mem(1);
      U1_slave_model.fill_mem(1);
      U2_slave_model.fill_mem(1);
      U3_slave_model.fill_mem(1);
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
    reg [DW-1:0] mdata, sdata;

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
          0: mdata = U0_master_model.mem[(n<<2)+o+mo+slave];
          1: mdata = U1_master_model.mem[(n<<2)+o+mo+slave];
          2: mdata = U2_master_model.mem[(n<<2)+o+mo+slave];
          3: mdata = U3_master_model.mem[(n<<2)+o+mo+slave];
          default: begin
            $display("ERROR: Illegal Master %0d", master);
            $finish;
          end
        endcase



        case (slave)
          0: sdata = U0_slave_model.mem[n+(o>>2)+so];
          1: sdata = U1_slave_model.mem[n+(o>>2)+so];
          2: sdata = U2_slave_model.mem[n+(o>>2)+so];
          3: sdata = U3_slave_model.mem[n+(o>>2)+so];
          default: begin
            $display("ERROR: Illegal Slave %0d", slave);
            $finish;
          end
        endcase
        //$display("INFO: Master[%0d]: %h - Slave[%0d]: %h (%0t)",
        //	master, mdata, slave, sdata, $time);
        if (mdata !== sdata) begin
          $display("ERROR: Master[%0d][%0d]: %h - Slave[%0d]: %h (%0t)", master, n, mdata, slave,
                   sdata, $time);
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
            U0_master_model.wr_mult('h000 + s0, 4'hf, 0, 4);
            U0_master_model.rd_mult('h010 + s0, 4'hf, 0, 4);
            U0_master_model.wr_mult('h020 + s0, 4'hf, 0, 4);
            U0_master_model.rd_mult('h030 + s0, 4'hf, 0, 4);

          end
          begin
            U1_master_model.wr_mult('h100 + s1, 4'hf, 0, 4);
            U1_master_model.rd_mult('h110 + s1, 4'hf, 0, 4);
            U1_master_model.wr_mult('h120 + s1, 4'hf, 0, 4);
            U1_master_model.rd_mult('h130 + s1, 4'hf, 0, 4);
          end
          begin
            U2_master_model.wr_mult('h200 + s2, 4'hf, 0, 4);
            U2_master_model.rd_mult('h210 + s2, 4'hf, 0, 4);
            U2_master_model.wr_mult('h220 + s2, 4'hf, 0, 4);
            U2_master_model.rd_mult('h230 + s2, 4'hf, 0, 4);
          end
          begin
            U3_master_model.wr_mult('h300 + s3, 4'hf, 0, 4);
            U3_master_model.rd_mult('h310 + s3, 4'hf, 0, 4);
            U3_master_model.wr_mult('h320 + s3, 4'hf, 0, 4);
            U3_master_model.rd_mult('h330 + s3, 4'hf, 0, 4);
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
            U0_master_model.rd_mult('h000 + 0, 4'hf, del, 4);
            U0_master_model.wr_mult('h010 + 0, 4'hf, del, 4);
            U0_master_model.rd_mult('h020 + 0, 4'hf, del, 4);
            U0_master_model.wr_mult('h030 + 0, 4'hf, del, 4);
          end
          begin
            U1_master_model.wr_mult('h100 + 0, 4'hf, del, 4);
            U1_master_model.rd_mult('h110 + 0, 4'hf, del, 4);
            U1_master_model.wr_mult('h120 + 0, 4'hf, del, 4);
            U1_master_model.rd_mult('h130 + 0, 4'hf, del, 4);
          end
          begin
            U2_master_model.rd_mult('h200 + 0, 4'hf, del, 4);
            U2_master_model.wr_mult('h210 + 0, 4'hf, del, 4);
            U2_master_model.rd_mult('h220 + 0, 4'hf, del, 4);
            U2_master_model.wr_mult('h230 + 0, 4'hf, del, 4);
          end
          begin
            U3_master_model.wr_mult('h300 + 0, 4'hf, del, 4);
            U3_master_model.rd_mult('h310 + 0, 4'hf, del, 4);
            U3_master_model.wr_mult('h320 + 0, 4'hf, del, 4);
            U3_master_model.rd_mult('h330 + 0, 4'hf, del, 4);
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
