VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS=-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow 
DENYLIST=/home/user/Research/Fuzz/FuzzCore/cores/aquila/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/cores/aquila/lists/allowlist.txt
V_FLAGS=-Wno-WIDTHEXPAND -Wno-INITIALDLY -Wno-COMBDLY -Wno-CASEOVERLAP -Wno-UNSIGNED -Wno-WIDTHTRUNC

# Compile for fuzzing run

aquila_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -I./hdl/include ./hdl/include/csr_file.v -I./hdl/mem_model -DSIZE_OF_THE_BUS=32 ./hdl/aquila_top.v --top-module aquila_top 
	AFL_LLVM_ALLOWLIST=$(ALLOWLIST) make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vaquila_top.mk 
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	AFL_LLVM_ALLOWLIST=$(ALLOWLIST) $(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vaquila_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o aquila_afl

# Compile for inspector gadget edge calculation

aquila_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -I./hdl/include ./hdl/include/csr_file.v -I./hdl/mem_model -DSIZE_OF_THE_BUS=32 ./hdl/aquila_top.v --top-module aquila_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vaquila_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -O0 -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vaquila_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o aquila_cov
	nm aquila_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir aquila_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -I./hdl/include ./hdl/include/csr_file.v -I./hdl/mem_model -DSIZE_OF_THE_BUS=32 ./hdl/aquila_top.v --top-module aquila_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vaquila_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -O0 -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./c_tests/core_clk_rst.cc ./obj_dir/Vaquila_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o aquila_cov