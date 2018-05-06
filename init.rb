require './utils/pretty_printer'
require './controllers/minesweeper_controller'

class Init
  def self.execute
    width = 4
    height = 4
    num_mines = 1
    game = Minesweeper.new(width, height, num_mines)

    while game.still_playing?
      PrettyPrinter.print_matrix(game.matrix)

      puts 'Digite 0 para revelar uma célula, ou 1 para adicionar uma bandeira'
      option = gets.to_i

      if option == 0
        MinesweeperController.cell_reveal(game)
      else option == 1
        MinesweeperController.add_flag(game)
      end
    end

    puts 'Fim do jogo!'
    if game.victory?
      puts 'Você venceu!'
    else
      puts 'Você perdeu! As minas eram:'
      # PrettyPrinter.new.print(game.board_state(xray: true))
    end
  end
end

Init.execute


