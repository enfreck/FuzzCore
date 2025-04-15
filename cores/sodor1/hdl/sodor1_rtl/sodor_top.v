`timescale 1 ns / 1 ps
`include "model_parameters.v"
module sodor_top (input clk, input rst);

	// Core0
	wire [`SIZE_OF_THE_BUS - 1:0] imem_req_addr;
	wire [`SIZE_OF_THE_BUS - 1:0] imem_resp_data;
	wire [`SIZE_OF_THE_BUS - 1:0] dmem_req_addr;
	wire [`SIZE_OF_THE_BUS - 1:0] dmem_req_data;
	wire dmem_resp_valid;
	wire dmem_req_valid;
	wire dmem_fcn_write_en;
	wire [2:0] dmem_bit_typ;
	wire [`SIZE_OF_THE_BUS - 1:0] dmem_resp_data;
	wire [4:0] ddpath_addr;
	
	reg reset;

	always @(posedge clk) begin
		// if ($urandom_range(0, 4) == 0) begin
		// 	reset <= 1;
		// end else begin
		// 	reset <= 0;
		// end

		reset <= rst;
	end

/* verilator lint_off PINMISSING */
   Core sodor_core (
		.clock(clk),
		.reset(reset),
		.io_imem_req_bits_addr(imem_req_addr),
		.io_imem_resp_bits_data(imem_resp_data),
		.io_dmem_req_valid(dmem_req_valid),
		.io_dmem_req_bits_addr(dmem_req_addr),
		.io_dmem_req_bits_data(dmem_req_data),
		.io_dmem_req_bits_fcn(dmem_fcn_write_en),
		.io_dmem_req_bits_typ(dmem_bit_typ),
		.io_dmem_resp_valid(dmem_resp_valid),
		.io_dmem_resp_bits_data(dmem_resp_data)
	        );

   sodor_mem_model  memory_modelling_inst(
	    .clk(clk),
		.imem_addr(imem_req_addr),
		.imem_data(imem_resp_data),
		.dmem_req_addr(dmem_req_addr),
		.dmem_req_data(dmem_req_data),
		.dmem_req_valid(dmem_req_valid),
		.dmem_req_write_en(dmem_fcn_write_en),
		.dmem_req_bits_typ(dmem_bit_typ),
		.dmem_resp_valid(dmem_resp_valid),
		.dmem_resp_data(dmem_resp_data)
		    );

endmodule
