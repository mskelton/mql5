lint:
	@clang-format --dry-run $(shell find Include -name *.mqh)

tidy:
	@clang-format -i $(shell find Include -name *.mqh)

test:
	@clang -IInclude --include=Core/MQL5.mqh -std=c++11 -xc++ -Wno-write-strings -fsyntax-only Test.mq5
