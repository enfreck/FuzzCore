#include "custom_mutator_RISCV_biriscv.h"

// Number of instructions in the initial seed
#ifndef _NUM_INSTRUCTIONS_CHARS
  #define _NUM_INSTRUCTIONS_CHARS 18 
#endif
//enough for space and terminator

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

int mutate_value(int values[], int values_size){
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
    uint32_t value = 0; //default to be set later

    switch (opcode)
    {
        case R_TYPE:
        //add (func3 = 0, imm = 0), sub (func3 = 0, imm has 1 in 6 bit position (0x2))
        //sll (func3 = 1, imm = 0), slt (func3 = 2, imm = 0), sltu (func3 = 3, imm = 0)
        //xor (func3 = 4, imm = 0), srl (func3 = 5, imm = 0), sra (func3 = 5, imm has 1 in 6 bit)
        //or (func3 = 6, imm = 0), and (func3 = 7, imm = 0), mul (func3 = 0, imm has 1 in lowest bit)
        //mulh (func3 = 1, imm has 1 in lowest bit), mulhsu (func3 = 2, imm has 1 in lowest)
        //mulhu (func3 = 3, imm has 1 in lowest), div (func3 = 4, imm = 1), divu (func3 = 5, imm = 1)
        //rem (func3 = 6, imm = 1), remu (func3 = 7, imm = 1)
            value = rand() % 5;
            if (value == 0) { // rd mutation
                modified_inst.rtype_inst.rd = mutate_register();
            }else if (value == 1) {  // func3 mutation
                modified_inst.rtype_inst.func3 = mutate_func3((int[]){0,1,2,3,4,5,6,7}, 8);

                //Create valid func7 based on the func3
                if(modified_inst.rtype_inst.func3 == 0){
                    modified_inst.rtype_inst.func7 = mutate_value((int[]){0x0,0x20,0x1}, 3);
                }else if(modified_inst.rtype_inst.func3 == 5){
                    modified_inst.rtype_inst.func7 = mutate_value((int[]){0x0,0x20}, 2);
                }else{
                    modified_inst.rtype_inst.func7 = mutate_value((int[]){0x0,0x1}, 2);
                }

            } else if (value == 2) { // r1 mutation
                modified_inst.rtype_inst.rs1 = mutate_register();
            } else if (value == 3) { // r2 mutation
                modified_inst.rtype_inst.rs2 = mutate_register();    
            } else if (value == 4) { // func7 mutation
                if(modified_inst.rtype_inst.func3 == 0){
                    modified_inst.rtype_inst.func7 = mutate_value((int[]){0x0,0x20,0x1}, 3);
                }else if(modified_inst.rtype_inst.func3 == 5){
                    modified_inst.rtype_inst.func7 = mutate_value((int[]){0x0,0x20}, 2);
                }else{
                    modified_inst.rtype_inst.func7 = mutate_value((int[]){0x0,0x1}, 2);
                }
            }
            break;

        case I_TYPE_ARITH:
        //addi (func3 = 0), slti (func3 = 2), sltiu (func3 = 3), xori (func3 = 4)
        //ori (func3 = 6), andi (func3 = 7), slli (func3 = 1, last 7 bits are 0)
        //srli (func3 = 5, last 7 bits are 0), srai (func3 = 5, last 7 bits have 1 in 6 position)
            value = rand() % 4;

            if (value == 0) { // rd mutation
                modified_inst.itype_inst.rd = mutate_register();
            }
            else if (value == 1) {  // func3 mutation
                
                modified_inst.itype_inst.func3 = mutate_func3((int[]){0,2,3,4,6,7,1,5}, 8);
                
                //make value of imm based on new func3 to be valid
                if (modified_inst.itype_inst.func3 == 0x1) {
                // In this case, only the 5 LSBs of Immediate can be non zero
                    modified_inst.itype_inst.imm =  mutate_imm() & 0b11111;
                }else if(modified_inst.itype_inst.func3 == 0x5){
                    modified_inst.itype_inst.imm = (mutate_imm() & 0b11111) | (rand() % 2) << 10;
                }else {
                    modified_inst.itype_inst.imm = mutate_imm();
                }
            } else if (value == 2) { // r1 mutation
                modified_inst.itype_inst.rs1 = mutate_register();
            } else {
                //make value of imm based on new func3
                if (modified_inst.itype_inst.func3 == 0x1) {
                // In this case, only the 5 LSBs of Immediate can be non zero
                    modified_inst.itype_inst.imm =  mutate_imm() & 0b11111;
                }else if(modified_inst.itype_inst.func3 == 0x5){
                    modified_inst.itype_inst.imm = (mutate_imm() & 0b11111) | (rand() % 2) << 10;
                }else {
                    modified_inst.itype_inst.imm = mutate_imm();
                }
            }
            break;

        case I_TYPE_JUMP:
            //jalr (func3 = 0)
            value = rand() % 3;
            if (value == 0) { 
                modified_inst.itype_inst.rd = mutate_register();
            } else if (value == 1) {
                modified_inst.itype_inst.rs1 = mutate_register();
            } else {
                modified_inst.itype_inst.imm = mutate_imm();
            }
            break;
        case I_TYPE_LOAD:
        //lw (func3 = 2), lb (func3 = 0), lh (func3 = 1), lbu (func3 = 4)
        //lhu (func3 = 5)
            value = rand() % 4;
            if (value == 0) {
                modified_inst.itype_inst.rd = mutate_register();
            } else if (value == 1) {
                modified_inst.itype_inst.func3 = mutate_func3((int[]){2,0,1,4,5}, 5);
            } else if(value == 2){
                modified_inst.itype_inst.rs1 = mutate_register();
            }else{
                modified_inst.itype_inst.imm = mutate_imm();
            }
            break;
        case I_TYPE_ENV:
            value = rand() % 4;
            if (modified_inst.itype_inst.func3 == 0) {
                //sfence.vma
                if(modified_inst.rtype_inst.func7 == 0x9){
                    
                    uint32_t temp_rand = rand() % 3;
                    if(temp_rand == 0){
                        modified_inst.rtype_inst.rd = mutate_register();
                    }else if(temp_rand == 1){
                        modified_inst.rtype_inst.rs1 = mutate_register();
                    }else{
                        modified_inst.rtype_inst.rs2 = mutate_register();
                    }
                //ecall, ebreak, uret, sret, mret, wfi
                }else{
                    modified_inst.itype_inst.imm = mutate_value((int[]){0x0, 0x01, 0x2, 0x102, 0x302, 0x105}, 6);
                }
            // change csr command 
            } else if (value == 0) {
                modified_inst.itype_inst.rd = mutate_register();
            } else if (value == 1) {
                modified_inst.itype_inst.func3 = mutate_func3((int[]){1,2,3,5,6,7}, 6);
            } else if (value == 2) {
                modified_inst.itype_inst.rs1 = mutate_register();
            } else {
                modified_inst.itype_inst.imm = mutate_imm(); //no longer call mutate csr
            }
            break;

        case B_TYPE:
        //beq (func3 = 0), bne (func3 = 1), blt (func3 = 4), bge (func3 = 5), bltu (func3 = 6), bgeu (func3 = 7)
            value = rand() % 5;
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
        //lui, auipc, jal
            value = rand() % 2;
            if (value == 0) {
                modified_inst.utype_inst.rd = mutate_register();
            }else {
                modified_inst.utype_inst.imm = mutate_imm();
            }
            break;
        case S_TYPE:
        //sw (func3 = 2), sb (func3 = 0), sh (func3 = 1)
            value = rand() % 5;
            if (value == 0) {
                modified_inst.stype_inst.imm1 = mutate_imm();
            } else if (value == 1) {
                modified_inst.stype_inst.func3 = mutate_func3((int[]){0,1,2},3);
            } else if (value == 2) {
                modified_inst.stype_inst.rs1 = mutate_register();
            }else if(value == 3){
                modified_inst.stype_inst.rs2 = mutate_register();
            }else{
                modified_inst.stype_inst.imm2 = mutate_imm();
            }
            break;
        case FENCE:
            value = rand() % 2;
            if (value == 0) {
                modified_inst.itype_inst.func3 = modified_inst.itype_inst.func3 ^ 0x1;
                if (modified_inst.itype_inst.func3 == 0) {
                    modified_inst.itype_inst.imm = mutate_fence();
                } else {
                    modified_inst.itype_inst.imm = 0;
                }
            } else {
                //modify imm based on valid func3
                if (modified_inst.itype_inst.func3 == 0) {
                    modified_inst.itype_inst.imm = mutate_fence();
                } else {
                    modified_inst.itype_inst.imm = 0;
                }
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
        //add (func3 = 0, imm = 0), sub (func3 = 0, imm has 1 in 6 bit position (0x2))
        //sll (func3 = 1, imm = 0), slt (func3 = 2, imm = 0), sltu (func3 = 3, imm = 0)
        //xor (func3 = 4, imm = 0), srl (func3 = 5, imm = 0), sra (func3 = 5, imm has 1 in 6 bit)
        //or (func3 = 6, imm = 0), and (func3 = 7, imm = 0), mul (func3 = 0, imm has 1 in lowest bit)
        //mulh (func3 = 1, imm has 1 in lowest bit), mulhsu (func3 = 2, imm has 1 in lowest)
        //mulhu (func3 = 3, imm has 1 in lowest), div (func3 = 4, imm = 1), divu (func3 = 5, imm = 1)
        //rem (func3 = 6, imm = 1), remu (func3 = 7, imm = 1)
            instruction.rtype_inst.rd = mutate_register();
        // func3
            instruction.rtype_inst.func3 = mutate_func3((int[]){0,1,2,3,4,5,6,7}, 8);
        // r1
            instruction.rtype_inst.rs1 = mutate_register();
        // r2
            instruction.rtype_inst.rs2 = mutate_register();    
        // func7
            if(instruction.rtype_inst.func3 == 0){
                instruction.rtype_inst.func7 = mutate_value((int[]){0x0,0x20,0x1}, 3);
            }else if(instruction.rtype_inst.func3 == 5){
                instruction.rtype_inst.func7 = mutate_value((int[]){0x0,0x20}, 2);
            }else{
                instruction.rtype_inst.func7 = mutate_value((int[]){0x0,0x1}, 2);
            }
            break;

        case I_TYPE_ARITH:
        //addi (func3 = 0), slti (func3 = 2, sltiu (func3 = 3), xori (func3 = 4)
        //ori (func3 = 6), andi (func3 = 7), slli (func3 = 1, last 7 bits are 0)
        //srli (func3 = 5, last 7 bits are 0), srai (func3 = 5, last 7 bits have 1 in 6 position)
        // rd
            instruction.itype_inst.rd = mutate_register();
        // func3
            instruction.itype_inst.func3 = mutate_func3((int[]){0,2,3,4,6,7,1,5}, 8);
        // r1
            instruction.itype_inst.rs1 = mutate_register();
        // imm
            if (instruction.itype_inst.func3 == 0x1) {
                // In this case, only the 5 LSBs of Immediate can be non zero
                instruction.itype_inst.imm =  mutate_imm() & 0b11111;
            }else if(instruction.itype_inst.func3 == 0x5){
                instruction.itype_inst.imm = (mutate_imm() & 0b11111) | (rand() % 2) << 10;
            }else {
                instruction.itype_inst.imm = mutate_imm();
            }
            break;

        case I_TYPE_JUMP:
        //jalr (func3 = 0)
        // rd
            instruction.itype_inst.rd = mutate_register();
        //func3
            instruction.itype_inst.func3 = 0;
        // r1
            instruction.itype_inst.rs1 = mutate_register();
        // imm
            instruction.itype_inst.imm = mutate_imm();
            break;
        case I_TYPE_LOAD:
        //lw (func3 = 2), lb (func3 = 0), lh (func3 = 1), lbu (func3 = 4)
        //lhu (func3 = 5)
        // rd
                instruction.itype_inst.rd = mutate_register();
        // func3
                instruction.itype_inst.func3 = mutate_func3((int[]){2,0,1,4,5}, 5);
        // r1
                instruction.itype_inst.rs1 = mutate_register();
        // imm
                instruction.itype_inst.imm = mutate_imm();
            break;
        case I_TYPE_ENV:
            instruction.itype_inst.func3 = mutate_func3((int[]){0,1,2,3,5,6,7}, 7);
            // ecall, ebreak, uret, sret, mret, wfi, sfence.vma
            if (instruction.itype_inst.func3 == 0) {
                //sfence.vma
                if(rand() % 7 == 0){
                    instruction.rtype_inst.rd = mutate_register();
                    instruction.rtype_inst.rs1 = mutate_register();
                    instruction.rtype_inst.rs2 = mutate_register();
                    instruction.rtype_inst.func7 = 0x9;
                //ecall, ebreak, uret, sret, mret, wfi
                }else{
                    instruction.itype_inst.rd = 0;
                    instruction.itype_inst.rs1 = 0;
                    instruction.itype_inst.imm = mutate_value((int[]){0x0, 0x01, 0x2, 0x102, 0x302, 0x105}, 6);
                }
            } else { // csr
                instruction.itype_inst.rd = mutate_register();
                instruction.itype_inst.rs1 = mutate_register();
                instruction.itype_inst.imm = mutate_imm();
            }
            break;
        case B_TYPE:
        //beq (func3 = 0), bne (func3 = 1), blt (func3 = 4), bge (func3 = 5), bltu (func3 = 6), bgeu (func3 = 7)
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
        //lui, auipc, jal
        // rd
            instruction.utype_inst.rd = mutate_register();
        // imm
            instruction.utype_inst.imm = mutate_imm();
            break;
        case S_TYPE:
        //sw (func3 = 2), sb (func3 = 0), sh (func3 = 1)
        // upper imm
            instruction.stype_inst.imm1 = mutate_imm();
        // func3
            instruction.stype_inst.func3 = mutate_func3((int[]){0,1,2},3);
        // r1
            instruction.stype_inst.rs1 = mutate_register();
        // r2
            instruction.stype_inst.rs2 = mutate_register();
       // imm
            instruction.stype_inst.imm2 = mutate_imm();
            break;
        case FENCE:
        //rd
            instruction.itype_inst.rd = 0;
        //func3
            instruction.itype_inst.func3 = mutate_func3((int[]){0,1}, 2);
        //rs1
            instruction.itype_inst.rs1 = 0;
        //imm
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

    //Buffer Size: 340, Add Buffer Size 339, Max Buffer Size 1048576

    // // Remove \n and copy buf
    buf[strcspn(buf, "\n")] = 0;
    char *copy = (char *)malloc(strlen(buf) + 1);
    strcpy(copy, buf);

    memset(data->final_instructions,0,MAX_FILE);
    int out_pos = 0;

    // Percent of instructions to be mutated
    int percent_var = 40; //10
    // Percent of times mutation is ALL instead of field
    int percent_all = 20; //20

    char *curr = copy;
    int offset = 0;

    //2 instructions for 64 bits
    instruction_type insn_block[2];

    while (*curr) {
    
        //Read in 2 instructions in block
        int count = sscanf(curr, "%08x%08x %n", &(insn_block[0].raw_inst),&(insn_block[1].raw_inst), &offset);
         //fprintf(out_f, "Curr: %s\n", curr);
        //Check if instructions were read properly
        if (count == 2) {
            curr += offset;

            int random_num = 0;
            //Go through each instruction and mutate
            for(int i = 0; i < 2; i++){

                random_num = rand() % 100;
                if (random_num < percent_var) {
                    // Determine what type of mutation it is
                    int mutate_type = rand() % 100;
                    if (mutate_type < percent_all) {
                        insn_block[i] = mutate_instruction();
                        
                    }
                    else {
                        insn_block[i] = mutate_field(insn_block[i]);
                            
                    }
                }
            }


            // Add struct to list
            //str will have to hold 16 chars for insn + space and has capacity of 40
            char str[_NUM_INSTRUCTIONS_CHARS];
            out_pos += sprintf(str, "%08x%08x ", insn_block[0].raw_inst, insn_block[1].raw_inst);
            strcat(data->final_instructions, str);

        } else {
            break;
        }

    }
    //Returns updated seed info to AFL++
    *out_buf = (unsigned char*)data->final_instructions;
    free(copy);
    return strlen(data->final_instructions);
}
