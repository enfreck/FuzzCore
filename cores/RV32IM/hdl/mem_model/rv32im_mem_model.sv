module rv32im_mem_model (input logic clk,
			input logic [31:0] imem_addr,
			output logic [31:0] imem_data,
			input logic [31:0] dmem_req_addr,
			input logic [31:0] dmem_req_data,
			input logic dmem_req_valid,
			input logic [3:0] dmem_req_write_en,
			output logic dmem_resp_valid,
			output logic [31:0] dmem_resp_data,
      //New Wires
      output logic imem_valid,
      output logic imem_accept,
      output logic imem_error,
      output logic i_intr,
      output logic dmem_accept_w,
      output logic dmem_error_write
      //output logic dcache_accept_write,
      //output logic dcache_error_write,
      //output logic dcache_resp_tag_write
      //output logic [31:0] icache_inst_write
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
    imem_data = imem_read (imem_addr);
    //Set these so all instructions are valid
    imem_valid <= 1;
    imem_accept <= 1;
    imem_error <= 0;
    i_intr <= 0;
    dmem_accept_w <= 1;
    dmem_error_write <= 0;
    
    //if dmem write enable is not on, enter and grab dmem
	  if (!dmem_req_write_en) begin
	          dmem_resp_valid <= 1;
	          dmem_resp_data = dmem_read (dmem_req_addr);
	  end
	  else begin
	          dmem_write (dmem_req_addr, dmem_req_data);
	  end
  end

// Returns next instruction in the input file
  function logic [31:0] imem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
    logic [31:0] mem_rdata; //update return size so it can hold two, 32 bit instructions
    
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

endmodule
