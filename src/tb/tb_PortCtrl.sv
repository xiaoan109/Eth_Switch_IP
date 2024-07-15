`include "define.v"
module tb_PortCtrl;
reg clk;
reg rst_n;

Decoupled#(.DW(`ADDR_LENTH+8), .AW(0)) iTagQueueIn();
Decoupled#(.DW(`ADDR_LENTH+8), .AW(0)) iTagDropIn();
Decoupled#(.DW(`ADDR_LENTH+5), .AW(4)) oRdCmd();
Decoupled#(.DW(`DATA_WIDTH+1), .AW(4)) iRdData();
logic iRdRdy;

  logic   [3:0]                 qSrcPort; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   qMsg;     // 包首地址+包长度，RD不需要对其做区分

  logic   [3:0]                 dSrcPort; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   dMsg;     // 包首地址+包长度，RD不需要对其做区分

  logic [`DATA_WIDTH-1:0]  rdData;
  logic                    rdLast;

  assign iTagQueueIn.Pld = {qMsg, qSrcPort};
  assign iTagDropIn.Pld = {dMsg, dSrcPort};
  assign iRdData.Pld = {rdData, rdLast};

PortCtrl  DUT
(
  .iRst_n (rst_n),
  .iClk (clk),

  .iTagQueueIn(iTagQueueIn),
  .iTagDropIn(iTagDropIn),        
  .oRdCmd(oRdCmd),
  .iRdData(iRdData)  ,
  .oRdSop(),
  .oRdEop(),
  .oRdVld(),
  .oRdData(),
  .iRdRdy (iRdRdy),
  .oRdLast()
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_PortCtrl.fsdb");
  $fsdbDumpvars(0, tb_PortCtrl);
end

initial begin
  #1 rst_n<=1'bx;clk<=1'bx;
  #(CLK_PERIOD*3) rst_n<=1;
  #(CLK_PERIOD*3) rst_n<=0;clk<=0;
  repeat(5) @(posedge clk);
  rst_n<=1;
  @(posedge clk);
  repeat(300) @(posedge clk);
  $finish(2);
end

int i;
initial begin
  oRdCmd.Rdy = 1;
  iTagQueueIn.Vld = 0;
  iTagDropIn.Vld = 0;

  repeat(20) @(posedge clk);
  
  iTagQueueIn.Vld = 1;
  qSrcPort = 3;
  qMsg = 4;
  wait(iTagQueueIn.Rdy);
  @(posedge clk);
  #1;
  iTagQueueIn.Vld = 0;
  repeat(10) @(posedge clk);

  iTagQueueIn.Vld = 1;
  qSrcPort = 2;
  qMsg = 3;
  wait(iTagQueueIn.Rdy);
  @(posedge clk);
  #1;
  iTagQueueIn.Vld = 0;
  repeat(10) @(posedge clk);

  iTagDropIn.Vld = 1;
  dSrcPort = 8;
  dMsg = 9;
  wait(iTagDropIn.Rdy);
  @(posedge clk);
  #1;
  iTagDropIn.Vld = 0;
  repeat(10) @(posedge clk);
  $finish(2);

end

initial begin
  iRdRdy = 0;
  forever begin
    repeat({$random()}%10) @(posedge clk);
    #1;
    iRdRdy = ~iRdRdy;
  end
end

initial begin
  rdData = 0;
  rdLast = 0;
  iRdData.Vld = 0;
  repeat(20) @(posedge clk);
  forever begin
    repeat(8) begin
      iRdData.Vld = 1;
      wait(iRdData.Rdy);
      @(posedge clk);
      #1;
      rdData = rdData + 1;
    end
    rdLast = 1;
    wait(iRdData.Rdy);
    @(posedge clk);
    #1;
    iRdData.Vld = 0;
    rdLast = 0;
    repeat(5) @(posedge clk);
  end
end

endmodule
