#!/usr/bin/env ruby
# frozen_string_literal: true

# Day 5
module BinaryBoarding
  # Represents a seat
  class Seat
    DECODE = { F: 0, B: 1, L: 0, R: 1 }.freeze
    ROW_WIDTH = 8

    def self.decode(code)
      bits = code.chomp
        .each_char
        .lazy
        .reverse_each
        .map(&:upcase)
        .map(&:to_sym)
        .map { |char| DECODE.fetch(char) }

      new(bits)
    end

    def initialize(bits)
      @bits = bits
    end

    def id
      @id ||= @bits
        .each_with_index
        .map { |bit, index| bit * (2**index) }
        .sum
    end

    def row
      @row ||= id / ROW_WIDTH
    end

    def column
      @column ||= id % ROW_WIDTH
    end
  end
end
