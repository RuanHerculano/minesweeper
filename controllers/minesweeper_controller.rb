require './models/minesweeper'

class MinesweeperController
  def self.add_flag(game)
    puts 'Digite a coordenada da linha'
    line = gets.to_i

    puts 'Digite a coordenada da coluna'
    column = gets.to_i

    game.flag(line, column)
  end

  def self.cell_reveal(game)
    puts 'Digite a coordenada da linha'
    line = gets.to_i

    puts 'Digite a coordenada da coluna'
    column = gets.to_i

    game.play(line, column)
  end
end
