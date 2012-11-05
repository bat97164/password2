source 'http://rubygems.org'

gem 'rails', '3.2.8'

group :development, :test, :private do
  gem "sqlite3"
end

group :production do
  gem 'pg'
  # Note: Remove the following gem if you are running production - it requires a Tracelytics account
  # This is intended for pwpush.com only; http://www.tracelytics.com
  source 'http://gem.tracelytics.com'
  gem 'oboe', '1.3.3'
end

group :development, :test do
  gem 'silent-postgres'
  gem "ruby-debug19", :platforms => :ruby_19
  gem "ruby-debug", :platforms => :ruby_18
  gem "rspec-rails", ">= 2.0.1"
  gem "rspec"
  gem "rspec-core"
  gem "rspec-expectations"
  gem "rspec-mocks"
  gem "blueprints"
  gem "nifty-generators"
end

gem 'json'
gem 'haml'
gem 'haml-rails'
gem 'fastercsv' # Only required on Ruby 1.8 and below
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'therubyracer'
gem 'ezcrypto', :git => 'git://github.com/pglombardo/ezcrypto.git'
gem 'modernizr-rails', :git => 'git://github.com/russfrisch/modernizr-rails.git'
gem "high_voltage"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.7'
end

gem "mocha", :group => :test

gem 'jquery-rails'
gem 'delayed_job_active_record'
gem 'thin'
gem 'capistrano'
gem "devise"
gem "omniauth"
gem 'omniauth-openid'
gem 'omniauth-twitter'

