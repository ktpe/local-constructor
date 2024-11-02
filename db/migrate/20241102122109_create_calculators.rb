class CreateCalculators < ActiveRecord::Migration[7.2]
  def change
    create_table :calculators do |t|
      t.string :name
      t.string :formula

      t.timestamps
    end
  end
end
