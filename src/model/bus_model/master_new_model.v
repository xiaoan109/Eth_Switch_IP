// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/bus_model/master_new_model.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-21
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-09
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
module master_new_model #(
  parameter AW = 12,
  parameter DW = 14,
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
  input  wire          iMstWrReady,
  output reg           oMstRdReq,
  output reg           oMstRdValid,
  output reg  [AW-1:0] oMstRdAddr,
  output reg  [SW-1:0] oMstRdSel,
  output reg           oMstRdLast,
  input  wire          iMstRdReady,
  input  wire [DW-1:0] iMstRdData
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
    oMstRdAddr = {AW{1'b1}};
    oMstRdSel = {SW{1'bx}};
    oMstRdLast = 1'b0;
    oMstRdValid = 1'b0;
    oMstRdReq = 1'b0;
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


      // repeat (2) @(posedge iClk);  // req sync 2clk later
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

        // if (n == 0) begin
        //   repeat (2) @(posedge iClk);  // req sync 2clk later
        // end
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
      oMstRdAddr = a;
      oMstRdSel  = s;
      oMstRdLast = 1'b1;  // TODO: rdLast 2clk later?
      oMstRdReq  = 1'b1;


      // repeat (2) @(posedge iClk);  // req sync 2clk later
      oMstRdValid = 1'b1;

      @(posedge iClk);  // rd op 1clk
      while (~iMstRdReady) @(posedge iClk);
      @(posedge iClk);  // 1clk for rdata reg output
      d = iMstRdData;
      #1;
      oMstRdReq   = 1'b0;
      oMstRdValid = 1'b0;
      oMstRdAddr  = {AW{1'b1}};
      oMstRdSel   = {SW{1'bx}};
      // oMstRdAddr  = $random;

    end
  endtask


  task rd_mult;
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
      // oMstReq = 1;
      oMstRdReq = 1'b1;
      oMstRdSel = s;
      repeat (delay) @(posedge iClk);

      for (n = 0; n < count; n = n + 1) begin
        addr = a + (n * 4);
        if (TYPE == "INCR") begin
          oMstRdAddr = addr;
        end else if (TYPE == "FIXED") begin
          oMstRdAddr = a;
        end else begin
          $display("ERROR: read TYPE must be INCR or FIXED!");
          $stop;
        end
        oMstRdLast = (n == count - 1);  // TODO: rdLast 2clk later?

        // if (n == 0) begin
        //   repeat (2) @(posedge iClk);  // req sync 2clk later
        // end
        oMstRdValid = 1'b1;
        @(posedge iClk);
        while (~iMstRdReady) @(posedge iClk);
        #2;
        mem[n+cnt]  = iMstRdData;
        oMstRdValid = 1'b0;
        oMstRdSel   = {SW{1'bx}};
        oMstRdLast  = 1'b0;
        //adr = 32'hxxxx_xxxx;
        // oMstRdAddr  = $random;
        if (n != count - 1) begin
          repeat (delay) begin
            @(posedge iClk);
            #1;
          end
        end
        oMstRdSel = s;
      end
      oMstRdReq = 1'b0;
      // addr = a + (n * 4);
      // if(TYPE == "INCR") begin
      //   oMstRdAddr  = addr;
      // end else if(TYPE == "FIXED") begin
      //   oMstRdAddr  = a;
      // end else begin
      //   $display("ERROR: read TYPE must be INCR or FIXED!");
      //   $stop;
      // end
      // oMstRdValid = 1;
      // @(posedge iClk);
      // while (~iMstRdReady) @(posedge iClk);
      // // mem[n+cnt] = iMstRdData;
      // #1;
      // mem[addr] = iMstRdData;
      // oMstRdReq = 1'b0;
      // oMstRdValid = 1'b0;
      // oMstRdSel = {SW{1'bx}};
      // //adr = 32'hffff_ffff;
      // //adr = 32'hxxxx_xxxx;
      // //due to memory reg output, keep RdAddr 1clk for not transferring other slave's data
      // // @(posedge iClk);  
      // // #1;  // avoid wrong mem addr
      oMstRdAddr = $random;

      cnt = cnt + count;
    end
  endtask


endmodule
