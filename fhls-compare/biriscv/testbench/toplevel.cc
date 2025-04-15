#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vriscv_core___024root.h"
#include "Vriscv_core.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 5;
const int BITS = 178;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vriscv_core* core = new Vriscv_core{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
	core->clk_i = 0;
	core->rst_i = 0;
	core->eval();
	core->clk_i = 1;
	core->rst_i = 1;
	core->eval();
	core->clk_i = 0;
	core->rst_i = 0;
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
		std::string mem_d_data_rd_i = line.substr(0, 32); //32 bits
		std::string mem_d_accept_i = line.substr(32, 1);
		std::string mem_d_ack_i = line.substr(33, 1);
		std::string mem_d_error_i = line.substr(34, 1);
		std::string mem_d_resp_tag_i = line.substr(35, 11);
		std::string mem_i_accept_i = line.substr(46, 1);
		std::string mem_i_valid_i = line.substr(47, 1);
		std::string mem_i_error_i = line.substr(48, 1);
		std::string mem_i_inst_i = line.substr(49, 64);
		std::string intr_i = line.substr(113, 1);
		std::string reset_vector_i = line.substr(114, 32);
		std::string cpu_id_i = line.substr(146, 32);


		// Convert the chunk to a uint32_t
		core->mem_d_data_rd_i = std::bitset<32>(mem_d_data_rd_i).to_ulong();
		core->mem_d_accept_i = std::bitset<1>(mem_d_accept_i).to_ulong();
		core->mem_d_ack_i = std::bitset<1>(mem_d_ack_i).to_ulong();
		core->mem_d_error_i = std::bitset<1>(mem_d_error_i).to_ulong();
		core->mem_d_resp_tag_i = std::bitset<11>(mem_d_resp_tag_i).to_ulong();
		core->mem_i_accept_i = std::bitset<1>(mem_i_accept_i).to_ulong();
		core->mem_i_valid_i = std::bitset<1>(mem_i_valid_i).to_ulong();
		core->mem_i_error_i = std::bitset<1>(mem_i_error_i).to_ulong();
		core->mem_i_inst_i = std::bitset<64>(mem_i_inst_i).to_ulong();
		core->intr_i = std::bitset<1>(intr_i).to_ulong();
		core->reset_vector_i = std::bitset<32>(reset_vector_i).to_ulong();

		core->clk_i = 1;
		core->eval();
		core->clk_i = 0;
		core->eval();
	}
}