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

module wb_ram_generic_data
  (input clk,
   input [3:0] we,
   input [31:0] din,
   input [29:0] waddr,
   input [29:0] raddr,
   output reg [31:0] dout);

   logic [31:0] current_dmem [logic [29:0]];
   logic [31:0] initial_dmem [logic [29:0]];

   /* verilator lint_off WIDTH */
   /* verilator lint_off IGNOREDRETURN */
   always @(posedge clk) begin
      if (!we) begin
        dout = dmem_read (raddr);
      end
      else begin
	dmem_write (waddr, din, we);
      end
   end

   function logic [31:0] dmem_read(input logic [29:0] m_addr);
     logic [31:0] mem_rdata;
     /* verilator lint_off WIDTH */
     if (!initial_dmem.exists(m_addr)) begin
         current_dmem[m_addr] = $random;
         initial_dmem[m_addr] = current_dmem[m_addr];
     end

     mem_rdata = initial_dmem[m_addr];
    return mem_rdata;

   endfunction // dmem_read

   task dmem_write(input logic [29:0] waddr, input logic [31:0] wdata, input [3:0]we);

       if (we[0]) current_dmem[waddr][7:0]   = wdata[7:0];
       if (we[1]) current_dmem[waddr][15:8]  = wdata[15:8];    
       if (we[2]) current_dmem[waddr][23:16] = wdata[23:16];
       if (we[3]) current_dmem[waddr][31:24] = wdata[31:24];

  endtask // dmem_write
endmodule
