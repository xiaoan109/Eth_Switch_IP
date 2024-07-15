module tb_DcpSwitchUnit;
reg clk;
reg rst_n;
localparam ARB = 4;
localparam DW = 8;
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

Decoupled#(DW) iDcpIn[ARB]();
Decoupled#(DW) oDcpOut();

initial begin
  $fsdbDumpfile("tb_DcpSwitchUnit.fsdb");
  $fsdbDumpvars(0, tb_DcpSwitchUnit);
end

initial begin
  #1 rst_n<=1'bx;clk<=1'bx;
  #(CLK_PERIOD*3) rst_n<=1;
  #(CLK_PERIOD*3) rst_n<=0;clk<=0;

  iDcpIn[0].Vld<=1'b0;
  iDcpIn[1].Vld<=1'b0;
  iDcpIn[2].Vld<=1'b0;
  iDcpIn[3].Vld<=1'b0;

  repeat(5) @(posedge clk);
  

  rst_n<=1;
  @(posedge clk);
  repeat(200) @(posedge clk);
  $finish(2);
end

DcpSwitchUnit#(
  .DW (DW),
  .SNUM (ARB)
)DUT(
  .iClk   (clk),
  .iRst_n (rst_n),

  .iDcpIn  (iDcpIn),   

  .oDcpOut  (oDcpOut)
);

initial fork
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  WriteDecoupled(iDcpIn[1], clk);
join
initial fork
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  WriteDecoupled(iDcpIn[2], clk);
join
initial fork
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  WriteDecoupled(iDcpIn[3], clk);
join
initial fork
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  WriteDecoupled(iDcpIn[0], clk);
join


initial begin
  wait(!rst_n);
  wait(rst_n);
  repeat(40) @(posedge clk);
  WriteDecoupled(iDcpIn[0], clk);
  WriteDecoupled(iDcpIn[1], clk);
  WriteDecoupled(iDcpIn[2], clk);
  WriteDecoupled(iDcpIn[3], clk);

  repeat(10) @(posedge clk)
  $finish();


end

initial begin
  repeat(8) begin
    ReadDecoupled(oDcpOut, clk);
  end
  
end

endmodule