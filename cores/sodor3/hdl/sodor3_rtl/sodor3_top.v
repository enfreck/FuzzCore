`timescale 1 ns / 1 ps
`include "model_parameters.v"
module sodor3_top (input clk, input rst);

        // Core0
	wire [`SIZE_OF_THE_BUS - 1:0] imem_req_addr;
	wire [`SIZE_OF_THE_BUS - 1:0] dmem_req_addr;
	wire [`SIZE_OF_THE_BUS - 1:0] imem_resp_data;
	wire [`SIZE_OF_THE_BUS - 1:0] dmem_req_data;
	wire dmem_fcn_write_en;
	reg [`SIZE_OF_THE_BUS - 1:0] dmem_resp_data;

	reg reset;

	always @(posedge clk) begin
		reset <= rst;
	end

/* verilator lint_off PINMISSING */
   Core sodor_core (
		.clock(clk),
		.reset(reset),
		.io_imem_req_bits_addr(imem_req_addr),
		.io_imem_resp_bits_data(imem_resp_data),
		.io_dmem_req_bits_addr(dmem_req_addr),
		.io_dmem_req_bits_data(dmem_req_data),
		.io_dmem_req_bits_fcn(dmem_fcn_write_en),
		//.io_dmem_req_bits_typ(),
		.io_dmem_resp_bits_data(dmem_resp_data)
	        );

   sodor_mem_model  memory_modelling_inst(
	                  .clk(clk),
	                  .imem_addr(imem_req_addr),
			  .imem_data(imem_resp_data),
			  .dmem_req_addr(dmem_req_addr),
			  .dmem_req_data(dmem_req_data),
			  .dmem_req_write_en(dmem_fcn_write_en),
			  .dmem_resp_data(dmem_resp_data)
		          );

endmodule
