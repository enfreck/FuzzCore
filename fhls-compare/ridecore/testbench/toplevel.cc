#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include <fstream>
#include <vector>
#include <bitset>
#include "Vpipeline___024root.h"
#include "Vpipeline.h"

const int NUM_CYCLES = 5;
const int BITS = 160;
const int BYTES = (BITS + 7) / 8;
const int WORDS = (BITS + 31) / 32;

int main(int argc, char **argv, char **env) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <input_file>\n";
        return 1;
    }

    std::ifstream file(argv[1], std::ios::binary);
    if (!file) {
        std::cerr << "Error opening file: " << argv[1] << "\n";
        return 1;
    }

    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vpipeline* core = new Vpipeline{contextp};

    core->clk = 0;
    core->reset = 0;
    core->eval();
    core->clk = 1;
    core->reset = 1;
    core->eval();
    core->clk = 0;
    core->reset = 0;
    core->eval();

    std::vector<uint8_t> buffer(BYTES, 0);

    for (int i = 0; i < NUM_CYCLES; i++) {
        file.read(reinterpret_cast<char*>(buffer.data()), BYTES);
        std::streamsize bytesRead = file.gcount();
        if (bytesRead < BYTES) {
            std::fill(buffer.begin() + bytesRead, buffer.end(), 0);  // Zero-fill missing data
        }

        std::bitset<BITS> bits;
        for (size_t j = 0; j < bytesRead; ++j) {
            bits |= std::bitset<BITS>(static_cast<uint8_t>(buffer[j])) << (8 * j);
        }

        std::string bit_string = bits.to_string();
        std::string idata = bit_string.substr(0, 128);  // 128 bits
        std::string dmem_data = bit_string.substr(128, 32);  // 32 bits

        uint64_t high = std::stoull(idata.substr(0, 64), nullptr, 2);
        uint64_t low = std::stoull(idata.substr(64, 64), nullptr, 2);

        VlWide<4> i_data_arr = {0};
        i_data_arr[0] = low & 0xFFFFFFFF;
        i_data_arr[1] = (low >> 32) & 0xFFFFFFFF;
        i_data_arr[2] = high & 0xFFFFFFFF;
        i_data_arr[3] = (high >> 32) & 0xFFFFFFFF;

        core->idata = i_data_arr;
        core->dmem_data = std::bitset<32>(dmem_data).to_ulong();

        core->clk = 1;
        core->eval();
        core->clk = 0;
        core->eval();
    }

    core->final();
    delete core;
    delete contextp;
    return 0;
}
