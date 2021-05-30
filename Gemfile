# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'aws-sdk-sqs'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv-rails', groups: %i[development test]
gem 'jaro_winkler'
gem 'paper_trail'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'redis'
gem 'rest-client'
gem 'rspec-rails', '~> 4.0.1'
gem 'savon'

group :test do
  gem 'rainbow'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'paranoia'
  gem 'pry', '~> 0.12.2'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
