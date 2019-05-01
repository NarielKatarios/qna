source 'https://rubygems.org'
ruby '2.7.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'carrierwave'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'emoji'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'private_pub'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rails-ujs'
gem 'remotipart'
gem 'responders'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'therubyracer'
gem 'thin'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'omniauth'
gem 'omniauth-vkontakte'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google'
gem 'omniauth-yandex'
gem 'omniauth-odnoklassniki'


group :development, :test do
  gem 'byebug'
  gem 'capybara'
  gem 'factory_bot_rails', require: false
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'geckodriver-helper'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1.2' # , require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
