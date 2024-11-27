class GenerateMonthlySalesReportWorker
  include Sidekiq::Worker

  def perform(month, year)
    # Define the start and end dates for the month and year
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month

    # Get the sales data from the Purchase table for the given month and year
    sales_data = Purchase.joins(:bookstore)
                         .where(created_at: start_date..end_date)
                         .group("bookstores.name")
                         .sum(:price)  # The 'price' includes the 5% markup

    # Generate the sales report as a string (this can be customized to your needs)
    report = generate_report(sales_data, start_date, end_date)

    # Send the generated report to all managers
    User.where(role: 1).each do |manager|  # Send only to managers
      SalesMailer.monthly_report(manager, report).deliver_now
    end
  end

  private

  def generate_report(sales_data, start_date, end_date)
    # This method generates the report in a textual format.
    report = "Monthly Sales Report\n"
    report += "------------------------\n"
    report += "Date Range: #{start_date.strftime('%B %d, %Y')} - #{end_date.strftime('%B %d, %Y')}\n\n"
    report += "Bookstore Name  | Total Sales (with 5% added)\n"
    report += "--------------------------------------------\n"

    # Format the sales data for each bookstore
    sales_data.each do |bookstore_name, total_sales|
      report += "#{bookstore_name}  | $#{'%.2f' % total_sales}\n"
    end

    report
  end
end
