#!/bin/bash

for i in $(find IncludeOriginal -name '*.mqh'); do
	# for i in $(find IncludeOriginal -name 'TerminalInfo.mqh'); do
	echo "Cleaning $i..."
	node ./scripts/cleanup.mjs $i
	clang-format -i $i
done

# mkdir -p Include/Core
cp -r ../magellan/Include/Core Include/

# find Include -name '*.mqh' | sed 's/Include\//#include </' | sed 's/$/>/'
