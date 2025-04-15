#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vpicorv32_top___024root.h"
#include "Vpicorv32_top.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 5;
const int BITS = 100;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vpicorv32_top* core = new Vpicorv32_top{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
	
	// reset core
	core->clk = 0;
	core->resetn = 1;
	core->eval();
	core->clk = 1;
	core->resetn = 0;
	core->eval();
	core->clk = 0;
	core->resetn = 1;
	core->eval();

	//102 bits requires 13 bytes
	std::vector<uint8_t> buffer(BYTES);


	while (std::getline(file, line))
	{
		// Extract the 32-bit chunk from the input string		
		std::string irq = line.substr(0, 32);
		std::string mem_rdata = line.substr(32, 32);
		std::string mem_ready = line.substr(64, 1);
		std::string pcpi_rd = line.substr(65, 32);
		std::string pcpi_ready = line.substr(97, 1);
		std::string pcpi_wait = line.substr(98, 1);
		std::string pcpi_wr = line.substr(99, 1);

		// Convert the chunk to a uint32_t
		core->irq = std::bitset<32>(irq).to_ulong();
		core->mem_rdata = std::bitset<32>(mem_rdata).to_ulong();
		core->mem_ready = std::bitset<1>(mem_ready).to_ulong();
		core->pcpi_rd = std::bitset<32>(pcpi_rd).to_ulong();
		core->pcpi_ready = std::bitset<1>(pcpi_ready).to_ulong();
		core->pcpi_wait = std::bitset<1>(pcpi_wait).to_ulong();
		core->pcpi_wr = std::bitset<1>(pcpi_wr).to_ulong();

		core->clk = 1;
		core->eval();
		core->clk = 0;
		core->eval();
	}
	
}