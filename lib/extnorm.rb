require 'active_support'

require 'extnorm/version'

module Extnorm
  extend ActiveSupport::Autoload

  autoload :Resolving

  autoload :Rescale
  autoload :Sigmoid
  autoload :Tanh
  autoload :ZScore

  extend Resolving
end
