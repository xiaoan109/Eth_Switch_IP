// +FHEADER =====================================================================
// FilePath       : /src/rtl/design/PkgRead/PkgReadUnit.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-04-16
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-20
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
//  24-4-16  | liuyanlong |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module PkgReadUnit #(
  parameter ADDR_LENTH = 12,
  parameter DATA_WIDTH = 32
) (
  input wire iClk,
  input wire iRst_n,

  //AddrCtrl
  output wire [ADDR_LENTH - 1:0] oRcvrAddr,     //需要回收的地址
  output wire                    oRcvrAddrVld,
  output reg                     oDropRun,

  //链表SRAM
  input wire [ADDR_LENTH - 1:0] iLdata,  //链表sram数据（指针）
  input wire iLdataVld,  //从链表读回来的数据有效（同时也是回复信号）

  output wire [ADDR_LENTH - 1:0] oLaddr,
  output reg                     oLNxtAddrReq,
  output reg  [ADDR_LENTH - 1:0] oDropRcvrAddr,
  output reg                     oDropRcvrAddrVld,

  //MMU
  input  wire                    iMmuRdy,
  output wire [ADDR_LENTH - 1:0] oBlockAddr,     //读地址
  output wire                    oBlockAddrVld,  //读有效
  output reg                     oMmuReadReq,    //MMU读请求
  output wire                    oMmuReadLast,

  input wire [DATA_WIDTH - 1:0] iData,  //读数据

  //WRR
  input  wire [ADDR_LENTH - 1:0] iPkgFirAddr,
  input  wire                    iPkgFirAddrVld,
  input  wire [           3 : 0] iBlockNum,
  input  wire                    iPkgDrop,
  output wire                    oPkgFirAddrRdy,

  output wire [DATA_WIDTH - 1:0] oWrrData,      //帧数据
  output wire                    oWrrVld,       //数据有效
  output reg                     oWrrDataLast,
  input  wire                    iWrrRdy,

  input wire iDropChnRdy  //丢包通道就绪
);


  //-------------------------------主要状态控制信号--------------------------------//
  reg [ADDR_LENTH - 1:0] rCurAddr;  //当前地址
  reg rCurAddrVld;  //当前地址有效,在整个包传输过程中始终拉高

  reg [ADDR_LENTH - 1:0] rNxtAddr;  //下一个地址
  reg rNxtAddrVld;  //下一个地址有效

  wire wPkgReadEnd;  //包传输结束  
  wire wDropEnd;


  //--------------------------计数器--------------------------------//
  reg [4:0] rBlockCnt;  //block计数器
  // reg [3:0] rDataCnt;  //数据计数器
  reg [3:0] rDataRcvCnt;  //数据请求计数器
  reg [4:0] rBlockNum;  //完整的block数目(不包括最后一个不完整的block)

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rBlockCnt <= 0;
    end else if (wPkgReadEnd) begin
      rBlockCnt <= 0;
    end else if (oBlockAddrVld & iMmuRdy & rDataRcvCnt == 15) begin
      rBlockCnt <= rBlockCnt + 1;
    end
  end


  // always @(posedge iClk or negedge iRst_n) begin
  //   if (!iRst_n) begin
  //     rDataCnt <= 0;
  //   end else if (oWrrVld & iWrrRdy) begin
  //     if (oWrrDataLast) begin  //rDataCnt == 15，说明一个block的数据已经发完 ,rDataCnt == 15, plus 1 = 0
  //       rDataCnt <= 0;
  //     end else begin  //与WRR握手成功，数据计数加1
  //       rDataCnt <= rDataCnt + 1;
  //     end
  //   end
  // end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rDataRcvCnt <= 0;
    end else if (wPkgReadEnd) begin  //rDataRcvCnt == 15, plus 1 = 0
      rDataRcvCnt <= 0;
    end else if (oBlockAddrVld & iMmuRdy) begin
      rDataRcvCnt <= rDataRcvCnt + 1;
    end
  end

  //--------------------------MMU data read--------------------------------//
  reg  [DATA_WIDTH - 1:0] rData;  //数据寄存器
  reg                     rDataVld;
  wire                    wDataRdy;

  reg  [            23:0] rPkgFirAddr_r2;
  reg  [             1:0] rPkgFirAddrVld_r2;

  reg                     rInDataVld;  //iData有效

  //PkgFirAddr buffer,延迟两个周期为了因为mmu需求提前两个周期给req信号
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rPkgFirAddr_r2    <= 0;
      rPkgFirAddrVld_r2 <= 0;
    end else if (oPkgFirAddrRdy & (iPkgDrop == 0)) begin
      rPkgFirAddr_r2    <= {rPkgFirAddr_r2[ADDR_LENTH - 1:0],iPkgFirAddr};
      rPkgFirAddrVld_r2 <= {rPkgFirAddrVld_r2[0],iPkgFirAddrVld};
    end else begin  //以为寄存器有了数据之后，就不会再有新的数据进来，所以补0移位
      rPkgFirAddr_r2    <= {rPkgFirAddr_r2[ADDR_LENTH - 1:0],12'b0};
      rPkgFirAddrVld_r2 <= {rPkgFirAddrVld_r2[0],1'b0};
    end
  end

  //对MMU的读请求保持整个包的传输过程中有效
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oMmuReadReq <= 0;
    end else if (wPkgReadEnd | wDropEnd) begin
      oMmuReadReq <= 0;
    end else if (oPkgFirAddrRdy & iPkgFirAddrVld) begin
      oMmuReadReq <= 1;
    end
  end

  //CurAddr
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rCurAddr    <= 0;
      rCurAddrVld <= 0;
    end else if (rCurAddrVld) begin
      if (wPkgReadEnd) begin  //当传完了完整的包，同时余下的字数也传完则整个包已经传完
        rCurAddrVld <= 0;
        rCurAddr    <= rCurAddr; //避免因为最后一个不完整的包太短，导致地址回收错误
      end else if (rDataRcvCnt == 15 & oBlockAddrVld & iMmuRdy) begin  //下一个周期会发下一个block的地址
        rCurAddr    <= rNxtAddr;
        rCurAddrVld <= 1;
      end else begin
        rCurAddr    <= rCurAddr;
        rCurAddrVld <= rCurAddrVld;
      end
    end else if (rPkgFirAddrVld_r2[1]) begin
      rCurAddr    <= rPkgFirAddr_r2[23:12];
      rCurAddrVld <= 1;
    end
  end

  assign oPkgFirAddrRdy = (rPkgFirAddrVld_r2 == 0) & !oMmuReadReq;
  assign oBlockAddr = rCurAddr;
  assign oBlockAddrVld = rBlockCnt == rBlockNum ? rBlockNum == 0 ? 0 : (!rInDataVld | wDataRdy) & (oLNxtAddrReq == 0) & !wPkgReadEnd : rCurAddrVld & (!rInDataVld | wDataRdy);

  //如果rCurAddr有效，同时Data寄存器准备好或者当前输入数据无效，就发出读请求
  ////包末尾需要等取到Nxtaddr再发读请求，防止因为末尾太短而连续请求造成NxtAddr的wWordNum不能及时收到

  //-------------------------------WRR--------------------------------//

  reg rWrrDataLast;
  wire [ADDR_LENTH-1:0] wWordNum;  //包末尾不完整Block的字数

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rInDataVld <= 0;
    end else if (oBlockAddrVld & iMmuRdy) begin  //读请求的下一周期输入数据有效
      rInDataVld <= 1;
    end else if (wDataRdy) begin  //没新的读请求时，后级Rdy，那么当前级一定是无效的
      rInDataVld <= 0;
    end else begin  //其余情况保持不变
      rInDataVld <= rInDataVld;
    end
  end

  //BlockNum
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rBlockNum <= 0;
    end else if (wPkgReadEnd) begin
      rBlockNum <= 0;
    end else if (iPkgFirAddrVld & oPkgFirAddrRdy) begin  //读请求的下一周期输入数据有效
      rBlockNum <= iBlockNum + 1;  //+1是因为完整的block0代表1，1代表2，以节约内存
    end else begin
      rBlockNum <= rBlockNum;
    end
  end


  //Data寄存器
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rData <= 0;
      rDataVld <= 0;
    end else if (rInDataVld & wDataRdy) begin  //与MMU握手成功将数据存入寄存器
      rData <= iData;
      rDataVld <= 1;
    end else if (rDataVld & iWrrRdy) begin  //寄存器有数据但是MMU没来数据而后级需要数据则置零
      rData <= 0;
      rDataVld <= 0;
    end else begin  //其他情况保持不变
      rData <= rData;
      rDataVld <= rDataVld;
    end
  end

  assign wDataRdy = (rDataVld & iWrrRdy) | !rDataVld;

  assign oWrrData = rData;
  assign oWrrVld  = rDataVld;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rWrrDataLast <= 0;
    end else if (wPkgReadEnd) begin
      if (rInDataVld & wDataRdy) begin
        rWrrDataLast <= 0;
      end else begin
        rWrrDataLast <= 1;
      end
    end else if (rInDataVld & wDataRdy) begin
      rWrrDataLast <= 0;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oWrrDataLast <= 0;
    end else if (rInDataVld & wDataRdy) begin
      if (wPkgReadEnd) begin
        oWrrDataLast <= 1;
      end else if (rWrrDataLast) begin
        oWrrDataLast <= 1;
      end else begin
        oWrrDataLast <= 0;
      end
    end else if (rDataVld && iWrrRdy && oWrrDataLast) begin
      oWrrDataLast <= 0;
    end
  end


  //--------------------------链表SRAM--------------------------------//

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oLNxtAddrReq <= 0;
    end else if (oLNxtAddrReq & iLdataVld) begin  //握手成功，请求信号拉低
      oLNxtAddrReq <= 0;
    end else if (rPkgFirAddrVld_r2[1] | (oBlockAddrVld & iMmuRdy & rDataRcvCnt == 15 & wWordNum != 0)) begin
      oLNxtAddrReq <= 1;
    end else begin
      oLNxtAddrReq <= oLNxtAddrReq;
    end
  end

  //NxtAddr
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rNxtAddrVld <= 0;
      rNxtAddr    <= 0;
    end else if (wPkgReadEnd) begin  //包全部传完置零
      rNxtAddrVld <= 0;
      rNxtAddr    <= 0;
    end else if (oLNxtAddrReq & iLdataVld) begin  //握手成功，收到下一个指针
      rNxtAddrVld <= 1;
      rNxtAddr    <= iLdata;
    end else begin
      rNxtAddrVld <= rNxtAddrVld;
      rNxtAddr    <= rNxtAddr;
    end
  end

  assign wPkgReadEnd = ((rBlockCnt == rBlockNum) & (wWordNum == rDataRcvCnt)) & rCurAddrVld;  //& rCurAddrVld为了防止包还没来的时候就判断结束
  assign oMmuReadLast = ((rBlockCnt == rBlockNum) & (wWordNum - 1 == rDataRcvCnt)) | ((rBlockCnt != rBlockNum) & (rDataRcvCnt == 15)); // TODO: confusion while wWordNum = 1
  assign wWordNum = rNxtAddr;
  //最后一个的Block是没有下一个指针的，所以其中存的是包末尾不完整Block的字数，rBlockCnt == rBlockNum时候才生效

  assign oLaddr = rCurAddr;

  //-------------------------------内存回收--------------------------------//
  assign oRcvrAddr = rCurAddr;
  // assign oRcvrAddrVld = (!rCurAddrVld_r1 & rCurAddrVld) |  //rCurAddrVld上升沿，用于包刚开始的时候发出第一个指针请求
  //   (rDataRcvCnteq15_r1 & !(rDataRcvCnt == 15) & rCurAddr != 0 & rCurAddrVld);  //rDataRcvCnt == 15的下降沿，用于Block读完了发出下一个指针请求
  //oRcvrAddrVld只拉高一个周期
  //全是完整block的情况下，最后一个0代表数量，不需要回收, 此时默认0地址不存数据，后面会再做修改
  //& rCurAddrVld: avoid repeat addr recycle when wordnum = 15 

  assign oRcvrAddrVld = oBlockAddrVld & iMmuRdy & oMmuReadLast;

  //-------------------------------丢包-----------------------------------//
  // wire wDropEnd;
  reg [4:0] rDropNum, rDropCnt;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rDropNum <= 0;
      oDropRun <= 0;
    end else if (oDropRun & wDropEnd) begin
      rDropNum <= 0;
      oDropRun <= 0;
    end else if (iPkgFirAddrVld & iPkgDrop) begin
      rDropNum <= iBlockNum + 1;  //15代表16个包
      oDropRun <= 1;
    end else begin
      rDropNum <= rDropNum;
      oDropRun <= oDropRun;
    end
  end

  //oDropRcvrAddr既需要发送到链表接收下一个地址又需要发给addrctrl进行回收
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oDropRcvrAddr    <= 0;
      oDropRcvrAddrVld <= 0;
    end else if (wDropEnd) begin
      oDropRcvrAddr    <= 0;
      oDropRcvrAddrVld <= 0;
    end else if (oDropRun & iDropChnRdy) begin
      oDropRcvrAddr    <= iLdata;
      oDropRcvrAddrVld <= iLdataVld;
    end else if (iPkgFirAddrVld & iPkgDrop) begin
      oDropRcvrAddr    <= iPkgFirAddr;
      oDropRcvrAddrVld <= 1;
    end else begin
      oDropRcvrAddr    <= oDropRcvrAddr   ;
      oDropRcvrAddrVld <= oDropRcvrAddrVld;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      rDropCnt <= 0;
    end else if (wDropEnd) begin
      rDropCnt <= 0;
    end else if (oDropRcvrAddrVld & iDropChnRdy) begin
      rDropCnt <= rDropCnt + 1;
    end else begin
      rDropCnt <= rDropCnt;
    end
  end

  assign wDropEnd = (rDropCnt == rDropNum + 1);  //需要把最后一个不完整的包也算上，所以是 + 1
endmodule
