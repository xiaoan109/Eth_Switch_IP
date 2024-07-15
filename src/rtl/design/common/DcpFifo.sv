module DcpFifo #(
  /// FIFO is in fall-through mode
  parameter bit          FALL_THROUGH = 1'b0,
  /// Default data width if the fifo is of type logic
  parameter int unsigned DATA_WIDTH   = 32,
  /// Depth can be arbitrary from 0 to 2**32
  parameter int unsigned DEPTH        = 8,
    // DO NOT OVERWRITE THIS PARAMETER
  parameter int unsigned ADDR_DEPTH  = (DEPTH > 1) ? $clog2(DEPTH) : 1

) (
  input   logic                     iClk,
  input   logic                     iRst_n,

  Decoupled.slave                   iDcpIn,
  Decoupled.master                  oDcpOut,
  output  logic   [ADDR_DEPTH  :0]  oUsage,
  input   logic                     iTestmode,
  input   logic                     iFlush
);
  localparam type  T = logic [DATA_WIDTH-1:0];
  
  Decoupled#(.DW(DATA_WIDTH), .AW(1)) fifoOut();

    logic push, pop;
    logic empty, full;
    logic [ADDR_DEPTH-1:0] usage;

    assign push    = iDcpIn.Vld & ~full;
    assign pop     = fifoOut.Rdy & ~empty;
    assign iDcpIn.Rdy = ~full;
    assign fifoOut.Vld = ~empty;

    fifo_v3 #(
        .FALL_THROUGH   (FALL_THROUGH),
        .DATA_WIDTH     (DATA_WIDTH),
        .DEPTH          (DEPTH),
        .dtype(T)
    ) U_FIFO (
        .clk_i        (iClk),
        .rst_ni       (iRst_n),
        .flush_i      (iFlush),
        .testmode_i   (iTestmode),
        .full_o       (full),
        .empty_o      (empty),
        .usage_o      (usage),
        .data_i       (iDcpIn.Pld),
        .push_i       (push),
        .data_o       (fifoOut.Pld),
        .pop_i        (pop)
    );
  
  gnrl_buf#(
    .DW(DATA_WIDTH),
    .CUT_RDY(1)
  ) U_OUTBUF(
    .clk_i      (iClk),
    .rst_n_i    (iRst_n),
    .din_i      (fifoOut.Pld),
    .din_vld_i  (fifoOut.Vld),
    .din_rdy_o  (fifoOut.Rdy),
    .dout_o     (oDcpOut.Pld),
    .dout_vld_o (oDcpOut.Vld),
    .dout_rdy_i (oDcpOut.Rdy)
  );

  assign oUsage = (full ? {1'b1, usage} : usage) + oDcpOut.Vld + U_OUTBUF.din_vld;

endmodule