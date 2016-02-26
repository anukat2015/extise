require 'ruby-progressbar'

module Progresso
  extend self

  def build(options = {})
    progress = options.delete :progress
    options = [true, nil].include?(progress) ? {
      format: "#{options[:title] if options[:title]} %E %B %c/%C %P%%",
      progress_mark: '-',
      total: options[:total]
    } : progress
    ProgressBar.create options if options
  end
end
