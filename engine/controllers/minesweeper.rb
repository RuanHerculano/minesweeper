require './engine/models/minesweeper'
require './engine/utils/pretty_printer'
require './engine/inputs/console'

module Controllers
  class Minesweeper
    def self.add_flag(game)
      line, column = Inputs::Console.coordenate_input_params
      game.flag(line, column)
    end

    def self.cell_reveal(game)
      line, column = Inputs::Console.coordenate_input_params

      game.play(line, column)
    end

    def self.execute
      lines, columns, quantity_mines = Inputs::Console.matrix_input_params
      game = Models::Minesweeper.new(lines, columns, quantity_mines)

      while game.still_playing?
        Utils::PrettyPrinter.print_matrix(game.matrix)

        option = Inputs::Console.option_input_param

        if option == 0
          cell_reveal(game)
        elsif option == 1
          add_flag(game)
        else
          puts 'Opção inválida'
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
end
