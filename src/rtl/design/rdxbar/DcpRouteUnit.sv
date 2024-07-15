`include "define.v"
module DcpRouteUnit #(
  parameter DW  = 16,
  parameter AW  = 4,
  parameter RNUM = 4
) (
  input   logic           iClk,
  input   logic           iRst_n,
  // 注意，这里Decoupled的Width是由外部的interface决定的，所以本模块无法单独综合
  Decoupled.slave         iDcpIn,
  Decoupled.master        oDcpOut[0:RNUM-1]
);

  logic               swiInRdy;          
  logic               swiInVld;      
  logic   [DW-1:0]    swiInPld;
  logic   [AW-1:0]    swiInDst;

  logic   [RNUM-1:0]  swiOutVld;
  logic   [RNUM-1:0]  swiOutRdy;
  
  localparam IDLE  = 1'b0;
  localparam GRANT = 1'b1;

  gnrl_buf#(
    .DW(DW+AW),
    .CUT_RDY(1)
  ) U_INBUF(
    .clk_i      (iClk),
    .rst_n_i    (iRst_n),
    .din_i      ({iDcpIn.Dst[AW-1:0], iDcpIn.Pld}),
    .din_vld_i  (iDcpIn.Vld),
    .din_rdy_o  (iDcpIn.Rdy),
    .dout_o     ({swiInDst, swiInPld}),
    .dout_vld_o (swiInVld),
    .dout_rdy_i (swiInRdy)
  );

  genvar i;
  generate
    for(i=0; i<RNUM; i=i+1) begin : GEN_ROUTE
      always_comb begin
        //if(swiInVld && swiInDst == i) begin   // SHOULD INDEX FROM LSB!
        if(swiInVld && swiInDst[AW-1-:$clog2(RNUM)] == i) begin   // SHOULD INDEX FROM LSB!
          swiOutVld[i] = swiInVld;
        end else begin
          swiOutVld[i] = 1'b0;
        end
      end
    end
  endgenerate

  int j;
  always_comb begin
    if(swiInVld) begin
      for(j=0; j<RNUM; j=j+1) begin
        //if(swiInDst == j) begin
        if(swiInDst[AW-1-:$clog2(RNUM)] == j) begin  // SHOULD INDEX FROM LSB!
          swiInRdy = swiOutRdy[j];
        end
      end
    end else begin
      swiInRdy = 1'b0;
    end
  end

  generate
    for(i=0; i<RNUM; i=i+1) begin : GEN_OUTBUF
      gnrl_buf#(
        .DW(DW+AW),
        .CUT_RDY(1)
      ) U_OUTBUF(
        .clk_i      (iClk),
        .rst_n_i    (iRst_n),
        .din_i      ({swiInDst, swiInPld}),
        .din_vld_i  (swiOutVld[i]),
        .din_rdy_o  (swiOutRdy[i]),
        .dout_o     ({oDcpOut[i].Dst[AW-1:0], oDcpOut[i].Pld}),
        .dout_vld_o (oDcpOut[i].Vld),
        .dout_rdy_i (oDcpOut[i].Rdy)
      );
    end
  endgenerate
  
endmodule