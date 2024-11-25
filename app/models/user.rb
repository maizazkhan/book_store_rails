class User < ActiveRecord::Base
  enum role: { customer: 0, manager: 1, admin: 2 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
end
