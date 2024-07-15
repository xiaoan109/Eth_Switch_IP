module queue
(
    input clk, rst, wr_en, rd_en,
    input [32:0] wr_data,
    output [32:0] rd_data
);
    
    reg [32:0] queue_data[127:0];
    reg [6:0] rd_ptr, wr_ptr;
    integer i;

    assign rd_data = (rst == 1'b1 | rd_ptr == wr_ptr) ? 33'd0 : queue_data[rd_ptr];

    always @(rst) begin
        if(rst == 1'b1) begin
            for (i=0; i<128; i=i+1) begin
                queue_data[i] <= 33'd0;
            end
            wr_ptr <= 7'd127;
            rd_ptr <= 7'd127;
        end
    end

    always @(*) begin
        if(rst != 1'b1) begin
            
        end
    end

    always @(posedge clk) begin
        if(rst != 1'b1) begin
            if(rd_en == 1'b1 & rd_ptr != wr_ptr) begin
                rd_ptr = rd_ptr-1;
            end
            if(wr_en == 1'b1) begin
                queue_data[wr_ptr] = wr_data;
                wr_ptr = wr_ptr - 1;
            end
        end
    end

endmodule
