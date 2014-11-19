require 'simplecov'
require 'byebug'

SimpleCov.adapters.define 'gem' do
  add_filter '/spec/'
  add_filter '/autotest/'
  add_group 'Libraries', '/lib/'
end
SimpleCov.start 'gem'

require 'wirecard_giropay'

RSpec.configure do |config|
  # config.before do
  #   Bancard.test = true
  # end
  #
  # config.before(:all) do
  #   body = { status: :success, process_id: 'lx6niQel0QzWK1g' }
  #   response = Typhoeus::Response.new(code: 200, body: body.to_json, headers: { 'Location' => 'payment-url' })
  #   Typhoeus.stub(/vpos/).and_return(response)
  # end
end
