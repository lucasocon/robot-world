class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.references :car, index: true, foreign_key: true
      t.string :name
      t.integer :stock

      t.timestamps null: false
    end
  end
end
