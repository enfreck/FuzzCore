VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS= -I. -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping"
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/cores/sodor1/lists/allowlist.txt
DENYLIST=/home/user/Research/Fuzz/FuzzCore/cores/sodor1/lists/denylist.txt

#Compile for fuzzing run

sodor1_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -I./hdl/include -DSIZE_OF_THE_BUS=32 ./hdl/sodor1_rtl/sodor_top.v ./hdl/sodor1_rtl/sodor_core_1stage.v ./hdl/sodor1_rtl/sodor_mem_model.sv
	AFL_LLVM_ALLOWLIST=$(ALLOWLIST) make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vsodor_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	AFL_LLVM_ALLOWLIST=$(ALLOWLIST) $(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vsodor_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o sodor1_afl

#Compile for edge calculations

sodor1_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -I./hdl/include -DSIZE_OF_THE_BUS=32 ./hdl/sodor1_rtl/sodor_top.v ./hdl/sodor1_rtl/sodor_core_1stage.v ./hdl/sodor1_rtl/sodor_mem_model.sv
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vsodor_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -O0 -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vsodor_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o sodor1_cov
	nm sodor1_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir sodor1_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -I./hdl/include -DSIZE_OF_THE_BUS=32 ./hdl/sodor1_rtl/sodor_top.v ./hdl/sodor1_rtl/sodor_core_1stage.v ./hdl/sodor1_rtl/sodor_mem_model.sv
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vsodor_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -O0 -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vsodor_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o sodor1_cov
