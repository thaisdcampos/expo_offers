class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :description, null: false
      t.datetime :active_from, null: false
      t.datetime :active_until
      t.boolean :premium
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
