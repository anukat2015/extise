require 'extisimo'
require 'extinf/version'

module Extinf
  extend ActiveSupport::Autoload

  autoload_under 'elements' do
  end

  autoload_under 'tasks' do
  end
end
