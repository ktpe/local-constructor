require "rails_helper"

RSpec.describe "Calculators", type: :request do
  let(:valid_attributes) do
    {
      name: "Sample Calculator",
      formulas_attributes: [
        { expression: "a + b", label: "Addition" }
      ],
      fields_attributes: [
        {
          label: "Field 1",
          var_name: "a",
          field_type: "number",
          categories_attributes: [
            { name: "Category 1", price: 100 }
          ]
        }
      ]
    }
  end

  let(:invalid_attributes) do
    {
      name: "",
      formulas_attributes: [
        { expression: "", label: "" }
      ]
    }
  end

  describe "GET /new" do
    it "returns http success" do
      get new_calculator_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let!(:calculator) { Calculator.create!(valid_attributes) }

    it "returns http success" do
      get calculator_path(calculator)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Calculator and redirects to show page" do
        expect do
          post calculators_path, params: { calculator: valid_attributes }
        end.to change(Calculator, :count).by(1)
        
        expect(response).to redirect_to(calculator_path(Calculator.last))
        follow_redirect!
        expect(response.body).to include("Calculator created successfully.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Calculator and re-renders new" do
        expect do
          post calculators_path, params: { calculator: invalid_attributes }
        end.not_to change(Calculator, :count)
        
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /calculate" do
    let!(:calculator) { Calculator.create!(valid_attributes) }
    let(:calculate_params) { { inputs: { a: 5, b: 10 } } }

    it "calculates result and redirects to show page with result" do
      post calculate_calculator_path(calculator), params: calculate_params
      expect(response).to redirect_to(calculator_path(calculator, result: 15))
    end
  end
end
