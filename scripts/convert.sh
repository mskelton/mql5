#!/bin/bash

rm -rf IncludeOriginal/
cp -r ~/Library/Application\ Support/MetaTrader\ 5/Bottles/metatrader5/drive_c/Program\ Files/MetaTrader\ 5/MQL5/Include IncludeOriginal

# Remove images
find IncludeOriginal -name '*.bmp' -o -name '*.hlsl' -exec rm {} +

for i in $(find IncludeOriginal -name '*.mqh'); do
	# Remove comments
	LC_ALL=C sed -i '' 's/\/\/.*//' $i

	# # Convert to utf8 and unix line endings
	dos2unix -n $i $i

	# Some files are in latin-1 and require manual conversion
	content=$(iconv -f ISO-8859-1 -t UTF-8 $i)
	echo -e "$content" >$i

	# Remove comments again
	sed -i '' 's/\/\/.*//' $i

	# Remove resources and properties
	sed -i '' 's/^#resource .*//' $i
	sed -i '' 's/^#import .*//' $i
	sed -i '' 's/^#property .*//' $i

	# Add #ifndef
	h_name=$(echo $i | xargs basename | sed 's/\([a-z]\)\([A-Z]\)/\1_\2/g' | sed 's/\.mqh/_H/' | tr '[:lower:]' '[:upper:]')

	sed -i '' "1s/.*/#ifndef $h_name/" $i
	sed -i '' "2s/.*/#define $h_name/" $i
	echo -e "\n#endif" >>$i

	clang-format -style='{AllowShortFunctionsOnASingleLine: None, BinPackArguments: true, BinPackParameters: true, AlwaysBreakAfterDefinitionReturnType: None, PenaltyReturnTypeOnItsOwnLine: 99999}' -i $i

	# Use forward slashes in include path
	sed -i '' '/^#include/s/\\\\/\//g' $i
done
