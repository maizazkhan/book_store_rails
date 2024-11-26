class SalesMailer < ApplicationMailer
  default from: 'no-reply@bookstore.com'

  def monthly_report(manager, report)
    @manager = manager
    attachments['monthly_sales_report.csv'] = report
    mail(to: @manager.email, subject: "Monthly Sales Report")
  end
end
