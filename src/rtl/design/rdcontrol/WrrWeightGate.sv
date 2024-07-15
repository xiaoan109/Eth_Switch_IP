module WrrWeightGate #(
  parameter WEIGHT_NUM = 8,
  parameter ARB_NUM = 8
)(
  input   logic                           iClk,
  input   logic                           iRst_n,

  input   logic  [ARB_NUM-1:0]            iReq,
  output  logic  [ARB_NUM-1:0]            oGnt,

  output  logic  [ARB_NUM-1:0]            oReq,
  input   logic  [ARB_NUM-1:0]            iGnt,

  input   logic [$clog2(WEIGHT_NUM):0]    iWeight[ARB_NUM],
  input   logic                           iWeightLoad
);

  logic   [$clog2(WEIGHT_NUM):0]    initWeight[ARB_NUM];
  logic   [$clog2(WEIGHT_NUM):0]    currWeight[ARB_NUM];

  logic   [ARB_NUM-1:0]               gntMask;
  logic                               weightRefesh;

  genvar i;

  generate
    for(i=0; i<ARB_NUM; i=i+1) begin : GEN_GATE
      always @(posedge iClk or negedge iRst_n) begin
        if(!iRst_n) begin
          initWeight[i] <= {($clog2(WEIGHT_NUM)+1){1'b1}};
        end else if(iWeightLoad) begin
          initWeight[i] <= iWeight[i];
        end else begin
          initWeight[i] <= initWeight[i];
        end
      end

      always @(posedge iClk or negedge iRst_n) begin
        if(!iRst_n) begin
          currWeight[i] <= {($clog2(WEIGHT_NUM)+1){1'b1}};
        end else if(iWeightLoad) begin
          currWeight[i] <= iWeight[i];
        end else if(weightRefesh) begin
          currWeight[i] <= initWeight[i];
        end else if(iReq[i] && oGnt[i])begin
          currWeight[i] <= currWeight[i] - 'b1;
        end else begin
          currWeight[i] <= currWeight[i];
        end
      end

      assign gntMask[i] = |currWeight[i];

      assign oReq[i] = iReq[i] & gntMask[i];
      assign oGnt[i] = iGnt[i] & gntMask[i];      

    end
  endgenerate
  
  assign weightRefesh = !(|gntMask);

endmodule