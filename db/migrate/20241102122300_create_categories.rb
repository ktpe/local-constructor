class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.float :price, null: false

      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
