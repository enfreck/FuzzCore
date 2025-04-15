`include "define.v"
`include "constants.vh"

module ridecore_top
  (
	input clk,
	input reset,
	input [127:0] idata, //4, 32 bit instructions
	input [31:0] dmem_data //32 bit
   );

   //Continue here

   reg [4*`INSN_LEN-1:0] c_idata;
   reg [`DATA_LEN-1:0]   c_dmem_data;
   reg c_reset;

	always @(posedge clk) begin
		
      c_idata <= idata;
      c_dmem_data <= dmem_data;
      c_reset <= reset;

	end

   pipeline pipe
     (
      //Inputs
      .clk(clk),
      .reset(c_reset),
      .idata(c_idata), //4, 32 bit instructions
      .dmem_data(c_dmem_data) //32 bit
      );

			  
endmodule // top
