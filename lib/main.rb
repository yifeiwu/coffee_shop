# frozen_string_literal: true

# Shell entrypoint
# Given args [prices, order, payments], print out total, balance paid and balance owed

$LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
require 'coffee_app'

CoffeeApp.call(ARGV[0], ARGV[1], ARGV[2])
