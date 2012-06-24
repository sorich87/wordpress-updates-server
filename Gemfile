source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails',        '3.2.3'
gem 'mongoid',      "~> 2.4.10"
gem 'bson_ext',     "~> 1.6.2"
gem 'sanitize'
gem 'twitter-bootstrap-rails', '~> 2.0'
gem 'simple_form', '~> 2.0.0'
gem 'country_select', '~> 0.0.1'
gem 'simple-navigation', '~> 3.0'
gem 'devise', '~> 2.0'
gem 'paperclip', '~> 3.0'
gem 'jquery-rails'
gem 'kaminari', '~> 0.13'
gem 'fog', '~> 1.3.0'
gem 'rubyzip', :require => 'zip/zip'
gem 'rails_admin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'thin'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'spork', '~> 1.0rc'
  gem 'forgery'
end

group :test do
  gem 'mongoid-rspec'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'email_spec'
  gem 'shoulda-matchers'
end
