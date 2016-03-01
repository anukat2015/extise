require 'parallel'

module Parallen
  extend self

  def process(items, options = {}, &block)
    worker = "in_#{(options[:worker] || :thread).to_s.sub(/[sd]\z/) { |c| c == 's' ? 'ses' : 'ds'}}".to_sym
    options = {
      worker => options[:count] || 0,
      progress: options[:progress],
      start: options[:before_each],
      finish: options[:after_each]
    }
    Parallel.map items, options, &block
  end
end
