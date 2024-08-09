module tb_RdCtrlTop1Ch;
reg clk;
reg rst_n;

Decoupled#(.DW(`ADDR_LENTH+11), .AW(4)) iTagIn();
  logic   [2:0]                 rxTagPri;     // 优先级，决定去哪个queue
  logic   [3:0]                 rxTagSrcPort; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   rxTagMsg;     // 包首地址+包长度，RD不需要对其做区分

  assign iTagIn.Pld = {rxTagPri, rxTagMsg, rxTagSrcPort};  

Decoupled#(.DW(`ADDR_LENTH+5), .AW(4)) oRdCmd();
Decoupled#(.DW(`DATA_WIDTH+1), .AW(4)) iRdData();

logic   [3:0]               rdCmdDstPort;   // dst port for rddata, which is the PORT_ADDR of this port
logic   [`ADDR_LENTH+4-1:0] rdCmdMsg;
logic                       rdCmdDrop;
assign {rdCmdMsg, rdCmdDstPort, rdCmdDrop} = oRdCmd.Pld;

  logic [`DATA_WIDTH-1:0]  rdData;
  logic                    rdLast;
  assign iRdData.Pld = {rdData, rdLast};

logic [3:0] iWeight[8];
logic iWeightLoad;

  logic                             oRdSop;
  logic                             oRdEop;
  logic                             oRdVld;
  logic [`DATA_WIDTH-1:0]           oRdData;
  logic                             iRdRdy;
  logic                             oRdLast;

  RdCtrlTop1Ch #(
    .PORT_ADDR(3),
    .PRI_DEPTH(8),            // 优先级队列深度
    .WRR_WEIGHT(8)        // WRR最大权重数
  )U_RD_CHN(
    .iClk         (clk),
    .iRst_n       (rst_n),

    .iTagIn       (iTagIn),
    .oRdCmd       (oRdCmd),     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4)) 

    .iRdData      (iRdData),    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

    .oRdSop       (oRdSop),
    .oRdEop       (oRdEop),
    .oRdVld       (oRdVld),
    .oRdData      (oRdData),
    .iRdRdy       (iRdRdy),
    .oRdLast      (oRdLast),

    .iWeight      (iWeight),
    .iWeightLoad  (weightLoadArray)
  );

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $fsdbDumpfile("tb_RdCtrlTop1Ch.fsdb");
  $fsdbDumpvars(0, tb_RdCtrlTop1Ch);
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
  iWeight[0] = 8;
  iWeight[1] = 8;
  iWeight[2] = 8;
  iWeight[3] = 8;
  iWeight[4] = 8;
  iWeight[5] = 8;
  iWeight[6] = 8;
  iWeight[7] = 8;
  @(posedge clk);
  #1;
  iWeightLoad = 1;
  @(posedge clk);
  #1;
  iWeightLoad = 0;

  repeat(1000) @(posedge clk);
  $finish(2);
end

// GEN TAG
reg[3:0] i;
  initial begin
    i = 0;
    iTagIn.Vld = 0;
    rxTagMsg = 0;
    repeat(30) @(posedge clk);
    repeat(16) begin
      rxTagSrcPort = i;
      rxTagPri = i;
      rxTagMsg[3:0] = i;
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

    // Drop Pak
    repeat(16) begin
      rxTagSrcPort = 3;
      rxTagPri = 3;
      rxTagMsg[3:0] = 3;
      @(posedge clk);
      #1;
      iTagIn.Vld = 1;
      wait(iTagIn.Rdy);
      @(posedge clk);
      #1;
      iTagIn.Vld = 0;
      @(posedge clk);
      #1;
      
    end
    repeat(2) @(posedge clk);
  end

// gen rd cmd
initial begin
  oRdCmd.Rdy = 0;
  iRdData.Vld = 0;

  repeat(20) @(posedge clk);

  forever begin
    wait(oRdCmd.Vld);
    @(posedge clk);
    #1;
    if(oRdCmd.Dst != rdCmdMsg) $error("ERROR at oRdCmd, Wrong RdCmd.Dst");

    if(rdCmdDrop) begin
      $display("Info: Pkt Drop at %t", $realtime());
      oRdCmd.Rdy = 1;
      @(posedge clk);
      #1;
      oRdCmd.Rdy = 0;
    end else begin
      $display("Info: Pkt Trans at %t", $realtime());
      oRdCmd.Rdy = 1;
      @(posedge clk);
      #1;
      oRdCmd.Rdy = 0;
      GEN_RD_DATA();

    end

    repeat(10) @(posedge clk);

  end
  

end

initial begin
  iRdRdy = 0;
  forever begin
    repeat({$random()}%10) @(posedge clk);
    #1;
    iRdRdy = ~iRdRdy;
  end
end


task GEN_RD_DATA(

);
  rdData = 0;
  rdLast = 0;
  iRdData.Vld = 0;

    repeat({$random()}%16) begin
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


endtask


endmodule