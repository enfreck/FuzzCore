VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS=-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping"
DENYLIST=/home/user/Research/Fuzz/FuzzCore/cores/picorv32/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/cores/picorv32/lists/allowlist.txt

#Compile for fuzz testing

picorv_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -I./hdl/include -DSIZE_OF_THE_BUS=32 -DPICORV32 ./hdl/picorv32/picorv32_top.v ./hdl/picorv32/picorv32_core.v ./hdl/picorv32/memory_modelling.sv --top-module picorv32core
	AFL_LLVM_ALLOWLIST=$(ALLOWLIST) make CXX=$(AFL_PATH)/afl-clang-fast++ CXXFLAGS="-g" -C obj_dir -f Vpicorv32core.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -g -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	AFL_LLVM_ALLOWLIST=$(ALLOWLIST) $(AFL_PATH)/afl-clang-fast++ -g -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vpicorv32core__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o picorv_afl

#Compile for edge calculations

picorv_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -I./hdl/include -DSIZE_OF_THE_BUS=32 -DPICORV32 ./hdl/picorv32/picorv32_top.v ./hdl/picorv32/picorv32_core.v ./hdl/picorv32/memory_modelling.sv --top-module picorv32core
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vpicorv32core.mk 
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vpicorv32core__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o picorv_cov
	nm picorv_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir picorv_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -I./hdl/include -DSIZE_OF_THE_BUS=32 -DPICORV32 ./hdl/picorv32/picorv32_top.v ./hdl/picorv32/picorv32_core.v ./hdl/picorv32/memory_modelling.sv --top-module picorv32core
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vpicorv32core.mk 
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vpicorv32core__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o picorv_cov
