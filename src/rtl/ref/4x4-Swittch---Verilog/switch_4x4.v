module switch_4x4 (
    input clk, rst,
    input [31:0] input_1, input_2, input_3, input_4
    // output [31:0] output_1, output_2, output_3, output_4
);
    
    // wire [31:0] input_word_to_1, input_word_to_2, input_word_to_3, input_word_to_4;
    wire [32:0] input_queue_1_1, input_queue_1_2, input_queue_1_3, input_queue_1_4;
    wire [32:0] input_queue_2_1, input_queue_2_2, input_queue_2_3, input_queue_2_4;
    wire [32:0] input_queue_3_1, input_queue_3_2, input_queue_3_3, input_queue_3_4;
    wire [32:0] input_queue_4_1, input_queue_4_2, input_queue_4_3, input_queue_4_4;

    wire wr_en_1_1, wr_en_1_2, wr_en_1_3, wr_en_1_4;
    wire wr_en_2_1, wr_en_2_2, wr_en_2_3, wr_en_2_4;
    wire wr_en_3_1, wr_en_3_2, wr_en_3_3, wr_en_3_4;
    wire wr_en_4_1, wr_en_4_2, wr_en_4_3, wr_en_4_4;

    wire [32:0] queue_output_1_1, queue_output_2_1, queue_output_3_1, queue_output_4_1;
    wire [32:0] queue_output_1_2, queue_output_2_2, queue_output_3_2, queue_output_4_2;
    wire [32:0] queue_output_1_3, queue_output_2_3, queue_output_3_3, queue_output_4_3;
    wire [32:0] queue_output_1_4, queue_output_2_4, queue_output_3_4, queue_output_4_4;

    wire rd_en_1_1, rd_en_2_1, rd_en_3_1, rd_en_4_1;
    wire rd_en_1_2, rd_en_2_2, rd_en_3_2, rd_en_4_2;
    wire rd_en_1_3, rd_en_2_3, rd_en_3_3, rd_en_4_3;
    wire rd_en_1_4, rd_en_2_4, rd_en_3_4, rd_en_4_4;

    input_daemon input_daemon_1(.clk(clk), .rst(rst), .input_word(input_1),
        .to_output_buf_1(input_queue_1_1), .to_output_buf_2(input_queue_1_2),
        .to_output_buf_3(input_queue_1_3), .to_output_buf_4(input_queue_1_4),
        .wr_en_1(wr_en_1_1), .wr_en_2(wr_en_1_2), .wr_en_3(wr_en_1_3), .wr_en_4(wr_en_1_4)
    );

    queue queue_1_1(.clk(clk), .rst(rst), .wr_en(wr_en_1_1), .rd_en(rd_en_1_1), .wr_data(input_queue_1_1), .rd_data(queue_output_1_1));
    queue queue_1_2(.clk(clk), .rst(rst), .wr_en(wr_en_1_2), .rd_en(rd_en_1_2), .wr_data(input_queue_1_2), .rd_data(queue_output_1_2));
    queue queue_1_3(.clk(clk), .rst(rst), .wr_en(wr_en_1_3), .rd_en(rd_en_1_3), .wr_data(input_queue_1_3), .rd_data(queue_output_1_3));
    queue queue_1_4(.clk(clk), .rst(rst), .wr_en(wr_en_1_4), .rd_en(rd_en_1_4), .wr_data(input_queue_1_4), .rd_data(queue_output_1_4));


    input_daemon input_daemon_2(.clk(clk), .rst(rst), .input_word(input_2),
        .to_output_buf_1(input_queue_2_1), .to_output_buf_2(input_queue_2_2),
        .to_output_buf_3(input_queue_2_3), .to_output_buf_4(input_queue_2_4),
        .wr_en_1(wr_en_2_1), .wr_en_2(wr_en_2_2), .wr_en_3(wr_en_2_3), .wr_en_4(wr_en_2_4)
    );

    queue queue_2_1(.clk(clk), .rst(rst), .wr_en(wr_en_2_1), .rd_en(rd_en_2_1), .wr_data(input_queue_2_1), .rd_data(queue_output_2_1));
    queue queue_2_2(.clk(clk), .rst(rst), .wr_en(wr_en_2_2), .rd_en(rd_en_2_2), .wr_data(input_queue_2_2), .rd_data(queue_output_2_2));
    queue queue_2_3(.clk(clk), .rst(rst), .wr_en(wr_en_2_3), .rd_en(rd_en_2_3), .wr_data(input_queue_2_3), .rd_data(queue_output_2_3));
    queue queue_2_4(.clk(clk), .rst(rst), .wr_en(wr_en_2_4), .rd_en(rd_en_2_4), .wr_data(input_queue_2_4), .rd_data(queue_output_2_4));

    input_daemon input_daemon_3(.clk(clk), .rst(rst), .input_word(input_3),
        .to_output_buf_1(input_queue_3_1), .to_output_buf_2(input_queue_3_2),
        .to_output_buf_3(input_queue_3_3), .to_output_buf_4(input_queue_3_4),
        .wr_en_1(wr_en_3_1), .wr_en_2(wr_en_3_2), .wr_en_3(wr_en_3_3), .wr_en_4(wr_en_3_4)
    );

    queue queue_3_1(.clk(clk), .rst(rst), .wr_en(wr_en_3_1), .rd_en(rd_en_3_1), .wr_data(input_queue_3_1), .rd_data(queue_output_3_1));
    queue queue_3_2(.clk(clk), .rst(rst), .wr_en(wr_en_3_2), .rd_en(rd_en_3_2), .wr_data(input_queue_3_2), .rd_data(queue_output_3_2));
    queue queue_3_3(.clk(clk), .rst(rst), .wr_en(wr_en_3_3), .rd_en(rd_en_3_3), .wr_data(input_queue_3_3), .rd_data(queue_output_3_3));
    queue queue_3_4(.clk(clk), .rst(rst), .wr_en(wr_en_3_4), .rd_en(rd_en_3_4), .wr_data(input_queue_3_4), .rd_data(queue_output_3_4));

    input_daemon input_daemon_4(.clk(clk), .rst(rst), .input_word(input_4),
        .to_output_buf_1(input_queue_4_1), .to_output_buf_2(input_queue_4_2),
        .to_output_buf_3(input_queue_4_3), .to_output_buf_4(input_queue_4_4),
        .wr_en_1(wr_en_4_1), .wr_en_2(wr_en_4_2), .wr_en_3(wr_en_4_3), .wr_en_4(wr_en_4_4)
    );

    queue queue_4_2(.clk(clk), .rst(rst), .wr_en(wr_en_4_2), .rd_en(rd_en_4_2), .wr_data(input_queue_4_2), .rd_data(queue_output_4_1));
    queue queue_4_3(.clk(clk), .rst(rst), .wr_en(wr_en_4_3), .rd_en(rd_en_4_3), .wr_data(input_queue_4_3), .rd_data(queue_output_4_2));
    queue queue_4_1(.clk(clk), .rst(rst), .wr_en(wr_en_4_1), .rd_en(rd_en_4_1), .wr_data(input_queue_4_1), .rd_data(queue_output_4_3));
    queue queue_4_4(.clk(clk), .rst(rst), .wr_en(wr_en_4_4), .rd_en(rd_en_4_4), .wr_data(input_queue_4_4), .rd_data(queue_output_4_4));


    output_daemon output_daemon_1(.clk(clk), .rst(rst),
        .NOBLOCKOBUF_FROM_1(queue_output_1_1), .NOBLOCKOBUF_FROM_2(queue_output_2_1),
        .NOBLOCKOBUF_FROM_3(queue_output_3_1), .NOBLOCKOBUF_FROM_4(queue_output_4_1),
        .OUTPUT_PORT(), .last_read_from_queue({rd_en_1_1, rd_en_2_1, rd_en_3_1, rd_en_4_1})
    );

    output_daemon output_daemon_2(.clk(clk), .rst(rst),
        .NOBLOCKOBUF_FROM_1(queue_output_1_2), .NOBLOCKOBUF_FROM_2(queue_output_2_2),
        .NOBLOCKOBUF_FROM_3(queue_output_3_2), .NOBLOCKOBUF_FROM_4(queue_output_4_2),
        .OUTPUT_PORT(), .last_read_from_queue({rd_en_1_2, rd_en_2_2, rd_en_3_2, rd_en_4_2})
    );

        output_daemon output_daemon_3(.clk(clk), .rst(rst),
        .NOBLOCKOBUF_FROM_1(queue_output_1_3), .NOBLOCKOBUF_FROM_2(queue_output_2_3),
        .NOBLOCKOBUF_FROM_3(queue_output_3_3), .NOBLOCKOBUF_FROM_4(queue_output_4_3),
        .OUTPUT_PORT(), .last_read_from_queue({rd_en_1_3, rd_en_2_3, rd_en_3_3, rd_en_4_3})
    );

        output_daemon output_daemon_4(.clk(clk), .rst(rst),
        .NOBLOCKOBUF_FROM_1(queue_output_1_4), .NOBLOCKOBUF_FROM_2(queue_output_2_4),
        .NOBLOCKOBUF_FROM_3(queue_output_3_4), .NOBLOCKOBUF_FROM_4(queue_output_4_4),
        .OUTPUT_PORT(), .last_read_from_queue({rd_en_1_4, rd_en_2_4, rd_en_3_4, rd_en_4_4})
    );

endmodule