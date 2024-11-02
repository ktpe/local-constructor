class CreateFields < ActiveRecord::Migration[7.2]
  def change
    create_table :fields do |t|
      t.string :label
      t.string :var_name
      t.string :field_type

      t.references :calculator, null: false

      t.timestamps
    end
  end
end
