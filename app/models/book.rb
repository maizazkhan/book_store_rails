# app/models/book.rb
class Book < ActiveRecord::Base
  belongs_to :bookstore
  has_many :purchases  # This allows each book to have multiple purchases

  validates :title, :author, presence: true
end
