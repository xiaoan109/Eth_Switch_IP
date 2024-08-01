// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/behav_model/RAM_Single_Port.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-02
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-09
// Version        :
// Description    : http://fpgacpu.ca/fpga/RAM_Single_Port.html
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
//  23-08-24 |         |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
`default_nettype none

module RAM_Single_Port #(
  parameter                  WORD_WIDTH        = 8,
  parameter                  ADDR_WIDTH        = 8,
  parameter                  DEPTH             = 256,
  parameter                  RAMSTYLE          = "",
  parameter                  READ_NEW_DATA     = 0,
  parameter                  RW_ADDR_COLLISION = "",
  parameter                  USE_INIT_FILE     = 0,
  parameter                  INIT_FILE         = "",
  parameter [WORD_WIDTH-1:0] INIT_VALUE        = 0
) (
  input  wire                  clock,
  input  wire                  wren,
  input  wire [ADDR_WIDTH-1:0] addr,
  input  wire [WORD_WIDTH-1:0] write_data,
  output reg  [WORD_WIDTH-1:0] read_data
);

  initial begin
    read_data = {WORD_WIDTH{1'b0}};
  end
  (* ramstyle             = RAMSTYLE *)
  // Quartus
  (* ram_style            = RAMSTYLE *)
  // Vivado
  (* rw_addr_collision    = RW_ADDR_COLLISION *)
  // Vivado

  reg [WORD_WIDTH-1:0] mem_array[DEPTH-1:0];

  generate
    // Returns OLD data
    if (READ_NEW_DATA == 0) begin
      always @(posedge clock) begin
        if (wren == 1'b1) begin
          mem_array[addr] <= write_data;
        end
        read_data <= mem_array[addr];
      end
    end 
      // Returns NEW data
      // This isn't proper, but the CAD tool expects it for inference.
      // verilator lint_off BLKSEQ
      else begin
      always @(posedge clock) begin
        if (wren == 1'b1) begin
          mem_array[addr] = write_data;
        end
        read_data = mem_array[addr];
      end
    end
    // verilator lint_on BLKSEQ
  endgenerate

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
