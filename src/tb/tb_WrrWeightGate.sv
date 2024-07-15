
module tb_WrrWeightGate;
reg clk;
reg rst_n;

parameter ARB_NUM = 4;

logic [ARB_NUM-1:0]  iReq, oGnt, oReq, iGnt;
logic [3:0] iWeight[ARB_NUM];
logic iWeightLoad;

WrrWeightGate #(
  .ARB_NUM(ARB_NUM)
) DUT(
  .iRst_n (rst_n),
  .iClk (clk),
  .iReq (iReq),
  .oGnt (oGnt),
  .oReq (oReq),
  .iGnt (iGnt),
  .iWeightLoad (iWeightLoad),
  .iWeight (iWeight)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_WrrWeightGate.fsdb");
  $fsdbDumpvars(0, tb_WrrWeightGate);
  $fsdbDumpMDA();
end

initial begin
  #1 rst_n<=1'bx;clk<=1'bx;
  #(CLK_PERIOD*3) rst_n<=1;
  #(CLK_PERIOD*3) rst_n<=0;clk<=0;
  repeat(5) @(posedge clk);
  rst_n<=1;
  @(posedge clk);
  repeat(2) @(posedge clk);
  iWeightLoad = 0;
  iWeight[0] = 4;
  iWeight[1] = 3;
  iWeight[2] = 2;
  iWeight[3] = 1;
  @(posedge clk);
  #1;
  iWeightLoad = 1;
  @(posedge clk);
  #1;
  iWeightLoad = 0;

  repeat(200) @(posedge clk);
  $finish(2);
end

initial begin
  iReq[0] = 0;
  wait(iWeightLoad);
  repeat(3) @(posedge clk);
  #1;
  repeat(6) begin
    iReq[0] = 1;
    wait(oGnt[0]);
    @(posedge clk);
    #1;
  end
  iReq[0] = 0;
end

initial begin
  iReq[1] = 0;
  wait(iWeightLoad);
  repeat(3) @(posedge clk);
  #1;
  repeat(6) begin
    iReq[1] = 1;
    wait(oGnt[1]);
    @(posedge clk);
    #1;
  end
  iReq[1] = 0;
end

initial begin
  iReq[2] = 0;
  wait(iWeightLoad);
  repeat(3) @(posedge clk);
  #1;
  repeat(6) begin
    iReq[2] = 1;
    wait(oGnt[2]);
    @(posedge clk);
    #1;
  end
  iReq[2] = 0;
end

initial begin
  iReq[3] = 0;
  wait(iWeightLoad);
  repeat(3) @(posedge clk);
  #1;
  repeat(6) begin
    iReq[3] = 1;
    wait(oGnt[3]);
    @(posedge clk);
    #1;
  end
  iReq[3] = 0;
end

initial begin
  iGnt = 4'b1111;
end

endmodule