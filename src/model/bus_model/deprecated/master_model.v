// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/bus_model/deprecated/master_model.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-11
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-18
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
module master_model #(
  parameter CMD_W = 1,
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4,
  parameter MEM_SIZE = 4096
) (
  input  wire             iClk,
  input  wire             iRst_n,
  output reg              oMstReq,
  output reg  [CMD_W-1:0] oMstCmd,    // 0: wr, 1:rd, TODO
  output reg  [   AW-1:0] oMstAddr,
  output reg  [   SW-1:0] oMstSel,
  output reg  [   DW-1:0] oMstWData,
  input  wire             iMstAck,
  input  wire [   DW-1:0] iMstRData
);

  reg [DW-1:0] mem[MEM_SIZE-1:0];
  integer cnt;

  ////////////////////////////////////////////////////////////////////
  //
  // Memory Logic
  //

  initial begin
    oMstAddr = {AW{1'b1}};
    oMstSel = {SW{1'bx}};
    oMstWData = {DW{1'bx}};
    oMstCmd = {CMD_W{1'bx}};
    oMstReq = 1'b0;
    cnt = 0;
    #1;
    $display("\nINFO: MASTER MODEL INSTANTIATED (%m)\n");
  end

  task mem_fill;
    integer n;
    begin
      cnt = 0;
      for (n = 0; n < MEM_SIZE; n = n + 1) begin
        mem[n] = $random;
      end
    end
  endtask

  ////////////////////////////////////////////////////////////////////
  //
  // Write 1 Word Task
  //
  task wr1;
    input [AW-1:0] a;
    input [SW-1:0] s;
    input [DW-1:0] d;
    begin
      //@(posedge clk);
      #1;
      oMstAddr  = a;
      oMstSel   = s;
      oMstWData = d;
      // oMstWData = mem[a];
      oMstReq   = 1;
      oMstCmd   = 0;

      @(posedge iClk);
      while (~iMstAck) @(posedge iClk);
      #1;
      oMstReq   = 0;
      oMstAddr  = {AW{1'bx}};
      oMstSel   = {SW{1'bx}};
      oMstWData = {DW{1'bx}};
      oMstCmd   = {CMD_W{1'bx}};
      oMstAddr  = $random;
    end
  endtask

  task wr_mult;
    input [AW-1:0] a;
    input [SW-1:0] s;
    input delay;
    input count;

    integer delay;
    integer count;
    integer n;

    begin

      //@(posedge clk);
      #1;
      oMstAddr = $random;
      for (n = 0; n < count; n = n + 1) begin
        repeat (delay) begin
          @(posedge iClk);
          #1;
        end
        oMstAddr  = a + (n * 4);
        oMstWData = mem[oMstAddr];
        // oMstWData = mem[n+cnt];
        oMstReq   = 1;
        oMstCmd   = 0;
        oMstSel   = s;
        if (n != 0) @(posedge iClk);
        while (~iMstAck) @(posedge iClk);
        #2;
        oMstReq   = 0;
        oMstCmd   = {CMD_W{1'bx}};
        oMstSel   = {SW{1'bx}};
        oMstWData = {DW{1'bx}};
        //adr = 32'hxxxx_xxxx;
        oMstAddr  = $random;
      end

      oMstAddr = {AW{1'bx}};
      //adr = 32'hffff_ffff;

      cnt = cnt + count;
    end
  endtask


  ////////////////////////////////////////////////////////////////////
  //
  // Read 1 Word Task
  //

  task rd1;
    input [AW-1:0] a;
    input [SW-1:0] s;
    output [DW-1:0] d;
    begin
      //@(posedge clk);
      #1;
      oMstAddr = a;
      oMstSel  = s;
      oMstReq  = 1;
      oMstCmd  = 1;

      //@(posedge clk);
      while (~iMstAck) @(posedge iClk);
      d = iMstRData;
      #1;
      oMstReq   = 0;
      oMstAddr  = {AW{1'b1}};
      oMstSel   = {SW{1'bx}};
      oMstWData = {DW{1'bx}};
      oMstCmd   = {CMD_W{1'bx}};
      oMstAddr  = $random;

    end
  endtask


  task rd_mult;
    input [AW-1:0] a;
    input [SW-1:0] s;
    input delay;
    input count;

    integer delay;
    integer count;
    integer n;

    begin

      //@(posedge clk);
      #1;
      // oMstReq = 1;
      oMstCmd = 1;
      oMstSel = s;
      repeat (delay) @(posedge iClk);

      for (n = 0; n < count - 1; n = n + 1) begin
        oMstAddr = a + (n * 4);
        oMstReq  = 1;
        while (~iMstAck) @(posedge iClk);
        mem[oMstAddr] = iMstRData;
        // mem[n+cnt] = iMstRData;
        #2;
        oMstReq  = 0;
        oMstCmd  = {CMD_W{1'bx}};
        oMstSel  = {SW{1'bx}};
        //adr = 32'hxxxx_xxxx;
        oMstAddr = $random;
        repeat (delay) begin
          @(posedge iClk);
          #1;
        end
        oMstCmd = 1;
        oMstSel = s;
      end

      oMstAddr = a + (n * 4);
      oMstReq  = 1;
      @(posedge iClk);
      while (~iMstAck) @(posedge iClk);
      mem[oMstAddr] = iMstRData;
      // mem[n+cnt] = iMstRData;
      #1;
      oMstReq = 0;
      oMstCmd = {CMD_W{1'bx}};
      oMstSel = {SW{1'bx}};
      //adr = 32'hffff_ffff;
      //adr = 32'hxxxx_xxxx;
      oMstAddr = $random;

      cnt = cnt + count;
    end
  endtask


endmodule
