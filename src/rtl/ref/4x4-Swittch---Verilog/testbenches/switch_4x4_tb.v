module switch_4x4_tb ();
    
    reg clk, rst;
    always #25 clk = ~clk;

    reg [31:0] input_word_1, input_word_2, input_word_3, input_word_4;
    // wire [32:0] to_output_buf_1, to_output_buf_2, to_output_buf_3, to_output_buf_4;

    switch_4x4 switch_4x4_instance(
        .clk(clk), .rst(rst),
        .input_1(input_word_1),
        .input_2(input_word_2),
        .input_3(input_word_3),
        .input_4(input_word_4)
    );

    initial begin
        $dumpfile("switch_4x4_test.vcd");
        $dumpvars(0, switch_4x4_tb);
        #0 clk = 1'b0; rst = 1'b1;

        #20 rst = 1'b0;

        input_word_1[31:24]=8'd3; input_word_1[23:8]=16'd5; input_word_1[7:0]=8'd1; 
        #50 input_word_1 = 32'd32;
        #50 input_word_1 = 32'd10;
        #50 input_word_1 = 32'd7;
        #50 input_word_1 = 32'd128;
        #50 input_word_1 = 32'd200;

        #50 input_word_1 = 32'd0;

        input_word_2[31:24]=8'd1; input_word_2[23:8]=16'd3; input_word_2[7:0]=8'd2; 
        #50 input_word_2 = 32'd119;
        #50 input_word_2 = 32'd78;
        #50 input_word_2 = 32'd43;

        #600 $finish;
        $display("tested");
    end

endmodule