class RPNCalculator
  attr_accessor :calculator

  def initialize(calculator = [])
    @calculator = calculator
  end

  def push(number)
    @calculator << number
  end

  def plus
    operation(:+)
  end

  def minus
    operation(:-)
  end

  def times
    operation(:*)
  end

  def divide
    operation(:/)
  end

  def value
    @calculator.last
  end

  def operation(op)
    raises_error
    operation_arr = []
    operation_arr.push(*@calculator.pop(2))
    @calculator << operation_arr.map(&:to_f).reduce(op)
  end

  def raises_error
    raise("calculator is empty") if @calculator.empty?
  end

  def tokens(string)
    op_str = "*/+-"
    string.split.map { |el| op_str.include?(el) ? el.to_sym : el.to_i }
  end

  def evaluate(string)
    tokens(string).each do |el|
      if el.is_a? Numeric
        push(el)
      elsif el.is_a? Symbol
        operation(el)
      end
    end
    value
  end

end
