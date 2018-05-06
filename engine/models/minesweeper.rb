require './engine/models/cell'
require './libs/matrix_operations'

class Minesweeper
  attr_accessor :lines
  attr_accessor :columns
  attr_accessor :quantity_mines
  attr_accessor :matrix
  attr_accessor :still_playing
  attr_accessor :victory
  attr_accessor :num_unarmed_mines

  def initialize(lines, columns, quantity_mines)
    @lines = lines
    @columns = columns
    @quantity_mines = quantity_mines
    @still_playing = true
    @victory = false
    @num_unarmed_mines = 0
    @matrix = MatrixOperations.build_matrix(lines, columns, quantity_mines)
  end

  def still_playing?
    @still_playing
  end

  def victory?
    @victory
  end

  def check_victory
    increment_num_unarmed_mines(1)

    if @num_unarmed_mines == (@lines * @columns) - @quantity_mines
      @victory = true
      @still_playing = false
    end
  end

  def play(line, column)
    success = false

    if !@matrix[line][column].is_clear && !@matrix[line][column].is_flag && @matrix[line][column].content == ''
      @matrix[line][column].is_clear = true
      @matrix, num_unarmed_mines = MatrixOperations.check_arround_cells(@matrix, line, column)
      increment_num_unarmed_mines(num_unarmed_mines)

      check_victory
      success = true
    elsif !@matrix[line][column].is_clear && !@matrix[line][column].is_flag && @matrix[line][column].content == '#'
      @still_playing = false
    end

    success
  end

  def increment_num_unarmed_mines(quantity_mines)
    @num_unarmed_mines += quantity_mines
  end

  def flag(line, column)
    success = false
    cell    = @matrix[line][column]

    return success if cell.is_clear

    if cell.is_flag
      cell.is_flag = false
    else
      cell.is_flag = true
    end

    success = true

    success
  end
end
