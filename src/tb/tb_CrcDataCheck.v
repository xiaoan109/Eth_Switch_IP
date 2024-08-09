// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_CrcDataCheck.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-15
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-16
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
module tb_CrcDataCheck;

  // Parameters

  //Ports
  reg iClk;
  reg iRst_n;
  reg iRdSop;
  reg iRdEop;
  reg iRdVld;
  reg iRdLast;
  reg [31:0] iRdData;
  wire oRdSop;
  wire oRdEop;
  wire oRdVld;
  wire [31:0] oRdData;
  wire oErr;
  reg iReady;

  CrcDataCheck CrcDataCheck_inst (
    .iClk(iClk),
    .iRst_n(iRst_n),
    .iRdSop(iRdSop),
    .iRdEop(iRdEop),
    .iRdVld(iRdVld),
    .iRdLast(iRdLast),
    .iRdData(iRdData),
    .oRdSop(oRdSop),
    .oRdEop(oRdEop),
    .oRdVld(oRdVld),
    .oRdData(oRdData),
    .oErr(oErr),
    .iReady(iReady)
  );

  always #5 iClk = !iClk;

  initial begin
    $fsdbDumpfile("tb_CrcDataCheck.fsdb");
    $fsdbDumpvars("+all");
  end

  initial begin
    iClk = 1'b0;
    iRst_n = 1'b0;
    iRdSop = 1'b0;
    iRdEop = 1'b0;
    iRdVld = 1'b0;
    iRdLast = 1'b0;
    `DELAY(10, iClk)
    iRst_n = 1'b1;
    `DELAY(10, iClk)
    PKTSEND(64, 0);

    #1000 $finish;
  end


  task PKTSEND;
    input [10:0] pktLen;  //Byte :64-1024
    input integer delay;  //random delay
    begin
      //Sop
      iRdSop = 1'b1;
      `DELAY(1, iClk)
      iRdSop = 1'b0;
      //Data frame
      repeat (pktLen >> 2) begin
        `DELAY(delay, iClk)
        iRdVld  = 1'b1;
        iRdData = $random;
        @(posedge iClk);
        while (!iReady) @(posedge iClk);
        #1;
        iRdVld = 1'b0;
      end
      iRdData = 32'bx;
      if (pktLen[1:0]) begin
        `DELAY(delay, iClk)
        iRdVld = 1'b1;
        iRdData[31:24] = 8'b0;
        iRdData[23:16] = pktLen[1:0] > 2 ? $random : 8'b0;
        iRdData[15:8] = pktLen[1:0] > 1 ? $random : 8'b0;
        iRdData[7:0] = $random;
        @(posedge iClk);
        while (!iReady) @(posedge iClk);
        #1;
        iRdVld = 1'b0;
      end
      iRdData = 32'bx;
      //Crc Result
      `DELAY(delay, iClk)
      iRdVld  = 1'b1;
      iRdLast = 1'b1;
      //   iRdData = $random;
      iRdData = 16'h61f7 + 1;
      @(posedge iClk);
      while (!iReady) @(posedge iClk);
      #1;
      iRdVld  = 1'b0;
      iRdLast = 1'b0;
      iRdData = 32'bx;
      //Eop
      iRdEop  = 1'b1;
      `DELAY(1, iClk)
      iRdEop = 1'b0;
    end
  endtask

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iReady <= 1'b0;
    end else begin
      iReady <= $urandom;
    end
  end

endmodule
