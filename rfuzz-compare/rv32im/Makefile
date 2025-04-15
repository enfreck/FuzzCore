VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
TOP_MODULE=riscv_core

V_FLAGS= -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-REDEFMACRO -Wno-DECLFILENAME -Wno-VARHIDDEN -Wno-WIDTHEXPAND -Wno-INITIALDLY -Wno-COMBDLY -Wno-CASEOVERLAP -Wno-UNSIGNED -Wno-WIDTHTRUNC -Wno-PINMISSING 
VERILATOR_COMMAND= --cc --top-module $(TOP_MODULE) ./hdl/rv32im.sv $(V_FLAGS)
CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping"
CXX_FLAGS="-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow"
VERILATOR_FLAGS= -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -std=c++11 -Wall -DIS_VANILLA -DSYNTHESIS -DTOPLEVEL_NAME=$(TOP_MODULE) -g -I$(RISCV)/include -O0 -DSTOP_COND=0
LDFLAGS= -pthread -lutil -latomic -DVM_TRACE=0
DENYLIST=/home/user/Research/Fuzz/FuzzCore/rfuzz-compare/rv32im/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/rfuzz-compare/rv32im/lists/allowlist.txt

#Compile for RFuzz testing

rv32im_rfuzz:
	$(VERILATOR_ROOT)/bin/verilator $(VERILATOR_COMMAND)
	make CXX=$(CXX) VM_PARALLEL_BUILDS=1 -C obj_dir -f V$(TOP_MODULE).mk
	cd obj_dir && $(CXX) $(VERILATOR_FLAGS) -c  -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(CXX) $(LDFLAGS) -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./obj_dir/V$(TOP_MODULE).cpp ./obj_dir/V$(TOP_MODULE)__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp ./testbench/*.cc -o rv32im_rfuzz

#Compile for Rfuzz edge calculations

rv32im_rfuzz_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 $(V_FLAGS) --cc -DSIZE_OF_THE_BUS=32 -I./hdl/core ./hdl/rv32im_top.v  --top-module rv32im_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vrv32im_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench_coverage/toplevel.cc ./obj_dir/Vrv32im_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o rv32im_cov
	nm rv32im_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir rv32im_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -DSIZE_OF_THE_BUS=32 -I./hdl/core ./hdl/rv32im_top.v --top-module rv32im_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vrv32im_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench_coverage/toplevel.cc ./obj_dir/Vrv32im_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o rv32im_cov