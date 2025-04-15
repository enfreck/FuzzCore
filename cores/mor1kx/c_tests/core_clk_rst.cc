#include <verilated.h>
#include "Vmor1kx_top_mor1kx_top.h"
#include "Vmor1kx_top.h"
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include "Vmor1kx_top__Dpi.h"
#include <random>
#include "Vmor1kx_top___024root.h"
#include "Vmor1kx_top__Syms.h"
#include "Vmor1kx_top_mor1kx_mem_model.h"

#define REQ_QUEUE_SIZE 100
#define CLOCK_CYCLES 100

uint32_t input_instructions[REQ_QUEUE_SIZE];

vluint64_t main_time = 0;
vluint64_t seed = time(0);

// Below function generates the instructions based on the random values of the opcode, func3, func7, r1, r2, rd and immediate data
svBitVecVal instruction_generator() {
	static int idx = 0;
	return input_instructions[idx++];
}

svBitVecVal rng_seed() {
    uint32_t dmem_seed = 0;

    for (int i = 0; i < REQ_QUEUE_SIZE; i++)
    {
        dmem_seed += input_instructions[i];
    }

    return dmem_seed;
}


int main (int argc, char** argv, char** env) {

	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	Vmor1kx_top* top = new Vmor1kx_top{contextp};

	FILE * f = fopen(argv[1], "r");
	
	int count = 0;
    while (count < REQ_QUEUE_SIZE && fscanf(f, "%x", &input_instructions[count]) == 1) {
        count++;
    }
	fclose(f);

	srand(seed);

	// reset core
	top->clock = 0;
	top->rst = 0;
	top->eval();
	top->clock = 1;
	top->rst = 1;
	top->eval();
	top->clock = 0;
	top->rst = 0;
	top->eval();

    // Providing clock to the rtl
	for (int i = 0; i < ((CLOCK_CYCLES)*2); i++) {
        contextp->timeInc(1);
        top->clock = ~top->clock;
        top->eval();
	}
		
	// Vmor1kx_top___024root* rp = top->rootp;


	// FILE * complete_f = fopen("/tmp/complete_input", "a");
	// for (auto a: rp->vlSymsp->TOP__mor1kx_top__mem_model.__PVT__imem) {
	// 	fprintf(complete_f, "@%x %x", a.first, a.second);
	// }
	// fprintf(complete_f,    "\n");
	// for (auto a: rp->vlSymsp->TOP__mor1kx_top__mem_model.__PVT__dmem) {
	// 	fprintf(complete_f, "@%x %x", a.first, a.second);
	// }
	// fprintf(complete_f, "\n-\n");
	// fclose(complete_f);

	top->final();
	delete top;
	delete contextp;
	return 0;
}
