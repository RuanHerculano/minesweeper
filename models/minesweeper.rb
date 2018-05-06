require './models/cell'

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
    @matrix = build_matrix
    @victory = false
    @num_unarmed_mines = 0
    insert(bomb_coordinates)
    build_arround_mines
  end

  def build_arround_mines
    quantity_lines   = @matrix.count
    quantity_columns = @matrix.first.count

    for line in 0...quantity_lines
      for column in 0...quantity_columns
        arround_mines = 0

        if line == 0 && column == 0
          if @matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end
        elsif line == @width - 1 && column == 0
          if @matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end
        elsif line == 0 && column == @height - 1
          if @matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

        elsif line == @width - 1 && column == @height - 1
          if @matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end
        elsif line == 0
          if @matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column + 1].content == '#'
            arround_mines += 1
          end
        elsif column == 0
          if @matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column].content == '#'
            arround_mines += 1
          end
        elsif line == @width - 1
          if @matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column + 1].content == '#'
            arround_mines += 1
          end
        elsif column == @height - 1
          if @matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column].content == '#'
            arround_mines += 1
          end
        else
          if @matrix[line][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line - 1][column + 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column - 1].content == '#'
            arround_mines += 1
          end

          if @matrix[line + 1][column + 1].content == '#'
            arround_mines += 1
          end
        end

        @matrix[line][column].arround_mines = arround_mines
      end
    end
  end

  def build_matrix
    matrix = []

    @width.times do
      line = []

      @height.times do
        cell = Cell.new('', false, false)
        line.push(cell)
      end

      matrix.push(line)
    end

    matrix
  end

  def bomb_coordinates
    coordinates = []

    @num_mines.times do
      coordinate = { width: rand(@width), height: rand(@height) }

      if !coordinates.include?(coordinate) || coordinates.empty?
        coordinates.push(coordinate)
      end
    end

    coordinates
  end

  def insert(bomb_coordinates)
    bomb_coordinates.each do |bomb_coordinate|
      cell = Cell.new('#', false, false)
      @matrix[bomb_coordinate[:width]][bomb_coordinate[:height]] = cell
    end
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
      check_arround_cells(line, column)
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

  def check_arround_cells(line, column)
    if line == 0 && column == 0
      if @matrix[line + 1][column].content == '' &&
        @matrix[line][column + 1].content == '' &&
          @matrix[line + 1][column + 1].content == ''

        @matrix[line + 1][column].is_clear = true
        @matrix[line][column + 1].is_clear = true
        @matrix[line + 1][column + 1].is_clear = true

        increment_num_unarmed_mines(3)
      end
    elsif line == @width - 1 && column == 0
      if @matrix[line - 1][column].content == '' &&
        @matrix[line][column + 1].content == '' &&
          @matrix[line - 1][column + 1].content == ''

        @matrix[line - 1][column].is_clear = true
        @matrix[line][column + 1].is_clear = true
        @matrix[line - 1][column + 1].is_clear = true

        increment_num_unarmed_mines(3)
      end
    elsif line == 0 && column == @height - 1
      if @matrix[line][column - 1].content == '' &&
        @matrix[line + 1][column].content == '' &&
          @matrix[line + 1][column - 1].content == ''

        @matrix[line][column - 1].is_clear = true
        @matrix[line + 1][column].is_clear = true
        @matrix[line + 1][column - 1].is_clear = true
        increment_num_unarmed_mines(3)
      end
    elsif line == @width - 1 && column == @height - 1
      if @matrix[line - 1][column].content == '' &&
        @matrix[line][column - 1].content == '' &&
          @matrix[line - 1][column - 1].content == ''

        @matrix[line - 1][column].is_clear = true
        @matrix[line][column - 1].is_clear = true
        @matrix[line - 1][column - 1].is_clear = true

        increment_num_unarmed_mines(3)
      end
    elsif line == 0
      if @matrix[line][column - 1].content == '' &&
        @matrix[line + 1][column - 1].content == '' &&
          @matrix[line + 1][column].content == '' &&
            @matrix[line + 1][column + 1].content == '' &&
              @matrix[line][column + 1].content == ''

        @matrix[line][column - 1].is_clear = true
        @matrix[line + 1][column - 1].is_clear = true
        @matrix[line + 1][column].is_clear = true
        @matrix[line + 1][column + 1].is_clear = true
        @matrix[line][column + 1].is_clear = true

        increment_num_unarmed_mines(5)
      end
    elsif column == 0
      if @matrix[line -1][column].content == '' &&
        @matrix[line - 1][column + 1].content == '' &&
          @matrix[line][column + 1].content == '' &&
            @matrix[line + 1][column + 1].content == '' &&
              @matrix[line + 1][column].content == ''

        @matrix[line -1][column].is_clear = true
        @matrix[line - 1][column + 1].is_clear = true
        @matrix[line][column + 1].is_clear = true
        @matrix[line + 1][column + 1].is_clear = true
        @matrix[line + 1][column].is_clear = true

        increment_num_unarmed_mines(5)
      end
    elsif line == @width - 1
      if @matrix[line][column - 1].content == '' &&
        @matrix[line - 1][column - 1].content == '' &&
          @matrix[line - 1][column].content == '' &&
            @matrix[line - 1][column + 1].content == '' &&
              @matrix[line][column + 1].content == ''

        @matrix[line][column - 1].is_clear = true
        @matrix[line - 1][column - 1].is_clear = true
        @matrix[line - 1][column].is_clear = true
        @matrix[line - 1][column + 1].is_clear = true
        @matrix[line][column + 1].is_clear = true

        increment_num_unarmed_mines(5)
      end
    elsif column == @height - 1
      if @matrix[line - 1][column].content == '' &&
        @matrix[line - 1][column - 1].content == '' &&
          @matrix[line][column - 1].content == '' &&
            @matrix[line + 1][column - 1].content == '' &&
              @matrix[line + 1][column].content == ''

        @matrix[line - 1][column].is_clear = true
        @matrix[line - 1][column - 1].is_clear = true
        @matrix[line][column - 1].is_clear = true
        @matrix[line + 1][column - 1].is_clear = true
        @matrix[line + 1][column].is_clear = true

        increment_num_unarmed_mines(5)
      end
    else
      if @matrix[line][column - 1].content == '' &&
        @matrix[line][column + 1].content == '' &&
          @matrix[line - 1][column].content == '' &&
            @matrix[line + 1][column].content == '' &&
              @matrix[line - 1][column - 1].content == '' &&
                @matrix[line - 1][column + 1].content == '' &&
                  @matrix[line + 1][column - 1].content == '' &&
                    @matrix[line + 1][column + 1].content == ''

        @matrix[line][column - 1].is_clear = true
        @matrix[line][column + 1].is_clear = true
        @matrix[line - 1][column].is_clear = true
        @matrix[line + 1][column].is_clear = true
        @matrix[line - 1][column - 1].is_clear = true
        @matrix[line - 1][column + 1].is_clear = true
        @matrix[line + 1][column - 1].is_clear = true
        @matrix[line + 1][column + 1].is_clear = true

        increment_num_unarmed_mines(8)
      end
    end
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
