class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :order, index: true, foreign_key: true
      t.string :car
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
