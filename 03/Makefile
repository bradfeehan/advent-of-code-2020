all: part1 part2

part1:
	time ./toboggan.rb input.txt

part2:
	time for slope in 1,1 3,1 5,1 7,1 1,2; do \
		./toboggan.rb --slope "$$slope" input.txt | sed 's/^Trees encountered: //';\
	done | awk 'BEGIN { product = 1; } { product *= $$1; } END { print "Product: " product; }'

.PHONY: all
