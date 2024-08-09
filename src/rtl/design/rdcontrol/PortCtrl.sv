/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/PortCtrl.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-15
 * @LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-05-17
 * Version        :
 * @Description    : 接收Queue和丢包请求，并发回至mmu，同时提供数据输出通道
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
 *  23-08-24 |     CICC2060    |     0.1     | Original Version
 *                  
 * 
 */
 `include "define.v"
module PortCtrl #(
  parameter PORT_ADDR = 4'b0000
)(
  input   logic                     iClk,
  input   logic                     iRst_n,
  
  Decoupled.slave                   iTagQueueIn,       // Decoupled#(.DW(`ADDR_LENTH+8), .AW(0))
  Decoupled.slave                   iTagDropIn,        // Decoupled#(.DW(`ADDR_LENTH+8), .AW(0))

  Decoupled.master                  oRdCmd,     // Decoupled#(.DW(`ADDR_LENTH+9), .AW(4))     // { firAddr, pktLen, dstPort, dropFlag}
  
  Decoupled.slave                   iRdData,    // Decoupled#(.DW(`DATA_WIDTH+1), .AW(4))

  output  logic                     oRdSop,
  output  logic                     oRdEop,
  output  logic                     oRdVld,
  output  logic [`DATA_WIDTH-1:0]   oRdData,
  input   logic                     iRdRdy,
  output  logic                     oRdLast
);

  logic   [3:0]               queueSrcPort;
  logic   [3:0]               queueDstPort;   // dst port for rddata, which is the PORT_ADDR of this port
  logic   [`ADDR_LENTH+4-1:0] queueMsg;

  logic   [3:0]               dropSrcPort;
  logic   [`ADDR_LENTH+4-1:0] dropMsg;

  logic                       rdCmdDrop;

  logic                       rawRdLast;
  logic   [`DATA_WIDTH-1:0]   rawRdData;

  logic                       tmpRdRdy;
  logic                       tmpRdVld;
  logic                       tmpRdLast;
  logic   [1:0]               fsmCstate_d;

  assign queueDstPort = PORT_ADDR;


  // 浅浅分配一下位宽，姐妹们，这个位宽是不是有点大
  // 注意，们字往后是copilot自己说的
  // 
  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      queueMsg <= 'b0;
      queueSrcPort <= 'b0;
    end else if(iTagQueueIn.Vld && iTagQueueIn.Rdy) begin
      {queueMsg, queueSrcPort} <= iTagQueueIn.Pld;
    end else begin
      {queueMsg, queueSrcPort} <= {queueMsg, queueSrcPort};
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      dropMsg <= 'b0;
      dropSrcPort <= 'b0;
    end else if(iTagDropIn.Vld && iTagDropIn.Rdy) begin
      {dropMsg, dropSrcPort} <= iTagDropIn.Pld;
    end else begin
      {dropMsg, dropSrcPort} <= {dropMsg, dropSrcPort};
    end
  end

  assign {rawRdData, rawRdLast} = iRdData.Pld;


  localparam FSM_IDLE   = 2'b00;
  localparam FSM_DROP   = 2'b01;
  localparam FSM_RDCMD  = 2'b10;
  localparam FSM_RDDATA = 2'b11;

  logic [1:0] fsmCstate, fsmNstate;


  // 主状态机
  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      fsmCstate <= FSM_IDLE;
    end else begin
      fsmCstate <= fsmNstate;
    end
  end

  always @(*) begin
    case(fsmCstate) 
    FSM_IDLE : begin
      if(iTagDropIn.Vld && iTagDropIn.Rdy) begin
        fsmNstate = FSM_DROP;
      end else if(iTagQueueIn.Vld && iTagQueueIn.Rdy) begin
        fsmNstate = FSM_RDCMD;
      end else begin
        fsmNstate = FSM_IDLE;
      end
    end
    FSM_DROP : begin
      if(oRdCmd.Vld && oRdCmd.Rdy) begin
        fsmNstate = FSM_IDLE;
      end else begin
        fsmNstate = FSM_DROP;
      end
    end
    FSM_RDCMD : begin
      if(oRdCmd.Vld && oRdCmd.Rdy) begin
        fsmNstate = FSM_RDDATA;
      end else begin
        fsmNstate = FSM_RDCMD;
      end
    end
    FSM_RDDATA : begin
      //if(rawRdLast && iRdData.Vld && iRdData.Rdy) begin //this would enable pielined sop/eop. not supported yet
      //if(oRdLast && iRdRdy && oRdVld) begin
      if(tmpRdLast && iRdRdy && tmpRdVld) begin
        fsmNstate = FSM_IDLE;
      end else begin
        fsmNstate = FSM_RDDATA;
      end
    end
    default : fsmNstate = FSM_IDLE;
    endcase
  end 

  // 优先应答Drop
  // assign iTagDropIn.Rdy  = (fsmCstate == FSM_IDLE) ? iTagDropIn.Vld : 1'b0;
  // assign iTagQueueIn.Rdy = (fsmCstate == FSM_IDLE) ? (iTagQueueIn.Vld && !iTagDropIn.Vld) : 1'b0;
  // Queue And Drop should be round-robin
  rr_arb_tree #(
    .NumIn(2),
    .DataWidth(1),
    .AxiVldRdy(1),
    .LockIn(0)
  )U_RR_QUEUE_DROP(
    .rst_ni (iRst_n),
    .clk_i (iClk),
    .req_i({iTagDropIn.Vld, iTagQueueIn.Vld}),
    .gnt_o({iTagDropIn.Rdy, iTagQueueIn.Rdy}),
    .data_i(),

    .req_o(),
    .gnt_i(fsmCstate == FSM_IDLE),
    .data_o()
  );

  assign rdCmdDrop = fsmCstate == FSM_DROP;

  assign oRdCmd.Vld = ^fsmCstate;   //DROP RDCMD
  assign oRdCmd.Pld = fsmCstate[0] ? {dropMsg, queueDstPort, rdCmdDrop} : {queueMsg, queueDstPort, rdCmdDrop};
  assign oRdCmd.Dst = fsmCstate[0] ? dropSrcPort : queueSrcPort;


  // ================================= 下面来折腾数据通道
  

  
  gnrl_buf#(
    .DW(`DATA_WIDTH+1),
    .CUT_RDY(1)
  ) U_INBUF(
    .clk_i      (iClk),
    .rst_n_i    (iRst_n),
    .din_i      ({rawRdData, rawRdLast}),
    .din_vld_i  (iRdData.Vld),
    .din_rdy_o  (iRdData.Rdy),
    .dout_o     ({oRdData, tmpRdLast}),
    .dout_vld_o (tmpRdVld),
    .dout_rdy_i (tmpRdRdy)
  );

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      fsmCstate_d <= FSM_IDLE;
    end else begin
      fsmCstate_d <= fsmCstate;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      oRdSop <= 1'b0;
    end else begin
      oRdSop <= fsmCstate == FSM_RDCMD && fsmCstate_d == FSM_IDLE;
    end
  end

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      oRdEop <= 1'b0;
    end else begin
      oRdEop <= iRdRdy && oRdLast && oRdVld;
    end
  end

  assign tmpRdRdy = (fsmCstate_d == FSM_RDDATA) ? iRdRdy : 1'b0;
  assign oRdVld   = {fsmCstate_d == FSM_RDDATA} ? tmpRdVld : 1'b0;
  assign oRdLast = tmpRdLast & tmpRdVld;

endmodule