# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Calculator < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :formulas, dependent: :destroy
  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :formulas, reject_if: :all_blank, allow_destroy: true

  validate :formulas_include_all_fields
  validate :fields_are_included_in_formulas

  private

  def formulas_include_all_fields
    formulas.each do |formula|
      missing_var_names = fields.map(&:var_name).reject { |var_name| formula.expression.include?(var_name) }

      if missing_var_names.present?
        errors.add(:base, "Fields #{missing_var_names.join(', ')} aren't used in any formulas")
      end
    end
  end

  def fields_are_included_in_formulas
    field_names = fields.map(&:var_name)

    formula_variables = formulas.flat_map do |formula|
      formula.expression.scan(/\b[a-zA-Z_]\w*\b/)
    end.uniq

    unused_fields = formula_variables.reject { |var| field_names.include?(var) }

    if unused_fields.any?
      errors.add(:base, "The #{unused_fields.join(', ')} fields are not initialized")
    end
  end
end
