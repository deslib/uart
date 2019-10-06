module uart (
    input           clk,
    input           rstb,
    input [7:0]     baudrate_cfg, 
    input           rx,
    output          tx,
    input           tx_valid,
    input [7:0]     tx_data,
    output          tx_busy,
    output          rx_valid,
    output [7:0]    rx_data
);

    localparam SAMPLE_RATE = 62;

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
    
        .wr_en(tx_valid),
        .data(tx_data),
    
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
