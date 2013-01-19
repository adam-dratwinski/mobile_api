source 'https://rubygems.org'

gem 'rails', '3.2.10'

gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'bourbon'
end

gem 'jquery-rails'
gem 'formtastic'
gem 'haml'

group :test, :development do
  gem 'pry'
end

group :test do
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'vcr'
end

group :development do
  gem 'guard-spork'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'guard-livereload'

  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'terminal-notifier-guard'
end
