VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS=-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
DENYLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/ridecore/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/ridecore/lists/allowlist.txt

MD=./hdl/include
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

#Compile for FHLS fuzz testing

ridecore_fhls_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(OBJS) -I./hdl/include -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-REDEFMACRO -Wno-MULTIDRIVEN -Wno-PINMISSING -Wno-DECLFILENAME -Wno-VARHIDDEN -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-UNDRIVEN -Wno-GENUNNAMED --top-module pipeline
	make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vpipeline.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel.cc ./obj_dir/Vpipeline__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ridecore_fhls

#Compile for FHLS edge calculations

ridecore_fhls_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(OBJS) -I./hdl/include ./hdl/ridecore_top -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-MULTIDRIVEN -Wno-REDEFMACRO -Wno-PINMISSING -Wno-DECLFILENAME -Wno-VARHIDDEN -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-UNDRIVEN -Wno-GENUNNAMED --top-module ridecore_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vridecore_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vridecore_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ridecore_cov
	nm ridecore_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir ridecore_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(OBJS) -I./hdl/include ./hdl/ridecore_top -Wall -Wno-PINCONNECTEMPTY -Wno-fatal -Wno-BLKANDNBLK -Wno-MULTIDRIVEN -Wno-REDEFMACRO -Wno-PINMISSING -Wno-DECLFILENAME -Wno-VARHIDDEN -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-UNDRIVEN -Wno-GENUNNAMED --top-module ridecore_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vridecore_top.mk 
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vridecore_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ridecore_cov
