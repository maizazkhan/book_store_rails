class Admin::DashboardController < ApplicationController

  def index
    # Total bookstores count
    @total_bookstores = Bookstore.count

    # Total books count across all bookstores
    @total_books = Book.count

    # Revenue trends (show only the 5% markup amount for each purchase)
    @revenue_trends = Purchase
                        .where('created_at >= ?', 1.year.ago)
                        .group_by_month(:created_at, format: "%b %Y")
                        .sum('price - price / 1.05') # This calculates only the 5% markup amount for each purchase

    # Best-performing bookstores (rank by total 5% markup revenue)
    @best_performing_bookstores = Bookstore
                                    .joins(:purchases)
                                    .select('bookstores.*, SUM(purchases.price - purchases.price / 1.05) AS total_revenue')
                                    .group('bookstores.id')
                                    .order('total_revenue DESC')
                                    .limit(5) # Limit to top 5 bookstores

    # Total revenue across all bookstores (sum of only the 5% markup for each purchase)
    @total_revenue = Purchase.sum('price - price / 1.05') # Calculate and sum only the 5% markup for each purchase
  end

end
