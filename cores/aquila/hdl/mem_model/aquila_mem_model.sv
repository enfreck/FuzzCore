`timescale 1ns / 1ps

module aquila_mem_model #(
    parameter XLEN = 32  // Default value for XLEN
) (
    input logic clk,
    // Mem Model Input Wires
    input logic [XLEN-1 : 0]   code_addr_i,
    input logic                code_req_i,
    input logic [XLEN-1 : 0]   data_i,
    input logic [XLEN-1 : 0]   data_addr_i,
    input logic                data_rw_i,    // 0: data read, 1: data write.
    input logic [XLEN/8-1 : 0] data_byte_enable_i,
    input logic                data_req_i,
    input logic                data_is_amo_i,
    input logic [4:0]          data_amo_type_i,
    input logic                cache_flush_i,
  
    // Mem Model Output Wires
    output logic                 stall_o, // 1 bit
    output logic  [XLEN-1 : 0]   init_pc_addr_o,
    output logic  [XLEN-1 : 0]   code_o,
    output logic                 code_ready_o,
    output logic  [XLEN-1 : 0]   data_o,
    output logic                 data_ready_o,
    output logic                 data_addr_ext_o,
    output logic                 ext_irq_o,
    output logic                 tmr_irq_o,
    output logic                 sft_irq_o
);
      


  //Has to match exactly to core_clk declaration
 import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] instruction_generator();
 import "DPI-C" function bit [`SIZE_OF_THE_BUS - 1:0] rng_seed ();

  // maps with address as key and instruction/data as value
  // logic [`SIZE_OF_THE_BUS - 1:0] denotes the data structure is an array of items (value) of 32-bits each --> instruction/data value is 32 bits
  // [logic [`SIZE_OF_THE_BUS - 1:0]] denotes that the indicies (key) is of 32-bits --> memory address is 32 bits
  logic [`SIZE_OF_THE_BUS - 1:0] dmem [logic [`SIZE_OF_THE_BUS - 1:0]];
  logic [`SIZE_OF_THE_BUS - 1:0] imem [logic [`SIZE_OF_THE_BUS - 1:0]];
  int file_handle;


  /* verilator lint_off WIDTH */
  always @(posedge clk) begin
    if(code_req_i) begin
      code_o = imem_read (code_addr_i);
      code_ready_o <= 1;
    end
          
	  if (data_req_i) begin //memory operation is requested
      
      if(data_rw_i) begin //write operation is true
        dmem_write (data_addr_i, data_i);
      end
      else begin //read request from dmem
          data_o = dmem_read (data_addr_i);
          data_ready_o <= 1;
      end
	  end

    //Set output wires
	  stall_o <= 0;
    init_pc_addr_o <= 0;
    data_addr_ext_o <= 0;
    ext_irq_o <= 0;
    tmr_irq_o <= 0;
    sft_irq_o <= 0;
    
  end

// Returns next instruction in the input file
  function logic [`SIZE_OF_THE_BUS - 1:0] imem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
    logic [`SIZE_OF_THE_BUS - 1:0] mem_rdata;
    logic [31:0] generated_instruction;
    
    // Check if the memory address exists
    if (!imem.exists(m_addr >> 2)) begin
      /* verilator lint_off WIDTH */
        imem[m_addr >> 2] = instruction_generator();
    end

    // Read the instruction from memory
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

endmodule // sodor_mem_model
