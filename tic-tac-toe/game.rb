require "./player"
require "./board"

include Board

puts "This is a tic-toc-toe game. Please, type in your name:"
name = Kernel.gets

player = Player.new(name);
puts "Your name is #{player.name}"
#puts "Your name is #{player.name}"
#puts name
#puts print_board
#player = Player.new("Artem")
#puts player
