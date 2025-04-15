VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
TOP_MODULE=pipeline

V_FLAGS= -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-REDEFMACRO -Wno-PINMISSING -Wno-DECLFILENAME -Wno-VARHIDDEN -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-UNDRIVEN -Wno-GENUNNAMED
VERILATOR_COMMAND= --cc --top-module $(TOP_MODULE) ./hdl/ridecore.sv $(V_FLAGS)
CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping"
CXX_FLAGS="-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow"
VERILATOR_FLAGS= -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -std=c++11 -Wall -DIS_VANILLA -DSYNTHESIS -DTOPLEVEL_NAME=$(TOP_MODULE) -g -I$(RISCV)/include -O0 -DSTOP_COND=0
LDFLAGS= -pthread -lutil -latomic -DVM_TRACE=0
DENYLIST=/home/user/Research/Fuzz/FuzzCore/rfuzz-compare/ridecore/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/rfuzz-compare/ridecore/lists/allowlist.txt

MD=./hdl/core
OBJS = $(MD)/alloc_issue_ino.v \
       $(MD)/alu.v \
       $(MD)/arf.v \
       $(MD)/brimm_gen.v \
       $(MD)/btb.v \
       $(MD)/decoder.v \
       $(MD)/define.v \
       $(MD)/dmem.v \
       $(MD)/dualport_ram.v \
       $(MD)/exunit_alu.v \
       $(MD)/exunit_branch.v \
       $(MD)/exunit_ldst.v \
       $(MD)/exunit_mul.v \
       $(MD)/gshare.v \
       $(MD)/imem.v \
       $(MD)/imem_outa.v \
       $(MD)/imm_gen.v \
       $(MD)/mpft.v \
       $(MD)/multiplier.v \
       $(MD)/pipeline_if.v \
       $(MD)/pipeline.v \
       $(MD)/prioenc.v \
       $(MD)/ram_sync_nolatch.v \
       $(MD)/ram_sync.v \
       $(MD)/reorderbuf.v \
       $(MD)/rrf_freelistmanager.v \
       $(MD)/rrf.v \
       $(MD)/rs_alu.v \
       $(MD)/rs_branch.v \
       $(MD)/rs_ldst.v \
       $(MD)/rs_mul.v \
       $(MD)/rs_reqgen.v \
       $(MD)/src_manager.v \
       $(MD)/srcopr_manager.v \
       $(MD)/srcsel.v \
       $(MD)/tag_generator.v \
       $(MD)/oldest_finder.v \
       $(MD)/storebuf.v \
       $(MD)/search_be.v

#Compile for RFuzz testing

ridecore_rfuzz:
	$(VERILATOR_ROOT)/bin/verilator $(VERILATOR_COMMAND)
	make CXX=$(CXX) VM_PARALLEL_BUILDS=1 -C obj_dir -f V$(TOP_MODULE).mk
	cd obj_dir && $(CXX) $(VERILATOR_FLAGS) -c  -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(CXX) $(LDFLAGS) -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./obj_dir/V$(TOP_MODULE).cpp ./obj_dir/V$(TOP_MODULE)__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp ./testbench/*.cc -o ridecore_rfuzz

#Compile for RFuzz edge calculations

ridecore_rfuzz_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) $(OBJS) -I./hdl/core ./hdl/ridecore_top  --top-module ridecore_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vridecore_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench_coverage/toplevel.cc ./obj_dir/Vridecore_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ridecore_cov
	nm ridecore_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir ridecore_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) $(OBJS) -I./hdl/core ./hdl/ridecore_top  --top-module ridecore_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vridecore_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench_coverage/toplevel.cc ./obj_dir/Vridecore_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ridecore_cov