require 'active_record'
require 'active_record/tasks/database_tasks'
require 'active_support/all'
require 'fileutils'
require 'yaml'

include ActiveRecord::Tasks

load 'active_record/railties/databases.rake'

environment = Exrec.environment
configuration = Exrec.configuration

ActiveRecord::Base.configurations = configuration
ActiveRecord::Base.schema_format = :sql

DatabaseTasks.env = environment
DatabaseTasks.database_configuration = ActiveRecord::Base.configurations
DatabaseTasks.current_config = DatabaseTasks.database_configuration[DatabaseTasks.env]
DatabaseTasks.root = File.expand_path '..', __FILE__
DatabaseTasks.db_dir = 'db'
DatabaseTasks.migrations_paths = ['db/migrate']
DatabaseTasks.seed_loader = nil

namespace :db do
  namespace :generate do
    desc 'Creates an empty migration file with specified name'
    task :migration, :name do |_, args|
      p = File.join DatabaseTasks.migrations_paths, "#{Time.now.strftime '%Y%m%d%H%M%S'}_#{args[:name].underscore}.rb"
      FileUtils.mkpath File.dirname p
      File.write p, "class #{args[:name].camelcase} < ActiveRecord::Migration\n  def change\n  end\nend\n"
    end
  end
end
