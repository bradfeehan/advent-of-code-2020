#!/usr/bin/env ruby
# frozen_string_literal: true

PATTERN = /\A(\d+)\s*-\s*(\d+)\s+(.)\s*:\s+(.+)\z/.freeze

STRATEGIES = {
  old: ->(min, max, c, pass) { (min..max).include? pass.count(c) },
  new: ->(pos1, pos2, c, pass) { [pos1, pos2].one? { |i| pass[i - 1] == c } },
}.freeze

verbose = false
strategy_name = :old

while (index = ARGV.index('--verbose'))
  ARGV.delete_at(index)
  verbose = true
end

while (index = ARGV.index('--strategy'))
  ARGV.delete_at(index)
  strategy_name = ARGV.delete_at(index).to_sym
end

def valid?(line, strategy)
  match_data = PATTERN.match(line.chomp)
  raise "Invalid format line: '#{line.chomp}'" if match_data.nil?

  captures = match_data.captures
  strategy.call(Integer(captures[0]), Integer(captures[1]), captures[2], captures[3])
end

strategy = STRATEGIES.fetch(strategy_name)
valid, invalid = ARGF.each_line.partition { |line| valid?(line, strategy) }

puts "Valid passwords: #{valid.count}"
puts "Invalid passwords: #{invalid.count}"
puts "Total: #{valid.count + invalid.count}"

puts "\nInvalid:\n\n", invalid if verbose
