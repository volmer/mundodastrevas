source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 4.2'
gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'unicorn'
gem 'sidekiq'
gem 'bootstrap'
gem 'font-awesome-sass'
gem 'rails-assets-tether'
gem 'bootsy', github: 'volmer/bootsy', branch: 'bootstrap-4'
gem 'carrierwave'
gem 'devise'
gem 'kaminari'
gem 'mini_magick'
gem 'omniauth-facebook'
gem 'pundit'
gem 'rails_autolink'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'simple_form'
gem 'rubocop'
gem 'sprockets-rails'
gem 'cucumber-rails', require: false

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
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'webmock', require: false
end

group :production do
  gem 'skylight'
  gem 'bugsnag'
end
