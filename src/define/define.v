// +FHEADER =====================================================================
// FilePath       : /Switch/src/define/define.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-03-29
// LastEditors    : zhouziheng ziheng.zhou.1999@qq.com
// LastEditTime   : 24-07-24
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
`define DELAY(N, clk) begin \
	repeat(N) @(posedge clk);\
	#1ps;\
end

`define ADDR_LENTH 12
`define DATA_WIDTH 32

`define RDDATA_CRSBAR_SHARE_MODE

`define FPGA
`define SDPRAM

// `define SYNTHESIS
