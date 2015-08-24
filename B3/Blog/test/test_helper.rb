ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(admin)
    session[:admin_id] = admins(admin).id
    session[:nickname] = admins(admin).nickname
  end

  def logout 
    session.delete :admin_id
  end

  def setup
    login_as :one if defined? session
  end
end
  