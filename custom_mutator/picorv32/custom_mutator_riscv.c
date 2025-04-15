#include "custom_mutator_riscv.h"

// Number of instructions in the initial seed
#ifndef _NUM_INSTRUCTIONS_CHARS
  #define _NUM_INSTRUCTIONS_CHARS 10 
#endif


// Called once when AFL++ starts up.  Seeds the RNG.
my_mutator_t *afl_custom_init(afl_state_t *afl, unsigned int seed) {
    srand(seed);
    my_mutator_t *data = calloc(1, sizeof(my_mutator_t));

    data->final_instructions = calloc(1, MAX_FILE);
    data->afl = afl;

    return data;
}

// Free all allocated memory
void afl_custom_deinit(my_mutator_t *data) {
    free(data->final_instructions);
    free(data);
}

// Pick a new opcode
int mutate_opcode() {
    int new_opcode = opcodes[rand() % 11];
    return new_opcode;
}

// Pick a new register x0-x31
int mutate_register() {
    return rand() % 32;
}

// Set func3 to a new value in values
int mutate_func3(int values[], int values_size){
    return values[rand() % values_size];
}

// Generate random value of x bits    
int mutate_imm() {
    return rand();
}

int mutate_fence() {
    return rand() & 0xFF;
}

// Generate random csr address (0x000-0x0FF, 0x300-0x3FF, 0x400-0x4FF, 0x700-0x7FF, 0x800-0x8FF, 0xB00-0xBFF, 0xC00-0xCFF, 0xF00-0xFFF)
// int mutate_csr() {
//     int base = rand() & 0xFF;

//     int top = rand() % 7;

//     if (top == 0) {
//         return (base);
//     }
//     else if (top == 1) {
//         return (base | (0x3 << 8));
//     }
//     else if (top == 2) {
//         return (base | (0x4 << 8));
//     }
//     else if (top == 3) {
//         return (base | (0x7 << 8));
//     }
//     else if (top == 4) {
//         return (base | (0x8 << 8));
//     }
//     else if (top == 5) {
//         return (base | (0xB << 8));
//     }
//     if (top == 6) {
//         return (base | (0xC << 8));  
//     }
// }


