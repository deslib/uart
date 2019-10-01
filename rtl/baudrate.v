module baudrate #(
    parameter CLK_FREQ = 50000000,
    parameter SAMPLE_RATE = 24
)(
    input clk,
    input rstb,
    input [7:0] baudrate_cfg, //clk_en will go to 1 every (50000000/(baudrate_cfg+1))
    output tx_clk_en,
    output rx_clk_en
);

    reg [7:0] cnt;
    reg [4:0] tx_cnt;
    always @(posedge clk or negedge rstb) begin
        if(~rstb) begin
            cnt <= 0;
        end else begin
            if(cnt == baudrate_cfg) begin
                cnt <= 0;
            end else begin
                cnt <= cnt + 1;
            end
        end
    end

    assign rx_clk_en = cnt == baudrate_cfg;

    always @(posedge clk or negedge rstb) begin
        if(~rstb) begin
            tx_cnt <= 0;
        end else begin
            if(rx_clk_en) begin
                if(tx_cnt  == SAMPLE_RATE -1) begin
                    tx_cnt <= 0;
                end else begin
                    tx_cnt <= tx_cnt + 1;
                end
            end
        end
    end

    assign tx_clk_en = (tx_cnt == (SAMPLE_RATE-1)) & rx_clk_en;

endmodule
