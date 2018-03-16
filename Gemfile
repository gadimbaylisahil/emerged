source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'wysiwyg-rails'

gem 'acts-as-taggable-on', '~> 5.0'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'acts_as_votable', '~> 0.11.1'
gem 'clearance'
gem 'font-awesome-rails'
gem 'haml'
gem 'jbuilder', '~> 2.5'

gem 'rubocop', require: false
gem 'rubocop-rspec'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
