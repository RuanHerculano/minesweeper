class Cell
  attr_accessor :content
  attr_accessor :is_clear
  attr_accessor :is_flag
  attr_accessor :arround_mines

  def initialize(content, is_clear, is_flag)
    @content = content
    @is_clear = is_clear
    @is_flag = is_flag
  end
end
