source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.4'
gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'unicorn'
gem 'sidekiq'
gem 'bootstrap-sass'
gem 'bootsy', github: 'volmer/bootsy'
gem 'carrierwave'
gem 'devise'
gem 'draper'
gem 'kaminari'
gem 'mini_magick'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'pundit'
gem 'rails_autolink'
gem 'recaptcha'
gem 'simple_form'
gem 'devise-encryptable'
gem 'rubocop'
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails'
gem 'elasticsearch-rails'

group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'capistrano3-unicorn'
  gem 'brakeman', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver', '~> 2.47.1'
  gem 'webmock', require: false
end

group :production do
  gem 'skylight'
  gem 'bugsnag'
end
