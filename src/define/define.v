// +FHEADER =====================================================================
// FilePath       : /Switch/src/define/define.v
// Author         : wangxuanji 18364998790@163.com
// CreateDate     : 24-03-29
// LastEditors    : wangxuanji 18364998790@163.com
// LastEditTime   : 24-05-19
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
`define DELAY(N, clk) begin \
	repeat(N) begin @(posedge clk);\
	#1;\
	end\
end

`define ADDR_LENTH 12
`define DATA_WIDTH 32

// `define RDDATA_CRSBAR_SHARE_MODE

`define FPGA
`define SDPRAM
