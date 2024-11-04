class CalculatorsController < ApplicationController
  def index
  end

  def new
    @calculator = Calculator.new

    @calculator.fields.build.categories.build
    @calculator.formulas.build
  end

  def show
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

  private

  def set_calculator
    @calculator = Calculator.find(params[:id])
  end

  def calculator_params
    params.require(:calculator).permit(
      :name, formulas_attributes: [:id, :expression, :label, :calculator_id, :_destroy],
      fields_attributes: [:id, :label, :var_name, :field_type, :_destroy,
        categories_attributes: [:id, :name, :price, :_destroy]]
    )
  end
end
