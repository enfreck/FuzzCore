VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS= -I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping"
DENYLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/picorv32/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/picorv32/lists/allowlist.txt

#Compile for FHLS fuzz testing

picorv32_fhls_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc ./hdl/picorv32_core.v -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-REDEFMACRO -Wno-PINMISSING -Wno-DECLFILENAME -Wno-VARHIDDEN --top-module picorv32
	make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vpicorv32.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel.cc ./obj_dir/Vpicorv32__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o picorv32_fhls

#Compile for edge calculations

picorv32_fhls_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -DSIZE_OF_THE_BUS=32 ./hdl/picorv32_top.v ./hdl/picorv32_core.v --top-module picorv32_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vpicorv32_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vpicorv32_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o picorv32_cov
	nm picorv32_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir picorv32_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -DSIZE_OF_THE_BUS=32 ./hdl/picorv32_top.v ./hdl/picorv32_core.v --top-module picorv32_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vpicorv32_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vpicorv32_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o picorv32_cov