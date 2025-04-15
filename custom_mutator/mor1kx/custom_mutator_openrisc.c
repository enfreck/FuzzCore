#include "custom_mutator_openrisc.h"

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

// Pick a new register x0-x31
int mutate_register() {
    return rand() % 32;
}

// Set field to a new value in values
int mutate_value(int values[], int values_size){
    return values[rand() % values_size];
}

// Generate random value of x bits    
int mutate_imm() {
    
    return rand();
   
}


INSTRUCTION_TYPE decode_instruction(uint32_t raw_inst) {
    uint8_t opcode1 = (raw_inst >> 26) & 0x3F;  // Extract the first 6 bits (opcode1)

    switch (opcode1) {
        case 0x38: {  // TYPE0, TYPE1, TYPE2
            uint8_t opcode2 = (raw_inst >> 8) & 0x3;  // Extract next 2 bits (opcode2)
            uint8_t opcode3 = raw_inst & 0xF;          // Extract next 4 bits (opcode3)

            // Handle opcode2 and opcode3 to determine the instruction type
            switch (opcode2) {
                case 0x0:
                    if (opcode3 == 0x8) {
                        return TYPE2;  // TYPE2: SLL, SRL, SRA, ROR
                    } else if (opcode3 == 0xc || opcode3 == 0xd) {
                        return TYPE1;  // TYPE1: EXTBS, EXTHS, EXTWS, etc.
                    } else if (opcode3 == 0xf) {
                        return TYPE8;  // TYPE8: Special case for opcode3 == 0xF
                    } else {
                        return TYPE0;  // TYPE0: Default case for opcode3
                    }

                case 0x1:
                    if (opcode3 == 0xf) {
                        return TYPE8;  // TYPE8: Special case for opcode3 == 0xF
                    } else if(opcode3 == 0x8){ 
                        return TYPE2;
                    } else {
                        return TYPE1;  // TYPE1: EXTBS, EXTHS, etc.
                    }

                case 0x2:
                    if (opcode3 == 0xc) {
                        return TYPE1;  // TYPE1: EXTHZ, EXTWZ, etc.
                    } else {
                        return TYPE2; 
                    }

                case 0x3:
                    if (opcode3 == 0xc) {
                        return TYPE1;  // TYPE1: EXTBZ
                    } else if(opcode3 == 0x8){
                        return TYPE2; 
                    } else{
                        return TYPE0;
                    }
                    return TYPE2;

                default:
                    return -1; // Handle unexpected opcode2 values
            }
            break;
        }
        case 0x1b:
        case 0x20:
        case 0x21:
        case 0x22:
        case 0x23:
        case 0x24:
        case 0x25:
        case 0x26:
        case 0x27:
        case 0x28:
        case 0x29:
        case 0x2a:
        case 0x2b:
        case 0x2c:
        case 0x2d:
            return TYPE3;
        case 0x0:
        case 0x1:
        case 0x3:
        case 0x4:
            return TYPE4;
        case 0x3c:
        case 0x3d:
            return TYPE5;
        case 0x1c:
        case 0x1d:
        case 0x1e:
        case 0x1f:
        case 0x9:
        case 0x3e:
        case 0x3f:
            return TYPE6;
        case 0x12:
        case 0x11:
            return TYPE9;
        case 0x13:
            return TYPE10;
        case 0x31:
            return TYPE11;
        case 0x6:
            // TYPE13: opcode2 is 1 bit (set to 0x0), and imm is 16 bits
            if ((raw_inst & 0x1FFFF) == 0x10000) {  
                return TYPE12;
            }
            // TYPE12: opcode2 is 17 bits (using the lower 17 bits directly)
            return TYPE13;
        case 0x30:
        case 0x36:
        case 0x34:
        case 0x37:
        case 0x35:
        case 0x33:
            return TYPE14;
        case 0x5:
            return TYPE15;
        case 0x2e:
            return TYPE16;
        case 0x39:
            return TYPE17;
        case 0x2f:
            return TYPE18;
        case 0x8:
            if(((raw_inst >> 16) & 0xFFFF) == 0x2000 || ((raw_inst >> 16) & 0xFFFF) == 0x2100){
                return TYPE18;
            } 
            return TYPE7;
        case 0xa:   
            return TYPE19;
        case 0x32: {
            uint32_t check_20 = (raw_inst >> 4) & 0xF; 
            if(check_20 == 0xd || check_20 == 0xe) {
                return TYPE20;
            } else {
                return TYPE19;
            }  
        }
        default:
            return -1;  // Invalid or unrecognized instruction type
    }

    return -1;  // Return -1 if no match found
}


