require 'rubygems'
require 'bundler/setup'

require 'pg'
require 'active_record'
require 'yaml'

namespace :db do
  desc 'Migrate the database'
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate('db/migrate/')
  end
end
