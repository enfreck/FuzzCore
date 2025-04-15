
import Falco_pkg::*;

module falco_top(
     input clk,
     input rst
);

    //program counter address at reset
    wire [XLEN_WIDTH-1:0]        init_pc; //32 bits

    //debug bus
    wire [1:0]             core_commit_count;
    committed_map_update_t  committed_update; /*vivado debug purpose*/

    //Instruction port (from TCM or ICache)
    instruction_req_t       instruction_req;
    instruction_resp_t      instruction_resp;

    wire                   load_dmem_stall;
    //Load check hit port
    core_load_ck_hit_req_t  load_ck_hit_req;
    core_load_hit_resp_t    load_hit_resp;

    //Load data response port
    core_load_data_req_t    load_data_req;
    core_load_data_resp_t   load_data_resp;

    //Store port
    core_store_req_t        store_req;
    core_store_resp_t       store_resp;

        reg reset;

        always @(posedge clk) begin
                reset <= rst;
        end

     /* verilator lint_off PINMISSING */

    //Core Model Declaration
    core_top core(

        //Input
        .clk(clk),
        .rst(reset),
        .init_pc(init_pc),
        .instruction_resp(instruction_resp),
        .load_hit_resp(load_hit_resp),
        .load_data_resp(load_data_resp),
        .store_resp(store_resp),

        //Output
        .core_commit_count(core_commit_count),
        .committed_update(committed_update),
        .instruction_req(instruction_req),
        .load_dmem_stall(load_dmem_stall),
        .load_ck_hit_req(load_ck_hit_req),
        .load_data_req(load_data_req),
        .store_req(store_req)
    );

    //Memory Model

    falco_mem_model memory_modelling_inst (
        .clk               (clk),
        
        // Instruction interface
        .instruction_req   (instruction_req),
        .instruction_resp  (instruction_resp),
        
        // Load/Store interface
        .store_req        (store_req),
        .load_data_req    (load_data_req),
        .load_ck_hit_req  (load_ck_hit_req),
        .store_resp       (store_resp),
        .load_data_resp   (load_data_resp),
        .load_hit_resp    (load_hit_resp)
    );

endmodule