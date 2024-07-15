`timescale 1ns / 1ps

// remake from Samir Palnitkar's book (Module 4-to-1 multiplexer)

// Module 2-to-1 multiplexer. 
module mux2_to_1(out, i0, i1, s0);

output out;
input i0, i1;
input s0;

wire s0n;
wire y0, y1;

// Create s0n signals.
not (s0n, s0);
// 2-input and gates instantiated
and (y0, i0, s0n);
and (y1, i1, s0);
// 2-input or gate instantiated
or (out, y0, y1);

endmodule