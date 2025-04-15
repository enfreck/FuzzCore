#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <math.h>
#include <stdint.h>
#include "afl-fuzz.h"
#include "alloc-inl.h"

// distinguish different structs for instructions

typedef enum
{
    TYPE0,
    TYPE1,
    TYPE2,
    TYPE3,
    TYPE4,
    TYPE5,
    TYPE6,
    TYPE7,
    TYPE8,
    TYPE9,
    TYPE10,
    TYPE11,
    TYPE12,
    TYPE13,
    TYPE14,
    TYPE15,
    TYPE16,
    TYPE17,
    TYPE18,
    TYPE19,
    TYPE20,
   // TYPE21,
   // TYPE22,
   // TYPE23,
   // TYPE24,
    TYPE_COUNT
} INSTRUCTION_TYPE;

typedef struct
{
    uint32_t opcode3 : 4;
    uint32_t reserved2 : 4;
    uint32_t opcode2 : 2;
    uint32_t reserved1 : 1;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type0;

typedef struct
{
    uint32_t opcode3 : 4;
    uint32_t reserved2 : 2;
    uint32_t opcode2 : 4;
    uint32_t reserved1 : 6;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type1;

typedef struct
{
    uint32_t opcode3 : 4;
    uint32_t reserved2 : 2;
    uint32_t opcode2 : 4;
    uint32_t reserved1 : 1;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type2;

typedef struct
{
    uint32_t imm : 16;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode : 6;
} type3;

typedef struct
{
    uint32_t imm : 26;
    uint32_t opcode : 6;
} type4;

typedef struct
{
    uint32_t k : 5;
    uint32_t l : 6;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode : 6;
} type5;

typedef struct
{
    uint32_t reserved : 26;
    uint32_t opcode : 6;
} type6;

typedef struct
{
    uint32_t opcode : 32;
} type7;

typedef struct
{
    uint32_t opcode3 : 4;
    uint32_t reserved3 : 4;
    uint32_t opcode2 : 2;
    uint32_t reserved2 : 1;
    uint32_t reserved1 : 5;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type8;

typedef struct
{
    uint32_t reserved2 : 11;
    uint32_t rb : 5;
    uint32_t reserved1 : 10;
    uint32_t opcode : 6;
} type9;

typedef struct
{
    uint32_t imm : 16;
    uint32_t ra : 5;
    uint32_t reserved : 5;
    uint32_t opcode : 6;
} type10;

typedef struct
{
    uint32_t opcode2 : 4;
    uint32_t reserved2 : 7;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t reserved1 : 5;
    uint32_t opcode1 : 6;
} type11;

typedef struct
{
    uint32_t opcode2 : 17;
    uint32_t reserved : 4;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type12;

typedef struct
{
    uint32_t imm : 16;
    uint32_t opcode2 : 1;
    uint32_t reserved1 : 4;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type13;

typedef struct
{
    uint32_t imm : 11;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t k : 5;
    uint32_t opcode : 6;
} type14;

typedef struct
{
    uint32_t imm : 16;
    uint32_t reserved : 8;
    uint32_t opcode : 8;
} type15;

typedef struct
{
    uint32_t l : 6;
    uint32_t opcode2 : 2;
    uint32_t reserved : 8;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type16;

typedef struct
{
    uint32_t reserved : 11;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t opcode : 11;
} type17;

/*
typedef struct
{

    uint32_t opcode : 11;

    uint32_t ra : 5;

    uint32_t imm : 16;

} type18;
*/

typedef struct
{
    uint32_t k : 16;
    uint32_t opcode : 16;
} type18;

typedef struct
{
    uint32_t opcode2 : 8;
    uint32_t reserved : 3;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type19;

typedef struct
{
    uint32_t reserved3 : 4;
    uint32_t opcode2 : 4;
    uint32_t reserved2 : 3;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t reserved1 : 5;
    uint32_t opcode1 : 6;
} type20;

/*
typedef struct
{
    uint32_t opcode3 : 8;
    uint32_t reserved : 3;
    uint32_t opcode2 : 5;
    uint32_t ra : 5;
    uint32_t rd : 5;
    uint32_t opcode1 : 6;
} type21;
*/
/*
typedef struct
{
    uint32_t opcode2 : 8;
    uint32_t reserved2 : 3;
    uint32_t rb : 5;
    uint32_t ra : 5;
    uint32_t reserved1 : 5;
    uint32_t opcode1 : 6;
} type21;
*/

/*
typedef struct
{
    uint32_t reserved2 : 4;
    uint32_t opcode2 : 4;
    uint32_t reserved1 : 18;
    uint32_t opcode1 : 6;
} type21;
*/

#pragma pack(push, 1)
// struct of all types of instructions
typedef union {

    uint32_t raw_inst;  // This holds the raw instruction as a 32-bit value
    
    type0 type0_inst;

    type1 type1_inst;

    type2 type2_inst;

    type3 type3_inst;

    type4 type4_inst;

    type5 type5_inst;

    type6 type6_inst;

    type7 type7_inst;

    type8 type8_inst;

    type9 type9_inst;

    type10 type10_inst;

    type11 type11_inst;

    type12 type12_inst;

    type13 type13_inst;

    type14 type14_inst;

    type15 type15_inst;

    type16 type16_inst;

    type17 type17_inst;

    type18 type18_inst;

    type19 type19_inst;

    type20 type20_inst;

    //type21 type21_inst;

    //type22 type22_inst;

    //type23 type23_inst;

    //type24 type24_inst;

} instruction_type;

#pragma pack(pop)


typedef struct my_mutator
{

    afl_state_t *afl;

    char *final_instructions; // string of all the mutated instructions

} my_mutator_t;