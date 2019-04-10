class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :code
      t.string :buyer
      t.date :date
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
