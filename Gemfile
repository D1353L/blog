source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'devise'
gem 'cancancan', '~> 2.0'
gem 'rolify'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'haml-rails'

gem 'paperclip', '~> 5.0.0'

gem 'bootstrap-kaminari-views'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda'
end

group :development do
  gem 'awesome_print', require: 'ap'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'web-console'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
