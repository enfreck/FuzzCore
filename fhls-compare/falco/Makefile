VERILATOR_ROOT=/home/user/Research/Files/verilator-5.016
AFL_PATH=/home/user/Research/Files/AFLplusplus
COV_PATH=/home/user/Research/Fuzz/inspector-gadget
CXX=clang++
CXX_FLAGS=-I.  -MMD -I$(VERILATOR_ROOT)/include -I$(VERILATOR_ROOT)/include/vltstd -DVM_COVERAGE=0 -DVM_SC=0 -DVM_TRACE=0 -faligned-new -fcf-protection=none -Wno-bool-operation -Wno-sign-compare -Wno-uninitialized -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-shadow
DENYLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/falco/lists/denylist.txt
ALLOWLIST=/home/user/Research/Fuzz/FuzzCore/fhls-compare/falco/lists/allowlist.txt


TYPES = \
    ./hdl/include/Include/Falco_pkg.sv

CORE_MODULES = \
	./hdl/include/issue_queue/int_balance_picker.sv \
	./hdl/include/issue_queue/int_issue_queue.sv \
	./hdl/include/issue_queue/int_rob_tag_replay_unit.sv \
	./hdl/include/issue_queue/empty_entry_finder.sv \
	./hdl/include/issue_queue/empty_entry_finder8_wrapper.sv \
	./hdl/include/Cache/L1_cache_pkg.sv \
	./hdl/include/Commit/reorder_buffer.sv \
	./hdl/include/LoadStoreUnit/combine_data_unit.sv \
	./hdl/include/register_read/register_read.sv \
	./hdl/include/issue_queue/mem_replay_unit.sv \
	./hdl/include/execute/ALU.sv \
	./hdl/include/Instruction_Decode/ID_stage_io.sv \
	./hdl/include/execute/exe_stage_io.sv \
	./hdl/include/Rename_Dispatch/register_map_table.sv \
	./hdl/include/Rename_Dispatch/RNDS_stage.sv \
	./hdl/include/Address_Generate_stage/AGU_io.sv \
	./hdl/include/LoadStoreUnit/load_forward_unit.sv \
	./hdl/include/pipeline_recovery/pipeline_control_recovery_io.sv \
	./hdl/include/execute/fast_mul.sv \
	./hdl/include/issue_queue/int_iq_ctr_rob_tag_balance_selector.sv \
	./hdl/include/execute/divider.sv \
	./hdl/include/Instruction_Fetch/IF_stage.sv \
	./hdl/include/Instruction_Fetch/gshare_branch_predictor.sv \
	./hdl/include/LoadStoreUnit/load_store_unit_io.sv \
	./hdl/include/issue_queue/int_issue_queue_io.sv \
	./hdl/include/LoadStoreUnit/store_buffer.sv \
	./hdl/include/execute/alu_csr_bc_execute_group.sv \
	./hdl/include/utility/distri_ram2r1w.v \
	./hdl/include/register_read/physical_register_file.sv \
	./hdl/include/LoadStoreUnit/load_buffer_io.sv \
	./hdl/include/issue_queue/mem_iq_balance_selector_wo_store.sv \
	./hdl/include/LoadStoreUnit/last_fetch_store_table.sv \
	./hdl/include/LoadStoreUnit/load_buffer.sv \
	./hdl/include/Commit/committed_map_table.sv \
	./hdl/include/Address_Generate_stage/AGU.sv \
	./hdl/include/Rename_Dispatch/prf_freelist.sv \
	./hdl/include/Rename_Dispatch/busy_list.sv \
	./hdl/include/Rename_Dispatch/rename_dispatch_io.sv \
	./hdl/include/Instruction_Decode/decoder.sv \
	./hdl/include/issue_queue/mem_issue_queue_io.sv \
	./hdl/include/Instruction_Decode/ID_stage.sv \
	./hdl/include/LoadStoreUnit/mem_access.sv \
	./hdl/include/pipeline_recovery/pipeline_control_recovery.sv \
	./hdl/include/Instruction_Fetch/program_counter.sv \
	./hdl/include/Instruction_Fetch/IF_stage_io.sv \
	./hdl/include/LoadStoreUnit/load_store_unit.sv \
	./hdl/include/Commit/commit_stage_io.sv \
	./hdl/include/execute/branch_unit.sv \
	./hdl/include/LoadStoreUnit/store_buffer_io.sv \
	./hdl/include/utility/sram_dual_port.sv \
	./hdl/include/CSR/csr_io.sv \
	./hdl/include/LoadStoreUnit/mem_access_io.sv \
	./hdl/include/execute/alu_muldiv_execute_group.sv \
	./hdl/include/LoadStoreUnit/store_set_id_table.sv \
	./hdl/include/register_read/register_read_io.sv \
	./hdl/include/CSR/csr.sv \
	./hdl/include/issue_queue/mem_issue_queue.sv \
	./hdl/include/Instruction_Fetch/BTB.sv \
	./hdl/falco_top.sv

