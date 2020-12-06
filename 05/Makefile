all: part1 part2

part1:
	time ruby -r ./seat.rb -e ' \
    puts "Maximum seat ID: " + \
    ARGF.each_line \
      .map { |line| BinaryBoarding::Seat.decode(line).id } \
      .max.to_s \
    ' input.txt

part2:
	time ruby -r set -r ./seat.rb -e ' \
    values = Set.new(0..0b1111111111); \
    ARGF.each_line \
      .map { |line| BinaryBoarding::Seat.decode(line) } \
      .each { |seat| values.delete(seat.id) }; \
    values.subtract(values.map(&:succ) + values.map(&:pred)); \
    puts "Your seat: #{values.to_a.inspect}"' \
  input.txt

.PHONY: all
