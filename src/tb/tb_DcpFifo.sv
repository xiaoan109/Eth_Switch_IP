module tb_DcpFifo;
reg clk;
reg rst_n;

Decoupled#(.DW(8), .AW(1)) iDcpIn();
Decoupled#(.DW(8), .AW(1)) oDcpOut();

DcpFifo #(
  .DATA_WIDTH(8),
  .DEPTH(8)
)DUT(
  .iRst_n (rst_n),
  .iClk (clk),

  .iDcpIn (iDcpIn),
  .oDcpOut (oDcpOut)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_DcpFifo.fsdb");
  $fsdbDumpvars(0, tb_DcpFifo);
end

initial begin
  #1 rst_n<=1'bx;clk<=1'bx;
  #(CLK_PERIOD*3) rst_n<=1;
  #(CLK_PERIOD*3) rst_n<=0;clk<=0;
  repeat(5) @(posedge clk);
  rst_n<=1;
  @(posedge clk);
  repeat(60) @(posedge clk);
  $finish(2);
end

initial begin
  iDcpIn.Vld = 0;
  iDcpIn.Pld = 0;
  repeat(20) @(posedge clk);
  forever begin
    iDcpIn.Vld = 1;
    wait(iDcpIn.Rdy);
    @(posedge clk);
    #1;
    iDcpIn.Pld = iDcpIn.Pld + 1;
  end
end

initial begin
  oDcpOut.Rdy = 0;
  repeat(40) @(posedge clk);
  forever begin
    repeat(2) @(posedge clk);
    #1;
    oDcpOut.Rdy = ~oDcpOut.Rdy;
  end
end

endmodule