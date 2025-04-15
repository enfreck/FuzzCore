#!/bin/bash

fill_seed() {

	local nop_num=$1

	echo -n "13 " >> ./input_nop_${nop_num}/input.hex

}

nop_count=40000000

mkdir -p ./input_nop_${nop_count}
touch ./input_nop_${nop_count}/input.hex

for i in $(seq 1 ${nop_count}); do
	fill_seed ${nop_count}
done
