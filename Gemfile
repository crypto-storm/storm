# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'tailwindcss-rails', '~> 2.0'

gem 'bootsnap', require: false
gem 'coingecko_ruby'
gem 'cssbundling-rails'
gem 'font-awesome-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'nokogiri', '~> 1.13.6'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rack', '~> 2.2.3.1'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'redis', '~> 4.0'
gem 'ruby-limiter'
gem 'scenic'
gem 'sidekiq', '~> 6.4'
gem 'sidekiq-scheduler'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'bullet'
  gem 'byebug'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