instruction_type mutate_field(instruction_type instruction) {
    
    instruction_type modified_inst = instruction;
    
    //Decode instruction type from 24 possible types
    uint32_t type = decode_instruction(instruction.raw_inst);
    uint32_t value; //stores rand value for mutation type
    
    
    switch (type)
    {
        case TYPE0:

            value = rand() % 5;

            if (value == 0) { // rd mutation

                modified_inst.type0_inst.rd = mutate_register();
            }else if(value == 1) { //ra mutation

                modified_inst.type0_inst.ra = mutate_register();
            }else if(value == 2) { //rb mutation
                
                modified_inst.type0_inst.rb = mutate_register();
            }else if(value == 3) { //opcode2 mutation
                
                modified_inst.type0_inst.opcode2 = mutate_value((int[]){0x0, 0x3}, 2);

                if(modified_inst.type0_inst.opcode2 == 0x0){
                    modified_inst.type0_inst.opcode3 = mutate_value((int[]){0x0, 0x1, 0x3, 0xe, 0x4, 0x2, 0x5}, 7);
                }else {
                    modified_inst.type0_inst.opcode3 = mutate_value((int[]){0x9, 0xa, 0x6, 0xb}, 4);
                }
                
            }else { //opcode3 mutation
                
                modified_inst.type0_inst.opcode2 = instruction.type0_inst.opcode2;
                if(modified_inst.type0_inst.opcode2 == 0x0){
                    modified_inst.type0_inst.opcode3 = mutate_value((int[]){0x0, 0x1, 0x3, 0xe, 0x4, 0x2, 0x5}, 7);
                }else {
                    modified_inst.type0_inst.opcode3 = mutate_value((int[]){0x9, 0xa, 0x6, 0xb}, 4);
                }  
            }
        

            //printf("Type 0 Mutated Field\n");
            break;
        
        case TYPE1:



            value = rand() % 4;
            if (value == 0) {
                modified_inst.type1_inst.rd = mutate_register();
            }else if(value == 1) {
                modified_inst.type1_inst.ra = mutate_register();
            }else if(value == 2) {
                modified_inst.type1_inst.opcode2 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3}, 4);

                if(modified_inst.type1_inst.opcode2 == 0x0 || modified_inst.type1_inst.opcode2 == 0x1){
                    modified_inst.type1_inst.opcode3 = mutate_value((int[]){0xc, 0xd}, 2);
                } else {
                    modified_inst.type1_inst.opcode3 = 0xc;
                }

            }else{
                if(modified_inst.type1_inst.opcode2 == 0x0 || modified_inst.type1_inst.opcode2 == 0x1) {
                    modified_inst.type1_inst.opcode3 = mutate_value((int[]){0xc, 0xd}, 2);
                }else{
                    modified_inst.type1_inst.opcode3 = 0xc;
                }
            }
            


            //printf("Type 1 Mutated Field\n");
            break;

        case TYPE2:

  
            value = rand() % 4;
            if (value == 0) { // rd mutation
                modified_inst.type2_inst.rd = mutate_register();
            }else if(value == 1) { //ra mutation
                modified_inst.type2_inst.ra = mutate_register();
            }else if(value == 2) {
                modified_inst.type2_inst.rb = mutate_register();
            }else {
                modified_inst.type2_inst.opcode2 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3}, 4);
            }


            //printf("Type 2 Mutated Field\n");
            break;


        case TYPE3:
    
            value = rand() % 4;
            if (value == 0) { // opcode mutation
                modified_inst.type3_inst.opcode = mutate_value((int[]){0x27, 0x28, 0x29, 0x24, 0x23, 0x20, 0x26, 0x25, 0x1b, 0x22, 0x21, 0x2d, 0x2c, 0x2a, 0x2b}, 15);
            }else if(value == 1) { //rd mutation
                modified_inst.type3_inst.rd = mutate_register();
            }else if(value == 2) {
                modified_inst.type3_inst.ra = mutate_register();
            }else {
                modified_inst.type3_inst.imm = mutate_imm(); //16
            }
   
            //printf("Type 3 Mu tated Field\n");
            break;

        case TYPE4:


            value = rand() % 2;
            if (value == 0) { // opcode mutation
                modified_inst.type4_inst.opcode = mutate_value((int[]){0x1, 0x3, 0x4}, 3); //removed 0x0 since it has overlap with TYPE18
            }else {
                modified_inst.type4_inst.imm = mutate_imm(); //26
            }


            //printf("Type 4 Mutated Field\n");
            break;

        case TYPE5:


            value = rand() % 6;
            if (value == 0) {
                modified_inst.type5_inst.opcode = mutate_value((int[]){0x3c, 0x3d}, 2);
            }else if (value == 1) { // rd mutation
                modified_inst.type5_inst.rd = mutate_register(); 
            }else if(value == 2) { //ra mutation
                modified_inst.type5_inst.ra = mutate_register();
            }else if(value == 3) {
                modified_inst.type5_inst.rb = mutate_register();
            }else if(value == 4) {
                modified_inst.type5_inst.l = mutate_imm(); //6
            }else {
                modified_inst.type5_inst.k = mutate_imm(); //5
            }

            //printf("Type 5 Mutated Field\n");
            break;

        case TYPE6:

   
           
            modified_inst.type6_inst.opcode = mutate_value((int[]){0x1c, 0x1d, 0x1e, 0x1f, 0x9, 0x3e, 0x3f}, 7);

            ////printf("Type 6 Mutated Field\n");
            break;

        case TYPE7:

            //don't have to set since twice only 1 field

            modified_inst.type7_inst.opcode = mutate_value((int[]){0x23000000, 0x22000000, 0x22800000}, 3);

       
            //printf("Type 7 Mutated Field\n");
            break;

        case TYPE8:

   

            value = rand() % 3;
            if (value == 0) { // rd mutation
                modified_inst.type8_inst.rd = mutate_register(); 
            }else if(value == 1) { //ra mutation
                modified_inst.type8_inst.ra = mutate_register();
            }else {
                modified_inst.type8_inst.opcode2 = mutate_value((int[]){0x1, 0x0}, 2);
            }
     

            //printf("Type 8 Mutated Field\n");
            break;

        case TYPE9:


            value = rand() % 2;
            if (value == 0) { // opcode mutation
                modified_inst.type9_inst.opcode = mutate_value((int[]){0x11, 0x12}, 2);
            }else {
                modified_inst.type9_inst.rb = mutate_register();
            }

 
            
            //printf("Type 9 Mutated Field\n");
            break;

        case TYPE10:



            value = rand() % 2;
            if (value == 0) { // ra mutation
                modified_inst.type10_inst.ra = mutate_register(); 
            }else {
                modified_inst.type10_inst.imm = mutate_imm(); //16
            }


            //printf("Type 10 Mutated Field\n");
            break;

        case TYPE11:

            value = rand() % 3;
            if (value == 0) { // ra mutation
                modified_inst.type11_inst.ra = mutate_register(); 
            }else if(value == 1) { //rb mutation
                modified_inst.type11_inst.rb = mutate_register();
            }else {
                modified_inst.type11_inst.opcode2 = mutate_value((int[]){0x1, 0x2, 0x3, 0x4}, 4); 
            }

            
            //printf("Type 11 Mutated Field\n");
            break;

        case TYPE12:


            modified_inst.type12_inst.rd = mutate_register();

       
        
            //printf("Type 12 Mutated Field\n");
            break;

        case TYPE13:


            value = rand() % 2;
            if (value == 0) { 
                modified_inst.type13_inst.rd = mutate_register(); 
            }else {
                modified_inst.type13_inst.imm = mutate_imm(); //16
            }

        
            //printf("Type 13 Mutated Field\n");
            break;



        case TYPE14:



            value = rand() % 5;
            if (value == 0) { 
                modified_inst.type14_inst.opcode = mutate_value((int[]){0x30, 0x36, 0x34, 0x37, 0x35, 0x33}, 6); 
            }else if(value == 1) { 
                modified_inst.type14_inst.k = mutate_imm(); //5
            }else if(value == 2) {
                modified_inst.type14_inst.ra = mutate_register();
            }else if(value == 3) {
                modified_inst.type14_inst.rb = mutate_register();
            }else {
                modified_inst.type14_inst.imm = mutate_imm(); //11
            }


            //printf("Type 14 Mutated Field\n");
            break;

        case TYPE15:



            modified_inst.type15_inst.imm = mutate_imm(); //16

                
            //printf("Type 15 Mutated Field\n");
            break;


        case TYPE16:



            value = rand() % 4;
            if (value == 0) { 
                modified_inst.type16_inst.rd = mutate_register(); 
            }else if(value == 1) { 
                modified_inst.type16_inst.ra = mutate_register();
            }else if(value == 2) {
                modified_inst.type16_inst.opcode2 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3}, 4);
            }else {
                modified_inst.type16_inst.l = mutate_imm(); //6
            }

 

            //printf("Type 16 Mutated Field\n");
            break;
        
        case TYPE17:

   
            // opcode - 11
            modified_inst.type17_inst.opcode = mutate_value((int[]){0x720, 0x72b, 0x723, 0x72a, 0x722, 0x72d, 0x725, 0x72c, 0x724, 0x721}, 10);
            // rd - 5
            modified_inst.type17_inst.ra = mutate_register();  
            // ra - 5
            modified_inst.type17_inst.rb = mutate_register();
            
 

            //printf("Type 17 Mutated Field\n");
            break;

        case TYPE18:

 

            value = rand() % 2;
            if (value == 0) { 
                modified_inst.type18_inst.opcode = mutate_value((int[]){0x2000, 0x2100}, 2);
            }else {
                modified_inst.type18_inst.k = mutate_imm(); //16
            }


            //printf("Type 18 Mutated Field\n");
            break;

         case TYPE19:


            value = rand() % 5;
            if (value == 0) {
            modified_inst.type19_inst.opcode1 = mutate_value((int[]){0x32, 0xa}, 2);
            } else if (value == 1) {
            modified_inst.type19_inst.rd = mutate_register();
            } else if (value == 2) {
            modified_inst.type19_inst.ra = mutate_register();
            } else if (value == 3) {
            modified_inst.type19_inst.rb = mutate_register();
            } else {
                if (modified_inst.type19_inst.opcode1 == 0x32) {
                modified_inst.type19_inst.opcode2 = mutate_value((int[]){0x0, 0x3, 0x7, 0x2, 0x6, 0x1, 0x10, 0x13, 0x17, 0x12, 0x16, 0x11}, 12);
                }else{
                    modified_inst.type19_inst.opcode2 = mutate_value((int[]){0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x38, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x39, 0x3a, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x6b, 0x69, 0x6a, 0x6e, 0x6f, 0x70, 0x6c, 0x6d, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b}, 85);
                }
            }
           

                    
            //printf("Type 19 Mutated Field\n");
            break;

        case TYPE20:



            value = rand() % 4;
            if (value == 0) {
                modified_inst.type20_inst.opcode1 = mutate_value((int[]){0x32}, 1);
            } else if (value == 1) {
                modified_inst.type20_inst.ra = mutate_register();
            } else if (value == 2) {
                modified_inst.type20_inst.rb = mutate_register();
            }else {
                modified_inst.type20_inst.opcode2 = mutate_value((int[]){0xd, 0xe}, 2);
            }

   

            //printf("Type 20 Mutated Field\n");
            break;
        
        default:
            break;
    }
    
    return modified_inst;
    
}

