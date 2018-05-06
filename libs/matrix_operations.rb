class MatrixOperations
  def self.build_matrix(width, height, quantity_mines)
    matrix = []

    width.times do
      line = []

      height.times do
        cell = Cell.new('', false, false)
        line.push(cell)
      end

      matrix.push(line)
    end

    matrix_with_mines = insert_mines(matrix, mines_coordinates(width, height, quantity_mines))

    build_quantity_mines_around(matrix_with_mines)
  end

  def self.mines_coordinates(width, height, quantity_mines)
    coordinates = []

    quantity_mines.times do
      coordinate = { width: rand(width), height: rand(height) }

      if !coordinates.include?(coordinate) || coordinates.empty?
        coordinates.push(coordinate)
      end
    end

    coordinates
  end

  def self.insert_mines(matrix, bomb_coordinates)
    bomb_coordinates.each do |bomb_coordinate|
      cell = Cell.new('#', false, false)
      matrix[bomb_coordinate[:width]][bomb_coordinate[:height]] = cell
    end

    matrix
  end

  def self.build_quantity_mines_around(matrix)
    quantity_lines   = matrix.count
    quantity_columns = matrix.first.count

    for line in 0...quantity_lines
      for column in 0...quantity_columns
        arround_mines = 0

        if line == 0 && column == 0
          if matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end
        elsif line == quantity_lines - 1 && column == 0
          if matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end
        elsif line == 0 && column == quantity_columns - 1
          if matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

        elsif line == quantity_lines - 1 && column == quantity_columns - 1
          if matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end
        elsif line == 0
          if matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line][column + 1].content == '#'
            arround_mines += 1
          end
        elsif column == 0
          if matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column].content == '#'
            arround_mines += 1
          end
        elsif line == quantity_lines - 1
          if matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line][column + 1].content == '#'
            arround_mines += 1
          end
        elsif column == quantity_columns - 1
          if matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column].content == '#'
            arround_mines += 1
          end
        else
          if matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

          if matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end
        end

        matrix[line][column].arround_mines = arround_mines
      end
    end

    matrix
  end

  def self.check_arround_cells(matrix, line, column)
    num_unarmed_mines = 0
    quantity_lines   = matrix.count
    quantity_columns = matrix.first.count

    if line == 0 && column == 0
      if matrix[line + 1][column].content == '' &&
        matrix[line][column + 1].content == '' &&
          matrix[line + 1][column + 1].content == ''

        matrix[line + 1][column].is_clear = true
        matrix[line][column + 1].is_clear = true
        matrix[line + 1][column + 1].is_clear = true

        num_unarmed_mines += 3
      end
    elsif line == quantity_lines - 1 && column == 0
      if matrix[line - 1][column].content == '' &&
        matrix[line][column + 1].content == '' &&
          matrix[line - 1][column + 1].content == ''

        matrix[line - 1][column].is_clear = true
        matrix[line][column + 1].is_clear = true
        matrix[line - 1][column + 1].is_clear = true

        num_unarmed_mines += 3
      end
    elsif line == 0 && column == quantity_columns - 1
      if matrix[line][column - 1].content == '' &&
        matrix[line + 1][column].content == '' &&
          matrix[line + 1][column - 1].content == ''

        matrix[line][column - 1].is_clear = true
        matrix[line + 1][column].is_clear = true
        matrix[line + 1][column - 1].is_clear = true

        num_unarmed_mines += 3
      end
    elsif line == quantity_lines - 1 && column == quantity_columns - 1
      if matrix[line - 1][column].content == '' &&
        matrix[line][column - 1].content == '' &&
          matrix[line - 1][column - 1].content == ''

        matrix[line - 1][column].is_clear = true
        matrix[line][column - 1].is_clear = true
        matrix[line - 1][column - 1].is_clear = true

        num_unarmed_mines += 3
      end
    elsif line == 0
      if matrix[line][column - 1].content == '' &&
        matrix[line + 1][column - 1].content == '' &&
          matrix[line + 1][column].content == '' &&
            matrix[line + 1][column + 1].content == '' &&
              matrix[line][column + 1].content == ''

        matrix[line][column - 1].is_clear = true
        matrix[line + 1][column - 1].is_clear = true
        matrix[line + 1][column].is_clear = true
        matrix[line + 1][column + 1].is_clear = true
        matrix[line][column + 1].is_clear = true

        num_unarmed_mines += 5
      end
    elsif column == 0
      if matrix[line -1][column].content == '' &&
        matrix[line - 1][column + 1].content == '' &&
          matrix[line][column + 1].content == '' &&
            matrix[line + 1][column + 1].content == '' &&
              matrix[line + 1][column].content == ''

        matrix[line -1][column].is_clear = true
        matrix[line - 1][column + 1].is_clear = true
        matrix[line][column + 1].is_clear = true
        matrix[line + 1][column + 1].is_clear = true
        matrix[line + 1][column].is_clear = true

        num_unarmed_mines += 5
      end
    elsif line == quantity_lines - 1
      if matrix[line][column - 1].content == '' &&
        matrix[line - 1][column - 1].content == '' &&
          matrix[line - 1][column].content == '' &&
            matrix[line - 1][column + 1].content == '' &&
              matrix[line][column + 1].content == ''

        matrix[line][column - 1].is_clear = true
        matrix[line - 1][column - 1].is_clear = true
        matrix[line - 1][column].is_clear = true
        matrix[line - 1][column + 1].is_clear = true
        matrix[line][column + 1].is_clear = true

        num_unarmed_mines += 5
      end
    elsif column == quantity_columns - 1
      if matrix[line - 1][column].content == '' &&
        matrix[line - 1][column - 1].content == '' &&
          matrix[line][column - 1].content == '' &&
            matrix[line + 1][column - 1].content == '' &&
              matrix[line + 1][column].content == ''

        matrix[line - 1][column].is_clear = true
        matrix[line - 1][column - 1].is_clear = true
        matrix[line][column - 1].is_clear = true
        matrix[line + 1][column - 1].is_clear = true
        matrix[line + 1][column].is_clear = true

        num_unarmed_mines += 5
      end
    else
      if matrix[line][column - 1].content == '' &&
        matrix[line][column + 1].content == '' &&
          matrix[line - 1][column].content == '' &&
            matrix[line + 1][column].content == '' &&
              matrix[line - 1][column - 1].content == '' &&
                matrix[line - 1][column + 1].content == '' &&
                  matrix[line + 1][column - 1].content == '' &&
                    matrix[line + 1][column + 1].content == ''

        matrix[line][column - 1].is_clear = true
        matrix[line][column + 1].is_clear = true
        matrix[line - 1][column].is_clear = true
        matrix[line + 1][column].is_clear = true
        matrix[line - 1][column - 1].is_clear = true
        matrix[line - 1][column + 1].is_clear = true
        matrix[line + 1][column - 1].is_clear = true
        matrix[line + 1][column + 1].is_clear = true

        num_unarmed_mines += 8
      end
    end

    [matrix , num_unarmed_mines]
  end
end
