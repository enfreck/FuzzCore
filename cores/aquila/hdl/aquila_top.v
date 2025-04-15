
`include "model_parameters.v"

module aquila_top
#(
	parameter HART_ID       = 0,
    parameter XLEN          = 32,
    parameter BPU_ENTRY_NUM = 64
)
(
     input clk,
	 input rst
);
   
    // Core Input Wires
	wire  stall; //1 bit
	wire  [XLEN-1 : 0]   init_pc_addr;
	wire  [XLEN-1 : 0]   code;
    wire                 code_ready;
	wire  [XLEN-1 : 0]   data_core_in;
    wire                 data_ready;
	wire                 data_addr_ext;
    wire                 ext_irq;
    wire                 tmr_irq;
    wire                 sft_irq;

	//Core Output Wires
	wire [XLEN-1 : 0]   code_addr;
    wire 				code_req;
	wire [XLEN-1 : 0]   data_core_out;
    wire [XLEN-1 : 0]   data_addr;
    wire                data_rw;      // 0: data read, 1: data write.
    wire [XLEN/8-1 : 0] data_byte_enable;
    wire                data_req;
    wire                data_is_amo;
    wire [ 4: 0]        data_amo_type;
	wire cache_flush;

	reg reset;

	always @(posedge clk) begin
		reset <= rst;
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
		.rst_i(reset),
		.stall_i(stall),
		.init_pc_addr_i(init_pc_addr),
		.code_i(code),
		.code_ready_i(code_ready),
		.data_i(data_core_in),
		.data_ready_i(data_ready),
		.data_addr_ext_i(data_addr_ext),
		.ext_irq_i(ext_irq),
		.tmr_irq_i(tmr_irq),
		.sft_irq_i(sft_irq),

		//Outputs
		.code_addr_o(code_addr),
		.code_req_o(code_req),
		.data_o(data_core_out),
		.data_addr_o(data_addr),
		.data_rw_o(data_rw),
		.data_byte_enable_o(data_byte_enable),
		.data_req_o(data_req),
		.data_is_amo_o(data_is_amo),
		.data_amo_type_o(data_amo_type),
		.cache_flush_o(cache_flush)

);


aquila_mem_model #(
	.XLEN(XLEN)
)  
memory_modelling_inst
(        
		//Inputs
		.clk(clk),
		.code_addr_i(code_addr),
		.code_req_i(code_req),
		.data_i(data_core_out),
		.data_addr_i(data_addr),
		.data_rw_i(data_rw),
		.data_byte_enable_i(data_byte_enable),
		.data_req_i(data_req),
		.data_is_amo_i(data_is_amo),
		.data_amo_type_i(data_amo_type),
		.cache_flush_i(cache_flush),

		//Outputs
		.stall_o(stall),
		.init_pc_addr_o(init_pc_addr),
		.code_o(code),
		.code_ready_o(code_ready),
		.data_o(data_core_in),
		.data_ready_o(data_ready),
		.data_addr_ext_o(data_addr_ext),
		.ext_irq_o(ext_irq),
		.tmr_irq_o(tmr_irq),
		.sft_irq_o(sft_irq)

	);

endmodule
