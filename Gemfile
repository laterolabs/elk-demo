source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'cloudwatchlogger'
gem 'dotenv-rails'
gem 'logstash-logger', '~> 0.26'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'

group :development, :test do
  gem 'amazing_print'
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'reek'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
