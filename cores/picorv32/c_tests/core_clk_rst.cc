#include <verilated.h>
#include "Vpicorv32core.h"
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include "Vpicorv32core__Dpi.h"
#include <random>
#include "math.h"
#include "Vpicorv32core___024root.h"
#include "Vpicorv32core__Syms.h"
#include "Vpicorv32core_memory_modelling.h"

#define REQ_QUEUE_SIZE 20
#define CLOCK_CYCLES 20

uint32_t input_instructions[REQ_QUEUE_SIZE];

vluint64_t main_time = 0;
vluint64_t seed = time(0);


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
	Vpicorv32core* top = new Vpicorv32core{contextp};

	FILE * f = fopen(argv[1], "r");
	
	int count = 0;
    while (count < REQ_QUEUE_SIZE && fscanf(f, "%x", &input_instructions[count]) == 1) {
        count++;
    }
	fclose(f);

	srand(seed);

	// active low reset
	// reset core
	top->clk = 0;
	top->rst = 1;
	top->eval();
	top->clk = 1;
	top->rst = 0;
	top->eval();
	top->clk = 0;
	top->rst = 1;
	top->eval();

	// Providing clock to the rtl
	for (int i = 0; i < ((CLOCK_CYCLES)*2); i++) {
        contextp->timeInc(1);
        top->clk = ~top->clk;
        top->eval();
	}

	// Vpicorv32core___024root* rp = top->rootp;


	// FILE * complete_f = fopen("/tmp/complete_input", "a");
	// for (auto a: rp->vlSymsp->TOP__picorv32core__memory_modelling_inst.__PVT__imem) {
	// 	fprintf(complete_f, "@%x %x", a.first, a.second);
	// }
	// fprintf(complete_f,    "\n");
	// for (auto a: rp->vlSymsp->TOP__picorv32core__memory_modelling_inst.__PVT__dmem) {
	// 	fprintf(complete_f, "@%x %x", a.first, a.second);
	// }
	// fprintf(complete_f, "\n-\n");
	// fclose(complete_f);

	//tfp->close();
	top->final();
	delete top;
	//delete tfp;
	delete contextp;
	return 0;
}