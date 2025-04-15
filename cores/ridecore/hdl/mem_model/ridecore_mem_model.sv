module ridecore_mem_model (
    input logic clk,
    input logic [31:0] imem_addr,
    output logic [127:0] imem_data, //4, 32 bit instructions
    input logic [31:0] dmem_req_addr,
    input logic [31:0] dmem_req_data,
    input logic dmem_req_write_en,
    output logic [31:0] dmem_resp_data
    );
      

  //Has to match exactly to core_clk declaration
 import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] instruction_generator();
 import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] rng_seed ();

  // maps with address as key and instruction/data as value
  // logic [`SIZE_OF_THE_BUS - 1:0] denotes the data structure is an array of items (value) of 32-bits each --> instruction/data value is 32 bits
  // [logic [`SIZE_OF_THE_BUS - 1:0]] denotes that the indicies (key) is of 32-bits --> memory address is 32 bits
  logic [`SIZE_OF_THE_BUS - 1:0] dmem [logic [`SIZE_OF_THE_BUS - 1:0]];
  logic [127:0] imem [logic [`SIZE_OF_THE_BUS-1:0]]; //updated to be 4 insns with 32 bit addressing
  int file_handle;

  /* verilator lint_off WIDTH */
  always @(posedge clk) begin
          imem_data = imem_read (imem_addr);
	  if (!dmem_req_write_en) begin
	          dmem_resp_data = dmem_read (dmem_req_addr);
	  end
	  else begin
	          dmem_write (dmem_req_addr, dmem_req_data);
	  end
  end

// Returns next instruction in the input file
  function logic [127:0] imem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
    logic [127:0] mem_rdata; //update return size so it can hold 4, 32 bit instructions
    
    if (!imem.exists(m_addr >> 2)) begin
        bit [127:0] instruction = 0;
        bit [31:0] single_instruction; // Temporary variable for each 32-bit instruction

        for (int i = 0; i < 4; i++) begin
            single_instruction = instruction_generator(); // Call to generate a 32-bit instruction
            instruction = instruction | (single_instruction << (i * 32)); // Place each 32-bit instruction into the 128-bit block
        end
        imem[m_addr >> 2] = instruction; // Assign the full 128-bit instruction
        instruction = 0;
        single_instruction = 0;
    end

    mem_rdata = imem[m_addr >> 2];
    return mem_rdata;
  endfunction // imem_read

// Returns dmem array data or randomly generates a value
 function logic [`SIZE_OF_THE_BUS - 1:0] dmem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
    logic [`SIZE_OF_THE_BUS - 1:0] mem_rdata;
    
    /* verilator lint_off WIDTH */
    if (!dmem.exists(m_addr >> 2)) begin
        dmem[m_addr >> 2] = $random(rng_seed());
    end

    mem_rdata = dmem[m_addr >> 2];

    return mem_rdata;
  endfunction // dmem_read

// Writes data to dmem array
  task dmem_write(input logic [`SIZE_OF_THE_BUS - 1:0] mem_addr, input logic [`SIZE_OF_THE_BUS - 1:0] wdata);
     logic [`SIZE_OF_THE_BUS - 1:0] m_addr;

       m_addr = mem_addr >> 2;
       dmem[m_addr] = wdata;
  endtask // dmem_write

endmodule
