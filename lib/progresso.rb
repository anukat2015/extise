require 'active_support/core_ext/kernel/reporting'
require 'ruby-progressbar'

# NOTE: always force desired progress bar output on TTY,
# any output to non-TTYs needs to be fixed manually

silence_warnings { ProgressBar::Outputs::NonTty = ProgressBar::Outputs::Tty }

module Progresso
  extend self

  def build(options = {})
    progress = options.delete :progress
    options = [true, nil].include?(progress) ? {
      format: "#{options[:title] if options[:title]} %E %B %c/%C %P%%",
      progress_mark: '-',
      total: options[:total]
    } : progress
    ProgressBar.create options
  end
end
