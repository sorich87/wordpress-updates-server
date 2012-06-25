source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails',        '~> 3.2.0'
gem 'mongoid',      '~> 2.4'
gem 'bson_ext',     '~> 1.5'
gem 'sanitize'
gem 'twitter-bootstrap-rails', '~> 2.0'
gem 'simple_form'
gem 'country_select'
gem 'simple-navigation', '~> 3.0'
gem 'devise', '~> 2.0'
gem 'paperclip', '~> 3.0'
gem 'jquery-rails'
gem 'kaminari'
gem 'fog', '~> 1.4.0'
gem 'rubyzip', :require => 'zip/zip'
gem 'rails_admin'

group :assets do
  gem 'sass-rails',   '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'
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
