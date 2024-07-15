module priority_select (
    input [7:0] down_counter,
    input [1:4] read_from_queue,
    input packet_is_valid,
    output reg [1:4] next_read_from_queue
);

  

    always @(*) begin
        if(down_counter != 8'd0 )
            next_read_from_queue <= read_from_queue;
        else if(packet_is_valid == 1'b1) begin
            if(read_from_queue[1] == 1'b1)
                next_read_from_queue <= 4'b0100;
            else if(read_from_queue[2] == 1'b1)
                next_read_from_queue <= 4'b0010;
            else if(read_from_queue[3] == 1'b1)
                next_read_from_queue <= 4'b0001;
            else if(read_from_queue[4] == 1'b1)
                next_read_from_queue <= 4'b1000;
            else
                next_read_from_queue <= 4'b1000; 
        end else 
            next_read_from_queue <= read_from_queue;
    end

endmodule