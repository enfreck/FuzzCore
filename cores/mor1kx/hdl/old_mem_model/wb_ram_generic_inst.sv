/* ISC License
 *
 * Copyright (C) 2016 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

module wb_ram_generic_inst
  (input clk,
   input [3:0] we,
   input [31:0] din,
   input [29:0] waddr,
   input [29:0] raddr,
   output reg [31:0] dout);

  logic [31:0] initial_imem [logic [29:0]];
  
  //import "DPI-C" function bit [31:0] mor1kx_instr (bit [31:0] out);
  import "DPI-C" function bit [31:0] mor1kx_instr_generator ();

   /* verilator lint_off WIDTH */
   always @(posedge clk) begin
     dout = imem_read(raddr);
   end

   function logic [31:0] imem_read (input logic [29:0] m_addr);
     logic [31:0] read_instr;

     if (!initial_imem.exists(m_addr)) begin
        initial_imem[m_addr] = mor1kx_instr_generator();
     end
     
     read_instr = initial_imem[m_addr];
     return read_instr;

   endfunction // imem_read

endmodule // wb_ram_generic_inst
