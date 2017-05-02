class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :buyer_id
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
