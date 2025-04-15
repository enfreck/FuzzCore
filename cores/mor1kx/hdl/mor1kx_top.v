module mor1kx_top (input clock, input rst);

  // Wires to connect memory model and mor1kx cappicuno core
  // Core Input Wires
  wire 			      iwbm_err;
  wire 			      iwbm_ack;
  wire [31:0] 		iwbm_dat_i; //core imem input
  wire 			      iwbm_rty;
  wire 			      dwbm_err;
  wire 			      dwbm_ack;
  wire [31:0] 		dwbm_dat_i; //core dmem input
  wire 			      dwbm_rty;


  //Core Output Wires
  wire [31:0] 		      iwbm_adr;
  wire 			      iwbm_stb;
  wire 			      iwbm_cyc;
  wire [3:0] 		      iwbm_sel;
  wire 			      iwbm_we;
  wire [2:0] 		      iwbm_cti;
  wire [1:0] 		      iwbm_bte;
  wire [31:0] 		      iwbm_dat_o; //core imem output
  
  wire [31:0] 		      dwbm_adr;
  wire 			      dwbm_stb;
  wire 			      dwbm_cyc;
  wire [3:0] 		      dwbm_sel;
  wire 			      dwbm_we;
  wire [2:0] 		      dwbm_cti;
  wire [1:0] 		      dwbm_bte;
  wire [31:0] 		      dwbm_dat_o; //core dmem output
    
  // reg reset = 1;

  // always @(posedge clock) begin
  //   reset = 0;
  // end

  reg reset;

	always @(posedge clock) begin
		// if ($urandom_range(0, 4) == 0) begin
		// 	reset <= 1;
		// end else begin
		// 	reset <= 0;
		// end
    reset <= rst;
	end

  /* verilator lint_off PINMISSING */
mor1kx mor1kx_inst (
	  .clk(clock),
	  .rst(reset),
	  .iwbm_adr_o(iwbm_adr),
    .iwbm_stb_o(iwbm_stb),
    .iwbm_cyc_o(iwbm_cyc),
    .iwbm_sel_o(iwbm_sel),
    .iwbm_we_o(iwbm_we),
    .iwbm_cti_o(iwbm_cti),
    .iwbm_bte_o(iwbm_bte),
    .iwbm_dat_o(iwbm_dat_o),
    .iwbm_err_i(iwbm_err),
    .iwbm_ack_i(iwbm_ack),
    .iwbm_dat_i(iwbm_dat_i),
    .iwbm_rty_i(iwbm_rty),
    .dwbm_adr_o(dwbm_adr),
    .dwbm_stb_o(dwbm_stb),
    .dwbm_cyc_o(dwbm_cyc),
    .dwbm_sel_o(dwbm_sel),
    .dwbm_we_o(dwbm_we),
    .dwbm_cti_o(dwbm_cti),
    .dwbm_bte_o(dwbm_bte),
    .dwbm_dat_o(dwbm_dat_o),
    .dwbm_err_i(dwbm_err),
    .dwbm_ack_i(dwbm_ack),
    .dwbm_dat_i(dwbm_dat_i),
    .dwbm_rty_i(dwbm_rty)
  );

mor1kx_mem_model mem_model (

  //Mem Model Input Wires
  .clk(clock),
  .iwbm_adr_i(iwbm_adr), //imem requested address
  .iwbm_stb_i(iwbm_stb), //strobe must be high when making request
  .iwbm_cyc_i(iwbm_cyc), //cycle to indicate valid transaction
  .iwbm_sel_i(iwbm_sel), //byte selector
  .iwbm_we_i(iwbm_we), //write enable
  .iwbm_cti_i(iwbm_cti), //cycle type identifier
  .iwbm_bte_i(iwbm_bte), //burst type extension
  .iwbm_dat_i(iwbm_dat_o), //data written to imem, output from core
  .dwbm_adr_i(dwbm_adr), //dmem request for read/write
  .dwbm_stb_i(dwbm_stb), //strobe
  .dwbm_cyc_i(dwbm_cyc), //cycle
  .dwbm_sel_i(dwbm_sel), //byte selector
  .dwbm_we_i(dwbm_we), //write enable
  .dwbm_cti_i(dwbm_cti), //cycle type
  .dwbm_bte_i(dwbm_bte), //burst type
  .dwbm_dat_i(dwbm_dat_o), //data to write

  // Mem Model Output Wires
  .iwbm_err_o(iwbm_err), 
  .iwbm_ack_o(iwbm_ack),
  .iwbm_dat_o(iwbm_dat_i), //data input to core
  .iwbm_rty_o(iwbm_rty),
  .dwbm_err_o(dwbm_err),
  .dwbm_ack_o(dwbm_ack),
  .dwbm_dat_o(dwbm_dat_i), //input to core
  .dwbm_rty_o(dwbm_rty)

);
  

endmodule // Top
