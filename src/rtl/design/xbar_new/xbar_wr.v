// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/xbar_new/xbar_wr.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-05-07
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-08
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
module xbar_wr #(
  // Number of inputs
  parameter S_COUNT = 4,
  // Number of outputs
  parameter M_COUNT = 4,
  // Width of data in bits
  parameter DATA_WIDTH = 8,
  // keep signal enable
  parameter KEEP_ENABLE = (DATA_WIDTH > 8),
  // kepp signal width (words per cycle)
  parameter KEEP_WIDTH = ((DATA_WIDTH + 7) / 8),
  // Width of address in bit
  parameter ADDR_WIDTH = 8,
  // select round robin arbitration
  parameter ARB_TYPE_ROUND_ROBIN = 1,
  // LSB priority selection
  parameter ARB_LSB_HIGH_PRIORITY = 1
) (
  input  wire                          iClk,
  input  wire                          iRst_n,
  input  wire [S_COUNT*DATA_WIDTH-1:0] iSlvWrData,
  input  wire [S_COUNT*ADDR_WIDTH-1:0] iSlvWrAddr,
  input  wire [S_COUNT*KEEP_WIDTH-1:0] iSlvWrKeep,
  input  wire [           S_COUNT-1:0] iSlvWrValid,
  output wire [           S_COUNT-1:0] oSlvWrReady,
  input  wire [           S_COUNT-1:0] iSlvWrLast,
  input  wire [S_COUNT*DATA_WIDTH-1:0] iSlvRdData,
  input  wire [S_COUNT*ADDR_WIDTH-1:0] iSlvRdAddr,
  input  wire [S_COUNT*KEEP_WIDTH-1:0] iSlvRdKeep,
  input  wire [           S_COUNT-1:0] iSlvRdValid,
  output wire [           S_COUNT-1:0] oSlvRdReady,
  input  wire [           S_COUNT-1:0] iSlvRdLast

);

endmodule
