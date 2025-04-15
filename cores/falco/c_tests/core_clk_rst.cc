#include <verilated.h>
#include "Vfalco_top.h"
#include "verilated_vcd_c.h"
#include <time.h>
#include "svdpi.h"
#include "Vfalco_top__Dpi.h"
#include <random>
#include "Vfalco_top___024root.h"


#define REQ_QUEUE_SIZE 400
#define CLOCK_CYCLES 200

uint32_t input_instructions[REQ_QUEUE_SIZE];

vluint64_t main_time = 0;
vluint64_t seed = time(0);

//Returns the imem data in memory model
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
	Vfalco_top* top = new Vfalco_top{contextp};

	FILE * f = fopen(argv[1], "r");
	
	int count = 0;
    //Read input from file and place instructions as 32 bit hex blocks into instructions
	while (count < REQ_QUEUE_SIZE && fscanf(f, "%08x", &input_instructions[count]) == 1) {
		count++;
    }
	fclose(f);
	
	srand(seed);

	// reset core
	top->clk = 0;
	top->rst = 0;
	top->eval();
	top->clk = 1;
	top->rst = 1;
	top->eval();
	top->clk = 0;
	top->rst = 0;
	top->eval();

    // Providing clock to the rtl
    for (int i = 0; i < (CLOCK_CYCLES*2); i++) {
        contextp->timeInc(1);
        top->clk = ~top->clk;
        top->eval();
	}

	// Vfalco_top___024root* rp = top->rootp;

    
	// FILE * complete_f = fopen("/tmp/complete_input", "a");
	// for (auto a: rp->vlSymsp->TOP__falco_top__memory_modelling_inst.__PVT__imem) {
	// 	fprintf(complete_f, "@%x %x", a.first, a.second);
	// }
	// fprintf(complete_f,    "\n");
	// for (auto a: rp->vlSymsp->TOP__falco_top__memory_modelling_inst.__PVT__dmem) {
	// 	fprintf(complete_f, "@%x %x", a.first, a.second);
	// }
	// fprintf(complete_f, "\n-\n");
	// fclose(complete_f);

	top->final();
    delete top;
	delete contextp;
	return 0;
}
