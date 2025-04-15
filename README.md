***FuzzCore***

FuzzCore is an advanced hardware processor fuzzer implemented using AFL++. It runs on 10 RISC-V cores and 1 OpenRISC core. 
Some features of FuzzCore include the custom memory models, the custom ISA-specific instruction mutators, and the memory dump outputs.


**Installation**

FuzzCore was run on Ubuntu 22.04 using LLVM-14. An installation script is provided which shows the required versions and dependencies needed for both Verilator and AFL++

**Using FuzzCore**

Creating the custom mutator:
Update the .env file to have the proper path to have the proper path to AFL++
Enter the custom mutator file and type make mutator_"core" where "core" is the processor core you wish to test with FuzzCore

For example, you can run
```
make mutator_core
```
in the custom mutator folder to create the shared object file in the ./custom_mutator/core/ folder


Creating the executable:
in ~/cores/core folder, run
```
make core_afl
```

Setting up the Environment for FuzzCore:
```
cd ~/FuzzCore
export AFL_CUSTOM_MUTATOR_ONLY=true
export AFL_CUSTOM_MUTATOR_LIBRARY=~/FuzzCore/custom_mutator/core/mutator_core.so
export AFL_DISABLE_TRIM=true
timeout 24h ~/AFLplusplus/afl-fuzz -t 1000000 -i ./inputs/input_nop_X/ -o ./test_output -- ~/FuzzCore/cores/core/core_afl @@
```

To Calculate Coverage:
```
cd ~/FuzzCore/cores/core
rm -rf obj_dir
make core_cov
rm -rf /tmp/edges
cd ~/inspector_gadget/scripts
./edge-coverage.py -d ~/FuzzCore/test_output/default/queue/ -r ~/FuzzCore/test_output_coverage.csv --cmdline "~/FuzzCore/cores/core/core_cov @@" -cache-dir /tmp/edges
```
To Find the Number of Edges:
In ~/cores/core
```
COVERAGE_DUMP_FILE=a ./core_cov ../../inputs/input_nop_20
```
To check memory dumps:

Uncomment the code at the bottom of the core_clk_rst.cc files in the core-specific folders. Upon re-running AFL++, the core outputs will be stored in a tmp folder after which inspection can be done.


**Using Fuzzing Hardware Like Software**

To create the FHLS executable
```
cd ~/FuzzCore/fhls-compare/core
make core_fhls_afl
```

To run the FHLS executable
```
export AFL_DISABLE_TRIM=true
timeout 24h ~/AFLplusplus/afl-fuzz -t 1000000 -g 65 -G 65 -i ~/FuzzCore/fhls-compare/core/seed/ -o ./test_output_fhls -- ~/FuzzCore/fhls-compare/core/core_fhls @@
```
Note, G is from the size of the file in bytes

To Calculate Coverage:
```
cd ~/FuzzCore/fhls-compare/core
rm -rf obj_dir
make core_cov
rm -rf /tmp/edges
cd ~/inspector_gadget/scripts
./edge-coverage.py -d ~/FuzzCore/test_output_fhls/default/queue/ -r ~/FuzzCore/test_output_fhls_coverage.csv --cmdline "~/FuzzCore/fhls-compare/core/core_cov @@" -cache-dir /tmp/edges
```

**Using RFuzz**

To create the RFuzz executable
```
cd ~/FuzzCore/fhls-compare/core
make core_rfuzz
rm ./core/inputs/*
```

To run the RFuzz executable
```
timeout 24h ./core_rfuzz 
```

To Calculate Coverage:
```
cd ~/FuzzCore/fhls-compare/core
make core_rfuzz_cov
rm -rf /tmp/edges
cd ~/inspector_gadget/scripts
./edge-coverage-rfuzz.py -d ~/FuzzCore/rfuzz-compare/core/inputs/ -r ~/FuzzCore/test_output_rfuzz_coverage.csv --cmdline "~/FuzzCore/rfuzz-compare/core/core_cov @@" -cache-dir /tmp/edges
```
