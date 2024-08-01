// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_sram16x16k.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-03-29
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-03-29
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
module tb_sram16x16k ();
  reg         iClk;
  reg         iRst_n;
  reg         iCEnA;
  reg         iCEnB;
  reg         iWEnA;
  reg         iWEnB;
  reg  [15:0] iBWEnA;
  reg  [15:0] iBWEnB;
  reg  [13:0] iAddrA;
  reg  [13:0] iAddrB;
  reg  [15:0] iWDataA;
  reg  [15:0] iWDataB;
  wire [15:0] oRDataA;
  wire [15:0] oRDataB;

  sram16x16k U_sram16x16k (
    .iClkA  (iClk),
    .iClkB  (iClk),
    .iRst_n (iRst_n),
    .iCEnA  (iCEnA),
    .iCEnB  (iCEnB),
    .iWEnA  (iWEnA),
    .iWEnB  (iWEnB),
    .iBWEnA (iBWEnA),
    .iBWEnB (iBWEnB),
    .iAddrA (iAddrA),
    .iAddrB (iAddrB),
    .iWDataA(iWDataA),
    .iWDataB(iWDataB),
    .oRDataA(oRDataA),
    .oRDataB(oRDataB)
  );

  initial begin
    $fsdbDumpfile("tb_sram16x16k.fsdb");
    $fsdbDumpvars(0, tb_sram16x16k);
    $fsdbDumpMDA();
  end

  initial begin
    iClk = 1'b0;
    forever #5 iClk = !iClk;
  end

  initial begin
    iRst_n  = 1'b0;
    iCEnA   = 1'b1;
    iCEnB   = 1'b1;
    iWEnA   = 1'b1;
    iWEnB   = 1'b1;
    iBWEnA  = 16'hff;
    iBWEnB  = 16'hff;
    iAddrA  = 14'h0;
    iAddrB  = 14'h0;
    iWDataA = 16'h0;
    iWDataB = 16'h0;
    `DELAY(10, iClk)
    iRst_n = 1'b1;
    `DELAY(5, iClk)
    WrMem("A", 16'h0, 14'hf, 16'h1234);
    `DELAY(1, iClk)
    RdMem("A", 14'hf);
    $display("oRDataA = %h", oRDataA);
    `DELAY(5, iClk)
    WrMem("A", 16'h0, 14'h100f, 16'h5678);
    `DELAY(1, iClk)
    RdMem("B", 14'h100f);
    $display("oRDataB = %h", oRDataB);
    `DELAY(5, iClk)
    WrMem("B", 16'h0, 14'h200f, 16'hdead);
    `DELAY(1, iClk)
    RdMem("B", 14'h200f);
    $display("oRDataB = %h", oRDataB);
    `DELAY(5, iClk)
    WrMem("B", 16'h0, 14'h300f, 16'hbeef);
    `DELAY(1, iClk)
    RdMem("A", 14'h300f);
    $display("oRDataA = %h", oRDataA);
    #10 $finish;
  end

  task WrMem;
    input [7:0] port;  // 'A', 'B'
    input [15:0] wen;
    input [13:0] addr;
    input [15:0] data;
    begin
      if (port == "A") begin
        iCEnA   = 1'b0;
        iWEnA   = 1'b0;
        iBWEnA  = wen;
        iAddrA  = addr;
        iWDataA = data;
        `DELAY(1, iClk)
        iCEnA   = 1'b1;
        iWEnA   = 1'b1;
        iBWEnA  = 16'hff;
        iAddrA  = 14'h0;
        iWDataA = 16'h0;
      end else if (port == "B") begin
        iCEnB   = 1'b0;
        iWEnB   = 1'b0;
        iBWEnB  = wen;
        iAddrB  = addr;
        iWDataB = data;
        `DELAY(1, iClk)
        iCEnB   = 1'b1;
        iWEnB   = 1'b1;
        iBWEnB  = 16'hff;
        iAddrB  = 14'h0;
        iWDataB = 16'h0;
      end else begin
        $display("Error: port must be A or B!");
      end
    end
  endtask

  task RdMem;
    input [7:0] port;  // 'A', 'B'
    input [13:0] addr;
    begin
      if (port == "A") begin
        iCEnA  = 1'b0;
        iWEnA  = 1'b1;
        iAddrA = addr;
        `DELAY(1, iClk)
        iCEnA  = 1'b1;
        iWEnA  = 1'b1;
        iAddrA = 14'h0;
      end else if (port == "B") begin
        iCEnB  = 1'b0;
        iWEnB  = 1'b1;
        iAddrB = addr;
        `DELAY(1, iClk)
        iCEnB  = 1'b1;
        iWEnB  = 1'b1;
        iAddrB = 14'h0;
      end else begin
        $display("Error: port must be A or B!");
      end
    end
  endtask

endmodule