VERILATOR_DISABLED_WARNING = \
-Wno-WIDTH \
-Wno-INITIALDLY \
-Wno-UNOPTFLAT \
-Wno-UNPACKED \
-Wno-PINCONNECTEMPTY \
-Wno-ASSIGNDLY \
-Wno-DECLFILENAME \
-Wno-VARHIDDEN \
-Wno-UNOPTTHREADS \
-Wno-BLKANDNBLK \
-Wno-PINMISSING \
-Wno-ASCRANGE \
-Wno-UNSIGNED \
-Wno-CASEOVERLAP \
-Wno-CASEINCOMPLETE \
-Wno-COMBDLY \
-Wno-MULTIDRIVEN

 
# Main Verilator options
VERILATOR_OPTION = \
    --cc \
    --assert \
    -sv \
    $(VERILATOR_DISABLED_WARNING) \
    -DSIZE_OF_THE_BUS=32 \
    +incdir+$(TYPES_DIR) \
    +incdir+$(CORE_DIR)/mem_model \
    --compiler clang \
    --trace-structs \
    --no-trace-params

#Compile for FHLS fuzz testing

falco_fhls_afl:
	$(VERILATOR_ROOT)/bin/verilator -O0 $(VERILATOR_OPTION) $(TYPES) $(CORE_MODULES) ./hdl/core_top.sv --top-module core_top
	make CXX=$(AFL_PATH)/afl-clang-fast++ -C obj_dir -f Vcore_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS)  -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(AFL_PATH)/afl-clang-fast++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel.cc ./obj_dir/Vcore_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o falco_fhls

#Compile for FHLS edge calculations

falco_fhls_cov:
	$(VERILATOR_ROOT)/bin/verilator --O0 $(VERILATOR_OPTION) $(TYPES) $(CORE_MODULES) ./hdl/core_top.sv --top-module falco_top
	make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vfalco_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	$(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vfalco_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o falco_cov
	nm falco_cov | rev | cut -d' ' -f1 | rev | sed 's/^/fun:/' | grep -vFf $(ALLOWLIST) > $(DENYLIST)
	rm -rf obj_dir falco_cov
	$(VERILATOR_ROOT)/bin/verilator --O0 $(VERILATOR_OPTION) $(TYPES) $(CORE_MODULES) ./hdl/core_top.sv --top-module falco_top
	export AFL_LLVM_DENYLIST=$(DENYLIST) && make CXX=$(COV_PATH)/cov-clang++ -C obj_dir -f Vfalco_top.mk
	cd obj_dir && $(CXX) $(CXX_FLAGS) -c -o verilated.o $(VERILATOR_ROOT)/include/verilated.cpp
	export AFL_LLVM_DENYLIST=$(DENYLIST) && $(COV_PATH)/cov-clang++ -latomic -I$(VERILATOR_ROOT)/include -pthread -I$(VERILATOR_ROOT)/include/vltstd -I./obj_dir ./testbench/toplevel_cov.cc ./obj_dir/Vfalco_top__ALL.a ./obj_dir/verilated.o $(VERILATOR_ROOT)/include/verilated_threads.cpp -o falco_cov