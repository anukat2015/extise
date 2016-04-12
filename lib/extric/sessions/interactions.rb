# NOTE: counts user interactions during a session

class Extric::Sessions::Interactions
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_interactions inside: session }
  end

  module Counting
    DEFAULT_KIND = %w(edit selection)

    extends ActiveSupport::Concern

    def count_interactions(inside: nil, kind: DEFAULT_KIND)
      inside.interactions.of(kind).count
    end

    def count_unique_interactions(inside: nil, kind: DEFAULT_KIND)
      inside.interactions.of(kind).group(:file, :path).count.values.select { |c| c == 1 }.sum
    end

    def count_subsequent_interactions(inside: nil, kind: DEFAULT_KIND)
      inside.interactions.of(kind).group(:file, :path).count.values.select { |c| c >= 2 }.sum
    end
  end
end
