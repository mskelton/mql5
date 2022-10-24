lint:
	@clang-format --dry-run $(shell find . -name *.mqh)

tidy:
	@clang-format -i $(shell find . -name *.mqh)

test:
	@clang -IInclude --include=Core/MQL5.mqh -std=c++11 -xc++ -Wno-write-strings -fsyntax-only Test.mq5
