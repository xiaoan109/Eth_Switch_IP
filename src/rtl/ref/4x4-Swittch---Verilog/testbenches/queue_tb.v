module queue_tb ();
    
    reg clk, rst, wr_en, rd_en;
    always #25 clk = ~clk;

    reg [32:0] wr_data;
    wire [32:0] rd_data;

    queue queue_instance(
        .clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en),
        .wr_data(wr_data), .rd_data(rd_data)
    );

    initial begin
        $dumpfile("queue_test.vcd");
        $dumpvars(0, queue_tb);
        #0 clk = 1'b0; rst = 1'b1; wr_data = 32'd25; wr_en = 1'b1; rd_en = 1'b0;

        #15 rst = 1'b0; // 15

        #5 wr_en = 1'b1; // 20
        rd_en = 1'b1;
        #10 wr_en = 1'b0; // 30
        rd_en = 1'b0;

        #40 wr_en = 1'b1; // 70
        wr_data = 32'd78;
        #10 wr_en = 1'b0; // 80

        #70 wr_en = 1'b1; // 150
        rd_en = 1'b1;
        wr_data = 32'd738;
        #30 wr_en = 1'b0; // 180
        rd_en = 1'b0;

        #10 rd_en = 1'b1; // 190
        #40 rd_en = 1'b0; // 230

        #20 rd_en = 1'b1; // 250
        #30 rd_en = 1'b0; // 280

        #40 rd_en = 1'b1; // 320
        #10 rd_en = 1'b0; // 330
        
        #400 $finish;
        $display("tested");
    end

endmodule