module tb_DcpTag16x16;
reg clk;
reg rst_n;
  localparam TAG_WIDTH = `ADDR_LENTH+11;
  Decoupled#(.DW(TAG_WIDTH), .AW(4))  intTag[16]();
  Decoupled#(.DW(TAG_WIDTH), .AW(4))  tagCrsbarOut[16]();

  logic   intTagVld[16], intTagRdy[16];
  logic [3:0] intTagDst[16];

  logic   [2:0]                 rxTagPri[16];     // 优先级，决定去哪个queue
  logic   [3:0]                 rxTagSrcPort[16]; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   rxTagMsg[16];     // 包首地址+包长度，RD不需要对其做区分


  genvar j;

  generate
    for(j=0; j<16; j=j+1) begin
      assign tagCrsbarOut[j].Rdy = 1;
      assign intTag[j].Vld = intTagVld[j];
      assign intTagRdy[j] = intTag[j].Rdy;
      assign intTag[j].Dst = intTagDst[j];
      assign intTag[j].Pld = {rxTagPri[j], rxTagMsg[j], rxTagSrcPort[j]};  
    end
  endgenerate

  DcpTag16x16 U_TAG_CRSBAR(
    .iClk(clk),
    .iRst_n(rst_n),
    .iTagIn(intTag),
    .oTagOut(tagCrsbarOut)
  );
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_DcpTag16x16.fsdb");
  $fsdbDumpvars(0, tb_DcpTag16x16);
  $fsdbDumpMDA();
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

integer  m;
initial begin
  m=0;
  repeat(16) begin
    intTagVld[m] = 0;
    m=m+1;
  end
  repeat(20) @(posedge clk);
  SEND_TAG(0);
end


task SEND_TAG(
  input int idx
);
begin
  rxTagMsg[idx] = idx;
  rxTagPri[idx] = 0;
  rxTagSrcPort[idx] = idx;
  intTagDst[idx] = 0;
  intTagVld[idx] = 0;
  @(posedge clk);
  #1;
  repeat(16) begin
    intTagVld[idx] = 1;
    wait(intTagRdy[idx]);
    @(posedge clk);
    #1;
    intTagVld[idx] = 0;
    @(posedge clk);
    #1;
    rxTagMsg[idx] = rxTagMsg[idx]+1;
    rxTagPri[idx] = rxTagPri[idx]+1;
    intTagDst[idx]   = intTagDst[idx] + 1;
    @(posedge clk);
    #1;
  end
end

endtask
endmodule
