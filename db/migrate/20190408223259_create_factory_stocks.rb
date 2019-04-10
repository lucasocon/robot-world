class CreateFactoryStocks < ActiveRecord::Migration
  def change
    create_table :factory_stocks do |t|
      t.string :car_model
      t.integer :stock, default: 0
      t.integer :cars_ready, default: 0
      t.integer :cars_with_failures, default: 0

      t.timestamps null: false
    end
  end
end
