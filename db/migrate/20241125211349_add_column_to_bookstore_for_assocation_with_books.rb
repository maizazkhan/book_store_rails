class AddColumnToBookstoreForAssocationWithBooks < ActiveRecord::Migration
  def change
    add_column :books, :description, :text
    add_column :books, :price, :decimal, precision: 10, scale: 2
    add_reference :books, :bookstore, foreign_key: true
  end
end
