#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <math.h>
#include <stdint.h>
#include "afl-fuzz.h"
#include "alloc-inl.h"


#define GET_OPCODE(num) (num & 0x7f)

// Placeholder values for now
typedef enum {
    R_TYPE = 0b0110011,
    I_TYPE_LOAD = 0b0000011,
    I_TYPE_JUMP = 0b1100111,
    I_TYPE_ENV = 0b1110011,
    I_TYPE_ARITH = 0b0010011,
    J_TYPE = 0b1101111,
    S_TYPE = 0b0100011,
    U_TYPE_LOAD = 0b0110111,
    U_TYPE_AUIPC = 0b0010111,
    B_TYPE = 0b1100011,
    FENCE = 0b0001111
} INSTRUCTION_TYPE;

INSTRUCTION_TYPE opcodes[11] = {R_TYPE, I_TYPE_LOAD, I_TYPE_JUMP, I_TYPE_ENV, I_TYPE_ARITH, J_TYPE, S_TYPE, U_TYPE_LOAD, U_TYPE_AUIPC, B_TYPE, FENCE}; 

// I Type instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t rd : 5;       
    uint32_t func3 : 3;   
    uint32_t rs1 : 5;      
    uint32_t imm : 12;     
} itype;

// R Type instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t rd : 5;       
    uint32_t func3 : 3;   
    uint32_t rs1 : 5;      
    uint32_t rs2 : 5;
    uint32_t func7: 7;
} rtype;

// S Type instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t imm1 : 5;       
    uint32_t func3 : 3;   
    uint32_t rs1 : 5;      
    uint32_t rs2 : 5;
    uint32_t imm2: 7;
} stype;

// B Type instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t imm1 : 5;       
    uint32_t func3 : 3;   
    uint32_t rs1 : 5;      
    uint32_t rs2 : 5;
    uint32_t imm2: 7;
} btype;

// U Type instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t rd : 5;       
    uint32_t imm: 20;
} utype;

// J Type instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t rd : 5;       
    uint32_t imm: 20;
} jtype;

// Fence instruction
typedef struct {
    uint32_t opcode : 7;    
    uint32_t rd : 5;       
    uint32_t func3 : 3;   
    uint32_t rs1 : 5;      
    uint32_t succ : 4; 
    uint32_t pred : 4; 
    uint32_t imm : 4; 
} ftype;

typedef struct {
    uint32_t opcode: 7;
    uint32_t rest: 25;
} baseinst;

typedef union {
    uint32_t raw_inst;
    baseinst base_inst;
    itype itype_inst;
    jtype jtype_inst;
    rtype rtype_inst;
    stype stype_inst;
    btype btype_inst;
    utype utype_inst;
} instruction_type;

typedef struct my_mutator {
  afl_state_t *afl;
  char* final_instructions; // string of all the mutated instructions
} my_mutator_t;

