#!/bin/bash

rm -rf Include/
cp -r ../magellan/Include .

for i in $(find . -name '*.bmp'); do
	rm $i
done

for i in $(find . -name '*.mqh'); do
	dos2unix -n $i $i
	content=$(iconv -f ISO-8859-1 -t UTF-8 $i)
	echo -e "$content" >$i
done

# sed -i '' 's/\/\/---.*\n//' $i
# sed -i '' 's/\/\/.*//' $i
