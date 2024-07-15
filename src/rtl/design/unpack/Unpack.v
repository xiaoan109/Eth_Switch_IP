// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/unpack/Unpack.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-07
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-19
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
//  2024-4-7 |  liuyanlong |     1.0     | Original Version
//                  
// 
// -FHEADER =====================================================================
module Unpack #(

) (
  input  wire        iClk,
  input  wire        iRst_n,
  //outside
  input  wire        iWrSop,
  input  wire        iWrEop,
  input  wire        iWrVld,
  input  wire [31:0] iWrData,
  output wire        oWrRdy,
  //Empty Addr
  input  wire [11:0] iEptyAddr,
  input  wire        iEptyAddrVld,
  output wire        oEptyAddrRcvRdy,
  //wrr
  input  wire        iWrrRdy,
  output wire [ 2:0] oPkgPri,
  output wire [ 3:0] oPkgDstPort,
  output wire [11:0] oPkgFirAddr,      //包首地址
  output wire [ 3:0] oPkgLen,
  output wire        oPkgTagVld,
  //Lsram
  // input  wire        iLWriteRdy,
  output wire [11:0] oLdata,
  output wire [11:0] oLaddr,           //link list addr
  output wire        oLaddrVld,
  //MMU
  input  wire        iPkgDataRdy,      //mmu
  output wire [31:0] oPkgData,
  output wire        oPkgDataVld,
  output wire [11:0] oPkgAddr,
  output wire        oPkgAddrVld,
  output wire        oPkgWrLast,
  //Ctrl Sop&Eop
  output wire        oIdleState,
  output wire        oAllLast
);

  localparam IDLE = 2'b00;
  localparam CTRLFRM = 2'b01;  //控制帧
  localparam DATAFRM = 2'b10;  //数据传输
  localparam ENDFRM = 2'b11;  //结束传输

  //[6:4] priority [3:0] dest_port [16:7]: lenth of pkg
  wire [31:0] iWrData_r;
  wire        iWrVld_r;
  wire        oWrRdy_r;

  //---------------------------解包状态机-------------------------------//

  reg [1:0] rState, rNxtState;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rState <= IDLE;
    end else begin
      rState <= rNxtState;
    end
  end

  always @(*) begin
    case (rState)
      IDLE:
      if (iWrSop) begin
        rNxtState <= CTRLFRM;
      end else begin
        rNxtState <= IDLE;
      end

      CTRLFRM:
      if (iWrVld_r) begin  //接收到控制帧后进入下一状态
        rNxtState <= DATAFRM;
      end else begin
        rNxtState <= CTRLFRM;
      end

      DATAFRM:
      if (iWrEop) begin
        rNxtState <= ENDFRM;
      end else begin
        rNxtState <= DATAFRM;
      end

      ENDFRM:
      if (iWrrRdy) begin
        rNxtState <= IDLE;
      end else begin
        rNxtState <= ENDFRM;
      end
      default: rNxtState <= IDLE;
    endcase
  end

  assign oIdleState = rState == IDLE;

  //------------------------控制帧解析------------------------//

  //skit buf to fix the time 

  gnrl_buf #(
    .DW(32),
    .CUT_RDY(1)
  ) buf_u (
    .clk_i  (iClk),
    .rst_n_i(iRst_n),

    .din_i    (iWrData),
    .din_vld_i(iWrVld),
    .din_rdy_o(oWrRdy),

    .dout_o    (iWrData_r),
    .dout_vld_o(iWrVld_r),
    .dout_rdy_i(oWrRdy_r)
  );

  reg [31:0] rWrCtrl;  //控制帧寄存器
  reg rWrCtrlVld;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rWrCtrl    <= 0;
      rWrCtrlVld <= 0;
    end else if (rState == CTRLFRM) begin  //CTRLFRM接收
      if (iWrVld_r) begin
        rWrCtrl    <= iWrData_r;
        rWrCtrlVld <= 1;
      end else begin
        rWrCtrl    <= rWrCtrl;
        rWrCtrlVld <= rWrCtrlVld;
      end
    end else if (rState == ENDFRM) begin
      if (iWrrRdy) begin  //与WRR握手成功，代表整个数据包全部传完
        rWrCtrl    <= rWrCtrl; //保持以避免内部包长度数据改变引起数据丢失，这样做可以减少寄存器使用
        rWrCtrlVld <= 0;
      end else begin
        rWrCtrl    <= rWrCtrl;
        rWrCtrlVld <= rWrCtrlVld;
      end
    end
  end


  assign oPkgPri = rWrCtrl[6:4];
  assign oPkgDstPort = rWrCtrl[3:0];
  assign oPkgLen     = ((rWrCtrl[16:7] | 2'b11) + 4 - 63) >> 6;  // in blocks (count: 1-16 --> number: 0-15)

  wire [3:0] wWordLen;  // words(32bit) in last block (count: 0-15 --> number: 0-15)
  assign wWordLen = ((rWrCtrl[16:7] | 2'b11) + 4 - ((64 << oPkgLen) - 1)) >> 2;
  wire [4:0] wAllBlockLen;
  assign wAllBlockLen = wWordLen ? oPkgLen + 1 : oPkgLen;

  reg rWaitFirAddr;
  reg [11:0] rFirstAddr;
  reg [11:0] rEptyAddr;  //空地址寄存器
  reg rEptyAddrVld;
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rWaitFirAddr <= 0;
      rFirstAddr   <= 0;
    end else if (rState == ENDFRM) begin
      if (iWrrRdy) begin  //下级握手成功时，首地址寄存器清零
        rWaitFirAddr <= 0;
        rFirstAddr   <= 0;
      end else begin  //握手失败继续保持
        rWaitFirAddr <= 0;
        rFirstAddr   <= rFirstAddr;
      end
    end else if (rState == CTRLFRM && rNxtState == DATAFRM) begin  //每次准备切到DATAFRM时
      rWaitFirAddr <= 1;
      rFirstAddr   <= 0;
    end else if (rWaitFirAddr && rEptyAddrVld && !oPkgDataVld) begin  // No data is sending
      rWaitFirAddr <= 0;
      rFirstAddr   <= rEptyAddr;
    end else begin
      rWaitFirAddr <= rWaitFirAddr;
      rFirstAddr   <= rFirstAddr;
    end
  end

  assign oPkgTagVld  = rState == ENDFRM ? rWrCtrlVld : 0;
  assign oPkgFirAddr = rState == ENDFRM ? rFirstAddr : 0;


  //------------------------data 、addr recive and sent------------------------//

  reg [31:0] rWrData;  //数据寄存器
  reg rWrDataVld;
  reg [3:0] rDataCnt;
  reg [4:0] rBlockCnt;
  wire wLastBlock;
  wire wNoLastBlock;
  assign wNoLastBlock = rBlockCnt != wAllBlockLen && rDataCnt == 15 && rWrDataVld;
  assign wLastBlock   = rBlockCnt == wAllBlockLen && rDataCnt == (wWordLen - 4'b1) && rWrDataVld;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rBlockCnt <= 0;
    end else if (rWrDataVld && iPkgDataRdy) begin
      if (rBlockCnt == wAllBlockLen && rDataCnt == (wWordLen - 4'b1)) begin
        rBlockCnt <= 0;
      end else if (rDataCnt == 15) begin
        rBlockCnt <= rBlockCnt + 1;
      end
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rEptyAddr    <= 0;
      rDataCnt     <= 0;
      rEptyAddrVld <= 0;
      rWrData      <= 0;
      rWrDataVld   <= 0;
      // end else if (rState == DATAFRM) begin
    end else begin
      if (rEptyAddrVld == 1) begin  //rEptyAddrVld == 1时接收数据，否则只接收地址
        if (wNoLastBlock | wLastBlock) begin  //已经接收完了16组数据，开始发送sram的数据
          if (rWrDataVld && iPkgDataRdy) begin
            rEptyAddr    <= rEptyAddr;
            rDataCnt     <= 0;
            rEptyAddrVld <= 0;
            rWrData      <= 0;
            rWrDataVld   <= 0;
          end else begin
            rEptyAddr    <= rEptyAddr;
            rDataCnt     <= rDataCnt;
            rEptyAddrVld <= rEptyAddrVld;
            rWrData      <= rWrData;
            rWrDataVld   <= rWrDataVld;
          end
        end else if(rWrDataVld && iPkgDataRdy)begin//每和下级握手成功一次数据计数加1,并接收下一组数据
          rEptyAddr    <= rEptyAddr;
          rDataCnt     <= rDataCnt + 1;
          rEptyAddrVld <= rEptyAddrVld;
          rWrData      <= iWrData_r;
          rWrDataVld   <= iWrVld_r;
        end else if(!rWrDataVld)begin//数据寄存器无效时，数据不断接收,地址寄存器保持
          rEptyAddr    <= rEptyAddr;
          rDataCnt     <= rDataCnt;
          rEptyAddrVld <= rEptyAddrVld;
          rWrData      <= iWrData_r;
          rWrDataVld   <= iWrVld_r;
        end else begin  //数据寄存器有效期下级不Rdy时，数据保持
          rEptyAddr    <= rEptyAddr;
          rDataCnt     <= rDataCnt;
          rEptyAddrVld <= rEptyAddrVld;
          rWrData      <= rWrData;
          rWrDataVld   <= rWrDataVld;
        end
      end else begin  //rEptyAddrVld == 0时接收地址等待地址有效
        rWrData <= 0;
        rWrDataVld <= 0;
        rDataCnt <= 0;
        rEptyAddr <= rState == DATAFRM ? iEptyAddr : rEptyAddr; //防止CTRLFRM状态下数据错误接收
        rEptyAddrVld <= rState == DATAFRM ? iEptyAddrVld : rEptyAddrVld;
      end
    end
  end


  assign oPkgData = rWrData;
  assign oPkgDataVld = rWrDataVld;
  assign oPkgAddr = rEptyAddr;
  assign oPkgAddrVld = rEptyAddrVld;//16个包数据传输的时候相同的地址每一次vld都拉高，可以用作xbar的Req信号
  assign oPkgWrLast = wLastBlock | wNoLastBlock;
  assign oAllLast = wLastBlock;

  assign oEptyAddrRcvRdy = !rEptyAddrVld && (rState == DATAFRM);
  //对应通道的端口没有数据则请求数据，下一个周期来了数据只保持一个周期下个周期传入rEptyAddr中
  assign oWrRdy_r = (rState == CTRLFRM ) | (!(wNoLastBlock | wLastBlock) && (rEptyAddrVld == 1) && (!rWrDataVld | (rWrDataVld && iPkgDataRdy)));
  //当rEptyAddrVld == 1，处于接收数据状态时，并且WrData寄存器无效或者与下级握手成功时才接收数据
  //rDataCnt == 15的时候Rdy拉低，防止清零的时候新的数据进来
  //CTRLFRM下只接收控制帧，但是不会发送到MMU


  //------------------------link list------------------------//
  reg [12:0] rEptyAddr_r1;  //上一个空地址寄存器
  reg rEptyAddrVld_r1;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rEptyAddr_r1    <= 13'h1000; //保证第一次判断一定不相等
      rEptyAddrVld_r1 <= 0;
    end else if (rState == DATAFRM) begin
      if(rEptyAddrVld && rEptyAddr_r1 != {1'b0, rEptyAddr} && rDataCnt == 15 && rWrDataVld && iPkgDataRdy) begin//rEptyAddr_r1!=rEptyAddr的时候说明下一个地址传入了，且保证最后一个数据发送完成
        rEptyAddr_r1    <= rEptyAddr;
        rEptyAddrVld_r1 <= rEptyAddrVld;
      end else begin
        rEptyAddr_r1    <=rEptyAddr_r1;
        rEptyAddrVld_r1 <=rEptyAddrVld_r1;
      end
    end else begin
      rEptyAddr_r1    <= 13'h1000; //保证第一次判断一定不相等
      rEptyAddrVld_r1 <= 0;
    end
  end

  assign oLdata = rState == DATAFRM ? rEptyAddr : rState == ENDFRM ? wWordLen : 0;
  assign oLaddr = rState == DATAFRM ? rEptyAddr_r1 : rState == ENDFRM ? rEptyAddr : 0;
  assign oLaddrVld = rState == DATAFRM ? ((wNoLastBlock | wLastBlock) && (rEptyAddr_r1 != {1'b0, rEptyAddr})) ? rEptyAddrVld_r1 : 0 : rState == ENDFRM ? rEptyAddrVld_r1 : 0;
  //(rEptyAddr_r1!=rEptyAddr)是为了第一个地址不输出，第一个地址是首地址。

endmodule
