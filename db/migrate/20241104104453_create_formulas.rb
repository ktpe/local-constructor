class CreateFormulas < ActiveRecord::Migration[7.2]
  def change
    create_table :formulas do |t|
      t.string :expression, null: false
      t.string :label, null: false
      t.references :calculator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
