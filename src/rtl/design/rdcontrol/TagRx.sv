/*
 * @FilePath       : /Switch/src/rtl/design/rdcontrol/TagRx.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-15
 * @LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-05-18
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
module TagRx (
  input   logic     iClk,
  input   logic     iRst_n,

  Decoupled.slave   iTagIn,

  Decoupled.master  oTagQueueOut[0:7],     // 进入优先级队列
  Decoupled.master  oTagDropOut         // 丢包
);

  // ==================================== 连接关系
  // iTagIn的Pld
  logic   [2:0]                 rxTagPri;     // 优先级，决定去哪个queue
  logic   [3:0]                 rxTagSrcPort; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   rxTagMsg;     // 包首地址+包长度，RD不需要对其做区分

  // Tag有写请求时缓存的信息
  logic   [2:0]                 tagPri;     // 优先级，决定去哪个queue
  logic   [3:0]                 tagSrcPort; // 源端口，这个需要存，后面知道怎么向前级发读请求
  logic   [`ADDR_LENTH+4-1:0]   tagMsg;     // 包首地址+包长度，RD不需要对其做区分

  logic   [7:0]                 queueOutVld;
  logic   [7:0]                 queueOutRdy;

  genvar i;

  assign {rxTagPri, rxTagMsg, rxTagSrcPort} = iTagIn.Pld;  
  
  assign oTagDropOut.Pld = {tagMsg, tagSrcPort};
  generate
    for(i=0; i<8;i =i+1) begin : GEN_QUEUE_PLD
      assign oTagQueueOut[i].Pld = {tagMsg, tagSrcPort};
      assign oTagQueueOut[i].Vld = queueOutVld[i];
      assign queueOutRdy[i] = oTagQueueOut[i].Rdy;
    end
  endgenerate

  // =============================== 控制逻辑
  logic [1:0] fsmCstate;
  logic [1:0] fsmNstate;

  localparam FSM_IDLE     = 2'b00;
  localparam FSM_FETCH    = 2'b01;
  localparam FSM_DISPATCH = 2'b10;
  localparam FSM_DROP     = 2'b11;

  int j;

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
        if(iTagIn.Vld && iTagIn.Rdy) begin
          fsmNstate = FSM_FETCH;
        end else begin
          fsmNstate = FSM_IDLE;
        end
      end
      FSM_FETCH : begin
        if(queueOutRdy[tagPri]) begin
          fsmNstate = FSM_DISPATCH;
        end else begin
          fsmNstate = FSM_DROP;
        end
      end
      FSM_DISPATCH : begin
        if(queueOutVld[tagPri] && queueOutRdy[tagPri]) begin
          fsmNstate = FSM_IDLE;
        end else begin
          fsmNstate = FSM_DISPATCH;
        end
      end
      FSM_DROP : begin
        if(oTagDropOut.Vld && oTagDropOut.Rdy) begin
          fsmNstate = FSM_IDLE;
        end else begin
          fsmNstate = FSM_DROP;
        end
      end
      default : fsmNstate = FSM_IDLE;
    endcase
  end

  always @(posedge iClk or negedge iRst_n) begin
    if(!iRst_n) begin
      tagPri     <= 0;
      tagSrcPort <= 0;
      tagMsg     <= 0;
    end else if(iTagIn.Vld && iTagIn.Rdy) begin
      tagPri     <= rxTagPri;
      tagSrcPort <= rxTagSrcPort;
      tagMsg     <= rxTagMsg;
    end else begin
      tagPri     <= tagPri;
      tagSrcPort <= tagSrcPort;
      tagMsg     <= tagMsg;
    end
  end

  assign iTagIn.Rdy = (fsmCstate == FSM_IDLE);    // 只允许IDLE状态写入请求
  assign oTagDropOut.Vld = (fsmCstate == FSM_DROP);

  generate
    for(i=0; i<8;i =i+1) begin : GEN_QUEUE_VLD
      assign queueOutVld[i] = (fsmCstate == FSM_DISPATCH) && (tagPri == i);
    end
  endgenerate
  
endmodule