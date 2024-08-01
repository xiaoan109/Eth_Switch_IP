// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_Crc.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-15
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
//  23-08-24 |     CICC2060    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module tb_Crc;

  // Parameters

  //Ports
  reg [31:0] iData;
  reg iCrcEn;
  wire [15:0] oCrc;
  reg iRst_n;
  reg iClk;

  initial begin
    $fsdbDumpfile("tb_Crc.fsdb");
    $fsdbDumpvars("+all");
  end

  Crc Crc_inst (
    .iData (iData),
    .iCrcEn(iCrcEn),
    .oCrc  (oCrc),
    .iRst_n(iRst_n),
    .iClk  (iClk)
  );

  always #5 iClk = !iClk;

  initial begin
    iClk   = 1'b0;
    iRst_n = 1'b0;
    iCrcEn = 1'b0;
    iData  = 32'b0;
    repeat (10) @(posedge iClk) #1;
    iRst_n = 1'b1;
    repeat (10) @(posedge iClk) #1;
    repeat (16) begin
      iCrcEn = $random;
      iData = iCrcEn ? $random : iData;
      @(posedge iClk) #1;
    end
    iCrcEn = 1'b0;


    #1000 $finish;
  end

endmodule
