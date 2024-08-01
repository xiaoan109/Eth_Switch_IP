// +FHEADER =====================================================================
// FilePath       : /prj/Switch/src/tb/tb_AddrCtrl.v
// Author         : error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
// CreateDate     : 24-04-24
// LastEditors    : liuyanlong 2283670208@qq.com
// LastEditTime   : 24-05-09
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

module tb_AddrCtrl ();
  //tb parameter
  localparam READ_DELAY = 16;
  localparam START_CLK = 10;

  //
  localparam ADDR_LENTH = 12;
  localparam DATA_WIDTH = 32;

  reg                          iClk;
  reg                          iRst_n;
  reg     [ADDR_LENTH - 1 : 0] iRecAddr    [3:0];
  reg                          iRecAddrVld [3:0];
  wire                         oRecAddrRdy [3:0];
  reg                          iEptyAddrRdy[3:0];

  reg     [              31:0] rAddrCnt;

  wire    [  ADDR_LENTH - 1:0] oEptyAddr   [3:0];
  wire                         oEptyAddrVld[3:0];

reg wInitFns;
integer i;
initial begin
    $fsdbDumpfile("tb_AddrCtrl.fsdb");
    $fsdbDumpvars("+all");  

    iClk     <= 0;
    iRst_n   <= 0;
    rAddrCnt <= 0;
    wInitFns <= 0;
    for (i = 0; i < 4; i = i + 1) begin
      iRecAddrVld[i]  <= 0;
      iRecAddr[i]     <= 0;
      iEptyAddrRdy[i] <= 0;
    end

    #20 iRst_n <= 1;

    repeat (START_CLK) @(posedge iClk);
    INIT();
    wInitFns <= 1;

    repeat (10) @(posedge iClk);
    OUTPUTADDR();

    repeat (1000) @(posedge iClk);
    $finish;
  end

  initial begin
    wait (wInitFns);
    @(posedge iClk);
    forever begin
      iRecAddr[0] <= oEptyAddr[0];
      iRecAddr[1] <= oEptyAddr[1];
      iRecAddr[2] <= oEptyAddr[2];
      iRecAddr[3] <= oEptyAddr[3];

      iRecAddrVld[0] <= oEptyAddrVld[0];
      iRecAddrVld[1] <= oEptyAddrVld[1];
      iRecAddrVld[2] <= oEptyAddrVld[2];
      iRecAddrVld[3] <= oEptyAddrVld[3];
      @(posedge iClk);
    end

  end

  always begin
    #5 iClk = ~iClk;
  end

  task INIT();
    fork
      begin
        repeat (4096) begin
          rAddrCnt <= rAddrCnt + 1;
          @(posedge iClk);
        end
      end

      begin
        repeat (4096) begin
          iRecAddrVld[0] <= 1;
          iRecAddr[0]    <= rAddrCnt;
          @(posedge iClk);
        end
        iRecAddr[0] <= 0;
        iRecAddrVld[0] <= 0;
        @(posedge iClk);

      end
    join
  endtask

  task OUTPUTADDR();
    fork
      begin
        repeat (1025) begin
          iEptyAddrRdy[0] <= 1;
          @(posedge iClk);
          wait (oEptyAddrVld[0]) begin
            iEptyAddrRdy[0] <= 0;
            repeat (READ_DELAY - 1) @(posedge iClk);
          end
        end
      end

      begin
        repeat (1025) begin
          iEptyAddrRdy[1] <= 1;
          @(posedge iClk);
          wait (oEptyAddrVld[1]) begin
            iEptyAddrRdy[1] <= 0;
            repeat (READ_DELAY - 1) @(posedge iClk);
          end
        end
      end

      begin
        repeat (1025) begin
          iEptyAddrRdy[2] <= 1;
          @(posedge iClk);
          wait (oEptyAddrVld[2]) begin
            iEptyAddrRdy[2] <= 0;
            repeat (READ_DELAY - 1) @(posedge iClk);
          end
        end
      end

      begin
        repeat (1025) begin
          iEptyAddrRdy[3] <= 1;
          @(posedge iClk);
          wait (oEptyAddrVld[3]) begin
            iEptyAddrRdy[3] <= 0;
            repeat (READ_DELAY - 1) @(posedge iClk);
          end
        end
      end
    join
  endtask

  task RECIVEADDR(
    input [ADDR_LENTH-1:0] iAddr0, input [ADDR_LENTH-1:0] iAddr1, input [ADDR_LENTH-1:0] iAddr2,
    input [ADDR_LENTH-1:0] iAddr3, input iAddrVld0, input iAddrVld1, input iAddrVld2,
    input iAddrVld3, output reg [ADDR_LENTH-1:0] oAddr0, output reg [ADDR_LENTH-1:0] oAddr1,
    output reg [ADDR_LENTH-1:0] oAddr2, output reg [ADDR_LENTH-1:0] oAddr3, output reg oAddrVld0,
    output reg oAddrVld1, output reg oAddrVld2, output reg oAddrVld3);
    begin
      repeat (4096) begin
        oAddr0    <= iAddr0;
        oAddr1    <= iAddr1;
        oAddr2    <= iAddr2;
        oAddr3    <= iAddr3;

        oAddrVld0 <= iAddrVld0;
        oAddrVld1 <= iAddrVld1;
        oAddrVld2 <= iAddrVld2;
        oAddrVld3 <= iAddrVld3;

        @(posedge iClk);
      end
    end
endtask

AddrCtrl #(
    .FIFO_DEPTH(4096),
    .DATA_WIDTH(12)
  ) AddrCtrl_0 (

    .iClk  (iClk),
    .iRst_n(iRst_n),

    .iRecAddr0   (iRecAddr[0]),
    .iRecAddrVld0(iRecAddrVld[0]),

    .iRecAddr1   (iRecAddr[1]),
    .iRecAddrVld1(iRecAddrVld[1]),

    .iRecAddr2   (iRecAddr[2]),
    .iRecAddrVld2(iRecAddrVld[2]),

    .iRecAddr3   (iRecAddr[3]),
    .iRecAddrVld3(iRecAddrVld[3]),


    .iEptyAddrRdy0(iEptyAddrRdy[0]),
    .oEptyAddr0   (oEptyAddr[0]),
    .oEptyAddrVld0(oEptyAddrVld[0]),

    .iEptyAddrRdy1(iEptyAddrRdy[1]),
    .oEptyAddr1   (oEptyAddr[1]),
    .oEptyAddrVld1(oEptyAddrVld[1]),

    .iEptyAddrRdy2(iEptyAddrRdy[2]),
    .oEptyAddr2   (oEptyAddr[2]),
    .oEptyAddrVld2(oEptyAddrVld[2]),

    .iEptyAddrRdy3(iEptyAddrRdy[3]),
    .oEptyAddr3   (oEptyAddr[3]),
    .oEptyAddrVld3(oEptyAddrVld[3]),

    .iDropData(),
    .iDropDataVld(),
    .oFull (),
    .oAlmostFull()
  );


endmodule
