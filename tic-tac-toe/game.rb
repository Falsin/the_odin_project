require 'colorize'
require "./player"
require "./session"

puts "This is a tic-toc-toe game. Please, type in your name:"
name = Kernel.gets.chomp

player = Player.new(name)
bot = Player.new('Bot')
session = Session.new(player, bot)
puts "Your name is #{player.name}".green

begin
  puts "Select your symbol (X or O):"
  symbol = Kernel.gets.match(/[XO]/).to_s.chomp

  raise ArgumentError.new "You should select X or Y. PLease, try again." if symbol.empty?

  session.select_symbol(player, symbol)
  session.select_symbol(bot)

  puts "Your symbol is #{player.symbol}".green

  session.start_game
rescue StandardError => e
  puts e.message.red
  retry
end
