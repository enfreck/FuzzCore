#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vbiriscv_top___024root.h"
#include "Vbiriscv_top.h"
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
	Vbiriscv_top* core = new Vbiriscv_top{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
	core->clk = 0;
	core->rst_i = 0;
	core->eval();
	core->clk = 1;
	core->rst_i = 1;
	core->eval();
	core->clk = 0;
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
		std::string dcache_data_rd_w = line.substr(0, 32);    
		std::string dcache_accept_w = line.substr(32, 1);     
		std::string dcache_ack_w = line.substr(33, 1);        
		std::string dcache_error_w = line.substr(34, 1);      
		std::string dcache_resp_tag_w = line.substr(35, 11);  
		std::string icache_accept_w = line.substr(46, 1);     
		std::string icache_valid_w = line.substr(47, 1);      
		std::string icache_error_w = line.substr(48, 1);      
		std::string icache_inst_w = line.substr(49, 64);      
		std::string intr_i = line.substr(113, 1);              
		std::string reset_vector_i = line.substr(114, 32);     
		std::string cpu_id_i = line.substr(146, 32);          

		// Convert the chunk to a uint32_t
		core->dcache_data_rd_w = std::bitset<32>(dcache_data_rd_w).to_ulong();
		core->dcache_accept_w = std::bitset<1>(dcache_accept_w).to_ulong();
		core->dcache_ack_w = std::bitset<1>(dcache_ack_w).to_ulong();
		core->dcache_error_w = std::bitset<1>(dcache_error_w).to_ulong();
		core->dcache_resp_tag_w = std::bitset<11>(dcache_resp_tag_w).to_ulong();
		core->icache_accept_w = std::bitset<1>(icache_accept_w).to_ulong();
		core->icache_valid_w = std::bitset<1>(icache_valid_w).to_ulong();
		core->icache_error_w = std::bitset<1>(icache_error_w).to_ulong();
		core->icache_inst_w = std::bitset<64>(icache_inst_w).to_ulong();
		core->intr_i = std::bitset<1>(intr_i).to_ulong();
		core->reset_vector_i = std::bitset<32>(reset_vector_i).to_ulong();
		core->cpu_id_i = std::bitset<32>(cpu_id_i).to_ulong();


		core->clk = 1;
		core->eval();
		core->clk = 0;
		core->eval();
	}
}