instruction_type mutate_instruction() {
    
    instruction_type instruction = {0};  // Zero initialize the struct to avoid uninitialized fields

    int insn_num = rand() % TYPE_COUNT; //Changed from TYPE_COUNT //get random instructions between 1 and 22

    //instructions not in base included: lf.madd.s, l.cust7, l.cust8, l.macu, l.msbu, l.muld, l.muldu, (muld and muldu need new type)

    //insn_num = check_num; //need to comment back out

    ////printf("Selected type: %d\n", insn_num);

    switch (insn_num)
    {
        //INSN: ADD (0x38, 0x0, 0x0), addc (0x38, 0x0, 0x1), sub (0x38, 0x0, 0x2), and (0x38, 0x0, 0x3), or (0x38, 0x0, 0x4), xor (0x38, 0x0, 0x5)
        //INSN: MUL (0x38, 0x3, 0x6), DIV (0x38, 0x3, 0x9), DIVU (0x38, 0x3, 0xa), MULU (0x38, 0x3, 0xb), CMOV (0x38, 0x0, 0xe)

        case TYPE0:

            //instruction.type = TYPE0;
        // opcode1 (6)
            instruction.type0_inst.opcode1 = 0x38;
        // rd (5)
            instruction.type0_inst.rd = mutate_register();
        // ra (5)
            instruction.type0_inst.ra = mutate_register();
        // rb (5)
            instruction.type0_inst.rb = mutate_register();
        // reserved1 (1)
            instruction.type0_inst.reserved1 = 0;
        // opcode2 (2)
            instruction.type0_inst.opcode2 = mutate_value((int[]){0x0, 0x3}, 2);
        // reserved2 (4)
            instruction.type0_inst.reserved2 = 0;
        // opcode3 (4)
            if(instruction.type0_inst.opcode2 == 0x0){
                instruction.type0_inst.opcode3 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0xe}, 7);
            }else{
                instruction.type0_inst.opcode3 = mutate_value((int[]){0x9, 0xa, 0x6, 0xb}, 4);
            }    
      
            //printf("Type 0 Raw Instruction after making INSN: %08x\n", instruction.raw_inst);
            //printf("Type 0 Mutated INSN\n");
            ////printf("Type %d\n", TYPE0);
            break;
        
        //INSN: EXTBS (0x38, 0x1, 0xc), EXTHS (0x38, 0x0, 0xc), EXTWS (0x38, 0x0, 0xd), EXTBZ (0x38, 0x3, 0xc), EXTHZ (0x38, 0x2, 0xc), EXTWZ (0x38, 0x1, 0xd), 

        case TYPE1:
            //instruction.type = TYPE1;
        // opcode1 (6)
            instruction.type1_inst.opcode1 = 0x38;
        // rd (5)
            instruction.type1_inst.rd = mutate_register();
        // ra (5)
            instruction.type1_inst.ra = mutate_register();
        // rerseved (6)
            instruction.type1_inst.reserved1 = 0;
        // opcode2 (4)
            instruction.type1_inst.opcode2 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3}, 4);
        // reserved2 (2)
            instruction.type1_inst.reserved2 = 0;
        // opcode3 (4)
            if(instruction.type1_inst.opcode2 == 0x0 || instruction.type1_inst.opcode2 == 0x1){
                instruction.type1_inst.opcode3 = mutate_value((int[]){0xc, 0xd}, 2);
            }else{
                instruction.type1_inst.opcode3 = 0xc;
            } 
 

            //printf("Type 1 Mutated INSN\n");
            ////printf("Type %d\n", TYPE1);
            break;
        
        //INSN: SLL (0x38, 0x0, 0x8), SRL (0x38, 0x1, 0x8), SRA (0x38, 0x2, 0x8), ROR (0x38, 0x3, 0x8), 

        case TYPE2:
            //instruction.type = TYPE2;
        // opcode1 (6)
            instruction.type2_inst.opcode1 = 0x38;
        // rd (5)
            instruction.type2_inst.rd = mutate_register();
        // ra (5)
            instruction.type2_inst.ra = mutate_register();
        // rb (5)
            instruction.type2_inst.rb = mutate_register();
        // rerseved (1)
            instruction.type2_inst.reserved1 = 0;
        // opcode2 (4)
            instruction.type2_inst.opcode2 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3}, 4); //was 0x0 and 0x1 for 0xf and 0x8
        // reserved2 (2)
            instruction.type2_inst.reserved2 = 0;
        // opcode3 (4)
            instruction.type2_inst.opcode3 = 0x8;
            
          

            //printf("Type 2 Mutated INSN\n");
            ////printf("Type %d\n", TYPE2);
            break;

        //Instructions: LWA: 0x1b, LD: 0x20, LWZ: 0x21, LWS: 0x22, LBZ: 0x23, LBS: 0x24, LHZ: 0x25, LHS: 0x26, ADDI: 0x27, ADDIC: 0x28, ANDI: 0x29, ORI 0x2a, XORI: 0x2b, MULI: 0x2c, MFSPR: 0x2d

        case TYPE3:
            //instruction.type = TYPE3;
        // opcode - 6
            instruction.type3_inst.opcode = mutate_value((int[]){0x27, 0x28, 0x29, 0x24, 0x23, 0x20, 0x26, 0x25, 0x1b, 0x22, 0x21, 0x2d, 0x2c, 0x2a, 0x2b}, 15);
        // rd - 5
            instruction.type3_inst.rd = mutate_register();
        // ra - 5
            instruction.type3_inst.ra = mutate_register();
        // imm - 16 bits
            instruction.type3_inst.imm = mutate_imm(); //16
            
       

            //printf("Type 3 Mutated INSN\n");
            ////printf("Type %d\n", TYPE3);
            break;

        //INSN: 0x0 for j, 0x1 for jal, 0x3 for bnf, 0x4 for bf

        case TYPE4:
            //instruction.type = TYPE4;
        // opcode - 6
            instruction.type4_inst.opcode = mutate_value((int[]){0x1, 0x3, 0x4}, 3); //removed 0x0 since overlap with TYPE 18
        // imm - 26 bits
            instruction.type4_inst.imm = mutate_imm(); //26


            //printf("Type 4 Mutated INSN\n");
            ////printf("Type %d\n", TYPE4);
            break;

        //INSN: CUST5 0x3c, CUST6 0x3d, (Disagrees with manual values of 0xf0 and 0xf1 for the disassembler)

        case TYPE5:
            //instruction.type = TYPE5;
            // opcode - 6
            instruction.type5_inst.opcode = mutate_value((int[]){0x3c, 0x3d}, 2);
            // rd - 5
            instruction.type5_inst.rd = mutate_register();
            // ra - 5
            instruction.type5_inst.ra = mutate_register();
            // rb - 5
            instruction.type5_inst.rb = mutate_register();
            // l - 6 bits
            instruction.type5_inst.l = mutate_imm(); //6
            // k - 5 bits   
            instruction.type5_inst.k = mutate_imm(); //5 

   
            //printf("Type 5 Mutated INSN\n");
            ////printf("Type %d\n", TYPE5);
            break;

        //INSN: CUST1 = 0x1c, CUST2 = 0x1d, CUST3 = 0x1e, CUST4 = 0x1f, l.RFE = 0x9

        //extra INSN Cust7 (0x3e), Cust8 (0x3f)

        case TYPE6:
            //instruction.type = TYPE6;   
            // opcode - 6
            instruction.type6_inst.opcode = mutate_value((int[]){0x1c, 0x1d, 0x1e, 0x1f, 0x9, 0x3e, 0x3f}, 7);
            // reserved - 26
            instruction.type6_inst.reserved = 0;
      

            //printf("Type 6 Mutated INSN\n");
            ////printf("Type %d\n", TYPE6);
            break;

        //INSN: MSYNC: 0x22000000, PSYNC: 0x22800000, CSYNC: 0x23000000


        case TYPE7:
            //instruction.type = TYPE7;
            // opcode - 32
            instruction.type7_inst.opcode = mutate_value((int[]){0x23000000, 0x22000000, 0x22800000}, 3);
            
        
            
            //printf("Type 7 Mutated INSN\n");
            ////printf("Type %d\n", TYPE7);
            break;

        //INSN: FF1 (0x38, 0x0, 0xf), FL1 (0x38, 0x1, 0xf)

        case TYPE8:
            //instruction.type = TYPE8;
            // opcode1 - 6
            instruction.type8_inst.opcode1 = 0x38;
            // rd - 5
            instruction.type8_inst.rd = mutate_register();
            // ra - 5
            instruction.type8_inst.ra = mutate_register();
            // reserved1 - 5 
            instruction.type8_inst.reserved1 = 0;
            // reserved2 - 1
            instruction.type8_inst.reserved2 = 0;  
            // opcode2 - 2
            instruction.type8_inst.opcode2 = mutate_value((int[]){0x0, 0x1}, 2);
            // reserved3 - 4
            instruction.type8_inst.reserved3 = 0;
            // opcode3 - 4
            instruction.type8_inst.opcode3 = 0xf;
            

            
            //printf("Type 8 Mutated INSN\n");
            ////printf("Type %d\n", TYPE8);
            break;

        //INSN: JR = 0x11, JALR = 0x12

        case TYPE9:
            //instruction.type = TYPE9;
            // opcode1 - 6
            instruction.type9_inst.opcode = mutate_value((int[]){0x12, 0x11}, 2);
            // reserved1 - 10
            instruction.type9_inst.reserved1 = 0;  
            // rb - 5
            instruction.type9_inst.rb = mutate_register();
            // reserved2 - 11
            instruction.type9_inst.reserved2 = 0;    
            
 
            
            //printf("Type 9 Mutated INSN\n");
            ////printf("Type %d\n", TYPE9);
            break;

        //INSN MACI

        case TYPE10:
            //instruction.type = TYPE10; 
            // opcode - 6
            instruction.type10_inst.opcode = 0x13;
            // reserved - 5
            instruction.type10_inst.reserved = 0;  
            // ra - 5
            instruction.type10_inst.ra = mutate_register();
            // imm - 16 bits
            instruction.type10_inst.imm = mutate_imm(); //16
            
 
            //printf("Type 10 Mutated INSN\n");
            ////printf("Type %d\n", TYPE10);
            break;

        //INSN: MAC = 0x31 (0x1), MSB = 0x31 (0x2)

        //extra insn: macu (0x31, 0x3), msbu (0x31, 0x4) (not hit by disassembler)

        case TYPE11:
            //instruction.type = TYPE11;
            // opcode - 6
            instruction.type11_inst.opcode1 = 0x31;
            // reserved - 5
            instruction.type11_inst.reserved1 = 0;  
            // ra - 5
            instruction.type11_inst.ra = mutate_register();
            // rb - 5
            instruction.type11_inst.rb = mutate_register();
            // reserved - 7
            instruction.type11_inst.reserved2 = 0;
            // opcode2- 4
            instruction.type11_inst.opcode2 = mutate_value((int[]){0x1, 0x2, 0x3, 0x4}, 4);    
            

            
            //printf("Type 11 Mutated INSN\n");
            ////printf("Type %d\n", TYPE11);
            break; 

        //INSN: MACRC

        case TYPE12:
            //instruction.type = TYPE12;
            // opcode - 6
            instruction.type12_inst.opcode1 = 0x6;
            // rd - 5
            instruction.type12_inst.rd = mutate_register();  
            // reserved - 4
            instruction.type12_inst.reserved = 0;
            // opcode - 17
            instruction.type12_inst.opcode2 = 0x10000;
            

            
            //printf("Type 12 Mutated INSN\n");
            ////printf("Type %d\n", TYPE12);
            break;  
            
        //INSN: movhi

        case TYPE13:
            //instruction.type = TYPE13;
            // opcode - 6
            instruction.type13_inst.opcode1 = 0x6;
            // rd - 5
            instruction.type13_inst.rd = mutate_register();  
            // reserved - 4
            instruction.type13_inst.reserved1 = 0;
            // opcode - 1
            instruction.type13_inst.opcode2 = 0x0;
            // immediate - 16
            instruction.type13_inst.imm = mutate_imm(); //16
            

            //printf("Type 13 Mutated INSN\n");
            ////printf("Type %d\n", TYPE13);
            break; 
        
        //INSN: SWA: 0x33, SD: 0x34, SW: 0x35, SB: 0x36, SH: 0x37, MTSPR: 0x30

        //SD is not registered in dissassembler

        case TYPE14:
            //instruction.type = TYPE14;
            // opcode - 6
            instruction.type14_inst.opcode = mutate_value((int[]){0x30, 0x36, 0x34, 0x37, 0x35, 0x33}, 6);
            // k - 5
            instruction.type14_inst.k = mutate_imm(); //5
            // ra - 5
            instruction.type14_inst.ra = mutate_register();
            // rb - 5
            instruction.type14_inst.rb = mutate_register();
            // immediate - 11
            instruction.type14_inst.imm = mutate_imm(); //11
            


            //printf("Type 14 Mutated INSN\n");
            ////printf("Type %d\n", TYPE14);
            break; 

        //INSN: nop

        case TYPE15:
            //instruction.type = TYPE15;
            // opcode - 8
            instruction.type15_inst.opcode = 0x15;
            // reserved - 8
            instruction.type15_inst.reserved = 0;  
            // intermediate - 16
            instruction.type15_inst.imm = mutate_imm(); //16
            

            
            //printf("Type 15 Mutated INSN\n");
            ////printf("Type %d\n", TYPE15);
            break; 

        //INSN: SLLI: 0x2e (0x0), SRLI: 0x2e (0x1), SRAI: 0x2e (0x2), RORI 0x2e (0x3)

        case TYPE16:
            //instruction.type = TYPE16;
            // opcode - 6
            instruction.type16_inst.opcode1 = 0x2e; 
            // rd - 5
            instruction.type16_inst.rd = mutate_register();  
            // ra - 5
            instruction.type16_inst.ra = mutate_register();
            // reserved - 8
            instruction.type16_inst.reserved = 0;
            // opcode - 2
            instruction.type16_inst.opcode2 = mutate_value((int[]){0x0, 0x1, 0x2, 0x3}, 4);
            // l - 6
            instruction.type16_inst.l = mutate_imm(); //6
            

            
            //printf("Type 16 Mutated INSN\n");
            ////printf("Type %d\n", TYPE16);
            break;

        //INSN: SFEQ 0x720, SFNE 0x721, SFGTU 0x722, SFGEU 0x723, SFLTU 0x724, SFLEU 0x725, SFGTS 0x72a, SFGES 0x72b, SFLTS 0x72c, SFLES 0x72d

        case TYPE17:
            //instruction.type = TYPE17;
            // opcode - 11
            instruction.type17_inst.opcode = mutate_value((int[]){0x720, 0x72b, 0x723, 0x72a, 0x722, 0x72d, 0x725, 0x72c, 0x724, 0x721}, 10);
            // rd - 5
            instruction.type17_inst.ra = mutate_register();  
            // ra - 5
            instruction.type17_inst.rb = mutate_register();
            // reserved - 11
            instruction.type17_inst.reserved = 0;
  

            //printf("Type 17 Mutated INSN\n");
            ////printf("Type %d\n", TYPE17);
            break;

        //INSN: SYS = 0x2000, trap = 0x2100

        case TYPE18:
            // opcode - 16
            instruction.type18_inst.opcode = mutate_value((int[]){0x2000, 0x2100}, 2);
            // k - 16
            instruction.type18_inst.k = mutate_imm(); //16  
            


            //printf("Type 18 Mutated INSN\n");
            break;

        //INSN lf.add.s (0x32, 0x0), lf.div.s (0x32, 0x3), lf.madd.s (0x32, 0x7), lf.mul.s (0x32, 0x2), lf.rem.s (0x32, 0x6), lf.sub.s (0x32, 0x1)
        //lf.add.d (0x32, 0x10), lf.div.d (0x32, 0x13), lf.madd.d (0x32, 0x17), lf.mul.d (0x32, 0x12), lf.rem.d (0x32, 0x16), lf.sub.d (0x32 0x11)

        //VECTOR INSN: lv.add.b (0xa, 0x30), lv.add.h (0xa, 0x31), lv.adds.b (0xa, 0x32), lv.adds.h (0xa, 0x33), lv.addu.b (0xa, 0x34), lv.addu.h (0xa, 0x35), lv.addus.b (0xa, 0x36)
        //VECTOR INSN: lv.addus.h (0xa, 0x37), lv.all_eq.b (0xa, 0x10), lv.all_eq.h (0xa, 0x11), lv.all_ge.b (0xa, 0x12), lv.all_ge.h (0xa, 0x13), lv.all_gt.b (0xa, 0x14), lv.all_gt.h (0xa, 0x15)
        //VECTOR INSN: lv.all_le.b (0xa, 0x16), lv.all_le.h (0xa, 0x17), lv.all_lt.b (0xa, 0x18), lv.all_lt.h (0xa, 0x19), lv.all_ne.b (0xa, 0x1a), lv.all_ne.h (0xa, 0x1b), lv.and (0xa, 0x38)
        //VECTOR INSN: lv.any_eq.b (0xa, 0x20), lv.any_eq.h (0xa, 0x21), lv.any_ge.b (0xa, 0x22), lv.any_ge.h (0xa, 0x23), lv.any_gt.b (0xa, 0x24), lv.any_gt.h (0xa, 0x25), lv.any_le.b (0xa, 0x26)
        //VECTOR INSN: lv/any_le.h (0xa, 0x27), lv.any_lt.b (0xa, 0x28), lv.any_lt.h (0xa, 0x29), lv.any_ne.b (0xa, 0x2a),  lv.any_ne.h (0xa, 0x2b), lv.avg.b (0xa, 0x39), lv.avg.h (0xa, 0x3a)
        //VECTOR INSN: lv.cmp_eq.b (0xa, 0x40), lv.cmp_eq.h (0xa, 0x41), lv.cmp_ge.b (0xa, 0x42), lv.cmp_ge.h (0xa, 0x43), lv.cmp_gt.b (0xa, 0x44), lv.cmp_gt.h (0xa, 0x45)
        //lv.cmp_le.b (0xa, 0x46), lv.cmp_le.h (0xa, 0x47), lv.cmp_lt.b (0xa, 0x48),  lv.cmp_lt.h (0xa, 0x49), lv.cmp_ne.b (0xa, 0x4a) lv.cmp_ne.h (0xa, 0x4b), lv.min.b (0xa, 0x59)
        //lv.madds.h (0xa, 0x54), lv.max.b (0xa, 0x55), lv.max.h (0xa, 0x56), lv.merge.b (0xa, 0x57), lv.merge.h (0xa, 0x58), lv.min.h (0xa, 0x5a), lv.msubs.h (0xa, 0x5b), lv.muls.h (0xa, 0x5c)
        //lv.nand (0xa, 0x5d), lv.nor (0xa, 0x5e), lv.or (0xa, 0x5f), lv.packs.b (0xa, 0x62), lv.packs.h (0xa, 0x63), lv.packus.b (0xa, 0x64), lv.packus.b (0xa, 0x65), lv.perm.n (0xa, 0x66)
        //lv.rl.b (0xa, 0x67), lv.rl.h (0xa, 0x68), lv.sll (0xa. 0x6b), lv.sll.b (0xa, 0x69), lv.sll.h (0xa, 0x6a), lv.sll.h (0xa, 0x6e), lv.sra.b (0xa, 0x6e), lv.sra.h (0xa, 0x6f)
        //lv.srl (0xa, 0x70)

        case TYPE19:
            //instruction.type = TYPE20;
            // opcode - 6
            instruction.type19_inst.opcode1 = mutate_value((int[]){0x32, 0xa}, 2);
            // rd - 5
            instruction.type19_inst.rd = mutate_register();
            //ra - 5
            instruction.type19_inst.ra = mutate_register();
            //rb - 5
            instruction.type19_inst.rb = mutate_register();
            //reserved - 3
            instruction.type19_inst.reserved = 0;
            //opcode2 - 8
            if(instruction.type19_inst.opcode1 == 0x32){
                instruction.type19_inst.opcode2 = mutate_value((int[]){0x0, 0x3, 0x7, 0x2, 0x6, 0x1, 0x10, 0x13, 0x17, 0x12, 0x16, 0x11}, 12);
            }else{
                instruction.type19_inst.opcode2 = mutate_value((int[]){0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1b, 0x38, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x39, 0x3a, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x6b, 0x69, 0x6a, 0x6e, 0x6f, 0x70, 0x6c, 0x6d, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b}, 84);
            }


            //printf("Type 19 Mutated INSN\n");
            break;

        //INSN lf.cust1.s (0x32, 0xd), lf.cust1.d (0x32, 0xe)

        case TYPE20:
           // instruction.type = TYPE21;
            // opcode - 6
            instruction.type20_inst.opcode1 = mutate_value((int[]){0x32}, 1);
            // reserved - 5
            instruction.type20_inst.reserved1 = 0;
            //ra - 5
            instruction.type20_inst.ra = mutate_register();
            //rb - 5
            instruction.type20_inst.rb = mutate_register();
            //reserved - 3
            instruction.type20_inst.reserved2 = 0;
            //opcode2 - 4
            instruction.type20_inst.opcode2 = mutate_value((int[]){0xd, 0xe}, 2);
            //reserved - 4
            instruction.type20_inst.reserved3 = 0;
   

            //printf("Type 20 Mutated INSN\n");

            break;

        default:
            break;
    }

    ////printf("Instruction Type %u\n", instruction.type);

    return instruction;
}


