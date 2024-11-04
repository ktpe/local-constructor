class CreateFormulas < ActiveRecord::Migration[7.2]
  def change
    create_table :formulas do |t|
      t.string :expression
      t.string :label
      t.references :calculator

      t.timestamps
    end
  end
end
