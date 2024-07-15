// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_Unpack.v
// Author         : error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
// CreateDate     : 24-04-16
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-12
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
//  24-4-16 |  liuyanlong |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
`include "define.v"
module tb_Unpack ();

  reg         iClk;
  reg         iRst_n;
  //outside
  reg         iWrSop;
  reg         iWrEop;
  reg         iWrVld;
  reg  [31:0] iWrData;
  wire        oWrRdy;
  //Empty Addr
  reg  [11:0] iEptyAddr;
  reg         iEptyAddrVld;
  wire        oEptyAddrRcvRdy;
  //wrr
  reg         iWrrRdy;
  wire [ 2:0] oPkgPri;
  wire [ 3:0] oPkgDstPort;
  wire [11:0] oPkgFirAddr;  //包首地址
  wire [ 3:0] oPkgLen;
  wire        oPkgTagVld;
  //Lsram
  reg         iLWriteRdy;
  wire [11:0] oLdata;
  wire [31:0] oLaddr;  //link list addr
  wire        oLaddrVld;
  //MMU
  reg         iPkgDataRdy;  //mmu
  wire [31:0] oPkgData;
  wire        oPkgDataVld;
  wire [11:0] oPkgAddr;
  wire        oPkgAddrVld;
  wire        oPkgWrLast;

  Unpack U_Unpack (
    .iClk           (iClk),
    .iRst_n         (iRst_n),
    .iWrSop         (iWrSop),
    .iWrEop         (iWrEop),
    .iWrVld         (iWrVld),
    .iWrData        (iWrData),
    .oWrRdy         (oWrRdy),
    .iEptyAddr      (iEptyAddr),
    .iEptyAddrVld   (iEptyAddrVld),
    .oEptyAddrRcvRdy(oEptyAddrRcvRdy),
    .iWrrRdy        (iWrrRdy),
    .oPkgPri        (oPkgPri),
    .oPkgDstPort    (oPkgDstPort),
    .oPkgFirAddr    (oPkgFirAddr),
    .oPkgLen        (oPkgLen),
    .oPkgTagVld     (oPkgTagVld),
    .iLWriteRdy     (iLWriteRdy),
    .oLdata         (oLdata),
    .oLaddr         (oLaddr),
    .oLaddrVld      (oLaddrVld),
    .iPkgDataRdy    (iPkgDataRdy),
    .oPkgData       (oPkgData),
    .oPkgDataVld    (oPkgDataVld),
    .oPkgAddr       (oPkgAddr),
    .oPkgAddrVld    (oPkgAddrVld),
    .oPkgWrLast     (oPkgWrLast)
  );



  initial begin
    $fsdbDumpfile("tb_Unpack.fsdb");
    $fsdbDumpvars(0, tb_Unpack);
  end

  initial begin
    #100000 $display("timeout!");
    $finish;
  end

  initial begin

  end

  initial begin
    iClk = 1'b0;
    forever begin
      #5 iClk = ~iClk;
    end
  end

  reg [10:0] rPkgLen;  // 64-1024
  reg [ 4:0] rBlockLen;  // 1-17
  initial begin
    iRst_n = 1'b0;
    iWrSop = 1'b0;
    iWrEop = 1'b0;
    iWrVld = 1'b0;
    iWrData = 32'bx;
    iEptyAddr = 12'bx;
    iEptyAddrVld = 1'b0;
    iWrrRdy = 1'b0;
    iLWriteRdy = 1'b0;
    iPkgDataRdy = 1'b0;
    `DELAY(10, iClk)
    iRst_n = 1'b1;
    // rPkgLen = 64 + {$random($get_initial_random_seed)} % (1025 - 64);
    rPkgLen = 1024;
    rBlockLen = (rPkgLen + 63 + 4) >> 6;
    fork
      begin
        `DELAY(5, iClk)
        PKGSEND(0, 0, rPkgLen, 0);
      end
      begin
        `DELAY(5, iClk)
        repeat (rBlockLen) begin
          ADDRGEN($random);
        end
      end
      begin
        `DELAY(1, iClk)
        MMUREADY(1, 1, 1000);
      end
      begin
        `DELAY(5, iClk)
        LINKSRAMREADY(1, 0, 1000);
      end
      begin
        WRRREADY(1, 0, 1000);
      end
      begin
        HANDSHAKE_MONITOR(1000);
      end
    join


    #10000 $finish;
  end

  // reg oWrRdy_s;

  task PKGSEND;
    input [2:0] prio;  // 0-7
    input [3:0] destPort;  // 0-15
    input [10:0] pkgLen;  //Byte :64-1024
    input integer delay;  //random delay
    reg [9:0] rLen;
    begin
      rLen   = pkgLen - 1;
      //Sop
      iWrSop = 1'b1;
      `DELAY(1, iClk)
      iWrSop = 1'b0;
      //Ctrl frame
      `DELAY(delay, iClk)
      iWrVld  = 1'b1;
      iWrData = {15'b0, rLen, prio, destPort};
      `DELAY(1, iClk)
      iWrVld = 1'b0;
      //Data frame
      repeat (pkgLen >> 2) begin
        `DELAY(delay, iClk)
        iWrVld  = 1'b1;
        iWrData = $random;
        @(posedge iClk);
        while (!oWrRdy) @(posedge iClk);
        #1;
        iWrVld = 1'b0;
      end
      iWrData = 32'bx;
      if (pkgLen[1:0]) begin
        `DELAY(delay, iClk)
        iWrVld = 1'b1;
        iWrData[31:24] = 8'b0;
        iWrData[23:16] = pkgLen[1:0] > 2 ? $random : 8'b0;
        iWrData[15:8] = pkgLen[1:0] > 1 ? $random : 8'b0;
        iWrData[7:0] = $random;
        @(posedge iClk);
        while (!oWrRdy) @(posedge iClk);
        #1;
        iWrVld = 1'b0;
      end
      iWrData = 32'bx;
      //CRC result
      `DELAY(delay, iClk)
      iWrVld  = 1'b1;
      iWrData = 32'hdeadbeef;
      @(posedge iClk);
      while (!oWrRdy) @(posedge iClk);
      #1;
      iWrVld  = 1'b0;
      iWrData = 32'bx;
      //Eop
      iWrEop  = 1'b1;
      `DELAY(1, iClk)
      iWrEop = 1'b0;
    end
  endtask

  // always @(posedge iClk or negedge iRst_n) begin
  //   if (!iRst_n) begin
  //     oWrRdy_s = #1 1'b0;
  //   end else begin
  //     oWrRdy_s = #1 $random;
  //   end
  // end

  task ADDRGEN;
    input [11:0] addr;
    begin
      iEptyAddr = addr;
      iEptyAddrVld = 1'b1;
      while (!oEptyAddrRcvRdy) @(posedge iClk);
      @(posedge iClk) #1;
    end
  endtask

  task MMUREADY;
    input ready_on;
    input rdm_on;
    input integer max_cyc;
    begin
      repeat (max_cyc) begin
        `DELAY(1, iClk)
        if (rdm_on) begin
          iPkgDataRdy = $random;
        end else begin
          iPkgDataRdy = ready_on;
        end
      end
    end
  endtask

  task LINKSRAMREADY;
    input ready_on;
    input rdm_on;
    input integer max_cyc;
    begin
      repeat (max_cyc) begin
        `DELAY(1, iClk)
        if (rdm_on) begin
          iLWriteRdy = $random;
        end else begin
          iLWriteRdy = ready_on;
        end
      end
    end
  endtask

  task WRRREADY;
    input ready_on;
    input rdm_on;
    input integer max_cyc;
    begin
      repeat (max_cyc) begin
        `DELAY(1, iClk)
        if (rdm_on) begin
          iWrrRdy = $random;
        end else begin
          iWrrRdy = ready_on;
        end
      end
    end
  endtask

  task HANDSHAKE_MONITOR;
    input integer max_cyc;
    reg [31:0] cnt;
    reg [31:0] cnt1;
    begin
      cnt  = 0;
      cnt1 = 0;
      repeat (max_cyc) begin
        @(posedge iClk);
        if (oPkgAddrVld && oPkgDataVld && iPkgDataRdy) begin
          cnt = cnt + 1;
          $display("@%t, Data Send Success! Total: %d", $time, cnt);
          if (oPkgWrLast) begin
            cnt1 = cnt1 + 1;
            $display("@%t, Block Send Success! Total: %d", $time, cnt1);
          end
        end
      end
    end
  endtask



endmodule
