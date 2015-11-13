require 'active_record'
require 'active_record/tasks/database_tasks'
require 'yaml'

include ActiveRecord::Tasks

load 'active_record/railties/databases.rake'

environment = ENV['db'] || 'development'
configuration = YAML.load_file File.expand_path('../db/config.yml', __FILE__)

ActiveRecord::Base.configurations = configuration
ActiveRecord::Base.schema_format = :sql

DatabaseTasks.env = environment
DatabaseTasks.database_configuration = ActiveRecord::Base.configurations
DatabaseTasks.current_config = DatabaseTasks.database_configuration[DatabaseTasks.env]
DatabaseTasks.root = File.expand_path '..', __FILE__
DatabaseTasks.db_dir = 'db'
DatabaseTasks.migrations_paths = ['db/migrate']
DatabaseTasks.seed_loader = nil
