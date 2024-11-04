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
end
