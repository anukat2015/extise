module Expric::Shared
  DEFAULT_DURATION_UNIT = :day

  DEFAULT_MEMORY_STRENGTH = 30
  DEFAULT_MEMORY_UNIT = :week

  extend ActiveSupport::Concern

  include Extric::Extise
  include Extric::Git

  def calculate_decay_factor(via: nil, on: nil, options: nil)
    g = open_repository name: on.commit.repository.name
    t = g.rev_parse('HEAD').time.utc

    options ||= {}

    case via
    when :duration_ratio
      unit = 1.public_send options[:unit] || DEFAULT_DURATION_UNIT
      1.0 / ((t - on.finished_at) / unit).ceil
    when :memory_strength
      strength = options[:strength] || DEFAULT_MEMORY_STRENGTH
      unit = 1.public_send options[:unit] || DEFAULT_MEMORY_UNIT
      ((t - on.finished_at) / unit).ceil / strength
    else
      raise
    end
  end
end
