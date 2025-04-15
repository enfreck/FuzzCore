include ../.env

CC = gcc
CFLAGS = -g -fPIC -I$(AFL_PATH)/include
LDFLAGS = -shared

mutator_sodor1: ./sodor1/custom_mutator_riscv.c ./sodor1/custom_mutator_riscv.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./sodor1/custom_mutator_riscv.c -o ./sodor1/mutator_sodor1.so

mutator_sodor3: ./sodor3/custom_mutator_riscv.c ./sodor3/custom_mutator_riscv.h
	$(CC) $(CFLAGS) $(LDFLAGS)  ./sodor3/custom_mutator_riscv.c -o ./sodor3/mutator_sodor3.so

mutator_sodor5: ./sodor5/custom_mutator_riscv.c ./sodor5/custom_mutator_riscv.h
	$(CC) $(CFLAGS) $(LDFLAGS)  ./sodor5/custom_mutator_riscv.c -o ./sodor5/mutator_sodor5.so

mutator_picorv32: ./picorv32/custom_mutator_riscv.c ./picorv32/custom_mutator_riscv.h
	$(CC) $(CFLAGS) $(LDFLAGS)  ./picorv32/custom_mutator_riscv.c -o ./picorv32/mutator_picorv32.so

mutator_mor1kx: ./mor1kx/custom_mutator_openrisc.c ./mor1kx/custom_mutator_openrisc.h
	$(CC) $(CFLAGS) $(LDFLAGS)  ./mor1kx/custom_mutator_openrisc.c -o ./mor1kx/mutator_mor1kx.so

mutator_ridecore: ./ridecore/custom_mutator_RISCV_ridecore.c ./ridecore/custom_mutator_RISCV_ridecore.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./ridecore/custom_mutator_RISCV_ridecore.c -o ./ridecore/mutator_ridecore.so

mutator_biriscv: ./biriscv/custom_mutator_RISCV_biriscv.c ./biriscv/custom_mutator_RISCV_biriscv.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./biriscv/custom_mutator_RISCV_biriscv.c -o ./biriscv/mutator_biriscv.so

mutator_rv32: ./rv32im/custom_mutator_RISCV_rv32.c ./rv32im/custom_mutator_RISCV_rv32.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./rv32im/custom_mutator_RISCV_rv32.c -o ./rv32im/mutator_rv32.so

mutator_falco: ./falco/custom_mutator_RISCV_falco.c ./falco/custom_mutator_RISCV_falco.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./falco/custom_mutator_RISCV_falco.c -o ./falco/mutator_falco.so

mutator_aquila: ./aquila/custom_mutator_RISCV_aquila.c ./aquila/custom_mutator_RISCV_aquila.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./aquila/custom_mutator_RISCV_aquila.c -o ./aquila/mutator_aquila.so

mutator_ssrv: ./ssrv/custom_mutator_RISCV_ssrv.c ./ssrv/custom_mutator_RISCV_ssrv.h
	$(CC) $(CFLAGS) $(LDFLAGS) ./ssrv/custom_mutator_RISCV_ssrv.c -o ./ssrv/mutator_ssrv.so

