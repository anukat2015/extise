require 'database'

task environment: 'db:load_config' do
  Database.establish_connection
end
