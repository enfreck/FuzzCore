`include "model_parameters.v"

module memory_modelling (input logic clk, 
      input logic [3:0] mem_la_wstrb, 
			input logic [`SIZE_OF_THE_BUS - 1:0] mem_la_wdata, 
			input logic [`SIZE_OF_THE_BUS - 1:0] mem_la_addr, 
			input logic mem_la_read,
			input logic mem_la_write,
			input logic mem_instr,
			input logic mem_valid,
			output logic mem_ready, 
			output logic [`SIZE_OF_THE_BUS - 1:0] mem_rdata
  );

  import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] instruction_generator ();
  import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] rng_seed ();

// maps with address as key and instruction/data as value
  // logic [`SIZE_OF_THE_BUS - 1:0] denotes the data structure is an array of items (value) of 32-bits each --> instruction/data value is 32 bits
  // [logic [`SIZE_OF_THE_BUS - 1:0]] denotes that the indicies (key) is of 32-bits --> memory address is 32 bits
  logic [`SIZE_OF_THE_BUS - 1:0] dmem [logic [`SIZE_OF_THE_BUS - 1:0]];
  logic [`SIZE_OF_THE_BUS - 1:0] imem [logic [`SIZE_OF_THE_BUS - 1:0]];
  int file_handle;

  /* verilator lint_off WIDTH */
  always @(posedge clk) begin
    mem_ready <= 1;

    // Check for instruction fetch
    if (mem_la_read && !mem_instr) begin
      // This is an instruction fetch
      mem_rdata <= imem_read(mem_la_addr);  // or mem_read_instr() if separate logic
    end

    // Check for data read
    else if (mem_la_read && mem_instr) begin
      // This is a data read
      mem_rdata <= dmem_read(mem_la_addr);  // or mem_read_data() if separate logic
    end

    // Handle data write
    if (mem_la_write) begin
      dmem_write(mem_la_addr, mem_la_wdata);
    end
  end

  function logic [`SIZE_OF_THE_BUS - 1:0] imem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
    logic [`SIZE_OF_THE_BUS - 1:0] mem_rdata;
    
        if (!imem.exists(m_addr >> 2)) begin
            /* verilator lint_off WIDTH */
            imem[m_addr >> 2] = instruction_generator();
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

  endmodule // pico mem_model