# here's my string and this is a comment
my_string = "Hello, world!"
pp my_string

require "./goodbye.rb"
require "active_support/all"

pp "What's their name?"

their_name = gets.chomp

puts "Hello, " + their_name + "!"
