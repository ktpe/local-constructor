# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :bigint
#
# Indexes
#
#  index_categories_on_field_id  (field_id)
#
class Category < ApplicationRecord
  belongs_to :field
end
