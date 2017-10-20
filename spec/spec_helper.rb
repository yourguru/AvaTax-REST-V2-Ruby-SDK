require File.expand_path('../../lib/avatax', __FILE__)
require 'rspec'
require 'yaml'


AvaTax.configure do |config|
  begin
    credentials = YAML.load_file(File.expand_path('../credentials.yaml', __FILE__))
    config.endpoint = credentials['endpoint']
    config.username = credentials['username']
    config.password = credentials['password']
  rescue
    config.endpoint = 'https://sandbox-rest.avatax.com'
    config.username = ENV['SANDBOX_USERNAME']
    config.password = ENV['SANDBOX_PASSWORD']
  end
end

client = AvaTax::Client.new()
companies = client.query_companies

RSpec.configure do |config|
  config.before {
    @client = client
    @company_code = companies["value"][1]["companyCode"]
  }
end
