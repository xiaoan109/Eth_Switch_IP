module input_daemon (
    input clk, rst,
    input [31:0] input_word,
    output reg [32:0] to_output_buf_1, to_output_buf_2, to_output_buf_3, to_output_buf_4,
    output reg wr_en_1, wr_en_2, wr_en_3, wr_en_4
);

    reg [31:0] current_input_word;
    wire [7:0] dest_id, seq_id;
    wire [15:0] pkt_length;
    reg [15:0] count_down;
    reg new_packet;
    reg [15:0] next_count_down;
    reg [7:0] last_dest_id, next_last_dest_id;
    wire [32:0] data_to_outport;

    assign dest_id = current_input_word[31: 24];
    assign pkt_length = current_input_word[23:8];
    assign seq_id = current_input_word[7:0];

    assign data_to_outport = {1'b1, current_input_word};

    always @(*) begin
        new_packet <= (count_down == 16'd0) ? 1'b1 : 1'b0;
    end

    always @(*) begin
        next_count_down = (new_packet == 1'b1) ? (pkt_length - 1) : (count_down);
    end

    always @(*) begin
        next_last_dest_id = (new_packet == 1'b1) ? dest_id : last_dest_id;
    end

    always @(rst) begin
        if(rst == 1'b1) begin 
            count_down <= 16'd0;
            last_dest_id <= 8'd0;
            current_input_word <= 32'd0;
            to_output_buf_1 <= 33'd0;
            to_output_buf_2 <= 33'd0;
            to_output_buf_3 <= 33'd0;
            to_output_buf_4 <= 33'd0;
        end
    end

    always @(negedge clk) begin
        if(current_input_word != 32'd0) begin
            wr_en_1 <= (next_last_dest_id == 8'd1) ? 1'b1 : 1'b0;
            wr_en_2 <= (next_last_dest_id == 8'd2) ? 1'b1 : 1'b0;
            wr_en_3 <= (next_last_dest_id == 8'd3) ? 1'b1 : 1'b0;
            wr_en_4 <= (next_last_dest_id == 8'd4) ? 1'b1 : 1'b0;
        end else begin
            wr_en_1 <= 33'b0;
            wr_en_2 <= 33'b0;
            wr_en_3 <= 33'b0;
            wr_en_4 <= 33'b0;
        end
    end

    always @(posedge clk) begin
         if(rst != 1'b1) begin
            if(current_input_word != 32'd0) begin
                count_down <= next_count_down;
                last_dest_id <= next_last_dest_id;
                to_output_buf_1 <= (next_last_dest_id == 8'd1) ? data_to_outport : 33'd0;
                to_output_buf_2 <= (next_last_dest_id == 8'd2) ? data_to_outport : 33'd0;
                to_output_buf_3 <= (next_last_dest_id == 8'd3) ? data_to_outport : 33'd0;
                to_output_buf_4 <= (next_last_dest_id == 8'd4) ? data_to_outport : 33'd0;
            end else begin
                to_output_buf_1 <= 33'd0;
                to_output_buf_2 <= 33'd0;
                to_output_buf_3 <= 33'd0;
                to_output_buf_4 <= 33'd0;
            end
            current_input_word <= input_word;
            wr_en_1 <= 33'b0;
            wr_en_2 <= 33'b0;
            wr_en_3 <= 33'b0;
            wr_en_4 <= 33'b0;
        end

    end


endmodule

