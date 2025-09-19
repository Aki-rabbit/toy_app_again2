# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.9'

gem 'bootsnap',        '1.16.0', require: false
gem 'concurrent-ruby', '1.3.4'
gem 'importmap-rails', '1.1.5'
gem 'jbuilder',        '2.11.5'
gem 'puma', '~> 6.4'
gem 'rails',           '7.1.5.2'
gem 'sassc-rails',     '2.1.2'
gem 'sprockets-rails', '3.4.2'
gem 'sqlite3', '1.6.1'
gem 'stimulus-rails', '1.2.1'
gem 'turbo-rails', '1.4.0'

group :development, :test do
  gem 'debug', '1.7.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'reline', '0.5.10'
  gem 'rspec-rails', '~> 6.0'
  gem 'shoulda-matchers', '~> 6.0'
end

group :development do
  gem 'irb',                 '1.10.0'
  gem 'repl_type_completor', '0.1.10'
  gem 'solargraph',          '0.56.2'
  gem 'web-console',         '4.2.0'
end

group :test do
  gem 'capybara',                 '3.38.0'
  gem 'guard',                    '2.18.0'
  gem 'guard-minitest',           '2.4.6'
  gem 'minitest',                 '5.18.0'
  gem 'minitest-reporters',       '1.6.0'
  gem 'rails-controller-testing', '1.0.5'
  gem 'selenium-webdriver',       '4.8.3'
  gem 'webdrivers',               '5.2.0'
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
# gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'rubocop', '~> 1.80', group: :development
gem 'rubocop-capybara', '~> 2.22', group: :development
gem 'rubocop-factory_bot', '~> 2.27', group: :development
gem 'rubocop-rails', '~> 2.33', group: :development
gem 'rubocop-rspec', '~> 3.7', group: :development
