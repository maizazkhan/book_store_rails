class Admin::DashboardController < ApplicationController
  # before_action :authorize_admin

  def index
    @total_bookstores = Bookstore.count

    # Total books across all bookstores
    @total_books = Book.count

    # Revenue trends (this can be done by grouping purchases by month)
    @revenue_trends = Purchase
                        .where('created_at >= ?', 1.year.ago)
                        .group_by_month(:created_at, format: "%b %Y")
                        .sum(:price)  # This will return total revenue per month

    # Best-performing bookstores (rank by total revenue)
    @best_performing_bookstores = Bookstore
                                    .joins(:purchases)
                                    .select('bookstores.*, SUM(purchases.price) AS total_revenue')
                                    .group('bookstores.id')
                                    .order('total_revenue DESC')
                                    .limit(5)  # Limit to top 5 bookstores

    # Total revenue across all bookstores
    @total_revenue = Purchase.sum(:price)  # Sum of all purchase prices (after 5% markup)
  end

  private

  def authorize_admin
    authorize! :manage, :dashboard
  end
end
