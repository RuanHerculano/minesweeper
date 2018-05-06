module Utils
  class PrettyPrinter
    def self.print_matrix(matrix)
      quantity_lines   = matrix.count
      quantity_columns = matrix.first.count

      for line in 0...quantity_lines
        for column in 0...quantity_columns
          print '[ '

          unless matrix[line][column].is_clear
            print '.'
          else
            print matrix[line][column].arround_mines
          end

          print ' ]'
        end

        puts
      end
    end

    def self.print_matrix_end_game(matrix)
      quantity_lines   = matrix.count
      quantity_columns = matrix.first.count

      for line in 0...quantity_lines
        for column in 0...quantity_columns
          print '[ '

          if matrix[line][column].content == '#'
            print '#'
          else
            print matrix[line][column].arround_mines
          end

          print ' ]'
        end

        puts
      end
    end
  end
end
