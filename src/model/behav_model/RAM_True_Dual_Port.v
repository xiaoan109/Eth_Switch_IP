// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/behav_model/RAM_True_Dual_Port.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-01
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-09
// Version        :
// Description    : http://fpgacpu.ca/fpga/RAM_True_Dual_Port.html
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

module RAM_True_Dual_Port #(
  parameter                  WORD_WIDTH        = 8,
  parameter                  ADDR_WIDTH        = 8,
  parameter                  DEPTH             = 256,
  parameter                  RAMSTYLE          = "",
  parameter                  READ_NEW_DATA     = 0, // Write Forwarding
  parameter                  RW_ADDR_COLLISION = "",
  parameter                  USE_INIT_FILE     = 0,
  parameter                  INIT_FILE         = "",
  parameter [WORD_WIDTH-1:0] INIT_VALUE        = 0
) (
  input  wire                  clock_A,
  input  wire                  clock_B,
  input  wire                  wren_A,
  input  wire [ADDR_WIDTH-1:0] addr_A,
  input  wire [WORD_WIDTH-1:0] write_data_A,
  output reg  [WORD_WIDTH-1:0] read_data_A,
  input  wire                  wren_B,
  input  wire [ADDR_WIDTH-1:0] addr_B,
  input  wire [WORD_WIDTH-1:0] write_data_B,
  output reg  [WORD_WIDTH-1:0] read_data_B
);
  localparam ZERO = {WORD_WIDTH{1'b0}};

  initial begin
    read_data_A = ZERO;
    read_data_B = ZERO;
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
      always @(posedge clock_A) begin
        if (wren_A == 1'b1) begin
          mem_array[addr_A] <= write_data_A;
        end
        read_data_A <= mem_array[addr_A];
      end

      always @(posedge clock_B) begin
        if (wren_B == 1'b1) begin
          mem_array[addr_B] <= write_data_B;
        end
        read_data_B <= mem_array[addr_B];
      end
    end
      // Returns NEW data
      // This isn't proper, but the CAD tool expects it for inference.
      // verilator lint_off BLKSEQ
      else begin
      always @(posedge clock_A) begin
        if (wren_A == 1'b1) begin
          mem_array[addr_A] = write_data_A;
        end
        read_data_A = mem_array[addr_A];
      end

      always @(posedge clock_B) begin
        if (wren_B == 1'b1) begin
          mem_array[addr_B] = write_data_B;
        end
        read_data_B = mem_array[addr_B];
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
