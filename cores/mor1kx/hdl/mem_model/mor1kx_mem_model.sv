
module mor1kx_mem_model #(
) (
    input logic clk,
  
    // Mem Model Input Wires
    input [31:0] 		      iwbm_adr_i, //imem requested address
    input 			      iwbm_stb_i, //strobe must be high when making request
    input 			      iwbm_cyc_i, //cycle to indicate valid transaction
    input [3:0] 		      iwbm_sel_i, //byte selector
    input 			      iwbm_we_i, //write enable
    input [2:0] 		      iwbm_cti_i, //cycle type identifier
    input [1:0] 		      iwbm_bte_i, //burst type extension
    input [31:0] 		      iwbm_dat_i, //data written to imem
    input [31:0] 		      dwbm_adr_i, //dmem request for read/write
    input 			      dwbm_stb_i, //strobe
    input 			      dwbm_cyc_i, //cycle
    input [3:0] 		      dwbm_sel_i, //byte selector
    input 			      dwbm_we_i, //write enable
    input [2:0] 		      dwbm_cti_i, //cycle type
    input [1:0] 		      dwbm_bte_i, //burst type
    input [31:0] 		      dwbm_dat_i, //data to write

    // Mem Model Output Wires
    output  			      iwbm_err_o, 
    output  			      iwbm_ack_o,
    output [31:0] 		iwbm_dat_o,
    output 			      iwbm_rty_o,
    output 			      dwbm_err_o,
    output 			      dwbm_ack_o,
    output [31:0] 		dwbm_dat_o,
    output 			      dwbm_rty_o
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
    
    // Imem Operation when strobe and cycle are 1
    if(iwbm_stb_i && iwbm_cyc_i) begin 
    
      if(!iwbm_we_i) begin //read operation
        iwbm_dat_o = imem_read (iwbm_adr_i);
        iwbm_err_o <= 0; 
        iwbm_ack_o <= 1; 
        iwbm_rty_o <= 0; //retry is 0
      end

      else if(iwbm_we_i) begin //Write Imem
        iwbm_err_o <= 0; 
        iwbm_ack_o <= 1;
        iwbm_rty_o <= 0; //retry is 0
      end
    end //End imem

    //Dmem Operation
	  if (dwbm_stb_i && dwbm_cyc_i) begin 
      
      if(!dwbm_we_i) begin //Dmem read
        dwbm_dat_o = dmem_read (dwbm_adr_i);
        dwbm_err_o <= 0;
        dwbm_ack_o <= 1;
        dwbm_rty_o <= 0;
      end
      else begin //Dmem write
        dmem_write(dwbm_adr_i,dwbm_dat_i);
        dwbm_err_o <= 0;
        dwbm_ack_o <= 1;
        dwbm_rty_o <= 0;
      end
	  end
    
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

endmodule 
