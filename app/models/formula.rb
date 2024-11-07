# == Schema Information
#
# Table name: formulas
#
#  id            :bigint           not null, primary key
#  expression    :string
#  label         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint
#
# Indexes
#
#  index_formulas_on_calculator_id  (calculator_id)
#
class Formula < ApplicationRecord
  belongs_to :calculator
  validate :fields_are_included_in_formulas

  private

  def fields_are_included_in_formulas
    field_names = calculator.fields.map(&:var_name)
    formula_variables = expression.scan(/\b[a-zA-Z_]\w*\b/).uniq
    unused_fields = formula_variables.reject { |var| field_names.include?(var) }

    return if unused_fields.blank?

    errors.add(:expression, "requires fields #{unused_fields.join(', ')} to be initialized")
  end
end
