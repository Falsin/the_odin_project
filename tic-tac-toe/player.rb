class Player
  attr_reader :name
  attr_accessor :symbol, :selected_symbols

  def initialize(name)
    @name = name
    @selected_symbols = []
  end

  def make_move(cells)
    is_valid_position = false

    until is_valid_position
      position = Kernel.gets.match(/\d/).to_s.to_i

      cells.each do |item|
        next unless item.include?(position)

        if item[position] != " "
          puts "#{position} is already occupied".red
        else
          item[position] = symbol
          selected_symbols.push(position)
          is_valid_position = true
        end
        break
      end
    end
  end
end
