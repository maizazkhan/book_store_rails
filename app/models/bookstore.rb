# app/models/bookstore.rb
class Bookstore < ActiveRecord::Base
  has_many :books, dependent: :destroy
  has_many :purchases, through: :books  # This line is important

  validates :name, presence: true
end
