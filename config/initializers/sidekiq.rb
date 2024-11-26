# config/initializers/sidekiq.rb
require 'sidekiq'
require 'sidekiq-cron'

# Schedule cron job
Sidekiq::Cron::Job.create(
  name: 'Generate Monthly Sales Report',
  cron: '0 0 1 * *',  # Runs on the 1st day of every month at midnight
  class: 'GenerateMonthlySalesReportJob'
)
