
`include "model_parameters.v"
`include "scr1_memif.svh"

//This is the top model currently in use

module ssrv_top
#(
  parameter SCR1_RESET_INPUTS_SYNC = 1 // Reset inputs are: 1 - synchronous, 0 -asynchronous  
)
(
	input clk,
	input rst_n
);   

	//Common Outputs
	wire   logic 								   core_rst_n_out;

	//Did not include debugger, IRQ, IPIC, or external timer wires

	//Core Ouputs
	wire  logic                                   imem_req;
	wire type_scr1_mem_cmd_e                     imem_cmd;
	wire  logic [`SCR1_IMEM_AWIDTH-1:0]           imem_addr;
	wire  logic                                   dmem_req;
	wire  type_scr1_mem_cmd_e                     dmem_cmd;
	wire  type_scr1_mem_width_e                   dmem_width; //width of dmem read / write (byte, hwrod, word, error)
	wire  logic [`SCR1_DMEM_AWIDTH-1:0]           dmem_addr;
	wire  logic [`SCR1_DMEM_DWIDTH-1:0]           dmem_wdata;

	//Core Inputs
	wire   logic                                   imem_req_ack;
	wire   logic [`SCR1_IMEM_DWIDTH-1:0]           imem_rdata;
	wire   type_scr1_mem_resp_e                    imem_resp;
	wire   logic                                   dmem_req_ack;
	wire   logic [`SCR1_DMEM_DWIDTH-1:0]           dmem_rdata;
	wire   type_scr1_mem_resp_e                    dmem_resp;


	reg pwrup_rst_n = 1;
	//reg rst_n = 1;  // Active low reset
	reg cpu_rst_n = 1;
	reg test_mode = 0;  // Or 1, depending on your needs
	reg test_rst_n = 0;
	reg [`SCR1_XLEN-1:0] fuse_mhartid;
	reg soft_irq;
	reg timer_irq;
    reg [63:0] mtime_ext = 0;

	//Debug Interface

	reg trst_n;
	reg tck;
	reg tms;
	reg tdi;
	reg reset;

	always @(posedge clk) begin
		pwrup_rst_n <= 1;
	//	rst_n <= 1;  // Active low reset
		reset <= rst_n;
		cpu_rst_n <= 1;
		test_mode <= 0;  // Or 1, depending on your needs
		test_rst_n <= 0;
		fuse_mhartid <= $random;
		soft_irq <= 0;
		timer_irq <= 0;
		mtime_ext <= mtime_ext + 1;

		//Debug Set
		trst_n <= 0;
		tck <= 0;
		tms <= 0;
		tdi <= 0;
	end

/* verilator lint_off PINMISSING */
  
   //Core declaration
   scr1_core_top
#( //set parameters based on top model
	.SCR1_RESET_INPUTS_SYNC(SCR1_RESET_INPUTS_SYNC)
)
core
(

	//Common Core Inputs
	.pwrup_rst_n(pwrup_rst_n),
	.rst_n(reset),					//Might have to change this wire
	.cpu_rst_n(cpu_rst_n),
	.test_mode(test_mode),
	.test_rst_n(test_rst_n),
	.clk(clk),
	
	//Common Core Output
	.core_rst_n_out(core_rst_n_out),

	//Fuses
	.fuse_mhartid(fuse_mhartid),

	//IRQ
	.soft_irq(soft_irq),

	//External Timer
	.timer_irq(timer_irq),
	.mtime_ext(mtime_ext),

	// .trst_n(trst_n),
	// .tck(tck),
	// .tms(tms),
	// .tdi(tdi),

	//Core Mem Inputs
	.imem_req_ack(imem_req_ack),
	.imem_rdata(imem_rdata),
	.imem_resp(imem_resp),
	.dmem_req_ack(dmem_req_ack),
	.dmem_rdata(dmem_rdata),
	.dmem_resp(dmem_resp),

	//Core Mem Outputs
	.imem_req(imem_req),
	.imem_cmd(imem_cmd),
	.imem_addr(imem_addr),
	.dmem_req(dmem_req),
	.dmem_cmd(dmem_cmd),
	.dmem_width(dmem_width),
	.dmem_addr(dmem_addr),
	.dmem_wdata(dmem_wdata)
);

   ssrv_mem_model  memory_modelling_inst(
	.clk(clk),
	
	//Core Inputs (Mem Outputs)	
	.imem_req_ack(imem_req_ack),
	.imem_rdata(imem_rdata),
	.imem_resp(imem_resp),
	.dmem_req_ack(dmem_req_ack),
	.dmem_rdata(dmem_rdata),
	.dmem_resp(dmem_resp),

	//Core Outputs (Mem Inputs)
	.imem_req(imem_req),
	.imem_cmd(imem_cmd),
	.imem_addr(imem_addr),
	.dmem_req(dmem_req),
	.dmem_cmd(dmem_cmd),
	.dmem_width(dmem_width),
	.dmem_addr(dmem_addr),
	.dmem_wdata(dmem_wdata)
	);

endmodule

