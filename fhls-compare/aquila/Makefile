VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS=-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
DENYLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/aquila/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/aquila/lists/allowlist.txt
V_FLAGS=-Wno-WIDTHEXPAND -Wno-INITIALDLY -Wno-COMBDLY -Wno-CASEOVERLAP -Wno-UNSIGNED -Wno-WIDTHTRUNC -Wno-PINMISSING

#Compile for Fuzzing Hardware Like Software Testing

aquila_fhls_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 $(V_FLAGS) --cc -I./hdl/include ./hdl/include/csr_file.v ./hdl/core_top --top-module core_top
	make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vcore_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel.cc ./obj_dir/Vcore_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o aquila_fhls

#Compile for Edge Calculations for Fuzzing Hardware Like Software

aquila_fhls_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 $(V_FLAGS) --cc -I./hdl/include ./hdl/include/csr_file.v ./hdl/core_top ./hdl/aquila_top.v --top-module aquila_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vaquila_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vaquila_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o aquila_cov
	nm aquila_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir aquila_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 $(V_FLAGS) --cc -I./hdl/include ./hdl/include/csr_file.v ./hdl/core_top ./hdl/aquila_top.v --top-module aquila_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vaquila_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vaquila_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o aquila_cov
