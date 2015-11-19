require 'active_record'
require 'active_record/tasks/database_tasks'
require 'active_support/core_ext/string/inflections'
require 'fileutils'

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
