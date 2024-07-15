/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/RdDstLock.sv
 * @Author         : zhouziheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-17
 * @LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-07-10
 * Version        :
 * @Description    : 
 *                  
 * 
 * Parameter       :
 *                  
 * 
 * IO Port         :
 *                  
 * 
 * Modification History
 *    Date   |   Author   |   Version   |   Change Description
 * ==============================================================================
 *  23-08-24 |     NJU    |     0.1     | Original Version
 *                  
 * 
 */
`include "define.v"
module RdDstLock #(
) (
  input   logic     iClk,
  input   logic     iRst_n,

  Decoupled.slave   iRdDataIn,  // RdDataIn dosent have the dst infom
  Decoupled.master  oRdDataOut, // RdDataOut now knows where to go
  Decoupled.slave   iRdCmdIn,   // RdCmd will provide the dst for rddata
  Decoupled.master  oRdCmdOut
);

  logic   [3:0]               rdCmdDstPort;   // this is the src of rdcmd, also the dst of rddata
  logic   [`ADDR_LENTH+4-1:0] rdCmdMsg;
  logic                       rdCmdDrop;

  logic   [3:0]               lockedDst;

  logic   [`DATA_WIDTH-1:0]   rdData;
  logic                       rdLast;

  logic   dstLockFlag;

  assign {rdCmdMsg, rdCmdDstPort, rdCmdDrop} = iRdCmdIn.Pld;
  assign {rdData, rdLast} = iRdDataIn.Pld;

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      dstLockFlag <= 1'b0;
    end else if(iRdCmdIn.Vld && iRdCmdIn.Rdy && !rdCmdDrop) begin
      dstLockFlag <= 1'b1;
    end else if(rdLast & iRdDataIn.Vld & iRdDataIn.Rdy) begin
      dstLockFlag <= 1'b0;
    end else begin
      dstLockFlag <= dstLockFlag;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      lockedDst <= 'b0;
    end else if(!dstLockFlag & iRdCmdIn.Vld && iRdCmdIn.Rdy && !rdCmdDrop) begin // a valid data trans cmd
      lockedDst <= rdCmdDstPort;
    end else begin
      lockedDst <= lockedDst;
    end
  end

  assign oRdDataOut.Dst = lockedDst;
  assign oRdDataOut.Pld = iRdDataIn.Pld;
  assign oRdDataOut.Vld = iRdDataIn.Vld;
  assign iRdDataIn.Rdy  = oRdDataOut.Rdy;

  assign oRdCmdOut.Dst = iRdCmdIn.Dst;
  assign oRdCmdOut.Pld = iRdCmdIn.Pld;
  assign oRdCmdOut.Vld = iRdCmdIn.Vld & !dstLockFlag;
  assign iRdCmdIn.Rdy  = oRdCmdOut.Rdy & !dstLockFlag;

  
endmodule