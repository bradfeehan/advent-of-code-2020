#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

target = 2020
count = 2
strategy = :bruteforce

while (index = ARGV.index('--triples'))
  ARGV.delete_at(index)
  count = 3
end

while (index = ARGV.index('--strategy'))
  ARGV.delete_at(index)
  strategy = ARGV.delete_at(index).to_sym
end

while (index = ARGV.index('--target'))
  ARGV.delete_at(index)
  target = Integer(ARGV.delete_at(index))
end

numbers = Set.new
ARGF.each_line { |number| numbers.add(Integer(number)) }

puts "Total #{numbers.to_a.combination(count).count} #{count}-tuples"

case strategy
when :bruteforce
  tuples = numbers.to_a.combination(count).select { |tuple| tuple.sum == target }
when :smart
  def combinations_with_sum(array, target:, count:)
    return (array.include?(target) ? [target] : []) if count.zero?

    array
      .map { |n| [n, *combinations_with_sum(array - [n], target: target - n, count: count - 1)] }
      .reject { |_head, *rest| rest.none? }
  end

  tuples = combinations_with_sum(numbers, target: target, count: count - 1)
else
  raise "Unknown strategy '#{strategy}'"
end

tuples.map!(&:sort)

puts "Narrowed down to #{tuples.count}"

unique = tuples.uniq
puts "Of these, #{unique.count} tuples are unique"
puts "#{count}-tuples with sum 2020: #{unique.inspect}"
puts "Product: #{unique.map { |elements| elements.reduce(1, &:*) }}"
