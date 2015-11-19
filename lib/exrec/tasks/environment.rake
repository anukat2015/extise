require 'exrec'

task environment: 'db:load_config' do
  Exrec.establish_connection
end
