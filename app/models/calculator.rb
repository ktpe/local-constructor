# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  formula    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Calculator < ApplicationRecord
  has_many :fields, dependent: :destroy
end
