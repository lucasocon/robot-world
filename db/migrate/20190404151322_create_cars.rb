class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.decimal :price, precision: 10, scale: 2, default: 0.00
      t.decimal :cost_price, precision: 10, scale: 2, default: 0.00 
      t.integer :year
      t.string  :car_model
      t.string :state

      t.timestamps null: false
    end
  end
end
