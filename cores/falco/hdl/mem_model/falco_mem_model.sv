import Falco_pkg::*;

module falco_mem_model (
    input  logic                    clk,
    
    // Instruction interface
    input  instruction_req_t        instruction_req,
    output instruction_resp_t       instruction_resp,
    
    // Load/Store interface
    input  core_store_req_t        store_req,
    input  core_load_data_req_t    load_data_req,
    input  core_load_ck_hit_req_t  load_ck_hit_req,
    output core_store_resp_t       store_resp,
    output core_load_data_resp_t   load_data_resp,
    output core_load_hit_resp_t    load_hit_resp

);

    // Import DPI function for instruction generation
    import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] instruction_generator();
    import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] rng_seed ();

    // Memory storage
    logic [`SIZE_OF_THE_BUS - 1:0] dmem [logic [`SIZE_OF_THE_BUS - 1:0]];
    logic [63:0] imem [logic [`SIZE_OF_THE_BUS-1:0]];

    // Main memory control logic
    always_ff @(posedge clk) begin
        // Handle instruction requests
        if (instruction_req.p_strobe) begin
            logic [63:0] fetched_instructions;
            fetched_instructions = imem_read(instruction_req.instr0_addr);
            
            instruction_resp.raw_instr0 = fetched_instructions[31:0];
            instruction_resp.raw_instr1 = fetched_instructions[63:32];
            instruction_resp.instr0_valid = 1'b1;
            instruction_resp.instr1_valid = 1'b1;
            instruction_resp.ready = 1'b1;
        end

        // Handle load requests
        if (load_data_req.load_req) begin
            load_data_resp.load_data = dmem_read(load_data_req.load_addr);
            load_data_resp.load_finished = 1'b1;
            load_data_resp.load_miss = 1'b0;
        end

        // Handle store requests
        if (store_req.store_req) begin
            dmem_write(store_req.store_addr, store_req.store_data);
            store_resp.store_finished = 1'b1;
            store_resp.store_miss = 1'b0;
        end

        // Handle load hit check requests
        if (load_ck_hit_req.load_req) begin
            load_hit_resp.load_hit = 1'b1;
            load_hit_resp.load_miss = 1'b0;
        end
    end

    // Instruction memory read function
    function logic [63:0] imem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
        logic [63:0] mem_rdata;
        
        if (!imem.exists(m_addr >> 2)) begin
            bit [63:0] instruction = 0;
            bit [31:0] single_instruction;
            
            for (int i = 0; i < 2; i++) begin
                single_instruction = instruction_generator();
                instruction = instruction | (single_instruction << (i * 32));
            end
            imem[m_addr >> 2] = instruction;
            instruction = 0;
            single_instruction = 0;
        end
        
        mem_rdata = imem[m_addr >> 2];
        return mem_rdata;
    endfunction

    // Data memory read function
    function logic [`SIZE_OF_THE_BUS - 1:0] dmem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
        logic [`SIZE_OF_THE_BUS - 1:0] mem_rdata;
        
        if (!dmem.exists(m_addr >> 2)) begin
            dmem[m_addr >> 2] = $random(rng_seed());
        end
        
        mem_rdata = dmem[m_addr >> 2];
        return mem_rdata;
    endfunction

    // Data memory write task
    task dmem_write(input logic [`SIZE_OF_THE_BUS - 1:0] mem_addr, input logic [`SIZE_OF_THE_BUS - 1:0] wdata);
        logic [`SIZE_OF_THE_BUS - 1:0] m_addr;
        m_addr = mem_addr >> 2;
        dmem[m_addr] = wdata;
    endtask

endmodule