class CalculationService
  def initialize(calculator, inputs)
    @calculator = calculator
    @inputs = inputs
    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result = @dentaku.evaluate(formula.expression, @inputs)

      { label: formula.label, result: result }
    end
  end
end
