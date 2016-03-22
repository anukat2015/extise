require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload_under 'concepts' do
  end

  autoload_under 'elements' do
  end

  autoload_under 'sessions' do
  end
end