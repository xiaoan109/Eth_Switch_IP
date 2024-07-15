// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/AddrCtrl/AddrCtrl.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-10
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-19
// Version        :
// Description    : 
// 通道0 - [FIFO] -                                     -  通道0
// 通道1 - [FIFO] -  [仲裁] - [EMPTY ADDR FIFO] - [MUX] -  通道1
// 通道2 - [FIFO] -                                     -  通道2
// 通道3 - [FIFO] -                                     -  通道3                 
// Parameter       :
//                  
// 
// IO Port         :
//                  
// 
// Modification History
//    Date   |   Author   |   Version   |   Change Description
// ==============================================================================
//  2024-4-10| liuyanlong |     0.1     |  Original Version
//                  
// 
// -FHEADER =====================================================================
`include "define.v"
module AddrCtrl #(
  parameter FIFO_DEPTH = 4095,
  parameter DATA_WIDTH = 12,
  parameter ADDR_WIDTH = $clog2(FIFO_DEPTH),

  parameter ADDR_LENTH = 12

) (
  input wire iClk,
  input wire iRst_n,

  input wire [ADDR_LENTH - 1:0] iRecAddr0,
  input wire                    iRecAddrVld0,

  input wire [ADDR_LENTH - 1:0] iRecAddr1,
  input wire                    iRecAddrVld1,

  input wire [ADDR_LENTH - 1:0] iRecAddr2,
  input wire                    iRecAddrVld2,

  input wire [ADDR_LENTH - 1:0] iRecAddr3,
  input wire                    iRecAddrVld3,

  input wire iEptyAddrRdy0,
  output wire [ADDR_LENTH - 1:0] oEptyAddr0,
  output wire oEptyAddrVld0,  //Vld主动拉高，与Rdy握手成功之后切下一个数据

  input  wire                    iEptyAddrRdy1,
  output wire [ADDR_LENTH - 1:0] oEptyAddr1,
  output wire                    oEptyAddrVld1,

  input  wire                    iEptyAddrRdy2,
  output wire [ADDR_LENTH - 1:0] oEptyAddr2,
  output wire                    oEptyAddrVld2,

  input  wire                    iEptyAddrRdy3,
  output wire [ADDR_LENTH - 1:0] oEptyAddr3,
  output wire                    oEptyAddrVld3,

  input wire [ADDR_LENTH - 1:0] iDropData,
  input wire                    iDropDataVld,

  output wire oFull,
  output wire oAlmostFull
);

  wire                          wWriteEn;
  wire                          wReadEn;
  wire [                   2:0] wReadNum;

  wire [    DATA_WIDTH - 1 : 0] rReadData;
  reg                           rReadDataVld;

  reg  [ADDR_WIDTH - 1 + 1 : 0] rDataCounter;

  reg  [    ADDR_WIDTH - 1 : 0] rWriteAddress;
  reg  [    ADDR_WIDTH - 1 : 0] rReadAddress;


  //-------------------------------输入FIFO----------------------------//
  wire [      ADDR_LENTH - 1:0] wRecFifoData    [3:0];
  wire [      ADDR_LENTH - 1:0] wRecAddr        [3:0];
  wire [                   3:0] wRecAddrVld;
  wire [                   3:0] wRecFifoDataVld;
  wire [                   3:0] wEmpty;
  wire                          wEptyAddrRdy0;
  wire                          wEptyAddrRdy1;
  wire                          wEptyAddrRdy2;
  wire                          wEptyAddrRdy3;
  wire [                   3:0] wFifoRen;
  reg  [      ADDR_LENTH - 1:0] rWriteData;
  reg                           rWriteDataVld;


  assign wRecAddr[0] = iRecAddr0;
  assign wRecAddr[1] = iRecAddr1;
  assign wRecAddr[2] = iRecAddr2;
  assign wRecAddr[3] = iRecAddr3;
  assign wRecAddrVld[0] = iRecAddrVld0;
  assign wRecAddrVld[1] = iRecAddrVld1;
  assign wRecAddrVld[2] = iRecAddrVld2;
  assign wRecAddrVld[3] = iRecAddrVld3;

  assign wFifoRen[0] = ~wEmpty[0];
  assign wFifoRen[1] = (wEmpty[0]) & ~wEmpty[1];
  assign wFifoRen[2] = (wEmpty[0]) & (wEmpty[1]) & ~wEmpty[2];
  assign wFifoRen[3] = (wEmpty[0]) & (wEmpty[1]) & (wEmpty[2]) & ~wEmpty[3];

  assign wEptyAddrRdy0 = iEptyAddrRdy0 & !oEptyAddrVld0;  // 保证只有一个地址读出来
  assign wEptyAddrRdy1 = iEptyAddrRdy1 & !oEptyAddrVld1;
  assign wEptyAddrRdy2 = iEptyAddrRdy2 & !oEptyAddrVld2;
  assign wEptyAddrRdy3 = iEptyAddrRdy3 & !oEptyAddrVld3;

  genvar i;
  generate
    //4个通道接4个深度为2的fifo防止包尾Block只有一个周期就读完了，
    //而下一个包回收的地址下一周期就到来，而覆盖掉了上一个包的地址（因为需要4个周期才能接收完4个通道）
    for (i = 0; i < 4; i = i + 1) begin : Fifo_gen
      Fifo #(
        .FIFO_DEPTH(2),
        .DATA_WIDTH(12)
      ) InFifo_U0 (
        .iClk(iClk),
        .iRst_n(iRst_n),
        .iWData(wRecAddr[i]),
        .iWEn(wRecAddrVld[i]),  //Vld主动拉高，与Rdy握手成功之后切下一个数据
        .iREn(wFifoRen[i]),
        .oReadData(wRecFifoData[i]),
        .oReadDataVld(wRecFifoDataVld[i]),
        .oFull(),  //一个地址需要16个周期，所以不可能会满
        .oEmpty(wEmpty[i])
      );
    end
  endgenerate

  always @(*) begin
    if (iDropDataVld) begin
      rWriteData    <= iDropData;
      rWriteDataVld <= 1;
    end else if(wRecFifoDataVld[0])begin//虽然有优先级，但是每次请求间隔16个时钟，所以不会出现分配不均匀的情况
      rWriteData    <= wRecFifoData[0];
      rWriteDataVld <= 1;
    end else if (wRecFifoDataVld[1]) begin
      rWriteData    <= wRecFifoData[1];
      rWriteDataVld <= 1;
    end else if (wRecFifoDataVld[2]) begin
      rWriteData    <= wRecFifoData[2];
      rWriteDataVld <= 1;
    end else if (wRecFifoDataVld[3]) begin
      rWriteData    <= wRecFifoData[3];
      rWriteDataVld <= 1;
    end else begin
      rWriteData    <= 0;
      rWriteDataVld <= 0;
    end
  end


  //-------------------------------输出MUX--------------------------------//
  reg [4*ADDR_LENTH-1:0] rEptyAddr;
  reg [3:0] rEptyAddrVld;

  //收到请求后的下一个周期给出数据，请求撤掉之后
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rEptyAddr    <= 0;
      rEptyAddrVld <= 0;
    end else if(wEptyAddrRdy0)begin//虽然有优先级，但是每次请求间隔16个时钟，所以不会出现分配不均匀的情况
      rEptyAddr    <= {12'b0,12'b0,12'b0,rReadData};
      rEptyAddrVld <= {1'b0,1'b0,1'b0,rReadDataVld};
    end else if (wEptyAddrRdy1) begin
      rEptyAddr    <= {12'b0,12'b0,rReadData,12'b0};
      rEptyAddrVld <= {1'b0,1'b0,rReadDataVld,1'b0};
    end else if (wEptyAddrRdy2) begin
      rEptyAddr    <= {12'b0,rReadData,12'b0,12'b0};
      rEptyAddrVld <= {1'b0,rReadDataVld,1'b0,1'b0};
    end else if (wEptyAddrRdy3) begin
      rEptyAddr    <= {rReadData,12'b0,12'b0,12'b0};
      rEptyAddrVld <= {rReadDataVld,1'b0,1'b0,1'b0};
    end else begin
      rEptyAddr    <= 0;
      rEptyAddrVld <= 0;
    end
  end

  assign oEptyAddr0 = rEptyAddr[ADDR_LENTH-1:0];
  assign oEptyAddr1 = rEptyAddr[23:12];
  assign oEptyAddr2 = rEptyAddr[35:24];
  assign oEptyAddr3 = rEptyAddr[47:36];

  assign oEptyAddrVld0 = rEptyAddrVld[0];
  assign oEptyAddrVld1 = rEptyAddrVld[1];
  assign oEptyAddrVld2 = rEptyAddrVld[2];
  assign oEptyAddrVld3 = rEptyAddrVld[3];


  //----------------------------------读写控制---------------------------------//

  assign wWriteEn      = (wRecFifoDataVld[0]|wRecFifoDataVld[1]|wRecFifoDataVld[2]|wRecFifoDataVld[3]|iDropDataVld) & (!oFull);
  assign wReadNum = wEptyAddrRdy0 + wEptyAddrRdy1 + wEptyAddrRdy2 + wEptyAddrRdy3;
  assign wReadEn = (((wReadNum != 0 & rReadDataVld) | (rReadDataVld == 0)) & (!oAlmostFull));
  //输出寄存器与任意一个通道握手成功或者当前寄存器为空，则将fifo读出一个值

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rReadDataVld <= 0;
    end else if(oAlmostFull & wReadNum!=0) begin//fifo空了并且输出寄存器接收到了读请求，那么寄存器清零
      rReadDataVld <= 0;
    end else if (wReadEn) begin  //读信号一个周期后返回一个读数据vld
      rReadDataVld <= 1;
    end else begin
      rReadDataVld <= rReadDataVld;
    end
  end

  // 读写地址
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rWriteAddress <= 0;
    end else if (wWriteEn) begin
      rWriteAddress <= (rWriteAddress == (FIFO_DEPTH - 1)) ? 'b0 : rWriteAddress + 1'b1;
    end
  end
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rReadAddress <= 0;
    end else if (wReadEn) begin
      rReadAddress <= (rReadAddress == (FIFO_DEPTH - 1)) ? 0 : rReadAddress + 1'b1;
    end
  end

  //rDataCounter
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      // rDataCounter <= 0;
      rDataCounter <= FIFO_DEPTH;  //use init file
    end else if (wWriteEn && wReadEn) begin
      rDataCounter <= rDataCounter;
    end else if (wWriteEn) begin
      rDataCounter <= rDataCounter + 1'b1;
    end else if (wReadEn) begin
      rDataCounter <= rDataCounter - 1'b1;
    end else begin
      rDataCounter <= rDataCounter;
    end
  end

  assign oFull = (rDataCounter == FIFO_DEPTH);
  assign oAlmostFull = (rDataCounter == 0);

  //---------------------------dpram-----------------------------//
`ifndef FPGA
  wire wCenA, wCenB;

  S55NLLGDPH_X512Y8D12_BW EmptyAddrSram_U0 (
    .QA   (),               //A口写入B口读出
    .QB   (rReadData),
    .CLKA (iClk),
    .CLKB (iClk),
    .CENA (!wCenA),         //0是激活
    .CENB (!wCenB),
    .WENA (1'b0),           //0是写
    .BWENA(12'b0),
    .WENB (1'b1),
    .BWENB(12'b0),
    .AA   (rWriteAddress),
    .DA   (rWriteData),

    .AB(rReadAddress),
    .DB()
  );
  assign wCenA = wWriteEn;
  assign wCenB = wReadEn;
`else
  RAM_Simple_Dual_Port_Dual_Clock #(
    .WORD_WIDTH   (ADDR_LENTH),
    .ADDR_WIDTH   (ADDR_WIDTH),
    .DEPTH        (FIFO_DEPTH),
    .RAMSTYLE     ("block"),
    .USE_INIT_FILE(1),
    .INIT_FILE    ("../../src/rtl/design/AddrCtrl/addr.mem"),
    .INIT_VALUE   (0)
  ) EmptyAddrSram_U0 (
    .write_clock(iClk),
    .read_clock (iClk),
    .wren       (wWriteEn),
    .write_addr (rWriteAddress),
    .write_data (rWriteData),
    .rden       (wReadEn),
    .read_addr  (rReadAddress),
    .read_data  (rReadData)
  );
`endif


endmodule
