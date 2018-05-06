require './engine/controllers/minesweeper'

class Init
  def self.execute
    Controllers::Minesweeper.execute
  end
end

Init.execute
