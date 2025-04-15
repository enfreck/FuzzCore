`include "define.v"
`include "constants.vh"

module ridecore_top
  (
   input clk,
   input rst
   );

   wire [`ADDR_LEN-1:0] pc;
   wire [4*`INSN_LEN-1:0] idata;
   wire [`DATA_LEN-1:0]   dmem_data;
   wire [`DATA_LEN-1:0]   dmem_wdata;
   wire [`ADDR_LEN-1:0]   dmem_addr;
   wire 		  dmem_we;

   reg reset;

	always @(posedge clk) begin
		reset <= rst;
	end

   pipeline pipe
     (
      //Inputs
      .clk(clk),
      .reset(reset),
      .idata(idata), //4, 32 bit instructions
      .dmem_data(dmem_data), //32 bit

      //Outputs
      .pc(pc), //32 bit
      .dmem_wdata(dmem_wdata), //32 bit
      .dmem_addr(dmem_addr), //32 bit
      .dmem_we(dmem_we) //32 bit
      );

   
   ridecore_mem_model  memory_modelling_inst(
   .clk(clk),
   .imem_addr(pc),      //points to instruction
   .imem_data(idata),   //points to block of imem
   .dmem_req_addr(dmem_addr), //access memory at dmem_addr
   .dmem_req_data(dmem_wdata), //data written to dmem during write operation
   .dmem_req_write_en(dmem_we), //check if write enable is on
   .dmem_resp_data(dmem_data) //carries data back to core
   );

			  
endmodule // top

   