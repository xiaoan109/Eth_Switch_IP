module tb_DcpRouteUnit;
reg clk;
reg rst_n;
localparam ARB = 4;
localparam DW = 8;
localparam AW = 4;
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

Decoupled#(.DW(DW), .AW(AW)) iDcpIn();
Decoupled#(.DW(DW), .AW(AW)) oDcpOut[ARB]();

initial begin
  $fsdbDumpfile("tb_DcpRouteUnit.fsdb");
  $fsdbDumpvars(0, tb_DcpRouteUnit);
end

initial begin
  #1 rst_n<=1'bx;clk<=1'bx;
  #(CLK_PERIOD*3) rst_n<=1;
  #(CLK_PERIOD*3) rst_n<=0;clk<=0;
  repeat(5) @(posedge clk);
  

  rst_n<=1;
  @(posedge clk);
  repeat(200) @(posedge clk);
  $finish(2);
end

DcpRouteUnit#(
  .DW (DW),
  .AW (4),
  .RNUM (4)
)DUT(
  .iClk   (clk),
  .iRst_n (rst_n),

  .iDcpIn  (iDcpIn),   

  .oDcpOut  (oDcpOut[3:0])
);

reg [1:0] dst;

initial begin
  iDcpIn.Pld = 0;
  iDcpIn.Dst = 0;
  dst = 0;
  iDcpIn.Vld = 0;
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  
  repeat(16) begin
    iDcpIn.Vld = 1;
    iDcpIn.Pld = dst;
    iDcpIn.Dst = dst;
    wait(iDcpIn.Rdy);
    @(posedge clk);
    #1;
    dst=dst+1;
  end
  iDcpIn.Vld = 0;
  repeat(10) @(posedge clk);
  $finish();
end


initial begin
  oDcpOut[0].Rdy = 0;
  while(1) begin
    repeat(1) @(posedge clk);
    #1;
    oDcpOut[0].Rdy = 1;
  end
end

initial begin
  oDcpOut[1].Rdy = 0;
  while(1) begin
    repeat(2) @(posedge clk);
    #1;
    oDcpOut[1].Rdy = !oDcpOut[1].Rdy;
  end
end

initial begin
  oDcpOut[2].Rdy = 0;
  while(1) begin
    repeat(5) @(posedge clk);
    #1;
    oDcpOut[2].Rdy = !oDcpOut[2].Rdy;
  end
end

initial begin
  oDcpOut[3].Rdy = 0;
  while(1) begin
    repeat(10) @(posedge clk);
    #1;
    oDcpOut[3].Rdy = !oDcpOut[3].Rdy;
  end
end
// initial begin
//   repeat(8) begin
//     ReadDecoupled(oDcpOut, clk);
//   end
  
// end

endmodule