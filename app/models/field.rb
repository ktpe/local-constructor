# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  field_type    :string
#  label         :string
#  var_name      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
class Field < ApplicationRecord
  belongs_to :calculator
  has_many :categories, dependent: :destroy
  accepts_nested_attributes_for :categories, reject_if: :all_blank, allow_destroy: true

  validate :field_is_part_of_any_formula

  private

  def field_is_part_of_any_formula
    return if calculator.formulas.any? { |formula| formula.expression.scan(/\b[a-zA-Z_]\w*\b/).uniq.include?(var_name) }

    errors.add(:var_name, "field isn't used in any formula")
  end
end
