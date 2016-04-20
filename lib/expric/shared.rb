module Expric::Shared
  DEFAULT_DURATION_UNIT = :day

  DEFAULT_MEMORY_STRENGTH = 30
  DEFAULT_MEMORY_UNIT = :week

  extend ActiveSupport::Concern

  def calculate_decay_factor(via: nil, on: nil, options: nil)
    case via
    when :duration_ratio
      unit = 1.public_send options[:unit] || DEFAULT_DURATION_UNIT
      1.0 / ((context[:until] - on.finished_at) / unit).ceil
    when :memory_strength
      strength = options[:strength] || DEFAULT_MEMORY_STRENGTH
      unit = 1.public_send options[:unit] || DEFAULT_MEMORY_UNIT
      ((context[:until] - on.finished_at) / unit).ceil / strength
    else
      raise
    end
  end
end
