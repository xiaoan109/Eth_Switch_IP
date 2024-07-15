// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/xbar/rr_arbiter.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-04-09
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-08
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
module rr_arbiter (
  input  wire       iClk,
  input  wire       iRst_n,
  input  wire [3:0] iReq,
  output wire [1:0] oGrant,
  output reg        oGrantValid
);

  parameter [1:0] grant0 = 2'b00;
  parameter [1:0] grant1 = 2'b01;
  parameter [1:0] grant2 = 2'b10;
  parameter [1:0] grant3 = 2'b11;

  reg [1:0] state;
  reg [1:0] next_state;
  reg grantValid_reg;

  assign oGrant = state;

  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      state <= grant0;
    end else begin
      state <= next_state;
    end
  end
  always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
      oGrantValid <= 1'b0;
    end else begin
      oGrantValid <= grantValid_reg;
    end
  end


  always @(*) begin
    next_state = state;
    grantValid_reg = 1'b0;
    case (state)
      grant0:
      // if this req is dropped, check for other req's
      if (!iReq[0]) begin
        if (iReq[1]) begin
          next_state = grant1;
          grantValid_reg = 1'b1;
        end else if (iReq[2]) begin
          next_state = grant2;
          grantValid_reg = 1'b1;
        end else if (iReq[3]) begin
          next_state = grant3;
          grantValid_reg = 1'b1;
        end
      end else begin
        grantValid_reg = 1'b1;
      end
      grant1:
      // if this req is dropped, check for other req's
      if (!iReq[1]) begin
        if (iReq[2]) begin
          next_state = grant2;
          grantValid_reg = 1'b1;
        end else if (iReq[3]) begin
          next_state = grant3;
          grantValid_reg = 1'b1;
        end else if (iReq[0]) begin
          next_state = grant0;
          grantValid_reg = 1'b1;
        end
      end else begin
        grantValid_reg = 1'b1;
      end
      grant2:
      // if this req is dropped, check for other req's
      if (!iReq[2]) begin
        if (iReq[3]) begin
          next_state = grant3;
          grantValid_reg = 1'b1;
        end else if (iReq[0]) begin
          next_state = grant0;
          grantValid_reg = 1'b1;
        end else if (iReq[1]) begin
          next_state = grant1;
          grantValid_reg = 1'b1;
        end
      end else begin
        grantValid_reg = 1'b1;
      end
      grant3:
      // if this req is dropped, check for other req's
      if (!iReq[3]) begin
        if (iReq[0]) begin
          next_state = grant0;
          grantValid_reg = 1'b1;
        end else if (iReq[1]) begin
          next_state = grant1;
          grantValid_reg = 1'b1;
        end else if (iReq[2]) begin
          next_state = grant2;
          grantValid_reg = 1'b1;
        end
      end else begin
        grantValid_reg = 1'b1;
      end
    endcase

  end
endmodule
