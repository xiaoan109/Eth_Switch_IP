`include "define.v"
module tb_TagRx;
reg clk;
reg rst_n;

Decoupled#(.DW(`ADDR_LENTH+8), .AW(0)) oTagQueueOut[8]();
Decoupled#(.DW(`ADDR_LENTH+8), .AW(0)) oTagDropOut();
Decoupled#(.DW(`ADDR_LENTH+11), .AW(4)) iTagIn();

  logic   [2:0]                 rxTagPri;     // 优先级，决定去哪个queue
  logic   [3:0]                 rxTagSrcPort; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   rxTagMsg;     // 包首地址+包长度，RD不需要对其做区分

  assign iTagIn.Pld = {rxTagPri, rxTagMsg, rxTagSrcPort};  

TagRx DUT
(
  .iRst_n (rst_n),
  .iClk (clk),

  .iTagIn(iTagIn),
  .oTagQueueOut(oTagQueueOut),
  .oTagDropOut(oTagDropOut)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_TagRx.fsdb");
  $fsdbDumpvars(0, tb_TagRx);
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

initial begin
  oTagQueueOut[0].Rdy = 0;
  oTagQueueOut[1].Rdy = 1;
  oTagQueueOut[2].Rdy = 0;
  oTagQueueOut[3].Rdy = 1;
  oTagQueueOut[4].Rdy = 0;
  oTagQueueOut[5].Rdy = 1;
  oTagQueueOut[6].Rdy = 0;
  oTagQueueOut[7].Rdy = 1;
  oTagDropOut.Rdy = 1;
end

int i;
  initial begin
    i = 0;
    iTagIn.Vld = 0;
    rxTagMsg = 0;
    repeat(30) @(posedge clk);
    repeat(8) begin
      rxTagSrcPort = i;
      rxTagPri = i;
      @(posedge clk);
      #1;
      iTagIn.Vld = 1;
      wait(iTagIn.Rdy);
      @(posedge clk);
      #1;
      iTagIn.Vld = 0;
      @(posedge clk);
      #1;
      i=i+1;
    end
    repeat(10) @(posedge clk);
    $finish(2);
  end
endmodule