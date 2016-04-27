module Expric::Shared
  DEFAULT_DURATION_UNIT = :day

  DEFAULT_MEMORY_STRENGTH = 30
  DEFAULT_MEMORY_UNIT = :week

  extend ActiveSupport::Concern

  include Extric::Extise
  include Extric::Git

  include Extric::Shared

  def calculate_decay_factor(via: nil, on: nil, unit: nil, strength: nil)
    g = open_repository name: on.commit.repository.name
    t = g.rev_parse('HEAD').time.utc

    case via
    when :duration_ratio
      u = 1.public_send unit || DEFAULT_DURATION_UNIT
      1.0 / ((t - on.finished_at) / u).ceil
    when :memory_strength
      s = strength || DEFAULT_MEMORY_STRENGTH
      u = 1.public_send unit || DEFAULT_MEMORY_UNIT
      Math.exp -((t - on.finished_at) / u).ceil / s
    else
      raise
    end
  end

  def calculate_interactive_productivity(on: nil, volume: nil, coefficients: nil)
    v = volume
    c = coefficients || {}

    e = count_unique_interactions inside: on, kind: 'edit'
    s = count_unique_interactions inside: on, kind: 'selection'
    i = count_subsequent_interactions inside: on, kind: 'edit'
    l = count_subsequent_interactions inside: on, kind: 'selection'

    v0 = c[:volume] || 0.5
    e0 = c[:unique_edits] || 0.25
    s0 = c[:unique_selections] || 0.1
    i0 = c[:subsequent_edits] || 0.1
    l0 = c[:subsequent_selections] || 0.05

    # NOTE: volume of change (reflects work done) per interactions (reflects time spent)

    (v0 * v) / (e0 * e + s0 * s + i0 * i + l0 * l)
  end
end
