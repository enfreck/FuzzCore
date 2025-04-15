#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vaquila_top___024root.h"
#include "Vaquila_top.h"
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
	Vaquila_top* core = new Vaquila_top{contextp};

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
		std::string stall = line.substr(0, 1);            
		std::string init_pc_addr = line.substr(1, 32);     
		std::string code = line.substr(33, 32);          
		std::string code_ready = line.substr(65, 1);     
		std::string data_core_in = line.substr(66, 32);
		std::string data_ready = line.substr(98, 1);     
		std::string data_addr_ext = line.substr(99, 1); 
		std::string ext_irq = line.substr(100, 1);    
		std::string tmr_irq = line.substr(101, 1);    
		std::string sft_irq = line.substr(102, 1);      


		// Convert the chunk to a uint32_t
		core->stall = std::bitset<1>(stall).to_ulong();
		core->init_pc_addr = std::bitset<32>(init_pc_addr).to_ulong();
		core->code = std::bitset<32>(code).to_ulong();
		core->code_ready = std::bitset<1>(code_ready).to_ulong();
		core->data_core_in = std::bitset<32>(data_core_in).to_ulong();
		core->data_ready = std::bitset<1>(data_ready).to_ulong();
		core->data_addr_ext = std::bitset<1>(data_addr_ext).to_ulong();
		core->ext_irq = std::bitset<1>(ext_irq).to_ulong();
		core->tmr_irq = std::bitset<1>(tmr_irq).to_ulong();
		core->sft_irq = std::bitset<1>(sft_irq).to_ulong();

		core->clk = 1;
		core->eval();
		core->clk = 0;
		core->eval();
	}
}