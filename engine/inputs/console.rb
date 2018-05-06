module Inputs
  class Console
    def self.coordenate_input_params
      line   = execute('Digite a coordenada da linha')
      column = execute('Digite a coordenada da coluna')

      [line, column]
    end

    def self.matrix_input_params
      lines          = execute('Digite a quantidade de linhas da matriz')
      columns        = execute('Digite a quantidade de colunas da matriz')
      quantity_mines = execute('Digite a quantidade de minas')

      [lines, columns, quantity_mines]
    end

    def self.option_input_param
      message = 'Digite 0 para revelar uma célula, ou 1 para adicionar uma bandeira'
      option = execute(message)

      option
    end

    def self.execute(message)
      puts message
      input = gets.to_i

      input
    end
    private_class_method :execute
  end
end
