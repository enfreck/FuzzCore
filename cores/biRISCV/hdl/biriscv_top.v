
`include "model_parameters.v"

//This is the top model currently in use

module biriscv_top
#(
     parameter CORE_ID          = 0
    ,parameter ICACHE_AXI_ID    = 0
    ,parameter DCACHE_AXI_ID    = 0
    ,parameter SUPPORT_BRANCH_PREDICTION = 1
    ,parameter SUPPORT_MULDIV   = 1
    ,parameter SUPPORT_SUPER    = 1
    ,parameter SUPPORT_MMU      = 1
    ,parameter SUPPORT_DUAL_ISSUE = 1
    ,parameter SUPPORT_LOAD_BYPASS = 1
    ,parameter SUPPORT_MUL_BYPASS = 1
    ,parameter SUPPORT_REGFILE_XILINX = 0
    ,parameter EXTRA_DECODE_STAGE = 1
    ,parameter MEM_CACHE_ADDR_MIN = 32'h80000000
    ,parameter MEM_CACHE_ADDR_MAX = 32'h8fffffff
    ,parameter NUM_BTB_ENTRIES  = 32
    ,parameter NUM_BTB_ENTRIES_W = 5
    ,parameter NUM_BHT_ENTRIES  = 512
    ,parameter NUM_BHT_ENTRIES_W = 9
    ,parameter RAS_ENABLE       = 1
    ,parameter GSHARE_ENABLE    = 0
    ,parameter BHT_ENABLE       = 1
    ,parameter NUM_RAS_ENTRIES  = 8
    ,parameter NUM_RAS_ENTRIES_W = 3
)
(
     input clk,
	 input rst
);

	// Core Input Wires
	wire  [ 31:0]  dcache_data_rd_w;
	wire dcache_accept_w;
	wire dcache_ack_w;
	wire dcache_error_w;
	wire [10:0] dcache_resp_tag_w;
	wire icache_accept_w;
	wire icache_valid_w;
	wire icache_error_w;
	wire  [ 63:0]  icache_inst_w;
	wire intr_i;
	wire [ 31:0]  reset_vector_i = 32'h80000000;
	wire  [ 31:0]  cpu_id_w = CORE_ID;

	//Core Output Wires
	wire  [ 31:0]  dcache_addr_w;
	wire  [ 31:0]  dcache_data_wr_w;
	wire           dcache_rd_w;
	wire  [  3:0]  dcache_wr_w;
	wire           dcache_cacheable_w;
	wire  [ 10:0]  dcache_req_tag_w;
	wire           dcache_invalidate_w;
	wire           dcache_writeback_w;
	wire           dcache_flush_w;
	wire           icache_rd_w;
	wire           icache_flush_w;
	wire           icache_invalidate_w;
	wire  [ 31:0]  icache_pc_w;

	reg reset;

	always @(posedge clk) begin
		reset <= rst;
	end

/* verilator lint_off PINMISSING */
   //Core declaration
   riscv_core
#( //set parameters based on top model
	.MEM_CACHE_ADDR_MIN(MEM_CACHE_ADDR_MIN)
	,.MEM_CACHE_ADDR_MAX(MEM_CACHE_ADDR_MAX)
	,.SUPPORT_BRANCH_PREDICTION(SUPPORT_BRANCH_PREDICTION)
	,.SUPPORT_MULDIV(SUPPORT_MULDIV)
	,.SUPPORT_SUPER(SUPPORT_SUPER)
	,.SUPPORT_MMU(SUPPORT_MMU)
	,.SUPPORT_DUAL_ISSUE(SUPPORT_DUAL_ISSUE)
	,.SUPPORT_LOAD_BYPASS(SUPPORT_LOAD_BYPASS)
	,.SUPPORT_MUL_BYPASS(SUPPORT_MUL_BYPASS)
	,.SUPPORT_REGFILE_XILINX(SUPPORT_REGFILE_XILINX)
	,.EXTRA_DECODE_STAGE(EXTRA_DECODE_STAGE)
	,.NUM_BTB_ENTRIES(NUM_BTB_ENTRIES)
	,.NUM_BTB_ENTRIES_W(NUM_BTB_ENTRIES_W)
	,.NUM_BHT_ENTRIES(NUM_BHT_ENTRIES)
	,.NUM_BHT_ENTRIES_W(NUM_BHT_ENTRIES_W)
	,.RAS_ENABLE(RAS_ENABLE)
	,.GSHARE_ENABLE(GSHARE_ENABLE)
	,.BHT_ENABLE(BHT_ENABLE)
	,.NUM_RAS_ENTRIES(NUM_RAS_ENTRIES)
	,.NUM_RAS_ENTRIES_W(NUM_RAS_ENTRIES_W)
)
u_core
(
	// Inputs
	.clk_i(clk)
	,.rst_i(reset)
	,.mem_d_data_rd_i(dcache_data_rd_w)
	,.mem_d_accept_i(dcache_accept_w)
	,.mem_d_ack_i(dcache_ack_w)
	,.mem_d_error_i(dcache_error_w)
	,.mem_d_resp_tag_i(dcache_resp_tag_w)
	,.mem_i_accept_i(icache_accept_w)
	,.mem_i_valid_i(icache_valid_w)
	,.mem_i_error_i(icache_error_w)
	,.mem_i_inst_i(icache_inst_w)
	,.intr_i(intr_i)
	,.reset_vector_i(reset_vector_i)
	,.cpu_id_i(cpu_id_w)

	// Outputs
	,.mem_d_addr_o(dcache_addr_w)
	,.mem_d_data_wr_o(dcache_data_wr_w)
	,.mem_d_rd_o(dcache_rd_w)
	,.mem_d_wr_o(dcache_wr_w)
	,.mem_d_cacheable_o(dcache_cacheable_w)
	,.mem_d_req_tag_o(dcache_req_tag_w)
	,.mem_d_invalidate_o(dcache_invalidate_w)
	,.mem_d_writeback_o(dcache_writeback_w)
	,.mem_d_flush_o(dcache_flush_w)
	,.mem_i_rd_o(icache_rd_w)
	,.mem_i_flush_o(icache_flush_w)
	,.mem_i_invalidate_o(icache_invalidate_w)
	,.mem_i_pc_o(icache_pc_w)
);

   biriscv_mem_model  memory_modelling_inst(
	.clk(clk),
	.imem_addr(icache_pc_w),
	.imem_data(icache_inst_w),
	.dmem_req_addr(dcache_addr_w),
	.dmem_req_data(dcache_data_wr_w),
	.dmem_req_valid(dcache_rd_w),
	.dmem_req_write_en(dcache_wr_w),
	.dmem_resp_valid(dcache_ack_w),
	.dmem_resp_data(dcache_data_rd_w),
	.imem_valid(icache_valid_w),
	.imem_accept(icache_accept_w),
	.imem_error(icache_error_w),
	.i_intr(intr_i)
	);

endmodule
