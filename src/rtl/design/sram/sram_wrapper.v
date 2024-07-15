// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/sram_wrapper.v
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
module sram_wrapper #(
  parameter Bits = 32,
  parameter Word_Depth = 16384,
  parameter Add_Width = 14,
  parameter Wen_Width = 32
) (
  input  wire                 iClkA,
  input  wire                 iClkB,
  input  wire                 iRst_n,
  input  wire                 iCEnA,
  input  wire                 iCEnB,
  input  wire                 iWEnA,
  input  wire                 iWEnB,
  input  wire [Wen_Width-1:0] iBWEnA,
  input  wire [Wen_Width-1:0] iBWEnB,
  input  wire [Add_Width-1:0] iAddrA,
  input  wire [Add_Width-1:0] iAddrB,
  input  wire [     Bits-1:0] iWDataA,
  input  wire [     Bits-1:0] iWDataB,
  output wire [     Bits-1:0] oRDataA,
  output wire [     Bits-1:0] oRDataB
);

  sram16x16k U_sram16x16k_Lo (
    .iClkA  (iClkA),
    .iClkB  (iClkB),
    .iRst_n (iRst_n),
    .iCEnA  (iCEnA),
    .iCEnB  (iCEnB),
    .iWEnA  (iWEnA),
    .iWEnB  (iWEnB),
    .iBWEnA (iBWEnA[15:0]),
    .iBWEnB (iBWEnB[15:0]),
    .iAddrA (iAddrA),
    .iAddrB (iAddrB),
    .iWDataA(iWDataA[15:0]),
    .iWDataB(iWDataB[15:0]),
    .oRDataA(oRDataA[15:0]),
    .oRDataB(oRDataB[15:0])
  );

  sram16x16k U_sram16x16k_Hi (
    .iClkA  (iClkA),
    .iClkB  (iClkB),
    .iRst_n (iRst_n),
    .iCEnA  (iCEnA),
    .iCEnB  (iCEnB),
    .iWEnA  (iWEnA),
    .iWEnB  (iWEnB),
    .iBWEnA (iBWEnA[Bits-1:16]),
    .iBWEnB (iBWEnB[Bits-1:16]),
    .iAddrA (iAddrA),
    .iAddrB (iAddrB),
    .iWDataA(iWDataA[Bits-1:16]),
    .iWDataB(iWDataB[Bits-1:16]),
    .oRDataA(oRDataA[Bits-1:16]),
    .oRDataB(oRDataB[Bits-1:16])
  );
endmodule
