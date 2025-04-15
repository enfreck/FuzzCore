#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vscr1_core_top___024root.h"
#include "Vscr1_core_top.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 5;
const int BITS = 176;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vscr1_core_top* core = new Vscr1_core_top{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
	core->clk = 0;
	core->rst_n = 0;
	core->eval();
	core->clk = 1;
	core->rst_n = 1;
	core->eval();
	core->clk = 0;
	core->rst_n = 0;
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
		std::string pwrup_rst_n = line.substr(0, 1); //32 bits
		std::string cpu_rst_n = line.substr(1, 1);
		std::string test_mode = line.substr(2, 1);
		std::string test_rst_n = line.substr(3, 1); //did not include IQR, timer, or debug wires as not testing those
		std::string imem_req_ack = line.substr(4, 1);
		std::string imem_rdata = line.substr(5, 32);
		std::string imem_resp = line.substr(37, 2);
		std::string dmem_req_ack = line.substr(39, 1);
		std::string dmem_rdata = line.substr(40, 32);
		std::string dmem_resp = line.substr(72, 2);
		std::string fuse_mhartid = line.substr(74, 32);
		std::string soft_irq = line.substr(106, 1);
		std::string timer_irq = line.substr(107, 1);
		std::string mtime_ext = line.substr(108, 64);

		// Convert the chunk to a uint32_t
		core->pwrup_rst_n = std::bitset<1>(pwrup_rst_n).to_ulong();
		core->cpu_rst_n = std::bitset<1>(cpu_rst_n).to_ulong();
		core->test_mode = std::bitset<1>(test_mode).to_ulong();
		core->test_rst_n = std::bitset<1>(test_rst_n).to_ulong();
		core->imem_req_ack = std::bitset<1>(imem_req_ack).to_ulong();
		core->imem_rdata = std::bitset<32>(imem_rdata).to_ulong();
		core->imem_resp = std::bitset<2>(imem_resp).to_ulong();
		core->dmem_req_ack = std::bitset<1>(dmem_req_ack).to_ulong();
		core->dmem_rdata = std::bitset<32>(dmem_rdata).to_ulong();
		core->dmem_resp = std::bitset<2>(dmem_resp).to_ulong();
		core->fuse_mhartid = std::bitset<32>(fuse_mhartid).to_ulong();
		core->soft_irq = std::bitset<1>(soft_irq).to_ulong();
		core->timer_irq = std::bitset<1>(timer_irq).to_ulong();
		core->mtime_ext = std::bitset<64>(mtime_ext).to_ulong();

		core->clk = 1;
		core->eval();
		core->clk = 0;
		core->eval();
	}
}