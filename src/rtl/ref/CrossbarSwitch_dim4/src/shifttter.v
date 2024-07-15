`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2021 00:22:39
// Design Name: 
// Module Name: shifttt
// Project Name: 
// Target Devices: Wrapped Wavefront Arbiter (for Crossbar Switch 4)
// Tool Versions: 
// Description:     module shifts 4'bxxxx once in toggle of clk
// 
// Dependencies: 
// 
// Revision:
// Revision 1.3 - workin' review of book vers. of shift register + shiftin' 4'b data + work extra
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shifttt(
    input wire clk, reset,
    input wire [4-1:0] data,
    output wire out,
    input wire WORK 
);
reg [4-1: 0] r_reg;
wire[4-1:0] r_next;

always @(posedge clk)
begin
    if(reset==1'b0)
         r_reg <= data;
    else 
        if (WORK == 1'b1)
        	r_reg <= r_next;
end

assign r_next = (WORK == 1'b1) ? { r_reg[0], r_reg[4-1:1]} : r_reg ;
assign out = (WORK == 1'b1) ?  r_reg[0]: r_reg[3] ;

endmodule
