// +FHEADER =====================================================================
// FilePath       : /Switch/src/rtl/design/common/gnrl_buf.v
// Author         : ZhouZiheng ziheng.zhou.1999@qq.com
// CreateDate     : 24-05-08
// LastEditors    : ZhouZiheng ziheng.zhou.1999@qq.com
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
//  23-08-24 |     CICC2060    |     0.1     | Original Version
//                  
// 
// -FHEADER =====================================================================
module gnrl_buf #(
  parameter DW = 32,
  parameter CUT_RDY = 0
) (
  input   wire            clk_i,
  input   wire            rst_n_i,

  input   wire  [DW-1:0]  din_i,
  input   wire            din_vld_i,
  output  wire            din_rdy_o,

  output  reg   [DW-1:0]  dout_o,
  output  reg             dout_vld_o,
  input   wire            dout_rdy_i
);
  
  wire  [DW-1:0]  din;
  wire            din_vld;
  wire            din_rdy;

  generate
    if(CUT_RDY == 1) begin : GEN_SKID_BUF
      gnrl_skid_buf #(
          .DW ( DW ))
      u_gnrl_skid_buf (
          .clk_i                   ( clk_i     ),
          .rst_n_i                 ( rst_n_i   ),
          .din_i                   ( din_i     ),
          .din_vld_i               ( din_vld_i ),
          .din_rdy_o               ( din_rdy_o ),
          .dout_o                  ( din       ),
          .dout_vld_o              ( din_vld   ),
          .dout_rdy_i              ( din_rdy   )
      );
    end
    else begin : NO_SKID_BUF
      assign din = din_i;
      assign din_vld = din_vld_i;
      assign din_rdy_o = din_rdy;
    end
  endgenerate
  
  always @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
      dout_o <= 'h0;
    end
    else if(din_vld && din_rdy) begin
      dout_o <= din;
    end
    else begin
      dout_o <= dout_o;
    end
  end

  always @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
      dout_vld_o <= 'b0;
    end
    else if(din_rdy) begin
      dout_vld_o <= din_vld;
    end
    else begin
      dout_vld_o <= dout_vld_o;
    end
  end
  assign din_rdy = !dout_vld_o || dout_rdy_i;

endmodule