#!/usr/bin/env ruby
# frozen_string_literal: true

require 'active_model'
require 'active_support/core_ext/hash/keys'

I18n.available_locales = %i[en]
I18n.default_locale = :en
I18n.backend.translations[:en] = {
  activemodel: {
    models: {
      'passport/passport': 'Passport',
    },
    attributes: {
      'passport/passport': {
        byr: 'Birth Year',
        iyr: 'Issue Year',
        eyr: 'Expiration Year',
        hgt: 'Height',
        hcl: 'Hair Color',
        ecl: 'Eye Color',
        pid: 'Passport ID',
        cid: 'Country ID',
      },
    },
  },
}

# Day 4
module Passport
  def self.strategy
    @strategy ||= begin
      strategy = :presence
      while (index = ARGV.index('--strategy'))
        ARGV.delete_at(index)
        strategy = ARGV.delete_at(index).to_sym
      end
      strategy
    end
  end

  class Passport
    # a number followed by either cm or in with ranges for both
    class HeightValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        case value
        when /\A(\d+)cm\z/
          range_validator(attribute, :cm).validate_each(record, attribute, Regexp.last_match(1))
        when /\A(\d+)in\z/
          range_validator(attribute, :in).validate_each(record, attribute, Regexp.last_match(1))
        else
          record.errors.add(attribute, (options[:message] || default_message))
        end
      end

      private

      def range_validator(attribute, type)
        ActiveModel::Validations::NumericalityValidator.new(
          greater_than_or_equal_to: options[type].begin,
          less_than_or_equal_to: options[type].end,
          only_integer: true,
          attributes: [attribute]
        )
      end

      def default_message
        'must be a a number followed by either cm or in'
      end

      def default_range
        0..1
      end
    end
  end

  # Represents a passport object
  class Passport
    include ActiveModel::Model

    attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

    case ::Passport.strategy
    when :presence
      validates_presence_of :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid
    when :strict
      validates_presence_of :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid

      # byr (Birth Year) - four digits; at least 1920 and at most 2002.
      # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
      # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
      {
        byr: 1920..2002,
        iyr: 2010..2020,
        eyr: 2020..2030,
      }.each do |attribute_name, range|
        validates attribute_name, numericality: {
          only_integer: true,
          greater_than_or_equal_to: range.begin,
          less_than_or_equal_to: range.end,
        }
      end

      # hgt (Height) - a number followed by either cm or in:
      # If cm, the number must be at least 150 and at most 193.
      # If in, the number must be at least 59 and at most 76.
      validates :hgt, height: { cm: 150..193, in: 59..76 }

      # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
      validates :hcl, format: {
        with: /\A#[0-9a-f]{6}\z/i,
        message: 'must be a # followed by exactly six characters 0-9 or a-f',
      }

      # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
      validates :ecl, inclusion: { in: %w[amb blu brn gry grn hzl oth] }

      # pid (Passport ID) - a nine-digit number, including leading zeroes.
      validates :pid, format: {
        with: /\A\d{9}\z/i,
        message: 'must be a nine-digit number, including leading zeroes',
      }
    end
  end
end

record = []
total = 1
valid = 0

def valid?(record)
  tuples = record.join(' ').split(/\s+/)
  hash = Hash[tuples.map { |tuple| tuple.split(':') }].symbolize_keys
  passport = Passport::Passport.new(**hash)
  passport.valid?
end

ARGF.each_line do |line|
  if line.chomp.empty?
    valid += 1 if valid?(record)
    total += 1
    record = []
  else
    record << line
  end
end

valid += 1 if valid?(record)

puts "Total: #{total}"
puts "Valid: #{valid}"
