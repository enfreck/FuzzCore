#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vcore_top___024root.h"
#include "Vcore_top.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 5;
const int BITS = 103;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vcore_top* core = new Vcore_top{contextp};

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
		std::string stall_i = line.substr(0, 1);            
		std::string init_pc_addr_i = line.substr(1, 32);     
		std::string code_i = line.substr(33, 32);          
		std::string code_ready_i = line.substr(65, 1);     
		std::string data_i = line.substr(66, 32);
		std::string data_ready_i = line.substr(98, 1);     
		std::string data_addr_ext_i = line.substr(99, 1); 
		std::string ext_irq_i = line.substr(100, 1);    
		std::string tmr_irq_i = line.substr(101, 1);    
		std::string sft_irq_i = line.substr(102, 1);     

		// Convert the chunk to a uint32_t
		core->stall_i = std::bitset<1>(stall_i).to_ulong();
		core->init_pc_addr_i = std::bitset<32>(init_pc_addr_i).to_ulong();
		core->code_i = std::bitset<32>(code_i).to_ulong();
		core->code_ready_i = std::bitset<1>(code_ready_i).to_ulong();
		core->data_i = std::bitset<32>(data_i).to_ulong();
		core->data_ready_i = std::bitset<1>(data_ready_i).to_ulong();
		core->data_addr_ext_i = std::bitset<1>(data_addr_ext_i).to_ulong();
		core->ext_irq_i = std::bitset<1>(ext_irq_i).to_ulong();
		core->tmr_irq_i = std::bitset<1>(tmr_irq_i).to_ulong();
		core->sft_irq_i = std::bitset<1>(sft_irq_i).to_ulong();

		core->clk_i = 1;
		core->eval();
		core->clk_i = 0;
		core->eval();
	}
}