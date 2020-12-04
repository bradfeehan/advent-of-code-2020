#!/usr/bin/env ruby
# frozen_string_literal: true

verbose = false

DEFAULT_SLOPE_X = 3
DEFAULT_SLOPE_Y = 1
slope = { x: DEFAULT_SLOPE_X, y: DEFAULT_SLOPE_Y }

while (index = ARGV.index('--verbose'))
  ARGV.delete_at(index)
  verbose = true
end

while (index = ARGV.index('--slope'))
  ARGV.delete_at(index)
  slope_description = ARGV.delete_at(index)
  slope_components = slope_description.split(',')
  slope_components = [slope_components[0], 1] if slope_components.count == 1
  slope = { x: Integer(slope_components[0]), y: Integer(slope_components[1]) }
end

puts "Slope: #{slope.inspect}" if verbose

width = ARGF.each_char.lazy.find_index("\n")

puts "Width: #{width}" if verbose

ARGF.rewind

row = 0
count = 0
until ARGF.closed? || ARGF.eof?
  col_offset = ((row * slope[:x]) % width)
  row_offset = (row * slope[:y] * (width + 1))
  pos = col_offset + row_offset
  ARGF.seek(pos)
  row += 1
  count += 1 if ARGF.getc == '#'
end

puts "Trees encountered: #{count}"