instruction_type mutate_field(instruction_type instruction) {
    instruction_type modified_inst = instruction;
    uint32_t opcode = instruction.base_inst.opcode;
    uint32_t value = rand() % 5;

    switch (opcode)
    {
        case R_TYPE:
            if (value == 0) { // rd mutation
                modified_inst.rtype_inst.rd = mutate_register();
            }
            else if (value == 1) {  // func3 mutation
                if (modified_inst.rtype_inst.func7 == 0x20) {
                    modified_inst.rtype_inst.func3 = modified_inst.rtype_inst.func3 ^ 0x5;
                } else {
                    modified_inst.rtype_inst.func3 = mutate_func3((int[]){0,1,2,3,4,5,6,7}, 8);
                }
            } else if (value == 2) { // r1 mutation
                modified_inst.rtype_inst.rs1 = mutate_register();
            } else if (value == 3) { // r2 mutation
                modified_inst.rtype_inst.rs2 = mutate_register();    
            } else if (value == 4) { // func7 mutation
                if (modified_inst.rtype_inst.func3 == 0x5 || modified_inst.rtype_inst.func3 == 0x0) {
                    modified_inst.rtype_inst.func7 = modified_inst.rtype_inst.func7 ^ 0x20;
                }
            }
            break;
        case I_TYPE_ARITH:

            if (value == 0) { // rd mutation
                modified_inst.itype_inst.rd = mutate_register();
            }
            else if (value == 1) {  // func3 mutation
                int upper_imm = modified_inst.itype_inst.imm >> 5;
                if (upper_imm == 0) {
                    modified_inst.itype_inst.func3 = mutate_func3((int[]){0,1,2,3,4,5,6,7}, 8);
                } 
                else if (upper_imm == 0x20) {
                    modified_inst.itype_inst.func3 = mutate_func3((int[]){0,2,3,4,5,6,7}, 7);
                }
                else {
                    modified_inst.itype_inst.func3 = mutate_func3((int[]){0,2,3,4,6,7}, 6);
                }
            } else if (value == 2) { // r1 mutation
                modified_inst.itype_inst.rs1 = mutate_register();
            } else if (value == 3 || value == 4) {
                if (modified_inst.itype_inst.func3 == 0x1 || modified_inst.itype_inst.func3 == 0x5 ) {
                    // In this case, only the 5 LSBs of Immediate can be non zero
                    modified_inst.itype_inst.imm =  mutate_imm() & 0b11111;
                } else {
                    modified_inst.itype_inst.imm = mutate_imm();
                }
            }
            break;

        case I_TYPE_ENV:
            // switch ecall and ebreak
            if (modified_inst.itype_inst.func3 == 0) {
                modified_inst.itype_inst.imm = modified_inst.itype_inst.imm ^ 0x1;
            } // change csr command 
            else if (value == 0) {
                modified_inst.itype_inst.rd = mutate_register();
            } else if (value == 1) {
                modified_inst.itype_inst.func3 = mutate_func3((int[]){1,2,3,5,6,7}, 6);
            } else if (value == 2) {
                modified_inst.itype_inst.rs1 = mutate_register();
            } else {
                modified_inst.itype_inst.imm = mutate_imm(); //mutate_csr();
            }
            break;
        case I_TYPE_JUMP:
            if (value == 0) {   // rd mutation
                modified_inst.itype_inst.rd = mutate_register();
            } else if (value == 1) {
                modified_inst.itype_inst.rs1 = mutate_register();
            } else {
                modified_inst.itype_inst.imm = mutate_imm();
            }
            break;
        case I_TYPE_LOAD:
            if (value == 0) {
                modified_inst.itype_inst.rd = mutate_register();
            } else if (value == 1) {
                modified_inst.itype_inst.func3 = mutate_func3((int[]){0,1,2,4,5}, 5);
            } else if (value == 2) {
                modified_inst.itype_inst.rs1 = mutate_register();
            } else if (value == 3) {
                modified_inst.itype_inst.imm = mutate_imm();
            }
            break;
        case B_TYPE:
            if (value == 0) {
                modified_inst.btype_inst.imm1 = mutate_imm();
            } else if (value == 1) {
                modified_inst.btype_inst.func3 = mutate_func3((int[]){0,1,4,5,6,7}, 6);
            } else if (value == 2) {
                modified_inst.btype_inst.rs1 = mutate_register();
            } else if (value == 3) {
                modified_inst.btype_inst.rs2 = mutate_register();
            } else {
                modified_inst.btype_inst.imm2 = mutate_imm();
            }
            break;
        
        // JType and both UTypes have the same layout so follow the same mutation strategy
        case J_TYPE:
        case U_TYPE_AUIPC:
        case U_TYPE_LOAD:
            if (value == 0) {
                modified_inst.utype_inst.rd = mutate_register();
            }
            else {
                modified_inst.utype_inst.imm = mutate_imm();
            }
            break;
        case S_TYPE:
            if (value == 0) {
                modified_inst.stype_inst.imm1 = mutate_imm();
            } else if (value == 1) {
                modified_inst.stype_inst.func3 = mutate_func3((int[]){0,1,2}, 3);
            } else if (value == 2) {
                modified_inst.stype_inst.rs1 = mutate_register();
            } else if (value == 3) {
                modified_inst.stype_inst.rs2 = mutate_register();
            } else {
                modified_inst.stype_inst.imm2 = mutate_imm();
            }
            break;
        // Fence instructions
        case FENCE:
            if (value == 0) {
                modified_inst.itype_inst.func3 = modified_inst.itype_inst.func3 ^ 0x1;
                if (modified_inst.itype_inst.func3 == 0) {
                    modified_inst.itype_inst.imm = mutate_fence();
                } else {
                    modified_inst.itype_inst.imm = 0;
                }
            } else {
                modified_inst.itype_inst.imm = mutate_fence();
            }
            break;
        default:
            break;
    }

    return modified_inst;
}

