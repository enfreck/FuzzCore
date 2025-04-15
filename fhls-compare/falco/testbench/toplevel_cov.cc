#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include <random>
#include "Vfalco_top___024root.h"
#include "Vfalco_top.h"
#include <sstream>
#include <string>
#include <fstream>
#include <vector>
#include <bitset>

const int NUM_CYCLES = 5;
const int BITS = 178;
const int BYTES = (BITS+7)/8;
const int WORDS = (BITS+31)/32;

template<int Words>
VlWide<Words> stringToVlWide(const std::string& bitstring) {
    VlWide<Words> result;
    std::string padded = bitstring;
    // Pad with zeros to make length multiple of 32
    while (padded.length() % 32 != 0) {
        padded = "0" + padded;
    }
    
    // Process 32 bits at a time
    for (int i = 0; i < Words; i++) {
        std::string chunk = padded.substr(std::max(0, (int)padded.length() - (i + 1) * 32), 
                                        std::min(32, (int)padded.length() - i * 32));
        if (chunk.empty()) {
            result[i] = 0;
        } else {
            result[i] = std::bitset<32>(chunk).to_ulong();
        }
    }
    return result;
}

// Helper function to convert string of bits to uint64_t (QData)
uint64_t stringToQData(const std::string& bitstring) {
    std::string padded = bitstring;
    // Pad with zeros if needed
    while (padded.length() < 64) {
        padded = "0" + padded;
    }
    // For strings longer than 64 bits, take the least significant 64 bits
    if (padded.length() > 64) {
        padded = padded.substr(padded.length() - 64);
    }
    
    // Split into two 32-bit chunks and combine
    std::string upper = padded.substr(0, 32);
    std::string lower = padded.substr(32);
    uint64_t upper_bits = std::bitset<32>(upper).to_ulong();
    uint64_t lower_bits = std::bitset<32>(lower).to_ulong();
    return (upper_bits << 32) | lower_bits;
}

int main(int argc, char **argv, char **env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vfalco_top* core = new Vfalco_top{contextp};

	std::ifstream file(argv[1], std::ios::binary);
	
	bool timestamp = true;
	std::string line;
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
		std::string init_pc = line.substr(0, 32); //32 bits
		std::string instruction_resp = line.substr(32, 67); //instruction_resp_t (32,1,32,1,1)
		std::string load_hit_resp = line.substr(99, 2); //core_load_hit_resp_t
		std::string load_data_resp = line.substr(101, 34); //core_load_data_resp_t (1,1,32)
		std::string store_resp = line.substr(135, 2); //core_store_resp_t


		// Convert regular 32-bit values
		core->init_pc = std::bitset<32>(init_pc).to_ulong();

		// Convert wide values
		core->instruction_resp = stringToVlWide<3>(instruction_resp);  // 67 bits needs 3 words
		core->load_hit_resp = std::bitset<2>(load_hit_resp).to_ulong();
		core->load_data_resp = stringToQData(load_data_resp);         // Convert to QData (uint64_t)
		core->store_resp = std::bitset<2>(store_resp).to_ulong();

		core->clk = 1;
		core->eval();
		core->clk = 0;
		core->eval();
	}
}