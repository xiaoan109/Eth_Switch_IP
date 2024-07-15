iverilog -o testing/switch_4x4.vvp ./switch_4x4.v components/input_daemon.v components/output_daemon.v components/priority_select.v components/queue.v testbenches/switch_4x4_tb.v
vvp testing/switch_4x4.vvp 
