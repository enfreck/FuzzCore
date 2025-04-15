#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vmor1kx___024root.h"
#include "Vmor1kx.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 5;
const int BITS = 250;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vmor1kx* core = new Vmor1kx{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
	
	// reset core
	core->clk = 0;
	core->rst = 0;
	core->eval();
	core->clk = 1;
	core->rst = 1;
	core->eval();
	core->clk = 0;
	core->rst = 0;
	core->eval();

	//102 bits requires 13 bytes
	std::vector<uint8_t> buffer(BYTES);

	for (int i = 0; i < NUM_CYCLES; i++)
	{
		file.read(reinterpret_cast<char*>(buffer.data()), BYTES);

		// Convert the buffer into a single bit string
		std::bitset<BITS> bits;
		for (size_t j = 0; j < BYTES; ++j) {
        	bits |= std::bitset<BITS>(buffer[j]) << (8 * j); // Fill bitset with buffer data
    	}

		std::string line = bits.to_string();

		// Extract the 32-bit chunk from the input string		
		std::string du_addr_i = line.substr(0, 16);
		std::string du_dat_i = line.substr(16, 32);
		std::string du_stall_i = line.substr(48, 1);
		std::string du_stb_i = line.substr(49, 1);
		std::string du_we_i = line.substr(50, 1);
		std::string dwbm_ack_i = line.substr(51, 1);
		std::string dwbm_dat_i = line.substr(52, 32);
		std::string dwbm_err_i = line.substr(84, 1);
		std::string dwbm_rty_i = line.substr(85, 1);
		std::string irq_i = line.substr(86, 32);
		std::string iwbm_ack_i = line.substr(118, 1);
		std::string iwbm_dat_i = line.substr(119, 32);
		std::string iwbm_err_i = line.substr(151, 1);
		std::string iwbm_rty_i = line.substr(152, 1);
		std::string multicore_coreid_i = line.substr(153, 32);
		std::string multicore_numcores_i = line.substr(185, 32);
		std::string snoop_adr_i = line.substr(217, 32);
		std::string snoop_en_i = line.substr(249, 1);

		// Convert the chunk to a uint32_t
		core->du_addr_i = std::bitset<16>(du_addr_i).to_ulong();
		core->du_dat_i = std::bitset<32>(du_dat_i).to_ulong();
		core->du_stall_i = std::bitset<1>(du_stall_i).to_ulong();
		core->du_stb_i = std::bitset<1>(du_stb_i).to_ulong();
		core->du_we_i = std::bitset<1>(du_we_i).to_ulong();
		core->dwbm_ack_i = std::bitset<1>(dwbm_ack_i).to_ulong();
		core->dwbm_dat_i = std::bitset<32>(dwbm_dat_i).to_ulong();
		core->dwbm_err_i = std::bitset<1>(dwbm_err_i).to_ulong();
		core->dwbm_rty_i = std::bitset<1>(dwbm_rty_i).to_ulong();
		core->irq_i = std::bitset<32>(irq_i).to_ulong();
		core->iwbm_ack_i = std::bitset<1>(iwbm_ack_i).to_ulong();
		core->iwbm_dat_i = std::bitset<32>(iwbm_dat_i).to_ulong();
		core->iwbm_err_i = std::bitset<1>(iwbm_err_i).to_ulong();
		core->iwbm_rty_i = std::bitset<1>(iwbm_rty_i).to_ulong();
		core->multicore_coreid_i = std::bitset<32>(multicore_coreid_i).to_ulong();
		core->multicore_numcores_i = std::bitset<32>(multicore_numcores_i).to_ulong();
		core->snoop_adr_i = std::bitset<32>(snoop_adr_i).to_ulong();
		core->snoop_en_i = std::bitset<1>(snoop_en_i).to_ulong();

		core->clk = 1;
		core->eval();
		core->clk = 0;
		core->eval();
	}
}