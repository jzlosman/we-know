ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'dotenv'

class ActiveSupport::TestCase
  Dotenv.load(File.expand_path("../../.ENV", __FILE__))

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...
end
