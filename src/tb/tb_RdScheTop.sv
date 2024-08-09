module tb_RdScheTop;
reg clk;
reg rst_n;

  parameter PRI_DEPTH = 8;            // 优先级队列深度
  parameter WRR_WEIGHT_NUM = 8;      // WRR最大权重数
  // DO NOT OVERWRITE
  parameter PRI_NUM = 8;

  localparam TAG_WIDTH = `ADDR_LENTH+11;
  localparam RDCMD_WIDTH = `ADDR_LENTH+9;
  localparam RDDATA_WIDTH = `DATA_WIDTH+1;


  Decoupled#(.DW(TAG_WIDTH), .AW(4))    intTag[16]();
  Decoupled#(.DW(RDCMD_WIDTH), .AW(4))  intRdCmd[16]();
  Decoupled#(.DW(RDDATA_WIDTH), .AW(4)) intRdData[16]();
  wire                             oRdSop[16];
  wire                             oRdEop[16];
  wire                             oRdVld[16];
  wire [`DATA_WIDTH-1:0]           oRdData[16];
  wire                             oRdRdy[16];
  wire                             oRdLast[16];

  logic [$clog2(WRR_WEIGHT_NUM):0]  weightPld[8];
  logic [3:0]                       iWeightIdx;
  logic                             iWeightLoad;  

  logic [3:0] intTagDst[16], intRdCmdDst[16], intRdDataDst[16];
  logic   intTagVld[16], intTagRdy[16], intRdCmdVld[16], intRdCmdRdy[16], intRdDataVld[16], intRdDataRdy[16];


  

  assign weightPld[0] = 8;
  assign weightPld[1] = 8;
  assign weightPld[2] = 8;
  assign weightPld[3] = 8;
  assign weightPld[4] = 8;
  assign weightPld[5] = 8;
  assign weightPld[6] = 8;
  assign weightPld[7] = 8;

  logic   [2:0]                 rxTagPri[16];     // 优先级，决定去哪个queue
  logic   [3:0]                 rxTagSrcPort[16]; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   rxTagMsg[16];     // 包首地址+包长度，RD不需要对其做区分

  logic   [3:0]               rdCmdDstPort[16];   // dst port for rddata, which is the PORT_ADDR of this port
  logic   [`ADDR_LENTH+4-1:0] rdCmdMsg[16];
  logic                       rdCmdDrop[16];

  logic [`DATA_WIDTH-1:0]  rdData[16];
  logic                    rdLast[16];

  genvar j;
  generate
    for(j=0; j<16; j=j+1) begin
      assign intTag[j].Pld = {rxTagPri[j], rxTagMsg[j], rxTagSrcPort[j]};  
      assign {rdCmdMsg[j], rdCmdDstPort[j], rdCmdDrop[j]} = intRdCmd[j].Pld;
      assign intRdData[j].Pld = {rdData[j], rdLast[j]};

      assign intTag[j].Vld = intTagVld[j];
      assign intTagRdy[j] = intTag[j].Rdy;

      assign intRdCmdVld[j] = intRdCmd[j].Vld;
      assign intRdCmd[j].Rdy = intRdCmdRdy[j];

      assign intRdData[j].Vld = intRdDataVld[j];
      assign intRdDataRdy[j] = intRdData[j].Rdy;
      assign intTag[j].Dst = intTagDst[j];
      assign intRdCmdDst[j] = intRdCmd[j].Dst; 

      assign oRdRdy[j] = 1;
      //assign 
    end
  endgenerate 



RdScheTop DUT
(
  .iRst_n (rst_n),
  .iClk (clk),

  .iTagIn     (intTag),
  .iRdDataIn  (intRdData),
  .oRdCmdOut  (intRdCmd),

  .oRdSop     (oRdSop ),
  .oRdEop     (oRdEop ),
  .oRdVld     (oRdVld ),
  .oRdData    (oRdData),
  .iRdRdy     (oRdRdy ),
  .oRdLast    (oRdLast),

  .iWeightPld (weightPld),
  .iWeightIdx (iWeightIdx),
  .iWeightLoad(iWeightLoad)  
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_RdScheTop.fsdb");
  $fsdbDumpvars(0, tb_RdScheTop);
  $fsdbDumpMDA();
end


initial begin
  iWeightIdx = 0;
  iWeightLoad = 0;
  #1 rst_n<=1'bx;clk<=1'bx;
  #(CLK_PERIOD*3) rst_n<=1;
  #(CLK_PERIOD*3) rst_n<=0;clk<=0;
  repeat(5) @(posedge clk);
  rst_n<=1;
  @(posedge clk);
  #1;
  repeat(8) begin
    iWeightLoad = 1;
    @(posedge clk);
    #1;
    iWeightLoad = 0;
    iWeightIdx = iWeightIdx + 1;
    @(posedge clk);
    #1;
  end

  repeat(2000) @(posedge clk);
  $finish(2);
end

int testedTagPort;

initial begin
  testedTagPort = 6;
end

integer  m;
initial begin
  m=0;
  repeat(16) begin
    intTagVld[m] = 0;
    m=m+1;
  end
  repeat(20) @(posedge clk);
  SEND_TAG(testedTagPort);
end

integer  i;
initial begin
  i = 0;
  repeat(16) begin
    intRdDataVld[i] = 0;
    i = i +1;
  end
  i=0;
  repeat(20) @(posedge clk);
  repeat(16) begin
    RX_RDCMD(testedTagPort);        // it will all come back to the same tag port!
    //i=i+1;
  end
end

int k;
initial begin
  k=0;
  repeat(16) begin
    intRdCmdRdy[k] = 0;
    k=k+1;
  end
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


task RX_RDCMD(
  input int idx
); 
begin
  intRdCmdRdy[idx] = 0;
  intRdDataVld[idx] = 0;

  repeat(20) @(posedge clk);

  //forever begin
    wait(intRdCmdVld[idx]);
    @(posedge clk);
    #1;
    //if(intRdCmdDst[idx] != rdCmdMsg[idx]) $error("ERROR at intRdCmd[idx], Wrong RdCmd.Dst, at %d", idx);

    if(rdCmdDrop[idx]) begin
      $display("Info: Pkt Drop at %t", $realtime());
      intRdCmdRdy[idx] = 1;
      @(posedge clk);
      #1;
      intRdCmdRdy[idx] = 0;
    end else begin
      $display("Info: Pkt Trans at %t at port %d", $realtime(), idx);
      intRdCmdRdy[idx] = 1;
      @(posedge clk);
      #1;
      intRdCmdRdy[idx] = 0;
      GEN_RD_DATA(idx);
    end
    repeat(10) @(posedge clk);
  //end
end
endtask

task GEN_RD_DATA(
  input int idx
);
  rdData[idx] = 0;
  rdLast[idx] = 0;
  intRdDataVld[idx] = 0;

    repeat({$random()}%16) begin
      intRdDataVld[idx] = 1;
      wait(intRdDataRdy[idx]);
      @(posedge clk);
      #1;
      rdData[idx] = rdData[idx] + 1;
    end
    rdLast[idx] = 1;
    wait(intRdDataRdy[idx]);
    @(posedge clk);
    #1;
    intRdDataVld[idx] = 0;
    rdLast[idx] = 0;
    repeat(5) @(posedge clk);
endtask

endmodule
