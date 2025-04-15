`include "scr1_memif.svh"

//This is the top model currently in use

module ssrv_top
#(
  parameter SCR1_RESET_INPUTS_SYNC = 1 // Reset inputs are: 1 - synchronous, 0 -asynchronous  
)
(
	input   logic                                   pwrup_rst_n,
    input   logic                                   rst_n,
    input   logic                                   cpu_rst_n,
    input   logic                                   test_mode,
    input   logic                                   test_rst_n,
    input   logic                                   clk,
	input   logic                                   imem_req_ack,
	input   logic [`SCR1_IMEM_DWIDTH-1:0]           imem_rdata,
    input   type_scr1_mem_resp_e                    imem_resp,
	input   logic                                   dmem_req_ack,
	input   logic [`SCR1_DMEM_DWIDTH-1:0]           dmem_rdata,
    input   type_scr1_mem_resp_e                    dmem_resp,
	input [`SCR1_XLEN-1:0] fuse_mhartid,
	input soft_irq,
	input timer_irq,
    input [63:0] mtime_ext
);   //Did not include debugger, IRQ, IPIC, or external timer wires

	reg                                   c_pwrup_rst_n;
    reg                                   c_rst_n;
    reg                                   c_cpu_rst_n;
    reg                                   c_test_mode;
    reg                                   c_test_rst_n;
	reg                                   c_imem_req_ack;
	reg [`SCR1_IMEM_DWIDTH-1:0]           c_imem_rdata;
	type_scr1_mem_resp_e               	  c_imem_resp;
	reg                                   c_dmem_req_ack;
	reg [`SCR1_DMEM_DWIDTH-1:0]           c_dmem_rdata;
    type_scr1_mem_resp_e                  c_dmem_resp;
	reg [`SCR1_XLEN-1:0] c_fuse_mhartid;
	reg c_soft_irq;
	reg c_timer_irq;
    reg [63:0] c_mtime_ext;
	reg c_trst_n;
	reg c_tck;
	reg c_tms;
	reg c_tdi;

	always @(posedge clk) begin
		c_pwrup_rst_n <= pwrup_rst_n;
		c_rst_n <= rst_n;
		c_cpu_rst_n <= cpu_rst_n;
		c_test_mode <= test_mode;
		c_test_rst_n <= test_rst_n;
		c_imem_req_ack <= imem_req_ack;
		c_imem_rdata <= imem_rdata;
		c_imem_resp <= imem_resp;
		c_dmem_req_ack <= dmem_req_ack;
		c_dmem_rdata <= dmem_rdata;
		c_dmem_resp <= dmem_resp;
		c_fuse_mhartid <= fuse_mhartid;
		c_soft_irq <= soft_irq;
		c_timer_irq <= timer_irq;
		c_mtime_ext <= mtime_ext;
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
	.pwrup_rst_n(c_pwrup_rst_n),
	.rst_n(c_rst_n),					
	.cpu_rst_n(c_cpu_rst_n),
	.test_mode(c_test_mode),
	.test_rst_n(c_test_rst_n),
	.clk(clk),

	//Fuses
	.fuse_mhartid(c_fuse_mhartid),

	//IRQ
	.soft_irq(c_soft_irq),

	//External Timer
	.timer_irq(c_timer_irq),
	.mtime_ext(c_mtime_ext),
	
	//Core Mem Inputs
	.imem_req_ack(c_imem_req_ack),
	.imem_rdata(c_imem_rdata),
	.imem_resp(c_imem_resp),
	.dmem_req_ack(c_dmem_req_ack),
	.dmem_rdata(c_dmem_rdata),
	.dmem_resp(c_dmem_resp)
);

endmodule
