require 'active_record'
require 'yaml'

module Exrec
  extend self

  attr_accessor :root, :environment, :configuration

  def environment
    @environment ||= ENV['db'] || :development
  end

  def configuration
    @configuration ||= YAML.load_file(File.expand_path 'db/config.yml', root)
  end

  def connect(options = {})
    ActiveRecord::Base.configurations = options[:configuration] || configuration
    ActiveRecord::Base.establish_connection options[:environment] || environment
  end
end
