require 'active_record'
require 'active_record/tasks/database_tasks'
require 'yaml'
require 'zlib'

require 'database/extensions/active_record'
require 'database/version'

module Database
  extend self

  include ActiveRecord::Tasks

  attr_accessor :root, :environment, :configurations

  def environment
    @environment ||= ENV['db'] || 'development'
  end

  def configurations
    @configurations ||= YAML.load_file(File.expand_path 'db/config.yml', root || File.expand_path('../..', __FILE__))
  end

  def establish_connection(options = {})
    ActiveRecord::Base.default_timezone = :utc
    ActiveRecord::Base.schema_format = :sql

    ActiveRecord::Base.internal_metadata_table_name = 'schema_metadata'
    ActiveRecord::Base.schema_migrations_table_name = 'schema_migrations'

    ActiveRecord::Base.configurations = options[:configurations] || configurations
    ActiveRecord::Base.establish_connection (options[:environment] || environment).to_sym
  end

  def load_tasks(options = {})
    load 'active_record/railties/databases.rake'
    load 'database/tasks/environment.rake'
    load 'database/tasks/databases.rake'

    establish_connection options

    DatabaseTasks.env = (options[:environment] || environment).to_s
    DatabaseTasks.database_configuration = ActiveRecord::Base.configurations
    DatabaseTasks.current_config = DatabaseTasks.database_configuration[DatabaseTasks.env]
    DatabaseTasks.root = options[:root] || root || File.expand_path('../..', __FILE__)
    DatabaseTasks.db_dir = 'db'
    DatabaseTasks.migrations_paths = ['db/migrate']
    DatabaseTasks.seed_loader = nil
  end
end
