#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vsodor_core_5stage___024root.h"
#include "Vsodor_core_5stage.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 20;
const int BITS = 102;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vsodor_core_5stage* core = new Vsodor_core_5stage{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
	
	// reset core
	core->clock = 0;
	core->reset = 0;
	core->eval();
	core->clock = 1;
	core->reset = 1;
	core->eval();
	core->clock = 0;
	core->reset = 0;
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
		std::string io_ddpath_addr = line.substr(0, 5);
		std::string io_ddpath_wdata = line.substr(5, 32);
		std::string io_dmem_resp_bits_data = line.substr(37, 32);
		std::string io_dmem_resp_valid = line.substr(69, 1);
		std::string io_imem_resp_bits_data = line.substr(70, 32);

		std::cout << io_ddpath_addr + " " + io_ddpath_wdata + " " + io_dmem_resp_bits_data + " " + io_dmem_resp_valid + " " + io_imem_resp_bits_data << std::endl;

		// Convert the chunk to a uint32_t
		core->io_ddpath_addr = std::bitset<5>(io_ddpath_addr).to_ulong();
		core->io_ddpath_wdata = std::bitset<32>(io_ddpath_wdata).to_ulong();
		core->io_dmem_resp_bits_data = std::bitset<32>(io_dmem_resp_bits_data).to_ulong();
		core->io_dmem_resp_valid = std::bitset<1>(io_dmem_resp_valid).to_ulong();
		core->io_imem_resp_bits_data = std::bitset<32>(io_imem_resp_bits_data).to_ulong();

		core->clock = 1;
		core->eval();
		core->clock = 0;
		core->eval();
	}
}