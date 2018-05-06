module Inputs
  class Console
    def self.execute(message)
      puts message
      input = gets.to_i

      input
    end

    def self.coordenate_input_params
      line   = Inputs::Console.execute('Digite a coordenada da linha')
      column = Inputs::Console.execute('Digite a coordenada da coluna')

      [line, column]
    end

    def self.matrix_input_params
      lines          = Inputs::Console.execute('Digite a quantidade de linhas da matriz')
      columns        = Inputs::Console.execute('Digite a quantidade de colunas da matriz')
      quantity_mines = Inputs::Console.execute('Digite a quantidade de minas')

      [lines, columns, quantity_mines]
    end

    def self.option_input_param
      message = 'Digite 0 para revelar uma célula, ou 1 para adicionar uma bandeira'
      option = Inputs::Console.execute(message)

      option
    end
  end
end
