require './engine/utils/pretty_printer'
require './engine/controllers/minesweeper'

class Init
  def self.execute
    puts 'Digite a quantidade de linhas da matriz'
    lines = gets.to_i
    puts 'Digite a quantidade de colunas da matriz'
    columns = gets.to_i
    puts 'Digite a quantidade de minas'
    quantity_mines = gets.to_i

    game = Models::Minesweeper.new(lines, columns, quantity_mines)

    while game.still_playing?
      Utils::PrettyPrinter.print_matrix(game.matrix)

      puts 'Digite 0 para revelar uma célula, ou 1 para adicionar uma bandeira'
      option = gets.to_i

      if option == 0
        Controllers::Minesweeper.cell_reveal(game)
      else option == 1
        Controllers::Minesweeper.add_flag(game)
      end
    end

    puts 'Fim do jogo!'
    if game.victory?
      puts 'Você venceu!'
    else
      puts 'Você perdeu! As minas eram:'
      Utils::PrettyPrinter.print_matrix_end_game(game.matrix)
    end
  end
end

Init.execute
