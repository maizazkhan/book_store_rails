# app/models/purchase.rb
class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  belongs_to :bookstore
end
