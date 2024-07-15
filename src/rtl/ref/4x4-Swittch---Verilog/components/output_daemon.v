module output_daemon (
    input clk,rst,
    input [32:0] NOBLOCKOBUF_FROM_1, NOBLOCKOBUF_FROM_2, NOBLOCKOBUF_FROM_3, NOBLOCKOBUF_FROM_4,
    output reg [31:0] OUTPUT_PORT,
    output [1:4] last_read_from_queue
);

    reg [1:4] read_from_queue;
    reg [32:0] pkt_word;
    wire packet_is_valid;
    reg [7:0] down_counter, next_down_counter;
    wire [15:0] pkt_length;

    wire [1:4] local_next_read_from_queue;
    
    assign packet_is_valid = pkt_word[32];

    assign pkt_length = pkt_word[23:8];

    assign last_read_from_queue = read_from_queue;

    // priority_select priority_select_instance(
    //     .down_counter(down_counter), .read_from_queue(read_from_queue), .packet_is_valid(packet_is_valid),
    //     .next_read_from_queue(local_next_read_from_queue)
    // );

    always @(*) begin
        if(read_from_queue == 4'b1000)
            pkt_word <= NOBLOCKOBUF_FROM_1;
        else if(read_from_queue == 4'b0100)
            pkt_word <= NOBLOCKOBUF_FROM_2;
        else if(read_from_queue == 4'b0010)
            pkt_word <= NOBLOCKOBUF_FROM_3;
        else if(read_from_queue == 4'b0001)
            pkt_word <= NOBLOCKOBUF_FROM_4;
        else
            pkt_word <= NOBLOCKOBUF_FROM_1;
    end

    always @(packet_is_valid, down_counter, pkt_length) begin
        if(~packet_is_valid & down_counter == 8'd0)
            next_down_counter <= 8'd0;
        else if(packet_is_valid & down_counter != 8'd0) 
            next_down_counter <= down_counter - 1;
        else if(packet_is_valid & down_counter == 8'd0) 
            next_down_counter <= pkt_length;
        else
            next_down_counter <= down_counter;
    end

    always @(posedge clk) begin
        if(rst != 1'b1) begin
            // read_from_queue <= local_next_read_from_queue;
            down_counter <= next_down_counter;
            if(packet_is_valid)
                OUTPUT_PORT <= pkt_word[31:0];
            else
                OUTPUT_PORT <= 32'd0;
        end
    end

    always @(rst) begin
        if(rst == 1'b1) begin
            down_counter <= 8'd0;
            read_from_queue <= 4'b1000;
        end
    end

endmodule