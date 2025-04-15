`timescale 1 ns / 1 ps
module sodor_top (input clock,
input reset,
input [4:0] ddpath_addr,
input [`SIZE_OF_THE_BUS - 1:0] ddpath_wdata,
input [`SIZE_OF_THE_BUS - 1:0] dmem_resp_data,
input [`SIZE_OF_THE_BUS - 1:0] imem_resp_data
);
	
	reg c_reset;
	reg [4:0] c_ddpath_addr;
	reg [`SIZE_OF_THE_BUS - 1:0] c_ddpath_wdata;
	reg [`SIZE_OF_THE_BUS - 1:0] c_dmem_resp_data;
	reg [`SIZE_OF_THE_BUS - 1:0] c_imem_resp_data;

	always @(posedge clock) begin
    	c_reset = reset;
		c_ddpath_addr <= ddpath_addr;
		c_ddpath_wdata <= ddpath_wdata;
		c_dmem_resp_data <= dmem_resp_data;
		c_imem_resp_data <= imem_resp_data;
	end

	

/* verilator lint_off PINMISSING */
   Core sodor_core (
		.clock(clock),
		.reset(c_reset),
		.io_imem_resp_bits_data(c_imem_resp_data),
		.io_dmem_resp_bits_data(c_dmem_resp_data),
		.io_ddpath_wdata(c_ddpath_wdata),
		.io_ddpath_addr(c_ddpath_addr)
	        );

endmodule
