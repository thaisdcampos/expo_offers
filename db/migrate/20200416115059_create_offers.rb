# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :advertiser_name, null: false
      t.string :url, null: false
      t.string :description, null: false
      t.date :active_from, null: false
      t.date :active_until
      t.boolean :premium
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :offers, :status
    add_index :offers, :premium
    add_index :offers, :active_from
  end
end
