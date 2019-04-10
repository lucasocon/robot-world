class CreateFailures < ActiveRecord::Migration
  def change
    create_table :failures do |t|
      t.references :computer, index: true, foreign_key: true
      t.string :location
      t.boolean :is_notified, default: false

      t.timestamps null: false
    end
  end
end
