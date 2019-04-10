class CreateStoreStocks < ActiveRecord::Migration
  def change
    create_table :store_stocks do |t|
      t.string :car_model
      t.integer :stock

      t.timestamps null: false
    end
  end
end
