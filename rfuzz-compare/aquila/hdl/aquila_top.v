
module aquila_top
#(
	parameter HART_ID       = 0,
    parameter XLEN          = 32,
    parameter BPU_ENTRY_NUM = 64
)
(
	input clk,
	input rst_i,
	input  stall, //1 bit
	input  [XLEN-1 : 0]   init_pc_addr,
	input  [XLEN-1 : 0]   code,
    input                 code_ready,
	input  [XLEN-1 : 0]   data_core_in,
    input                 data_ready,
	input                 data_addr_ext,
    input                 ext_irq,
    input                 tmr_irq,
    input                 sft_irq
);
   
	reg  c_rst_i;
	reg  c_stall; 
	reg  [XLEN-1 : 0]   c_init_pc_addr;
	reg  [XLEN-1 : 0]   c_code;
    reg                 c_code_ready;
	reg  [XLEN-1 : 0]   c_data_core_in;
    reg                 c_data_ready;
	reg                 c_data_addr_ext;
    reg                 c_ext_irq;
    reg                 c_tmr_irq;
    reg                 c_sft_irq;


	always @(posedge clk) begin
		c_rst_i <= rst_i;
		c_stall <= stall;
		c_init_pc_addr <= init_pc_addr;
		c_code <= c_code;
		c_code_ready <= code_ready;
		c_data_core_in <= data_core_in;
		c_data_ready <= data_ready;
		c_data_addr_ext <= data_addr_ext;
		c_ext_irq <= ext_irq;
		c_tmr_irq <= tmr_irq;
		c_sft_irq <= sft_irq;
	end

   //Core declaration
core_top #(
    .HART_ID(HART_ID),
    .XLEN(XLEN),
    .BPU_ENTRY_NUM(BPU_ENTRY_NUM)
)
core
(
		//Inputs
    	.clk_i(clk),
		.rst_i(c_rst_i),
		.stall_i(c_stall),
		.init_pc_addr_i(c_init_pc_addr),
		.code_i(c_code),
		.code_ready_i(c_code_ready),
		.data_i(c_data_core_in),
		.data_ready_i(c_data_ready),
		.data_addr_ext_i(c_data_addr_ext),
		.ext_irq_i(c_ext_irq),
		.tmr_irq_i(c_tmr_irq),
		.sft_irq_i(c_sft_irq)
);

endmodule
