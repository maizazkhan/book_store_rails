class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.references :bookstore, index: true, foreign_key: true
      t.decimal :price

      t.timestamps null: false
    end
  end
end
