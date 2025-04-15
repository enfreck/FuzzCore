`timescale 1 ns / 1 ps
module picorv32_top (input clk,
input resetn,
input mem_ready,
input [`SIZE_OF_THE_BUS - 1:0] mem_rdata,
input pcpi_wr,
input [`SIZE_OF_THE_BUS - 1:0] pcpi_rd,
input pcpi_wait,
input pcpi_ready,
input [`SIZE_OF_THE_BUS - 1:0] irq
);

	reg c_resetn;
	reg c_mem_ready;
	reg [`SIZE_OF_THE_BUS - 1:0] c_mem_rdata;
	reg c_pcpi_wr;
	reg [`SIZE_OF_THE_BUS - 1:0] c_pcpi_rd;
	reg c_pcpi_wait;
	reg c_pcpi_ready;
	reg [`SIZE_OF_THE_BUS - 1:0] c_irq;

	always @(posedge clk) begin
		c_resetn <= resetn;
		c_mem_ready <= mem_ready;
		c_mem_rdata <= mem_rdata;
		c_pcpi_wr <= pcpi_wr;
		c_pcpi_rd <= pcpi_rd;
		c_pcpi_wait <= pcpi_wait;
		c_pcpi_ready <= pcpi_ready;
		c_irq <= irq;
	end
	

/* verilator lint_off PINMISSING */
   picorv32 picorv32_core (
		.clk         (clk         ),
		.resetn      (c_resetn      ),
		.mem_ready   (c_mem_ready   ),
		.mem_rdata   (c_mem_rdata   ),
		.pcpi_wr     (c_pcpi_wr),
		.pcpi_rd     (c_pcpi_rd),
		.pcpi_wait   (c_pcpi_wait),
		.pcpi_ready  (c_pcpi_ready),
		.irq         (c_irq)
	);

endmodule
