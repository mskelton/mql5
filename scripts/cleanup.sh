#!/bin/bash

for i in $(find IncludeOriginal -name '*.mqh'); do
	# for i in $(find IncludeOriginal -name 'Queue.mqh'); do
	echo "Cleaning $i..."
	node ./scripts/cleanup.mjs $i
	clang-format -i $i
done

# find Include -name '*.mqh' | sed 's/Include\//#include </' | sed 's/$/>/'
