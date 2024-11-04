class CalculatorsController < ApplicationController
  def index
  end

  def new
    @calculator = Calculator.new

    @calculator.fields.build.categories.build
    @calculator.formulas.build
  end

  def show
    @calculator = resource
    @result = params[:result]
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      redirect_to @calculator, notice: "Calculator created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def calculate
    keisan = Keisan::Calculator.new

    @calculator = resource

    inputs = params[:inputs].transform_values(&:to_f)

    @results = @calculator.formulas.map do |formula|
      result = keisan.evaluate(formula.expression, inputs)

      { label: formula.label, result: result }
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def resource
    Calculator.find(params[:id])
  end

  def calculator_params
    params.require(:calculator).permit(
      :name, formulas_attributes: [:id, :expression, :label, :calculator_id, :_destroy],
      fields_attributes: [:id, :label, :var_name, :field_type, :_destroy,
        categories_attributes: [:id, :name, :price, :_destroy]]
    )
  end
end
