// +FHEADER =====================================================================
// FilePath       : /Switch/src/tb/tb_LinkListSram.v
// Author         : liuyanlong 2283670208@qq.com
// CreateDate     : 24-05-05
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-11
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
//  23-08-24 |     NJU    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================

module tb_LinkListSram();
localparam ADDR_LENTH = 12;

reg iClk;
reg iRst_n;

reg [ADDR_LENTH - 1:0] iWriteLdata0,iWriteLdata1,iWriteLdata2,iWriteLdata3;
reg [ADDR_LENTH - 1:0] iWriteLaddr0,iWriteLaddr1,iWriteLaddr2,iWriteLaddr3;
reg [ADDR_LENTH - 1:0] iLaddr0,iLaddr1,iLaddr2,iLaddr3;
reg                    iWriteLaddrVld0;
reg                    iWriteLaddrVld1;
reg                    iWriteLaddrVld2;
reg                    iWriteLaddrVld3;
                
reg                    iLNxtAddrReq0;
reg                    iLNxtAddrReq1;
reg                    iLNxtAddrReq2;
reg                    iLNxtAddrReq3;

wire oLdataVld0,oLdataVld1,oLdataVld2,oLdataVld3;

//tb reg
reg [ADDR_LENTH - 1:0]  rWriteAddrBase;
reg [12:0]              rCnt0,rCnt1,rCnt2,rCnt3;

initial begin
    $fsdbDumpfile("tb_LinkListSram.fsdb");
    $fsdbDumpvars("+all");  

    iClk <= 0;
    iRst_n <= 0;
    rWriteAddrBase<=0;
    iWriteLdata0 <= 0;
    iWriteLdata1 <= 0;
    iWriteLdata2 <= 0;
    iWriteLdata3 <= 0;
    iWriteLaddr0 <= 0;
    iWriteLaddr1 <= 0;
    iWriteLaddr2 <= 0;
    iWriteLaddr3 <= 0;
    rCnt0 <= 0;
    rCnt1 <= 1;
    rCnt2 <= 2;
    rCnt3 <= 3;
    iWriteLaddrVld0 <= 0;
    iWriteLaddrVld1 <= 0;
    iWriteLaddrVld2 <= 0;
    iWriteLaddrVld3 <= 0;  

    iLaddr0 <= 0;
    iLaddr1 <= 0;
    iLaddr2 <= 0;
    iLaddr3 <= 0;
    iLNxtAddrReq0 <= 0;
    iLNxtAddrReq1 <= 0;
    iLNxtAddrReq2 <= 0;
    iLNxtAddrReq3 <= 0;

    #20 iRst_n <= 1;
    @(posedge iClk);
    SRAM_WRITE();
    repeat(10)@(posedge iClk);
    
    SRAM_READ();
    repeat(10)@(posedge iClk);
    $finish;
end

always begin
    #5 iClk = ~iClk;
end

task SRAM_WRITE();
fork
    begin
        repeat(1024)begin
            rWriteAddrBase <= rWriteAddrBase + 1;
            repeat(17)@(posedge iClk);
        end
    end

    begin
        repeat(1024)begin
                iWriteLdata0 <= 4*rWriteAddrBase;
                iWriteLdata1 <= 4*rWriteAddrBase+1;
                iWriteLdata2 <= 4*rWriteAddrBase+2;
                iWriteLdata3 <= 4*rWriteAddrBase+3;

                iWriteLaddr0 <= 4*rWriteAddrBase;
                iWriteLaddr1 <= 4*rWriteAddrBase+1;
                iWriteLaddr2 <= 4*rWriteAddrBase+2;
                iWriteLaddr3 <= 4*rWriteAddrBase+3;

                iWriteLaddrVld0 <= 1;
                iWriteLaddrVld1 <= 1;
                iWriteLaddrVld2 <= 1;
                iWriteLaddrVld3 <= 1;
                repeat(1)@(posedge iClk);

                iWriteLaddrVld0 <= 0;
                iWriteLaddrVld1 <= 0;
                iWriteLaddrVld2 <= 0;
                iWriteLaddrVld3 <= 0;
                repeat(16)@(posedge iClk);
        end
    end
