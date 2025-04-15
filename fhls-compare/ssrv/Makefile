VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS=-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
DENYLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/ssrv/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/ssrv/lists/allowlist.txt

V_FLAGS = -Wno-WIDTHEXPAND -Wno-ASCRANGE -Wno-CASEINCOMPLETE -Wno-MULTIDRIVEN -Wno-UNOPTFLAT

CORE_DIR=./hdl/include

#Compile for FHLS fuzz testing

ssrv_fhls_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -I$(CORE_DIR)/core -I$(CORE_DIR)/core/primitives $(CORE_DIR)/core/primitives/scr1_reset_cells.sv -I$(CORE_DIR)/includes -I$(CORE_DIR)/pipeline -I$(CORE_DIR)/tb ./hdl/scr1_core_top.sv --top-module scr1_core_top
	make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vscr1_core_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel.cc ./obj_dir/Vscr1_core_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ssrv_fhls

#Compile for FHLS edge calculations

ssrv_fhls_cov:
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -I$(CORE_DIR)/core -I$(CORE_DIR)/core/primitives $(CORE_DIR)/core/primitives/scr1_reset_cells.sv -I$(CORE_DIR)/includes -I$(CORE_DIR)/pipeline -I$(CORE_DIR)/tb ./hdl/scr1_core_top.sv ./hdl/ssrv_top.v --top-module ssrv_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vssrv_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vssrv_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ssrv_cov
	nm ssrv_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir ssrv_cov
	$(VERILATOR_ROOT)/bin/verilator -O0 --cc $(V_FLAGS) -I$(CORE_DIR)/core -I$(CORE_DIR)/core/primitives $(CORE_DIR)/core/primitives/scr1_reset_cells.sv -I$(CORE_DIR)/includes -I$(CORE_DIR)/pipeline -I$(CORE_DIR)/tb ./hdl/scr1_core_top.sv ./hdl/ssrv_top.v --top-module ssrv_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vssrv_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vssrv_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o ssrv_cov