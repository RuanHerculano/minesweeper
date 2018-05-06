require 'matrix'
require 'byebug'

class Minesweeper
  attr_accessor :width, :height, :num_mines, :matrix, :still_playing, :victory

  def initialize(width, height, num_mines)
    @width = width
    @height = height
    @num_mines = num_mines
    @still_playing = true
    @matrix = build_matrix
    @victory = false
    insert(bomb_coordinates)
  end

  def build_matrix
    matrix = []

    @width.times do
      matrix.push(Array.new(@height, '.'))
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
      @matrix[bomb_coordinate[:width]][bomb_coordinate[:height]] = '#'
    end
  end

  def still_playing?
    @still_playing
  end

  def play(x, y)
    success = false

    if @matrix[x][y] == '.'
      @matrix[x][y] = ''
      check_arround_cells(x, y)
      success = true
    elsif @matrix[x][y] == '#'
      @still_playing = false
    end

    success
  end

  def check_arround_cells(line, column)
    # 1° siperior esquerda
    if line == 0 && column == 0
      if @matrix[line + 1][column] == '.' && @matrix[line][column + 1] == '.' && @matrix[line + 1][column + 1] == '.'
        @matrix[line + 1][column] = ''
        @matrix[line][column + 1] = ''
        @matrix[line + 1][column + 1] = ''
      end
    # 2° superior direita
    elsif line == @width - 1 && column == 0
      if @matrix[line - 1][column] == '.' && @matrix[line][column + 1] == '.' && @matrix[line - 1][column + 1] == '.'
        @matrix[line - 1][column] = ''
        @matrix[line][column + 1] = ''
        @matrix[line - 1][column + 1] = ''
      end
    # 3° inferior esquerda
    elsif line == 0 && column == @height - 1
      if @matrix[line][column - 1] == '.' && @matrix[line + 1][column] == '.' && @matrix[line + 1][column - 1] == '.'
        @matrix[line][column - 1] = ''
        @matrix[line + 1][column] = ''
        @matrix[line + 1][column - 1] = ''
      end
    # 4° inferior direita
    elsif line == @width - 1 && column == @height - 1
      if @matrix[line - 1][column] == '.' && @matrix[line][column - 1] == '.' && @matrix[line - 1][column - 1] == '.'
        @matrix[line - 1][column] = ''
        @matrix[line][column - 1] = ''
        @matrix[line - 1][column - 1] = ''
      end
    elsif line == 0
      if @matrix[line][column - 1] == '.' && @matrix[line + 1][column - 1] == '.' && @matrix[line + 1][column] == '.' && @matrix[line + 1][column + 1] == '.' && @matrix[line][column + 1] == '.'
        @matrix[line][column - 1] = ''
        @matrix[line + 1][column - 1] = ''
        @matrix[line + 1][column] = ''
        @matrix[line + 1][column + 1] = ''
        @matrix[line][column + 1] = ''
      end
    elsif column == 0
      if @matrix[line -1][column] == '.' && @matrix[line - 1][column + 1] == '.' && @matrix[line][column + 1] == '.' && @matrix[line + 1][column + 1] == '.' && @matrix[line + 1][column] == '.'
        @matrix[line -1][column] = ''
        @matrix[line - 1][column + 1] = ''
        @matrix[line][column + 1] = ''
        @matrix[line + 1][column + 1] = ''
        @matrix[line + 1][column] = ''
      end
    elsif line == @width - 1
      if @matrix[line][column - 1] == '.' && @matrix[line - 1][column - 1] == '.' && @matrix[line - 1][column] == '.' && @matrix[line + 1][column + 1] == '.' && @matrix[line][column + 1] == '.'
        @matrix[line][column - 1] = ''
        @matrix[line - 1][column - 1] = ''
        @matrix[line - 1][column] = ''
        @matrix[line + 1][column + 1] = ''
        @matrix[line][column + 1] = ''
      end
    elsif column == @height - 1
      if @matrix[line - 1][column] == '.' && @matrix[line - 1][column - 1] == '.' && @matrix[line][column - 1] == '.' && @matrix[line + 1][column + 1] == '.' && @matrix[line + 1][column] == '.'
        @matrix[line - 1][column] = ''
        @matrix[line - 1][column - 1] = ''
        @matrix[line][column - 1] = ''
        @matrix[line + 1][column + 1] = ''
        @matrix[line + 1][column] = ''
      end
    end
  end

  def flag(x, y)
    success = false
    cell = @matrix[x][y]

    if cell == '.' || cell == '#'
      @matrix[x][y].concat('F')
      success = true
    elsif cell == '.F' || cell == '#F'
      @matrix[x][y] = cell[0]
      success = true
    end

    success
  end

  def board_state
    quantity_lines   = @matrix.count
    quantity_columns = @matrix.first.count

    for line in 0...quantity_lines
      for column in 0...quantity_columns
        print '[ '

        if @matrix[line][column] == ''
          print ' '
        else
          print @matrix[line][column]
        end

        print ' ]'
      end

      puts
    end
  end
end

width = 4
height = 4
num_mines = 0
game = Minesweeper.new(width, height, num_mines)

# game.play(0, 3)
# game.play(3, 0)
# game.play(3, 3)

game.board_state

while game.still_playing?
  puts "Digite a coordenada da linha"
  line = gets.to_i
  puts "Digite a coordenada da coluna"
  column = gets.to_i
  game.play(line, column)
  game.board_state
end


puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  # PrettyPrinter.new.print(game.board_state(xray: true))
end

# while !game.still_playing?
#   valid_move = game.play(0, 0)
#   valid_flag = game.flag(rand(width), rand(height))

#   if valid_move or valid_flag
#     printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new
#     printer.print(game.board_stat e(
#   end
# end
