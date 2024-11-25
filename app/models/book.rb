class Book < ActiveRecord::Base
  belongs_to :bookstore
  validates :title, :author, presence: true
end
