// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_sram_wrapper.v
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
//  23-08-24 |     NJU    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
`include "define.v"
module tb_sram_wrapper ();
  reg         iClk;
  reg         iRst_n;
  reg         iCEnA;
  reg         iCEnB;
  reg         iWEnA;
  reg         iWEnB;
  reg  [31:0] iBWEnA;
  reg  [31:0] iBWEnB;
  reg  [13:0] iAddrA;
  reg  [13:0] iAddrB;
  reg  [31:0] iWDataA;
  reg  [31:0] iWDataB;
  wire [31:0] oRDataA;
  wire [31:0] oRDataB;

  sram_wrapper U_sram_wrapper (
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
    $fsdbDumpfile("tb_sram_wrapper.fsdb");
    $fsdbDumpvars(0, tb_sram_wrapper);
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
    iBWEnA  = 32'hff;
    iBWEnB  = 32'hff;
    iAddrA  = 14'h0;
    iAddrB  = 14'h0;
    iWDataA = 32'h0;
    iWDataB = 32'h0;
    `DELAY(10, iClk)
    iRst_n = 1'b1;
    `DELAY(5, iClk)
    WrMem("A", 32'h0, 14'hf, 32'h12345678);
    `DELAY(1, iClk)
    RdMem("A", 14'hf);
    $display("oRDataA = %h", oRDataA);
    `DELAY(5, iClk)
    WrMem("A", 32'h0, 14'h100f, 32'hdeadbeef);
    `DELAY(1, iClk)
    RdMem("B", 14'h100f);
    $display("oRDataB = %h", oRDataB);
    `DELAY(5, iClk)
    WrMem("B", 32'h0, 14'h200f, 32'h12345678);
    `DELAY(1, iClk)
    RdMem("B", 14'h200f);
    $display("oRDataB = %h", oRDataB);
    `DELAY(5, iClk)
    WrMem("B", 32'h0, 14'h300f, 32'hdeadbeef);
    `DELAY(1, iClk)
    RdMem("A", 14'h300f);
    $display("oRDataA = %h", oRDataA);
    #10 $finish;
  end

  task WrMem;
    input [7:0] port;  // 'A', 'B'
    input [31:0] wen;
    input [13:0] addr;
    input [31:0] data;
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
        iBWEnA  = 32'hff;
        iAddrA  = 14'h0;
        iWDataA = 32'h0;
      end else if (port == "B") begin
        iCEnB   = 1'b0;
        iWEnB   = 1'b0;
        iBWEnB  = wen;
        iAddrB  = addr;
        iWDataB = data;
        `DELAY(1, iClk)
        iCEnB   = 1'b1;
        iWEnB   = 1'b1;
        iBWEnB  = 32'hff;
        iAddrB  = 14'h0;
        iWDataB = 32'h0;
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
