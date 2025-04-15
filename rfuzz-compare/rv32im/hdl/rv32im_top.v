
module rv32im_top
#(
     parameter SUPPORT_SUPER = 1
    ,parameter SUPPORT_MMU = 1
    ,parameter SUPPORT_MULDIV = 1
    ,parameter SUPPORT_LOAD_BYPASS = 1
    ,parameter SUPPORT_MUL_BYPASS   = 1
    ,parameter SUPPORT_REGFILE_XILINX = 1
    ,parameter EXTRA_DECODE_STAGE = 1
    ,parameter MEM_CACHE_ADDR_MIN = 32'h0
    ,parameter MEM_CACHE_ADDR_MAX = 32'hffffffff
)
(
	input clk,
	input  [ 31:0]  dcache_data_rd_w,
	input dcache_accept_w,
	input dcache_ack_w,
	input dcache_error_w,
	input [10:0] dcache_resp_tag_w,
	input icache_accept_w,
	input icache_valid_w,
	input icache_error_w,
	input  [31:0]  icache_inst_w,
	input intr_i,
	input [ 31:0]  reset_vector_i,
    input [31:0] cpu_id_i,
	input rst_i
);
   
    // Core Input Wires
	reg  [ 31:0]  c_dcache_data_rd_w;
	reg c_dcache_accept_w;
	reg c_dcache_ack_w;
	reg c_dcache_error_w;
	reg [10:0] c_dcache_resp_tag_w;
	reg c_icache_accept_w;
	reg c_icache_valid_w;
	reg c_icache_error_w;
	reg  [31:0]  c_icache_inst_w;
	reg c_intr_i;
	reg [ 31:0]  c_reset_vector_i;
    reg [ 31:0] c_cpu_id_i; //Given in github
	reg c_rst_i;

	always @(posedge clk) begin
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
		c_cpu_id_i <= cpu_id_i; 
		c_rst_i <= rst_i;
    end

/* verilator lint_off PINMISSING */
   //Core declaration
   riscv_core
#( //set parameters based on top model
	.SUPPORT_MULDIV(SUPPORT_MULDIV)
	,.SUPPORT_SUPER(SUPPORT_SUPER)
	,.SUPPORT_MMU(SUPPORT_MMU)
	,.SUPPORT_LOAD_BYPASS(SUPPORT_LOAD_BYPASS)
	,.SUPPORT_MUL_BYPASS(SUPPORT_MUL_BYPASS)
	,.SUPPORT_REGFILE_XILINX(SUPPORT_REGFILE_XILINX)
	,.EXTRA_DECODE_STAGE(EXTRA_DECODE_STAGE)
	,.MEM_CACHE_ADDR_MIN(MEM_CACHE_ADDR_MIN)
	,.MEM_CACHE_ADDR_MAX(MEM_CACHE_ADDR_MAX)
)
core
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
	,.cpu_id_i(c_cpu_id_i)
);

endmodule
