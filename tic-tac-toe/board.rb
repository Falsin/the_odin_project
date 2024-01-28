module Board
  def print_board
    col_separator, row_separator = " | ", "\n--+---+--\n"
    cells = [
      { 1 => " ", 2 => " ", 3 => " " },
      { 4 => " ", 5 => " ", 6 => " " },
      { 7 => " ", 8 => " ", 9 => " " }
    ]

    col_creator = -> (obj) { obj.values.join(col_separator) }
    cells.map(&col_creator).join(row_separator)
  end
end
