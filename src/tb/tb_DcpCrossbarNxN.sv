module tb_DcpCrossbarNxN;
reg clk;
reg rst_n;
localparam N = 4;
localparam DW = 8;
localparam AW = 4;
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

Decoupled#(.DW(DW), .AW(AW)) iDcpIn[N]();
Decoupled#(.DW(DW), .AW(AW)) oDcpOut[N]();
reg [AW-1:0] dst[N];
reg  [3:0] fn;

initial begin
  $fsdbDumpfile("tb_DcpCrossbarNxN.fsdb");
  $fsdbDumpvars(0, tb_DcpCrossbarNxN);
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
  wait(fn==4'b1111);
  $finish(2);
end

DcpCrossbarNxN#(
  .DW (DW),
  .AW (AW),
  .N (N)
)DUT(
  .iClk   (clk),
  .iRst_n (rst_n),

  .iDcpIn  (iDcpIn),   

  .oDcpOut  (oDcpOut)
);



initial begin
  iDcpIn[0].Pld = 0;
  iDcpIn[0].Dst = 0;
  dst[0] = 0;
  iDcpIn[0].Vld = 0;
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  
  repeat(16) begin
    iDcpIn[0].Vld = 1;
    iDcpIn[0].Pld = {0, dst[0]};
    iDcpIn[0].Dst = dst[0];
    wait(iDcpIn[0].Rdy);
    @(posedge clk);
    #1;
    if(dst[0]==3) dst[0] = 0;
    else dst[0]=dst[0]+1;
  end
  iDcpIn[0].Vld = 0;
  repeat(10) @(posedge clk);
  fn[0] = 1;
end

initial begin
  iDcpIn[1].Pld = 0;
  iDcpIn[1].Dst = 0;
  dst[1] = 0;
  iDcpIn[1].Vld = 0;
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  
  repeat(16) begin
    iDcpIn[1].Vld = 1;
    iDcpIn[1].Pld = {1, dst[1]};
    iDcpIn[1].Dst = dst[1];
    wait(iDcpIn[1].Rdy);
    @(posedge clk);
    #1;
    if(dst[1]==3) dst[1] = 0;
    else dst[1]=dst[1]+1;
  end
  iDcpIn[1].Vld = 0;
  repeat(10) @(posedge clk);
  fn[1] = 1;
end

initial begin
  iDcpIn[2].Pld = 0;
  iDcpIn[2].Dst = 0;
  dst[2] = 0;
  iDcpIn[2].Vld = 0;
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  
  repeat(16) begin
    iDcpIn[2].Vld = 1;
    iDcpIn[2].Pld = {2, dst[2]};
    iDcpIn[2].Dst = dst[2];
    wait(iDcpIn[2].Rdy);
    @(posedge clk);
    #1;
    if(dst[2]==3) dst[2] = 0;
    else dst[2]=dst[2]+1;
  end
  iDcpIn[2].Vld = 0;
  repeat(10) @(posedge clk);
  fn[2] = 1;
end

initial begin
  iDcpIn[3].Pld = 0;
  iDcpIn[3].Dst = 0;
  dst[3] = 0;
  iDcpIn[3].Vld = 0;
  wait(!rst_n);
  wait(rst_n);
  repeat(10) @(posedge clk);
  
  repeat(16) begin
    iDcpIn[3].Vld = 1;
    iDcpIn[3].Pld = {3, dst[3]};
    iDcpIn[3].Dst = dst[3];
    wait(iDcpIn[3].Rdy);
    @(posedge clk);
    #1;
    if(dst[3]==3) dst[3] = 0;
    else dst[3]=dst[3]+1;
  end
  iDcpIn[3].Vld = 0;
  repeat(10) @(posedge clk);
  fn[3] = 1;
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