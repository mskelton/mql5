#!/bin/bash

for i in $(find IncludeOriginal -name '*.mqh'); do
	# for i in $(find IncludeOriginal -name 'TerminalInfo.mqh'); do
	echo "Cleaning $i..."
	node ./scripts/cleanup.mjs $i
	clang-format -i $i
done

mkdir -p Include/Core
cp ../magellan/Include/MQL5.mqh Include/Core/MQL5.mqh

# find Include -name '*.mqh' | sed 's/Include\//#include </' | sed 's/$/>/'
