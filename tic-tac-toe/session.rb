require "./gameUtilits"

class Session
  include GameUtilits
  attr_accessor :who_is_winner, :cells, :symbols, :cells_collection, :score
  attr_reader :player_1, :player_2

  # while use attr_accessor you should set variable value inside initialize
  # otherwise their value will nil
  def initialize(player_1, player_2)
    @symbols = { X: nil, O: nil }

    @cells_collection = [
      [[0, 1], [1, 4], [2, 7]],
      [[0, 2], [1, 5], [2, 8]],
      [[0, 3], [1, 6], [2, 9]],
      [[0, 1], [1, 5], [2, 9]],
      [[0, 3], [1, 5], [2, 7]]
    ]

    @cells = [
      { 1 => " ", 2 => " ", 3 => " " },
      { 4 => " ", 5 => " ", 6 => " " },
      { 7 => " ", 8 => " ", 9 => " " }
    ]

    @score = {
      player_1 => 0,
      player_2 => 0
    }

    @player_1 = player_1
    @player_2 = player_2
  end
end
