
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
	input rst_i,
	// Core Input Wires
	input  [ 31:0]  dcache_data_rd_w,
	input dcache_accept_w,
	input dcache_ack_w,
	input dcache_error_w,
	input [10:0] dcache_resp_tag_w,
	input icache_accept_w,
	input icache_valid_w,
	input icache_error_w,
	input  [ 63:0]  icache_inst_w,
	input intr_i,
	input [ 31:0]  reset_vector_i,
	input  [ 31:0]  cpu_id_i
	
);


	// Core Input Wires
	reg c_rst_i;
	reg  [ 31:0]  c_dcache_data_rd_w;
	reg c_dcache_accept_w;
	reg c_dcache_ack_w;
	reg c_dcache_error_w;
	reg [10:0] c_dcache_resp_tag_w;
	reg c_icache_accept_w;
	reg c_icache_valid_w;
	reg c_icache_error_w;
	reg  [ 63:0]  c_icache_inst_w;
	reg c_intr_i;
	reg [ 31:0]  c_reset_vector_i = 32'h80000000;
	reg  [ 31:0]  c_cpu_id_w;

	always @(posedge clk) begin
		c_rst_i <= rst_i;
		c_dcache_data_rd_w <= dcache_data_rd_w;
		c_dcache_accept_w <= dcache_accept_w;
		c_dcache_ack_w <= dcache_ack_w;
		c_dcache_error_w <= dcache_error_w;
		c_dcache_resp_tag_w <= dcache_resp_tag_w;
		c_icache_accept_w <= icache_accept_w;
		c_icache_valid_w <= icache_valid_w;
		c_icache_error_w <= icache_error_w;
		c_icache_inst_w <= icache_inst_w;
		c_intr_i <= intr_i;
		c_reset_vector_i <= reset_vector_i;
		c_cpu_id_w <= cpu_id_i;
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
	,.rst_i(c_rst_i)
	,.mem_d_data_rd_i(c_dcache_data_rd_w)
	,.mem_d_accept_i(c_dcache_accept_w)
	,.mem_d_ack_i(c_dcache_ack_w)
	,.mem_d_error_i(c_dcache_error_w)
	,.mem_d_resp_tag_i(c_dcache_resp_tag_w)
	,.mem_i_accept_i(c_icache_accept_w)
	,.mem_i_valid_i(c_icache_valid_w)
	,.mem_i_error_i(c_icache_error_w)
	,.mem_i_inst_i(c_icache_inst_w)
	,.intr_i(c_intr_i)
	,.reset_vector_i(c_reset_vector_i)
	,.cpu_id_i(c_cpu_id_w)
);

endmodule