instruction_type mutate_instruction() {
    instruction_type instruction;

    instruction.base_inst.opcode = mutate_opcode();

    switch (instruction.base_inst.opcode)
    {
        case R_TYPE:
        // rd
            instruction.rtype_inst.rd = mutate_register();
        // func3
            instruction.rtype_inst.func3 = mutate_func3((int[]){0,1,2,3,4,5,6,7}, 8);
        // r1
            instruction.rtype_inst.rs1 = mutate_register();
        // r2
            instruction.rtype_inst.rs2 = mutate_register();    
        // func7
            if (instruction.rtype_inst.func3 == 0x5 || instruction.rtype_inst.func3 == 0x0) {
                instruction.rtype_inst.func7 = instruction.rtype_inst.func7 ^ 0x20;
            }
            break;
        case I_TYPE_ARITH:
        // rd
            instruction.itype_inst.rd = mutate_register();
        // func3
            instruction.itype_inst.func3 = mutate_func3((int[]){0,2,3,4,6,7}, 6);
        // r1
            instruction.itype_inst.rs1 = mutate_register();
        // imm
            if (instruction.itype_inst.func3 == 0x1 || instruction.itype_inst.func3 == 0x5 ) {
                // In this case, only the 5 LSBs of Immediate can be non zero
                instruction.itype_inst.imm =  mutate_imm() & 0b11111;
            } else {
                instruction.itype_inst.imm = mutate_imm();
            }
            break;
        case I_TYPE_ENV:
            instruction.itype_inst.func3 = mutate_func3((int[]){0,1,2,3,5,6,7}, 7);
            // ecall, ebreak
            if (instruction.itype_inst.func3 == 0) {
                instruction.itype_inst.rd = 0;
                instruction.itype_inst.rs1 = 0;
                instruction.itype_inst.imm = rand() % 2;
            } else { // csr
                instruction.itype_inst.rd = mutate_register();
                instruction.itype_inst.rs1 = mutate_register();
                instruction.itype_inst.imm = mutate_imm(); //mutate_csr();
            }
            break;
        case I_TYPE_JUMP:
        // rd
            instruction.itype_inst.rd = mutate_register();
        //func3
            instruction.itype_inst.func3 = 0;
        // r1
            instruction.itype_inst.rs1 = mutate_register();
        // imm -TODO
            instruction.itype_inst.imm = mutate_imm();
            break;
        case I_TYPE_LOAD:
        // rd
                instruction.itype_inst.rd = mutate_register();
        // func3
                instruction.itype_inst.func3 = mutate_func3((int[]){0,1,2,4,5}, 5);
        // r1
                instruction.itype_inst.rs1 = mutate_register();
        // imm
                instruction.itype_inst.imm = mutate_imm();
            break;
        case B_TYPE:
        // upper imm
            instruction.btype_inst.imm1 = mutate_imm();
        // func3
            instruction.btype_inst.func3 = mutate_func3((int[]){0,1,4,5,6,7}, 6);
        // r1
            instruction.btype_inst.rs1 = mutate_register();
        // r2
            instruction.btype_inst.rs2 = mutate_register();
        // lower imm
            instruction.btype_inst.imm2 = mutate_imm();
            break;
        
        // JType and both UTypes have the same layout so follow the same mutation strategy
        case J_TYPE:
        case U_TYPE_AUIPC:
        case U_TYPE_LOAD:
        // rd
            instruction.utype_inst.rd = mutate_register();
        // imm - TODO
            instruction.utype_inst.imm = mutate_imm();
            break;
        case S_TYPE:
        // upper imm
            instruction.stype_inst.imm1 = mutate_imm();
        // func3
            instruction.stype_inst.func3 = mutate_func3((int[]){0,1,2}, 3);
        // r1
            instruction.stype_inst.rs1 = mutate_register();
        // r2
            instruction.stype_inst.rs2 = mutate_register();
       // imm
            instruction.stype_inst.imm2 = mutate_imm();
            break;
        // Fence instructions
        case FENCE:
            instruction.itype_inst.rd = 0;
            instruction.itype_inst.func3 = mutate_func3((int[]){0,1}, 2);
            instruction.itype_inst.rs1 = 0;
            if (instruction.itype_inst.func3 == 0){
                instruction.itype_inst.imm = mutate_fence();
            }
            else {
                instruction.itype_inst.imm = 0;
            }
            break;
        default:
            break;
    }

    return instruction;
}


size_t afl_custom_fuzz(
    my_mutator_t *data, 
    char *buf, 
    size_t buf_size, 
    unsigned char **out_buf, 
    unsigned char *add_buf, 
    size_t add_buf_size, 
    size_t max_size) {       


    // // Remove \n and copy buf
    buf[strcspn(buf, "\n")] = 0;
    char *copy = (char *)malloc(strlen(buf) + 1);
    strcpy(copy, buf);

    memset(data->final_instructions,0,MAX_FILE);
    int out_pos = 0;

    // Percent of instructions to be mutated
    int percent_var = 40;
    // Percent of times mutation is ALL instead of field
    int percent_all = 20;

    char *curr = copy;
    int offset = 0;

    instruction_type instruction;

    while (*curr) {
    
        int count = sscanf(curr, "%x %n", &(instruction.raw_inst), &offset);

        if (count == 1) {
            curr += offset;

            // Determine if it's getting mutated
            int random_num = rand() % 100;
            if (random_num < percent_var) {
                // Determine what type of mutation it is
                int mutate_type = rand() % 100;
                if (mutate_type < percent_all) {
                    instruction = mutate_instruction();
                }
                else {
                    instruction = mutate_field(instruction);
                }
            }

            // Add struct to list
            char str[_NUM_INSTRUCTIONS_CHARS];
            out_pos += sprintf(str, "%08x ", instruction.raw_inst);
            strcat(data->final_instructions, str);

        } else {
            break;
        }

    }

    *out_buf = (unsigned char*)data->final_instructions;
    free(copy);
    return strlen(data->final_instructions);
}
