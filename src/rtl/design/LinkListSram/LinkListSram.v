// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/LinkListSram/LinkListSram.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-24
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-06-26
// Version        :
// Description    : 
//                  
// 
// Parameter       :
//                  
// 
// IO Port         :
//                  
// 
// Modification History
//    Date   |   Author   |   Version   |   Change Description
// ==============================================================================
//  24-4-24  |liuyanlong  |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
`include "define.v"
module LinkListSram #(
  parameter ADDR_LENTH = 12
) (
  input wire iClk,
  input wire iRst_n,

  //Unpack
  input wire [ADDR_LENTH - 1:0] iWriteLdata0,
  input wire [ADDR_LENTH - 1:0] iWriteLaddr0,
  input wire                    iWriteLaddrVld0,

  input wire [ADDR_LENTH - 1:0] iWriteLdata1,
  input wire [ADDR_LENTH - 1:0] iWriteLaddr1,
  input wire                    iWriteLaddrVld1,

  input wire [ADDR_LENTH - 1:0] iWriteLdata2,
  input wire [ADDR_LENTH - 1:0] iWriteLaddr2,
  input wire                    iWriteLaddrVld2,

  input wire [ADDR_LENTH - 1:0] iWriteLdata3,
  input wire [ADDR_LENTH - 1:0] iWriteLaddr3,
  input wire                    iWriteLaddrVld3,

  //PkgRead
  output wire [ADDR_LENTH - 1:0] oLdata0,
  output wire                    oLdataVld0,
  input  wire [ADDR_LENTH - 1:0] iLaddr0,
  input  wire                    iLNxtAddrReq0,

  output wire [ADDR_LENTH - 1:0] oLdata1,
  output wire                    oLdataVld1,
  input  wire [ADDR_LENTH - 1:0] iLaddr1,
  input  wire                    iLNxtAddrReq1,

  output wire [ADDR_LENTH - 1:0] oLdata2,
  output wire                    oLdataVld2,
  input  wire [ADDR_LENTH - 1:0] iLaddr2,
  input  wire                    iLNxtAddrReq2,

  output   wire    [ADDR_LENTH - 1:0]   oLdata3,
  output   wire                         oLdataVld3,
  input    wire    [ADDR_LENTH - 1:0]   iLaddr3,
  input    wire                         iLNxtAddrReq3,

  //drop chnnel
  input   wire     [ADDR_LENTH - 1:0]   iDropAddr,
  input   wire                          iDropAddrVld,
  output  reg      [ADDR_LENTH - 1:0]   oDropData,
  output  reg                           oDropDataVld

);

//---------------------Sram 写入---------------------------------------、、
wire [3:0]                wRecFifoDataVld,wFifoRen,wWriteLaddrVld;
wire [2*ADDR_LENTH - 1:0] wRecFifoData[3:0];
wire [ADDR_LENTH - 1:0]   wWriteLdata[3:0],wWriteLaddr[3:0];
reg  [ADDR_LENTH - 1:0]   wWriteData,wWriteAddress;
reg                       wWriteVld;

  wire [3:0] wEmpty;

  assign wFifoRen[0] = ~wEmpty[0];
  assign wFifoRen[1] = (wEmpty[0]) & ~wEmpty[1];
  assign wFifoRen[2] = (wEmpty[0]) & (wEmpty[1]) & ~wEmpty[2];
  assign wFifoRen[3] = (wEmpty[0]) & (wEmpty[1]) & (wEmpty[2]) & ~wEmpty[3];

  assign wWriteLaddrVld[0] = iWriteLaddrVld0;
  assign wWriteLaddrVld[1] = iWriteLaddrVld1;
  assign wWriteLaddrVld[2] = iWriteLaddrVld2;
  assign wWriteLaddrVld[3] = iWriteLaddrVld3;

  assign wWriteLdata[0] = iWriteLdata0;
  assign wWriteLdata[1] = iWriteLdata1;
  assign wWriteLdata[2] = iWriteLdata2;
  assign wWriteLdata[3] = iWriteLdata3;

  assign wWriteLaddr[0] = iWriteLaddr0;
  assign wWriteLaddr[1] = iWriteLaddr1;
  assign wWriteLaddr[2] = iWriteLaddr2;
  assign wWriteLaddr[3] = iWriteLaddr3;

  genvar i;
  generate
    //4个通道接4个深度为2的fifo防止包尾Block只有一个周期就读完了，
    //而下一个包回收的地址下一周期就到来，而覆盖掉了上一个包的地址（因为需要4个周期才能接收完4个通道）
    for (i = 0; i < 4; i = i + 1) begin : Fifo_gen
      Fifo #(
        .FIFO_DEPTH(2),
        .DATA_WIDTH(2 * ADDR_LENTH)
      ) Fifo_u0 (
        .iClk(iClk),
        .iRst_n(iRst_n),
        .iWData({wWriteLdata[i], wWriteLaddr[i]}),
        .iWEn(wWriteLaddrVld[i]),
        .iREn(wFifoRen[i]),
        .oReadData(wRecFifoData[i]),
        .oReadDataVld(wRecFifoDataVld[i]),
        .oFull(),  //一个地址需要16个周期，所以不可能会满
        .oEmpty(wEmpty[i])
      );
    end
  endgenerate

  always @(*) begin
    if (wRecFifoDataVld[0]) begin
      wWriteData    = wRecFifoData[0][2*ADDR_LENTH-1 : ADDR_LENTH];
      wWriteAddress = wRecFifoData[0][ADDR_LENTH-1 : 0];
      wWriteVld     = 1;
    end else if (wRecFifoDataVld[1]) begin
      wWriteData    = wRecFifoData[1][2*ADDR_LENTH-1 : ADDR_LENTH];
      wWriteAddress = wRecFifoData[1][ADDR_LENTH-1 : 0];
      wWriteVld     = 1;
    end else if (wRecFifoDataVld[2]) begin
      wWriteData    = wRecFifoData[2][2*ADDR_LENTH-1 : ADDR_LENTH];
      wWriteAddress = wRecFifoData[2][ADDR_LENTH-1 : 0];
      wWriteVld     = 1;
    end else if (wRecFifoDataVld[3]) begin
      wWriteData    = wRecFifoData[3][2*ADDR_LENTH-1 : ADDR_LENTH];
      wWriteAddress = wRecFifoData[3][ADDR_LENTH-1 : 0];
      wWriteVld     = 1;
    end else begin
      wWriteData    = 0;
      wWriteAddress = 0;
      wWriteVld     = 0;
    end
  end

  //-----------------------------------Sram 读出-----------------------------------
  reg  [               2:0] rReqChnnel;  //当前读请求通道
  reg  [               2:0] rRdOutChnnel;  //当前读出数据有效通道

  reg  [  ADDR_LENTH - 1:0] wReadAddress;  //SRAM读出地址
  wire [  ADDR_LENTH - 1:0] wReadData;  //SRAM读出数据
  wire                      wReadEn;  //读使能

  reg  [4*ADDR_LENTH - 1:0] wLdata;
  reg  [               3:0] wLdataVld;
  reg                       rSramReadVld;  //SRAM读出数据有效

  assign wReadEn = (iLNxtAddrReq0|iLNxtAddrReq1|iLNxtAddrReq2|iLNxtAddrReq3|iDropAddrVld)  & (rReqChnnel!=5);

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rSramReadVld <= 0;
    end else if (wReadEn) begin
      rSramReadVld <= 1;
    end else begin
      rSramReadVld <= 0;
    end
  end

  always @(*) begin
    if (rRdOutChnnel == 0) begin
      wLdata    <= {12'd0,12'd0,12'd0,wReadData};
      wLdataVld <= {1'd0,1'd0,1'd0,rSramReadVld};
    end else if (rRdOutChnnel == 1) begin
      wLdata    <= {12'd0,12'd0,wReadData,12'd0};
      wLdataVld <= {1'd0,1'd0,rSramReadVld,1'd0};
    end else if (rRdOutChnnel == 2) begin
      wLdata    <= {12'd0,wReadData,12'd0,12'd0};
      wLdataVld <= {1'd0,rSramReadVld,1'd0,1'd0};
    end else if (rRdOutChnnel == 3) begin
      wLdata    <= {wReadData,12'd0,12'd0,12'd0};
      wLdataVld <= {rSramReadVld,1'd0,1'd0,1'd0};
    end else begin
      wLdata    <= 0;
      wLdataVld <= 0;
    end
  end

  always @(*) begin
    if (rReqChnnel == 0) begin
      wReadAddress <= iLaddr0;
    end else if (rReqChnnel == 1) begin
      wReadAddress <= iLaddr1;
    end else if (rReqChnnel == 2) begin
      wReadAddress <= iLaddr2;
    end else if (rReqChnnel == 3) begin
      wReadAddress <= iLaddr3;
    end else begin
      wReadAddress <= 0;
    end
  end

  assign oLdata0    = wLdata[ADDR_LENTH-1:0];
  assign oLdataVld0 = wLdataVld[0];
  assign oLdata1    = wLdata[2*ADDR_LENTH-1:ADDR_LENTH];
  assign oLdataVld1 = wLdataVld[1];
  assign oLdata2    = wLdata[3*ADDR_LENTH-1:2*ADDR_LENTH];
  assign oLdataVld2 = wLdataVld[2];
  assign oLdata3    = wLdata[4*ADDR_LENTH-1:3*ADDR_LENTH];
  assign oLdataVld3 = wLdataVld[3];

always@(*)begin
  if(iDropAddrVld) rReqChnnel = 6;                        //丢包通道
  else if(iLNxtAddrReq0 & !wLdataVld[0]) rReqChnnel = 0;
  else if(iLNxtAddrReq1 & !wLdataVld[1]) rReqChnnel = 1;
  else if(iLNxtAddrReq2 & !wLdataVld[2]) rReqChnnel = 2;
  else if(iLNxtAddrReq3 & !wLdataVld[3]) rReqChnnel = 3;
  else rReqChnnel = 5;                                    //防止与其他通道冲突 
end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rRdOutChnnel <= 0;
    end else begin
      rRdOutChnnel <= rReqChnnel;
    end
end

//------------------------丢包通道------------------------//

always@(*)begin
  if(rRdOutChnnel == 6) begin
    oDropData    <= wReadData;
    oDropDataVld <= 1;
  end else begin
    oDropData    <= 0;
    oDropDataVld <= 0;
  end
end

//------------------------LinkListDpram---------------------------//

wire                      wCenA,wCenB;
wire [ADDR_LENTH - 1 : 0] wReadAddr;

`ifndef FPGA
S55NLLGDPH_X512Y8D12_BW LinkListSram_U0 (
    .QA         (              ), //A口写入B口读出
    .QB         (wReadData     ), 
    .CLKA       (iClk          ), 
    .CLKB       (iClk          ), 
    .CENA       (!wCenA        ), //0是激活
    .CENB       (!wCenB        ), 
    .WENA       (1'b0          ), //0是写
    .BWENA      (12'b0         ),
    .WENB       (1'b1          ), 
    .BWENB      (12'b0         ),
    .AA         (wWriteAddress ), 
    .DA         (wWriteData    ),   
    .AB         (wReadAddr     ), 
    .DB         (              )
);
`else
  RAM_Simple_Dual_Port_Dual_Clock #(
    .WORD_WIDTH   (ADDR_LENTH),
    .ADDR_WIDTH   (12),
    .DEPTH        (4096),
    .RAMSTYLE     ("block"),
    .USE_INIT_FILE(0),
    .INIT_FILE    (""),
    .INIT_VALUE   (0)
  ) LinkListSram_U0 (
    .write_clock(iClk),
    .read_clock (iClk),
    .wren       (wWriteVld),
    .write_addr (wWriteAddress),
    .write_data (wWriteData),
    .rden       (wReadEn),
    .read_addr  (wReadAddr),
    .read_data  (wReadData)
  );
`endif

assign wReadAddr = iDropAddrVld ? iDropAddr : wReadAddress;
assign wCenA = wWriteVld;
assign wCenB = wReadEn | iDropAddrVld;

endmodule
