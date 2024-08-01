// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/bus_model/master_wr_model.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-17
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-22
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
module master_wr_model #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4,
  parameter MEM_SIZE = 4096
) (
  input  wire          iClk,
  input  wire          iRst_n,
  output reg           oMstWrReq,
  output reg           oMstWrValid,
  output reg  [AW-1:0] oMstWrAddr,
  output reg  [SW-1:0] oMstWrSel,
  output reg           oMstWrLast,
  output reg  [DW-1:0] oMstWrData,
  input  wire          iMstWrReady
);

  reg [DW-1:0] mem[MEM_SIZE-1:0];
  integer cnt;

  ////////////////////////////////////////////////////////////////////
  //
  // Memory Logic
  //

  initial begin
    oMstWrAddr = {AW{1'b1}};
    oMstWrSel = {SW{1'bx}};
    oMstWrLast = 1'b0;
    oMstWrData = {DW{1'bx}};
    oMstWrValid = 1'b0;
    oMstWrReq = 1'b0;
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
      oMstWrAddr = a;
      oMstWrSel  = s;
      oMstWrLast = 1'b1;  // TODO: wrLast 2clk later?
      oMstWrData = d;
      // oMstWrData = mem[a];
      oMstWrReq  = 1'b1;


      repeat (2) @(posedge iClk);  // req sync 2clk later
      oMstWrValid = 1'b1;

      @(posedge iClk);  //wr op 1clk
      while (~iMstWrReady) @(posedge iClk);
      #1;
      oMstWrReq   = 1'b0;
      oMstWrValid = 1'b0;
      oMstWrAddr  = {AW{1'bx}};
      oMstWrSel   = {SW{1'bx}};
      oMstWrLast  = 1'b0;
      oMstWrData  = {DW{1'bx}};
      // oMstWrAddr  = $random;
    end
  endtask

  task wr_mult;
    input [AW-1:0] a;
    input [SW-1:0] s;
    input delay;
    input count;
    input [5*8-1:0] TYPE;

    integer delay;
    integer count;
    integer n;

    reg [AW-1:0] addr;

    begin

      //@(posedge clk);
      #1;
      oMstWrReq = 1'b1;
      // oMstWrAddr = $random;
      for (n = 0; n < count; n = n + 1) begin
        repeat (delay) begin
          @(posedge iClk);
          #1;
        end
        addr = a + (n * 4);
        if (TYPE == "INCR") begin
          oMstWrAddr = addr;
        end else if (TYPE == "FIXED") begin
          oMstWrAddr = a;
        end else begin
          $display("ERROR: write TYPE must be INCR or FIXED!");
          $stop;
        end
        oMstWrData = mem[n+cnt];
        oMstWrSel  = s;
        oMstWrLast = (n == count - 1);  // TODO: wrLast 2clk later?

        if (n == 0) begin
          repeat (2) @(posedge iClk);  // req sync 2clk later
        end
        oMstWrValid = 1'b1;
        @(posedge iClk);
        while (~iMstWrReady) @(posedge iClk);
        #2;
        oMstWrValid = 1'b0;
        oMstWrSel   = {SW{1'bx}};
        oMstWrLast  = 1'b0;
        oMstWrData  = {DW{1'bx}};
        //adr = 32'hxxxx_xxxx;
        // oMstWrAddr  = $random;
      end
      oMstWrReq = 1'b0;

      oMstWrAddr = {AW{1'bx}};
      //adr = 32'hffff_ffff;

      cnt = cnt + count;
    end
  endtask

endmodule
