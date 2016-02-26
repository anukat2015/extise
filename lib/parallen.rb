require 'parallel'

module Parallen
  extend self

  def process(items, options = {}, &block)
    options = {
      "in_#{options[:worker].to_s.sub(/[sd]\z/) { |c| c == 's' ? 'ses' : 'ds'}}".to_sym => options[:count],
      progress: options[:progress],
      start: options[:before_each],
      finish: options[:after_each]
    }
    Parallel.map items, options, &block
  end
end
