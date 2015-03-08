source 'https://rubygems.org'

if ENV['HEROKU_RUBY_VERSION']
  ruby ENV['HEROKU_RUBY_VERSION']
end

gem 'sinatra'

gem 'slim'
gem 'gitlab', github: 'NARKOZ/gitlab'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sinatra-contrib', require: false
  gem 'guard-livereload', '~> 2.4', require: false
end
