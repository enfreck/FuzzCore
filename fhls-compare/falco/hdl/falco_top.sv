import Falco_pkg::*;

module falco_top(
    input clk,
    input rst,
    input [XLEN_WIDTH-1:0] init_pc,
    input instruction_resp_t instruction_resp,
    input core_load_hit_resp_t load_hit_resp,
    input   core_load_data_resp_t   load_data_resp,
    input core_store_resp_t store_resp
);

    reg c_rst;
    reg [XLEN_WIDTH-1:0] c_init_pc;
    instruction_resp_t c_instruction_resp;
    core_load_hit_resp_t c_load_hit_resp;
    core_load_data_resp_t c_load_data_resp;
    core_store_resp_t c_store_resp;

	always @(posedge clk) begin
		c_rst <= rst;
        c_init_pc <= init_pc;
        c_instruction_resp <= instruction_resp;
        c_load_hit_resp <= load_hit_resp;
        c_load_data_resp <= load_data_resp;
        c_store_resp <= store_resp;
	end

     /* verilator lint_off PINMISSING */

    //Core Model Declaration
    core_top core(

        //Input
        .clk(clk),
        .rst(c_rst),
        .init_pc(c_init_pc),
        .instruction_resp(c_instruction_resp),
        .load_hit_resp(c_load_hit_resp),
        .load_data_resp(c_load_data_resp),
        .store_resp(c_store_resp)
    );

endmodule
