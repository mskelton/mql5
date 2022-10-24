#!/bin/bash

for i in $(find IncludeOriginal/Math -name '*.mqh'); do
	# for i in $(find IncludeOriginal -name 'ap.mqh'); do
	echo "Cleaning $i..."
	node ./scripts/cleanup.mjs $i
	clang-format -i $i
done

# find Include -name '*.mqh' | sed 's/Include\//#include </' | sed 's/$/>/'
