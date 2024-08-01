// +FHEADER =====================================================================
// FilePath       : /Switch/src/model/bus_model/slave_mem_model.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-17
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-04-18
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
module slave_mem_model #(
  parameter AW = 12,
  parameter DW = 32,
  parameter SW = 4,
  parameter MEM_SIZE = 4096
) (
  input  wire          iClk,
  input  wire          iRst_n,
  // Wr  Ports
  input  wire          iSlvWrReq,
  input  wire          iSlvWrValid,
  input  wire [AW-1:0] iSlvWrAddr,
  input  wire [SW-1:0] iSlvWrSel,
  input  wire [DW-1:0] iSlvWrData,
  output wire          oSlvWrReady,
  // Rd Ports
  input  wire          iSlvRdReq,
  input  wire          iSlvRdValid,
  input  wire [AW-1:0] iSlvRdAddr,
  input  wire [SW-1:0] iSlvRdSel,
  output wire          oSlvRdReady,
  output reg  [DW-1:0] oSlvRdData
);
  reg [DW-1:0] mem[MEM_SIZE-1:0];
  // reg [31:0] del_rready;
  // reg [31:0] del_wready;
  reg [5:0] delay;
  wire mem_re;
  wire mem_we;
  wire [DW-1:0] tmp;
  wire [DW-1:0] tmp1;
  reg [DW-1:0] tmp2;
  integer i;

  initial begin
    delay = 0;
    #2;
    $display("\nINFO: SLAVE MEMORY MODEL INSTANTIATED (%m)\n");
  end

  assign mem_re = iSlvRdReq && iSlvRdValid;
  assign mem_we = iSlvWrReq && iSlvWrValid;

  assign tmp = mem[iSlvRdAddr[AW-1:2]];
  assign tmp1 = mem[iSlvWrAddr[AW-1:2]];

  always @(posedge iClk) begin
    if (mem_re) begin
      for (i = 0; i < 4; i = i + 1) begin
        oSlvRdData[i*8+:8] = iSlvRdSel[i] ? tmp[i*8+:8] : 8'hxx;
      end
    end else begin
      oSlvRdData = {DW{1'bz}};
    end
  end

  always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
      tmp2[i*8+:8] = !iSlvWrSel[i] ? tmp1[i*8+:8] : iSlvWrData[i*8+:8];
    end
  end

  always @(posedge iClk) begin
    if (mem_we) mem[iSlvWrAddr[AW-1:2]] <= tmp2;
  end

  // always @(posedge iClk) begin
  //   del_rready = oSlvRdReady ? 0 : {del_rready[30:0], mem_re};
  // end

  // always @(posedge iClk) begin
  //   del_wready = oSlvWrReady ? 0 : {del_wready[30:0], mem_we};
  // end

  // assign oSlvRdReady = iSlvRdReq & ((delay == 0) ? mem_re : del_rready[delay-1]);
  // assign oSlvWrReady = iSlvWrReq & ((delay == 0) ? mem_we : del_wready[delay-1]);
  assign oSlvRdReady = 1'b1;
  assign oSlvWrReady = 1'b1;
  
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
