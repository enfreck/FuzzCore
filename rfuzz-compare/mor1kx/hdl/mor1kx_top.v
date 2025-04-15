module mor1kx_top (input clk,
input rst,
input iwbm_err_i,
input iwbm_ack_i,
input [`SIZE_OF_THE_BUS - 1:0] iwbm_dat_i,
input iwbm_rty_i,
input dwbm_err_i,
input dwbm_ack_i,
input [`SIZE_OF_THE_BUS - 1:0] dwbm_dat_i,
input dwbm_rty_i,
input [`SIZE_OF_THE_BUS - 1:0] irq_i,
input [15:0] du_addr_i,
input du_stb_i,
input [`SIZE_OF_THE_BUS - 1:0] du_dat_i,
input du_we_i,
input du_stall_i,
input [`SIZE_OF_THE_BUS - 1:0] multicore_coreid_i,
input [`SIZE_OF_THE_BUS - 1:0] multicore_numcores_i,
input [`SIZE_OF_THE_BUS - 1:0] snoop_adr_i,
input snoop_en_i
);

    reg c_reset;
    reg c_iwbm_err_i;
    reg c_iwbm_ack_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_iwbm_dat_i;
    reg c_iwbm_rty_i;
    reg c_dwbm_err_i;
    reg c_dwbm_ack_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_dwbm_dat_i;
    reg c_dwbm_rty_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_irq_i;
    reg [15:0] c_du_addr_i;
    reg c_du_stb_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_du_dat_i;
    reg c_du_we_i;
    reg c_du_stall_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_multicore_coreid_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_multicore_numcores_i;
    reg [`SIZE_OF_THE_BUS - 1:0] c_snoop_adr_i;
    reg c_snoop_en_i;

    always @(posedge clk) begin
      c_reset <= rst;
      c_iwbm_err_i <= iwbm_err_i;
      c_iwbm_ack_i <= iwbm_ack_i;
      c_iwbm_dat_i <= iwbm_dat_i;
      c_iwbm_rty_i <= iwbm_rty_i;
      c_dwbm_err_i <= dwbm_err_i;
      c_dwbm_ack_i <= dwbm_ack_i;
      c_dwbm_dat_i <= dwbm_dat_i;
      c_dwbm_rty_i <= dwbm_rty_i;
      c_irq_i <= irq_i;
      c_du_addr_i <= du_addr_i;
      c_du_stb_i <= du_stb_i;
      c_du_dat_i <= du_dat_i;
      c_du_we_i <= du_we_i;
      c_du_stall_i <= du_stall_i;
      c_multicore_coreid_i <= multicore_coreid_i;
      c_multicore_numcores_i <= multicore_numcores_i;
      c_snoop_adr_i <= snoop_adr_i;
      c_snoop_en_i <= snoop_en_i;
    end

/* verilator lint_off PINMISSING */
    mor1kx mor1kx_inst (
      .clk(clk),
      .rst(c_reset),
      .iwbm_err_i (c_iwbm_err_i),
      .iwbm_ack_i (c_iwbm_ack_i),
      .iwbm_dat_i (c_iwbm_dat_i),
      .iwbm_rty_i (c_iwbm_rty_i),
      .dwbm_err_i (c_dwbm_err_i),
      .dwbm_ack_i (c_dwbm_ack_i),
      .dwbm_dat_i (c_dwbm_dat_i),
      .dwbm_rty_i (c_dwbm_rty_i),
      .irq_i (c_irq_i),
      .du_addr_i (c_du_addr_i),
      .du_stb_i (c_du_stb_i),
      .du_dat_i (c_du_dat_i),
      .du_we_i (c_du_we_i),
      .du_stall_i (c_du_stall_i),
      .multicore_coreid_i (c_multicore_coreid_i),
      .multicore_numcores_i (c_multicore_numcores_i),
      .snoop_adr_i (c_snoop_adr_i),
      .snoop_en_i (c_snoop_en_i)
    );
  

endmodule // Top
