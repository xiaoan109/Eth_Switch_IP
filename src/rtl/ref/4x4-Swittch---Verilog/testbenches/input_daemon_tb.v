module input_daemon_tb ();
    
    reg clk, rst;
    always #25 clk = ~clk;

    reg [31:0] input_word;
    wire [32:0] to_output_buf_1, to_output_buf_2, to_output_buf_3, to_output_buf_4;

    input_daemon input_daemon_instance(
        .clk(clk), .rst(rst),
        .input_word(input_word),
        .to_output_buf_1(to_output_buf_1),
        .to_output_buf_2(to_output_buf_2),
        .to_output_buf_3(to_output_buf_3),
        .to_output_buf_4(to_output_buf_4)
    );

    initial begin
        $dumpfile("input_daemon_test.vcd");
        $dumpvars(0, input_daemon_tb);
        #0 clk = 1'b0; rst = 1'b1; input_word = 32'd0;

        #20 rst = 1'b0;

        input_word[31:24]=8'd3; input_word[23:8]=16'd5; input_word[7:0]=8'd1; 
        #50 input_word = 32'd32;
        #50 input_word = 32'd10;
        #50 input_word = 32'd7;
        #50 input_word = 32'd128;
        #50 input_word = 32'd200;

        #50 input_word[31:24]=8'd2; input_word[23:8]=16'd3; input_word[7:0]=8'd2; 
        #50 input_word = 32'd119;
        #50 input_word = 32'd78;
        #50 input_word = 32'd43;

        #600 $finish;
        $display("tested");
    end

endmodule