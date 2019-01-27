source 'https://rubygems.org'
ruby '2.7.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'therubyracer'
gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'dotenv-rails'
gem 'slim-rails'
gem 'devise'
gem 'jquery-rails'
gem 'rails-ujs'
gem 'carrierwave'
gem 'remotipart'
gem 'cocoon'
gem 'emoji'
gem 'private_pub'
gem 'thin'

group :development, :test do
  gem 'byebug'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'factory_bot_rails', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 3.1.2'#, require: false
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'geckodriver-helper'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

