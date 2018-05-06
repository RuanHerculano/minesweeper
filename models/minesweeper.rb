require './models/cell'
require './libs/matrix_operations'

class Minesweeper
  attr_accessor :width
  attr_accessor :height
  attr_accessor :num_mines
  attr_accessor :matrix
  attr_accessor :still_playing
  attr_accessor :victory
  attr_accessor :num_unarmed_mines

  def initialize(width, height, num_mines)
    @width = width
    @height = height
    @num_mines = num_mines
    @still_playing = true
    @victory = false
    @num_unarmed_mines = 0
    @matrix = MatrixOperations.build_matrix(width, height, num_mines)
  end

  def still_playing?
    @still_playing
  end

  def victory?
    @victory
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

  def check_victory
    increment_num_unarmed_mines(1)

    if @num_unarmed_mines == (@width * @height) - @num_mines
      @victory = true
      @still_playing = false
    end
  end

  def increment_num_unarmed_mines(quantity_mines)
    @num_unarmed_mines += quantity_mines
  end

  def flag(line, column)
    success = false
    cell = @matrix[line][column]

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
