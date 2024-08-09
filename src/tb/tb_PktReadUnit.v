// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_PktReadUnit.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-05-07
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-16
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
//  23-08-24 |     CICC2060    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================

module tb_PktReadUnit ();
  localparam ADDR_LENTH = 12;
  localparam DATA_WIDTH = 32;

  localparam PKTNUM = 2;  //0代表1个整包，1代表2个整包
  localparam WORDNUM = 15;

  localparam FIRADDR = 1;

  reg                     iClk;
  reg                     iRst_n;

  wire [ADDR_LENTH - 1:0] oRcvrAddr;
  wire                    oRcvrAddrVld;
  reg  [ADDR_LENTH - 1:0] iLdata;
  reg                     iLdataVld;
  wire [ADDR_LENTH - 1:0] oLaddr;
  wire                    oLNxtAddrReq;
  reg                     iMmuRdy;
  wire [ADDR_LENTH - 1:0] oBlockAddr;
  wire                    oBlockAddrVld;
  wire                    oMmuReadReq;
  wire                    oMmuReadLast;
  reg  [DATA_WIDTH - 1:0] iData;
  wire                    oMmuRdy;
  reg  [ADDR_LENTH - 1:0] iPktFirAddr;
  reg                     iPktFirAddrVld;
  reg  [             3:0] iBlockNum;
  wire                    oPktFirAddrRdy;
  wire [DATA_WIDTH - 1:0] oWrrData;
  wire                    oWrrVld;
  reg                     iWrrRdy;
  reg                     oLNxtAddrReq_r1;
  wire                    wNxtEn;

  //tb reg
  reg  [            11:0] rCnt;

  initial begin
    $fsdbDumpfile("tb_PktReadUnit.fsdb");
    $fsdbDumpvars("+all");

    iClk           <= 0;
    iRst_n         <= 0;
    iLdata         <= 0;
    iLdataVld      <= 0;
    iMmuRdy        <= 0;
    iData          <= 0;
    iPktFirAddr    <= 0;
    iPktFirAddrVld <= 0;
    iBlockNum      <= 0;
    iWrrRdy        <= 0;
    rCnt           <= 0;
    #100 iRst_n <= 1;

    repeat (10) @(posedge iClk);

  end

  initial begin
    repeat (10000) @(posedge iClk);
    $finish;
  end

  always begin
    #5 iClk = ~iClk;
  end

  //-------------------------------LSRAM-----------------------------------//
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iLdata    <= 0;
      iLdataVld <= 0;
      rCnt      <= 0;
    end else if (wNxtEn) begin
      if (rCnt == PKTNUM + 1 & WORDNUM != 0) begin
        iLdata <= WORDNUM;
        rCnt   <= 0;
      end else if (WORDNUM == 0 && rCnt == PKTNUM) begin
        iLdata <= WORDNUM;
        rCnt   <= 0;
      end else begin
        iLdata <= rCnt + FIRADDR + 1;
        rCnt   <= rCnt + 1;
      end
      iLdataVld <= 1;
    end else begin
      iLdata    <= 0;
      iLdataVld <= 0;
      rCnt      <= rCnt;
    end
  end


  always @(posedge iClk) begin
    oLNxtAddrReq_r1 <= oLNxtAddrReq;
  end

  assign wNxtEn = !oLNxtAddrReq_r1 & oLNxtAddrReq;


  //---------------------------------MMU-------------------------//

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iData <= 32'b0;
    end else if (oBlockAddrVld & iMmuRdy) begin
      iData <= iData + 1;
    end
  end

  // always @(posedge iClk or negedge iRst_n) begin
  //   if (!iRst_n) begin
  //     iMmuRdy <= 1'b0;
  //   end else begin
  //     iMmuRdy <= $urandom;
  //   end
  // end
  always @(posedge iClk or negedge iRst_n) begin
    iMmuRdy <= 1'b1;
  end


  //---------------------------------WRR-------------------------//

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      iPktFirAddr    <= FIRADDR;
      iPktFirAddrVld <= 1;
      iBlockNum      <= PKTNUM;
    end else if (!iPktFirAddrVld) begin
      iPktFirAddr    <= FIRADDR;
      iPktFirAddrVld <= 1;
      iBlockNum      <= PKTNUM;
    end else if (oPktFirAddrRdy & iPktFirAddrVld) begin
      iPktFirAddr    <= 0;
      iPktFirAddrVld <= 0;
      iBlockNum      <= 0;
    end
  end

  // always @(posedge iClk or negedge iRst_n) begin
  //   if (!iRst_n) begin
  //     iWrrRdy <= 1'b0;
  //   end else begin
  //     iWrrRdy <= $urandom;
  //   end
  // end
    always @(posedge iClk or negedge iRst_n) begin
      iWrrRdy <= 1;
    end

  PktReadUnit #(
    .ADDR_LENTH(ADDR_LENTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) PktReadUnit_0 (
    .iClk  (iClk),
    .iRst_n(iRst_n),

    //AddrCtrl
    .oRcvrAddr       (oRcvrAddr),
    .oRcvrAddrVld    (oRcvrAddrVld),
    .oDropRun        (),
    //链表SRAM
    .iLdata          (iLdata),
    .iLdataVld       (iLdataVld),
    .oLaddr          (oLaddr),
    .oLNxtAddrReq    (oLNxtAddrReq),
    .oDropRcvrAddr   (),
    .oDropRcvrAddrVld(),
    //MMU
    .iMmuRdy         (iMmuRdy),
    .oBlockAddr      (oBlockAddr),
    .oBlockAddrVld   (oBlockAddrVld),
    .oMmuReadReq     (oMmuReadReq),
    .oMmuReadLast    (oMmuReadLast),
    .iData           (iData),

    //WRR
    .iPktFirAddr   (iPktFirAddr),
    .iPktFirAddrVld(iPktFirAddrVld),
    .iBlockNum     (iBlockNum),
    .iPktDrop      (1'b0),
    .oPktFirAddrRdy(oPktFirAddrRdy),
    .oWrrData      (oWrrData),
    .oWrrDataLast  (),
    .oWrrVld       (oWrrVld),
    .iWrrRdy       (iWrrRdy),

    .iDropChnRdy()
  );

endmodule
