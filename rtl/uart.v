module uart_top (
    input clk,
    input rstb,
    input [7:0] baudrate_cfg, //clk_en will go to 1 every (50000000/(baudrate_cfg+1)). 216: 9600; 108: 19200; 52: 38400; 36: 57600;  18: 115200; 9: 230400; 
    input rx,
    output tx,
    input wr_en,
    input [7:0] wr_data,
    output tx_busy,
    output rx_valid,
    output [7:0] rx_data
);

    localparam SAMPLE_RATE = 24;

    baudrate #(
        .CLK_FREQ(50000000),
        .SAMPLE_RATE(SAMPLE_RATE)
    )U_BAUDRATE(
        .clk(clk),
        .rstb(rstb),
        .baudrate_cfg(baudrate_cfg),
        .rx_clk_en(rx_clk_en),
        .tx_clk_en(tx_clk_en)
    );

    transmitter U_TX(
        .clk(clk),
        .clk_en(tx_clk_en),
        .rstb(rstb),
    
        .wr_en(wr_en),
        .data(wr_data),
    
        .tx(tx),
        .tx_busy(tx_busy)
    );

    receiver #(
        .SAMPLE_RATE(SAMPLE_RATE)
    )U_RX(
        .clk(clk),
        .clk_en(rx_clk_en),
        .rstb(rstb),
    
        .rx(rx),
    
        .rx_valid(rx_valid),
        .data(rx_data)
    );

endmodule
