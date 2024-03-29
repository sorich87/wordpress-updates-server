require 'rubygems'
require 'spork'
require 'forgery'
require 'capybara/rspec'
require 'email_spec'
require 'paperclip/matchers'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    config.include(Paperclip::Shoulda::Matchers)

    config.filter_run_excluding :time_consuming => true
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

  RSpec.configure do |config|
    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.orm = "mongoid"
    end

    config.before(:each) do
      DatabaseCleaner.clean
      Fabrication.clear_definitions
    end

    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerMacros, :type => :controller
  end
end
