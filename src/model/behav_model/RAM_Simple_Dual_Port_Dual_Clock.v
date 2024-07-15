// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/behav_model/RAM_Simple_Dual_Port_Dual_Clock.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-02
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-09
// Version        :
// Description    : http://fpgacpu.ca/fpga/RAM_Simple_Dual_Port_Dual_Clock.html
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
`default_nettype none

module RAM_Simple_Dual_Port_Dual_Clock #(
  parameter                  WORD_WIDTH    = 8,
  parameter                  ADDR_WIDTH    = 8,
  parameter                  DEPTH         = 256,
  // Used as an attribute, not a value
  // verilator lint_off UNUSED
  parameter                  RAMSTYLE      = "",
  // verilator lint_on  UNUSED
  parameter                  USE_INIT_FILE = 0,
  parameter                  INIT_FILE     = "",
  parameter [WORD_WIDTH-1:0] INIT_VALUE    = 0
) (
  input  wire                  write_clock,
  input  wire                  wren,
  input  wire [ADDR_WIDTH-1:0] write_addr,
  input  wire [WORD_WIDTH-1:0] write_data,
  input  wire                  read_clock,
  input  wire                  rden,
  input  wire [ADDR_WIDTH-1:0] read_addr,
  output reg  [WORD_WIDTH-1:0] read_data
);

  initial begin
    read_data = {WORD_WIDTH{1'b0}};
  end
  (* ramstyle  = RAMSTYLE *)
  // Quartus
  (* ram_style = RAMSTYLE *)
  // Vivado
  (* rw_addr_collision = "no" *)
  // Vivado
  reg [WORD_WIDTH-1:0] mem_array[DEPTH-1:0];
  always @(posedge write_clock) begin
    if (wren == 1'b1) begin
      mem_array[write_addr] <= write_data;
    end
  end

  always @(posedge read_clock) begin
    if (rden == 1'b1) begin
      read_data <= mem_array[read_addr];
    end
  end
  generate
    if (USE_INIT_FILE == 0) begin
      integer i;
      initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
          mem_array[i] = INIT_VALUE;
        end
      end
    end else begin
      initial begin
        $readmemh(INIT_FILE, mem_array);
      end
    end
  endgenerate

endmodule
