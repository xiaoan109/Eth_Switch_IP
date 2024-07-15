// +FHEADER ==================================================
// FilePath       : \OPU-Tile\rtl\tile\general\gnrl_skid_buf.v
// Author         : Ziheng Zhou ziheng.zhou.1999@qq.com
// CreateDate     : 2023-03-07 11:17:02
// LastEditors    : Ziheng Zhou ziheng.zhou.1999@qq.com
// LastEditTime   : 2023-03-07 14:22:50
// Description    : 
//                  
// 
//                  
// 
// Rev 1.0    
//                  
// 
// -FHEADER ==================================================
module gnrl_skid_buf #(
  parameter DW = 32
) (
  input   wire            clk_i,
  input   wire            rst_n_i,

  input   wire  [DW-1:0]  din_i,
  input   wire            din_vld_i,
  output  reg             din_rdy_o,

  output  wire  [DW-1:0]  dout_o,
  output  wire            dout_vld_o,
  input   wire            dout_rdy_i
);

  reg   [DW-1:0]    skid_buf;
  reg               skid_buf_vld;

  always @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
      din_rdy_o <= 'b1;
    end
    else if(dout_rdy_i) begin
      din_rdy_o <= 'b1;
    end
    else if(din_vld_i) begin
      din_rdy_o <= 'b0;
    end
    else begin
      din_rdy_o <= din_rdy_o;
    end
  end

  always @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
      skid_buf_vld <= 'b0;
    end
    else if(dout_rdy_i) begin
      skid_buf_vld <= 'b0;
    end
    else if(!dout_rdy_i && din_vld_i && din_rdy_o) begin
      skid_buf_vld <= 'b1;
    end
    else begin
      skid_buf_vld <= skid_buf_vld;
    end
  end

  always @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
      skid_buf <= 'h0;
    end
    else if(!dout_rdy_i && din_vld_i && din_rdy_o) begin
      skid_buf <= din_i;
    end
    else begin
      skid_buf <= skid_buf;
    end
  end

  assign dout_vld_o = din_rdy_o ? din_vld_i : skid_buf_vld;
  assign dout_o = din_rdy_o ? din_i : skid_buf;
  
endmodule