module ssrv_mem_model (input logic clk,
			
      //Inputs
      input  logic                                   imem_req,
      input  type_scr1_mem_cmd_e                     imem_cmd,
      input  logic [`SCR1_IMEM_AWIDTH-1:0]           imem_addr,
      input  logic                                   dmem_req,
      input  type_scr1_mem_cmd_e                     dmem_cmd,
      input  type_scr1_mem_width_e                   dmem_width, //width of dmem read / write (byte, hwrod, word, error)
      input  logic [`SCR1_DMEM_AWIDTH-1:0]           dmem_addr,
      input  logic [`SCR1_DMEM_DWIDTH-1:0]           dmem_wdata,

      //Outputs
      output   logic                                   imem_req_ack,
      output   logic [`SCR1_IMEM_DWIDTH-1:0]           imem_rdata,
      output   type_scr1_mem_resp_e                    imem_resp,
      output   logic                                   dmem_req_ack,
      output   logic [`SCR1_DMEM_DWIDTH-1:0]           dmem_rdata,
      output   type_scr1_mem_resp_e                    dmem_resp
);
      

  //Has to match exactly to core_clk declaration
  import "DPI-C" function bit [31:0] instruction_generator();
  import "DPI-C" function bit [31:0] rng_seed ();

  // maps with address as key and instruction/data as value
  // logic [`SIZE_OF_THE_BUS - 1:0] denotes the data structure is an array of items (value) of 32-bits each --> instruction/data value is 32 bits
  // [logic [`SIZE_OF_THE_BUS - 1:0]] denotes that the indicies (key) is of 32-bits --> memory address is 32 bits
  logic [`SIZE_OF_THE_BUS - 1:0] dmem [logic [`SIZE_OF_THE_BUS - 1:0]];
  logic [`SIZE_OF_THE_BUS - 1:0] imem [logic [`SIZE_OF_THE_BUS - 1:0]];
  
  /* verilator lint_off WIDTH */
  always @(posedge clk) begin

    //IMEM
    if(imem_req && (imem_cmd == SCR1_MEM_CMD_RD)) begin //check if request a read
      imem_rdata = imem_read (imem_addr); //call instruction generator
      imem_req_ack <= 1; //set ack
      imem_resp <= SCR1_MEM_RESP_RDY_OK; //successful mem read
    end
    
    //DMEM
	  if (dmem_req) begin
      //Request dmem read
	    if (dmem_cmd == SCR1_MEM_CMD_RD) begin
            dmem_rdata = dmem_read (dmem_addr);
      end
      //Requests dmem write
      else if (dmem_cmd == SCR1_MEM_CMD_WR) begin
           dmem_write (dmem_addr, dmem_wdata);
      end
      //Set response as valid
      dmem_resp <= SCR1_MEM_RESP_RDY_OK;
      dmem_req_ack <= 1;
    end
  end

// Returns next instruction in the input file
  function logic [`SIZE_OF_THE_BUS - 1:0] imem_read(input logic [`SIZE_OF_THE_BUS - 1:0] m_addr);
    logic [`SIZE_OF_THE_BUS - 1:0] mem_rdata;
    
    if (!imem.exists(m_addr >> 2)) begin
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