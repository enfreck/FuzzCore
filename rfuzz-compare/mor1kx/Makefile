VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
TOP_MODULE=mor1kx

VERILATOR_COMMAND= --cc --top-module $(TOP_MODULE) ./hdl/mor1kx.sv -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-REDEFMACRO -Wno-PINMISSING -Wno-DECLFILENAME -Wno-VARHIDDEN
CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping"
VERILATOR_FLAGS= -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -std=c++11 -Wall -DIS_VANILLA -DSYNTHESIS -DTOPLEVEL_NAME=$(TOP_MODULE) -g -I$(RISCV)/include -O0 -DSTOP_COND=0
LDFLAGS= -pthread -lutil -latomic -DVM_TRACE=0
DENYLIST=/home/user/Research/Fuzz/FuzzCore/rfuzz-compare/mor1kx/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/rfuzz-compare/mor1kx/lists/allowlist.txt

#Compile for Rfuzz testing

mor1kx_rfuzz:
	$(VERILATOR_ROOT)/bin/verilator $(VERILATOR_COMMAND)
	make CXX=$(CXX) VM_PARALLEL_BUILDS=1 -C obj_dir -f V$(TOP_MODULE).mk
	cd obj_dir && $(CXX) $(VERILATOR_FLAGS) -c  -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(CXX) $(LDFLAGS) -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./obj_dir/V$(TOP_MODULE).cpp ./obj_dir/V$(TOP_MODULE)__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp ./testbench/*.cc -o mor1kx_rfuzz

#Compile for Rfuzz edge calculations

mor1kx_rfuzz_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -DSIZE_OF_THE_BUS=32 ./hdl/mor1kx_top.v ./hdl/core/mor1kx.v -I./hdl/core
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vmor1kx_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench_coverage/toplevel.cc ./obj_dir/Vmor1kx_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o mor1kx_cov
	nm mor1kx_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir mor1kx_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc -DSIZE_OF_THE_BUS=32 ./hdl/mor1kx_top.v ./hdl/core/mor1kx.v -I./hdl/core
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vmor1kx_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench_coverage/toplevel.cc ./obj_dir/Vmor1kx_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o mor1kx_cov