size_t afl_custom_fuzz(my_mutator_t *data, char *buf, size_t buf_size, unsigned char **out_buf, unsigned char *add_buf, size_t add_buf_size, size_t max_size) {
    buf[strcspn(buf, "\n")] = 0;
    char *copy = (char *)malloc(strlen(buf) + 1);
    strcpy(copy, buf);
    memset(data->final_instructions, 0, MAX_FILE);
    int out_pos = 0, percent_var = 40, percent_all = 20; //10,20
    char *curr = copy;
    int offset = 0;
    instruction_type instruction;
    
    while (*curr) {
        int count = sscanf(curr, "%x %n", &(instruction.raw_inst), &offset);
        if (count == 1) {
            curr += offset;
            if (rand() % 100 < percent_var) {
                if (rand() % 100 < percent_all) instruction = mutate_instruction();
                else instruction = mutate_field(instruction);
            }
            char str[_NUM_INSTRUCTIONS_CHARS];
            //instruction.raw_inst = reverse_endian(instruction.raw_inst);
            out_pos += sprintf(str, "%08x ", instruction.raw_inst);
            strcat(data->final_instructions, str);
        } else {
            break;
        }
    }
    *out_buf = (unsigned char *)data->final_instructions;
    free(copy);

    return strlen(data->final_instructions);
}