join
endtask

task SRAM_READ();
fork
    begin
        repeat(1024)begin
            if(iLNxtAddrReq0 & oLdataVld0)begin
                iLaddr0 <= 0;
                iLNxtAddrReq0 <=0 ;
                rCnt0 <= rCnt0 + 4;
                repeat(16)@(posedge iClk);
            end else begin
                iLaddr0 <= rCnt0;
                iLNxtAddrReq0 <= 1;
                rCnt0 <= rCnt0 ;
                repeat(1)@(posedge iClk);
            end
        end
    end

    begin
        repeat(1024)begin
            if(iLNxtAddrReq1 & oLdataVld1)begin
                iLaddr1 <= 0;
                iLNxtAddrReq1 <=0 ;
                rCnt1 <= rCnt1 + 4;
                repeat(16)@(posedge iClk);
            end else begin
                iLaddr1 <= rCnt1;
                iLNxtAddrReq1 <= 1;
                rCnt1 <= rCnt1 ;
                repeat(1)@(posedge iClk);
            end
        end
    end

    begin
        repeat(1024)begin
            if(iLNxtAddrReq2 & oLdataVld2)begin
                iLaddr2 <= 0;
                iLNxtAddrReq2 <=0 ;
                rCnt2 <= rCnt2 + 4;
                repeat(16)@(posedge iClk);
            end else begin
                iLaddr2 <= rCnt2;
                iLNxtAddrReq2 <= 1;
                rCnt2 <= rCnt2 ;
                repeat(1)@(posedge iClk);
            end
        end
    end

    begin
        repeat(1024)begin
            if(iLNxtAddrReq3 & oLdataVld3)begin
                iLaddr3 <= 0;
                iLNxtAddrReq3 <=0 ;
                rCnt3 <= rCnt3 + 4;
                repeat(16)@(posedge iClk);
            end else begin
                iLaddr3 <= rCnt3;
                iLNxtAddrReq3 <= 1;
                rCnt3 <= rCnt3 ;
                repeat(1)@(posedge iClk);
            end
        end
    end
join
endtask


LinkListSram #(
    .ADDR_LENTH(12)
) LinkListSram_inst (
    .iClk                   (iClk           ),
    .iRst_n                 (iRst_n         ),

    .iWriteLdata0           (iWriteLdata0   ),
    .iWriteLaddr0           (iWriteLaddr0   ),
    .iWriteLaddrVld0        (iWriteLaddrVld0),

    .iWriteLdata1           (iWriteLdata1   ),
    .iWriteLaddr1           (iWriteLaddr1   ),
    .iWriteLaddrVld1        (iWriteLaddrVld1),

    .iWriteLdata2           (iWriteLdata2   ),
    .iWriteLaddr2           (iWriteLaddr2   ),
    .iWriteLaddrVld2        (iWriteLaddrVld2),

    .iWriteLdata3           (iWriteLdata3   ),
    .iWriteLaddr3           (iWriteLaddr3   ),
    .iWriteLaddrVld3        (iWriteLaddrVld3),

    .oLdata0                (               ),
    .oLdataVld0             (oLdataVld0     ),
    .iLaddr0                (iLaddr0        ),
    .iLNxtAddrReq0          (iLNxtAddrReq0  ),
  
    .oLdata1                (               ),
    .oLdataVld1             (oLdataVld1     ),
    .iLaddr1                (iLaddr1        ),
    .iLNxtAddrReq1          (iLNxtAddrReq1  ),
  
    .oLdata2                (               ),
    .oLdataVld2             (oLdataVld2     ),
    .iLaddr2                (iLaddr2        ),
    .iLNxtAddrReq2          (iLNxtAddrReq2  ),

    .oLdata3                (               ),
    .oLdataVld3             (oLdataVld3     ),
    .iLaddr3                (iLaddr3        ),
    .iLNxtAddrReq3          (iLNxtAddrReq3  ),

    .iDropAddr              (0),
    .iDropAddrVld           (0),
    .oDropData              (),
    .oDropDataVld           ()
);


endmodule