// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/sram/sram16x16k.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-03-29
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-18
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
module sram16x16k #(
  parameter Bits       = 16,
  parameter Word_Depth = 16384,
  parameter Add_Width  = 14,
  parameter Wen_Width  = 16
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
  wire [     3:0] cEnA;
  wire [     3:0] cEnB;
  wire [Bits-1:0] rDataA[3:0];
  wire [Bits-1:0] rDataB[3:0];
  reg  [     1:0] rSelA;
  reg  [     1:0] rSelB;


  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : gen_sram
`ifndef FPGA
      S55NLLGDPH_X512Y8D16_BW U_dpram16x4096 (
        .CLKA (iClkA),
        .CLKB (iClkB),
        .CENA (cEnA[i]),
        .CENB (cEnB[i]),
        .WENA (iWEnA),
        .WENB (iWEnB),
        .BWENA(iBWEnA),
        .BWENB(iBWEnB),
        .AA   (iAddrA[(Add_Width-2)-1:0]),
        .AB   (iAddrB[(Add_Width-2)-1:0]),
        .DA   (iWDataA),
        .DB   (iWDataB),
        .QA   (rDataA[i]),
        .QB   (rDataB[i])
      );
`else
`ifdef SDPRAM
      RAM_Simple_Dual_Port_Dual_Clock #(
        .WORD_WIDTH(Bits),
        .ADDR_WIDTH(Add_Width - 2),
        .DEPTH(Word_Depth >> 2),
        .RAMSTYLE(""),
        .USE_INIT_FILE(0),
        .INIT_FILE(""),
        .INIT_VALUE(0)
      ) U_dpram16x4096 (
        .write_clock(iClkA),
        .read_clock(iClkB),
        .wren(~iWEnA && ~cEnA[i]),
        .write_addr(iAddrA[(Add_Width-2)-1:0]),
        .write_data(iWDataA),
        .rden(iWEnB && ~cEnB[i]),
        .read_addr(iAddrB[(Add_Width-2)-1:0]),
        .read_data(rDataB[i])
      );
`else
      RAM_True_Dual_Port #(
        .WORD_WIDTH       (Bits),
        .ADDR_WIDTH       (Add_Width - 2),
        .DEPTH            (Word_Depth >> 2),
        .RAMSTYLE         (""),
        .READ_NEW_DATA    (0),
        .RW_ADDR_COLLISION(""),
        .USE_INIT_FILE    (0),
        .INIT_FILE        (""),
        .INIT_VALUE       (0)
      ) U_dpram16x4096 (
        .clock_A     (iClkA),
        .clock_B     (iClkB),
        .wren_A      (~iWEnA && ~cEnA[i]),
        .addr_A      (iAddrA[(Add_Width-2)-1:0]),
        .write_data_A(iWDataA),
        .read_data_A (rDataA[i]),
        .wren_B      (~iWEnB && ~cEnB[i]),
        .addr_B      (iAddrB[(Add_Width-2)-1:0]),
        .write_data_B(iWDataB),
        .read_data_B (rDataB[i])
      );
`endif
`endif
    end
    for (i = 0; i < 4; i = i + 1) begin : gen_cen
      assign cEnA[i] = iAddrA[Add_Width-1-:2] == i ? iCEnA : 1'b1;
      assign cEnB[i] = iAddrB[Add_Width-1-:2] == i ? iCEnB : 1'b1;
    end
  endgenerate

  always @(posedge iClkA or negedge iRst_n) begin
    if (!iRst_n) begin
      rSelA <= 2'b0;
    end else if (!(&cEnA) && iWEnA) begin
      rSelA <= iAddrA[Add_Width-1-:2];
    end
  end
  always @(posedge iClkB or negedge iRst_n) begin
    if (!iRst_n) begin
      rSelB <= 2'b0;
    end else if (!(&cEnB) && iWEnB) begin
      rSelB <= iAddrB[Add_Width-1-:2];
    end
  end

  assign oRDataA = rDataA[rSelA];
  assign oRDataB = rDataB[rSelB];

endmodule
