module GameUtilits
  def switch_turn(turn)
    keys = symbols.keys
    turn == keys[0] ? keys[1] : keys[0]
  end

  def print_board
    col_separator, row_separator = " | ", "\n--+---+--\n"

    col_creator = -> (obj) { obj.values.join(col_separator) }
    puts @cells.map(&col_creator).join(row_separator)
  end

  def play
    random_num = Random.new.rand(symbols.size)
    current_symbol = symbols.keys[random_num]
    current_player = symbols[current_symbol]
    is_complete = false

    until is_complete
      puts "#{current_player.name} make your move:"
      current_player.make_move(cells)
      print_board
      is_complete = complete?(current_player)
      current_symbol = switch_turn(current_symbol)
      current_player = symbols[current_symbol]
    end
  end

  def select_symbol(player, symbol = nil)
    raise ArgumentError.new "#{symbol} is already used" if symbols.include?(symbol)

    if symbol
      symbols[symbol.intern] = player
      player.symbol = symbol
    else
      key, * = symbols.rassoc(nil)[0]
      symbols[key] = player
      player.symbol = key.to_s
    end
  end

  def complete?(current_player)
    check_row = -> (item) { item.values.all?(current_player.symbol) }
    check_cell = -> (cell) { cells.dig(*cell) == current_player.symbol }
    check_collection = -> (row) { row.all?(&check_cell) }

    if cells.any?(&check_row) || cells_collection.any?(&check_collection)
      self.who_is_winner = current_player
      score[current_player] += 1
      return true
    end

    cells.none? { |row| row.values.any?(" ") }
  end

  def start_game
    loop do
      puts "This is initial board:"
      print_board
      play

      if who_is_winner
        puts "#{who_is_winner.name} won!"
        puts "#{player_1.name}: #{score[player_1]}\n#{player_2.name}: #{score[player_2]}"
        reset_game
      end
    end
  end

  def reset_game
    @cells.map! { |hash| hash.transform_values { " " } }
    player_1.selected_symbols = []
    player_2.selected_symbols = []

    self.who_is_winner = nil
  end
end
