# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby ENV['HEROKU_RUBY_VERSION'] if ENV['HEROKU_RUBY_VERSION']

gem 'sinatra'

gem 'slim'
gem 'gitlab', github: 'NARKOZ/gitlab'

gem 'puma', group: :production

group :development do
  gem 'rake'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sinatra-contrib', require: false
  gem 'guard-livereload', '~> 2.4', require: false
end

group :development, :test do
  gem 'minitest'
end
