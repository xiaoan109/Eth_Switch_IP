module output_daemon_tb ();
    
    reg clk, rst;
    always #25 clk = ~clk;

    reg [32:0] from_queue_1, from_queue_2, from_queue_3, from_queue_4;
    wire [31:0] output_to_fifo;

    output_daemon output_daemon_instance(
        .clk(clk), .rst(rst),
        .NOBLOCKOBUF_FROM_1(from_queue_1), .NOBLOCKOBUF_FROM_2(from_queue_2),
        .NOBLOCKOBUF_FROM_3(from_queue_3), .NOBLOCKOBUF_FROM_4(from_queue_4),
        .OUTPUT_PORT(output_to_fifo)
    );

    initial begin
        $dumpfile("output_daemon_test.vcd");
        $dumpvars(0, output_daemon_tb);
        #0 clk = 1'b0; rst = 1'b1; from_queue_1 = 33'h103000501;
        #20 rst = 1'b0;

        #50 from_queue_1 = 33'd32;
        #50 from_queue_1 = 33'd10;
        #50 from_queue_1 = 33'd7;
        #50 from_queue_1 = 33'd128;
        #50 from_queue_1 = 33'd200;


        #300 $finish;
        $display("tested");
    end

endmodule