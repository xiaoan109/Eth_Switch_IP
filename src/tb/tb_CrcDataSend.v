// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_CrcDataSend.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-13
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-13
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
module tb_CrcDataSend;

  // Parameters

  //Ports
  reg iClk;
  reg iRst_n;
  reg iWrSop;
  reg iWrEop;
  reg iWrVld;
  reg [31:0] iWrData;
  wire oWrSop;
  wire oWrEop;
  wire oWrVld;
  wire [31:0] oWrData;

  CrcDataSend CrcDataSend_inst (
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iWrSop(iWrSop),
    .iWrEop(iWrEop),
    .iWrVld(iWrVld),
    .iWrData(iWrData),
    .oWrSop(oWrSop),
    .oWrEop(oWrEop),
    .oWrVld(oWrVld),
    .oWrData(oWrData)
  );

  initial begin
    $fsdbDumpfile("tb_CrcDataSend.fsdb");
    $fsdbDumpvars("+all");
  end

  always #5 iClk = !iClk;

  initial begin
    iClk = 1'b0;
    iRst_n = 1'b0;
    iWrSop = 1'b0;
    iWrEop = 1'b0;
    iWrVld = 1'b0;
    iWrData = 32'bx;
    `DELAY(10, iClk)
    iRst_n = 1'b1;
    `DELAY(10, iClk)
    PKGSEND(0, 0, 64, 0);
    PKGSEND(0, 0, 128, 1);

    #1000 $finish;
  end


  task automatic PKGSEND;
    input [2:0] prio;  // 0-7
    input [3:0] destPort;  // 0-15
    input [10:0] pkgLen;  //Byte :64-1024
    input integer delay;  //random delay
    reg [9:0] rLen;
    begin
      rLen   = pkgLen - 1;
      //Sop
      iWrSop = 1'b1;
      `DELAY(1, iClk)
      iWrSop = 1'b0;
      //Ctrl frame
      `DELAY(delay, iClk)
      iWrVld  = 1'b1;
      iWrData = {15'b0, rLen, prio, destPort};
      `DELAY(1, iClk)
      iWrVld = 1'b0;
      //Data frame
      repeat (pkgLen >> 2) begin
        `DELAY(delay, iClk)
        iWrVld  = 1'b1;
        iWrData = $random;
        @(posedge iClk);
        #1;
        iWrVld = 1'b0;
      end
      iWrData = 32'bx;
      if (pkgLen[1:0]) begin
        `DELAY(delay, iClk)
        iWrVld = 1'b1;
        iWrData[31:24] = 8'b0;
        iWrData[23:16] = pkgLen[1:0] > 2 ? $random : 8'b0;
        iWrData[15:8] = pkgLen[1:0] > 1 ? $random : 8'b0;
        iWrData[7:0] = $random;
        @(posedge iClk);
        #1;
        iWrVld = 1'b0;
      end
      iWrData = 32'bx;
      //Eop
      iWrEop  = 1'b1;
      `DELAY(1, iClk)
      iWrEop = 1'b0;
    end
  endtask

endmodule
