class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @total_bookstores = Bookstore.count
    @total_books = Book.count
    @total_revenue = Bookstore.joins(:books).sum('books.price') # Assuming each bookstore has a revenue column
  end

  private

  def authorize_admin
    authorize! :manage, :dashboard
  end
end
