// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/bus_model/slave_model.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-11
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-14
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
module slave_model #(
  parameter CMD_W = 1,
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4,
  parameter MEM_SIZE = 4096
) (
  input  wire             iClk,
  input  wire             iRst_n,
  input  wire             iSlvReq,
  input  wire [CMD_W-1:0] iSlvCmd,    // 0: wr, 1:rd, TODO
  input  wire [   AW-1:0] iSlvAddr,
  input  wire [   SW-1:0] iSlvSel,
  input  wire [   DW-1:0] iSlvWData,
  output wire             oSlvAck,
  output reg  [   DW-1:0] oSlvRData
);
  reg [DW-1:0] mem[MEM_SIZE-1:0];
  reg [31:0] del_ack;
  reg [5:0] delay;
  wire mem_re;
  wire mem_we;
  wire [DW-1:0] tmp;
  reg [DW-1:0] tmp2;
  integer i;

  initial begin
    delay = 0;
    #2;
    $display("\nINFO: SLAVE MEMORY MODEL INSTANTIATED (%m)\n");
  end

  assign mem_re = iSlvReq && iSlvCmd;
  assign mem_we = iSlvReq && !iSlvCmd;
  assign tmp = mem[iSlvAddr[AW-1:2]];

  always @(*) begin
    if (mem_re && oSlvAck) begin
      for (i = 0; i < 4; i = i + 1) begin
        oSlvRData[i*8+:8] = iSlvSel[i] ? tmp[i*8+:8] : 8'hxx;
      end
    end else begin
      oSlvRData = {DW{1'bz}};
    end
  end

  always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
      tmp2[i*8+:8] = !iSlvSel[i] ? tmp[i*8+:8] : iSlvWData[i*8+:8];
    end
  end

  always @(posedge iClk) begin
    if (mem_we) mem[iSlvAddr[AW-1:2]] <= tmp2;
  end

  always @(posedge iClk) begin
    del_ack = oSlvAck ? 0 : {del_ack[30:0], (mem_re | mem_we)};
  end

  assign oSlvAck = iSlvReq & ((delay == 0) ? (mem_re | mem_we) : del_ack[delay-1]);

  task fill_mem;
    input mode;
    integer n, mode;
    begin
      for (n = 0; n < (MEM_SIZE); n = n + 1) begin
        case (mode)
          0: mem[n] = {~n[15:0], n[15:0]};
          1: mem[n] = $random;
        endcase
      end
    end
  endtask

endmodule
