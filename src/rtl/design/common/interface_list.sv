/*
 * @FilePath       : /Switch/src/rtl/design/common/interface_list.sv
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 24-05-08
 * @LastEditors    : ZhouZiheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 24-05-14
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
//typedef struct packed {
//  logic   [1:0]               SrcGrp;
//  logic   [2:0]               Pri;     //8个优先级
//  logic   [3:0]               DstPort; //16个端口
//  logic   [`ADDR_LENTH-1:0]   FirAddr; //包首地址
//  logic   [3:0]               Len;     //包长度（完整block数）,0代表1,1代表2,15代表16
//} u2w_pkg_req_pld_t;

//function logic [`ADDR_LENTH+10:0] cat_u2w_pkg_req_pld_f(u2w_pkg_req_pld_t pld);
//  logic [`ADDR_LENTH+10:0] ret;
//  ret = {pld.Pri, pld.DstPort, pld.FirAddr, pld.Len};
//  return ret;
//endfunction

//function u2w_pkg_req_pld_t split_u2w_pkg_req_pld_f(logic [`ADDR_LENTH+10:0] pld);
//  u2w_pkg_req_pld_t ret;
//  ret.Pri = pld[`ADDR_LENTH+10:`ADDR_LENTH+8];
//  ret.DstPort = pld[`ADDR_LENTH+7:`ADDR_LENTH+4];
//  ret.FirAddr = pld[`ADDR_LENTH+3:4];
//  ret.Len = pld[3:0];
//  return ret;
//endfunction

//interface u2w_pkg_req;
//  u2w_pkg_req_pld_t Pld;
//  logic             Vld;
//  logic             Rdy;
//  modport slave (
//    output  Rdy,
//    input   Pld,
//    input   Vld
//  );
//  modport master (
//    input   Rdy,
//    output  Pld,
//    output  Vld
//  );
//endinterface //interfacename

interface Decoupled #(parameter DW = 16, parameter AW = 2);
  logic [DW-1:0]    Pld;
  logic [AW-1:0]    Dst;
  logic             Vld;
  logic             Rdy;
  modport slave (
    output  Rdy,
    input   Pld,
    input   Dst,
    input   Vld
  );
  modport master (
    input   Rdy,
    output  Pld,
    output  Dst,
    output  Vld
  );
endinterface //interfacename

//task WriteDecoupled(
//  virtual Decoupled sport, 
//  ref logic clk
//  );
//  begin
//    sport.Pld = $random();
//    sport.Dst = $random();
//    @(posedge clk);
//    #1 sport.Vld = 1'b1;
//    wait(sport.Rdy);
//    @(posedge clk);
//    #1 sport.Vld = 1'b0;
//    repeat(5) @(posedge clk);
//  end
//endtask

//task ReadDecoupled(
//  virtual Decoupled mport, 
//  ref logic clk);
//  mport.Rdy = 0;
//  begin
//    while(!(mport.Vld && mport.Rdy)) begin
//      repeat(4) @(posedge clk);
//      #1 mport.Rdy = 1;
//      @(posedge clk);
//      #1 mport.Rdy = 0;
//    end
//  end

//endtask

//task u2w_pkg_req_wr(
//  virtual u2w_pkg_req sport, 
//  ref logic clk,
//  input int DstPort);
//  begin
//    sport.Vld   = 1'b0;
//    sport.Pld.Pri = 2'b00;
//    sport.Pld.DstPort = DstPort;
//    sport.Pld.FirAddr = 8'b00000000;
//    sport.Pld.Len = $random();

//    @(posedge clk);
//    #1 sport.Vld = 1'b1;
//    wait(sport.Rdy);
//    @(posedge clk);
//    #1 sport.Vld = 1'b0;
//    repeat(5) @(posedge clk);
//  end
//endtask

//task u2w_pkg_req_rd(
//  virtual u2w_pkg_req mport, 
//  ref logic clk);
//  mport.Rdy = 0;
//  begin
//    while(!(mport.Vld && mport.Rdy)) begin
//      repeat(4) @(posedge clk);
//      #1 mport.Rdy = 1;
//      @(posedge clk);
//      #1 mport.Rdy = 0;
//    end
//  end

//endtask










// interface u2w_rdata;
//   logic [`DATA_WIDTH-1:0] WrrData;
//   logic                   WrrWlast,
//   logic                   WrrVld;
//   logic                   WrrRdy;
//   modport slave (
//     input   WrrData,
//     input   WrrWlast,
//     input   WrrVld,
//     output  WrrRdy
//   );
//   modport master (
//     output  WrrData,
//     output  WrrWlast,
//     output  WrrVld,
//     input   WrrRdy
//   );

// endinterface //u2w_rdata

// interface w2u_pkg_rsp;
//   logic [`ADDR_LENTH-1:0]   PkgFirAddr;   //待读包首地址
//   logic                     PkgFirAddrVld;//地址有效
//   logic [3:0]               PkgBlockNum;  //包块数
//   logic                     PkgDrop,
//   logic                     PkgFirAddrRdy;//可以接收读请求rdy
//   modport slave (
//   input   PkgFirAddr,
//   input   PkgFirAddrVld,
//   input   PkgBlockNum,
//   input   PkgDrop,
//   output  PkgFirAddrRdy
//   );
//   modport master (
//   output  PkgFirAddr,
//   output  PkgFirAddrVld,
//   output  PkgBlockNum,
//   output  PkgDrop,
//   input   PkgFirAddrRdy
//   );
// endinterface //w2u_pkg_rsp