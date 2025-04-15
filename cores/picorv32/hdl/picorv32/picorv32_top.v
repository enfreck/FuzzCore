`timescale 1 ns / 1 ps
`include "model_parameters.v"
module picorv32core (input clk, input rst);

        // Core0
	wire mem_valid;
	wire mem_instr;
	reg mem_ready;
	wire [`SIZE_OF_THE_BUS - 1:0] mem_addr;
	wire [`SIZE_OF_THE_BUS - 1:0] mem_wdata;
	wire [3:0] mem_wstrb;
	reg [`SIZE_OF_THE_BUS - 1:0] mem_rdata;

	wire mem_la_read;
	wire mem_la_write;
	wire [`SIZE_OF_THE_BUS - 1:0] mem_la_addr;
	wire [`SIZE_OF_THE_BUS - 1:0] mem_la_wdata;
	wire [3:0] mem_la_wstrb;

	reg resetn;
	always @(posedge clk) begin
		resetn <= rst;
	end

/* verilator lint_off PINMISSING */
`ifdef PICORV32
	picorv32 picorv32_core (
		.clk         (clk         ),
		.resetn      (resetn      ),
		.mem_valid   (mem_valid   ),
		.mem_instr   (mem_instr   ),
		.mem_ready   (mem_ready   ),
		.mem_addr    (mem_addr    ),
		.mem_wdata   (mem_wdata   ),
		.mem_wstrb   (mem_wstrb   ),
		.mem_rdata   (mem_rdata   ),
		.mem_la_read (mem_la_read ),
		.mem_la_write(mem_la_write),
		.mem_la_addr (mem_la_addr ),
		.mem_la_wdata(mem_la_wdata),
		.mem_la_wstrb(mem_la_wstrb)
	);
`endif

    memory_modelling memory_modelling_inst(
		.clk(clk), 
		.mem_la_wstrb(mem_la_wstrb),
		.mem_la_wdata(mem_la_wdata),
		.mem_la_addr(mem_la_addr),
		.mem_la_write(mem_la_write),
		.mem_la_read(mem_la_read),
		.mem_instr(mem_instr),
		.mem_valid(mem_valid),
		.mem_ready(mem_ready),
		.mem_rdata(mem_rdata)
	);

endmodule