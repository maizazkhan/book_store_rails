class SalesMailer < ApplicationMailer
  default from: 'no-reply@bookstore.com'

  def monthly_report(manager, report)
    @manager = manager
    @report = report

    # Send the email with the report in the body
    mail(to: @manager.email, subject: "Monthly Sales Report") do |format|
      format.text { render plain: @report }  # Email content in plain text
    end
  end
end
