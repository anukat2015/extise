require 'parallel'

module Parallen
  extend self

  def process(items, options = {})
    progress = [true, nil].include?(options[:progress]) ? {
      format: "#{options[:title] if options[:title]} %E %B %c/%C %P%%",
      progress_mark: '-',
      total: options[:total] || items.count
    } : options[:progress]
    options = {
      "in_#{options[:worker].to_s.sub(/[sd]\z/) { |c| c == 's' ? 'ses' : 'ds'}}".to_sym => options[:count],
      progress: options[:count] != 0 ? progress : nil
    }
    Parallel.map(items, options) do |item|
      yield item
    end
  end
end
