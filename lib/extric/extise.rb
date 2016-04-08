module Extric::Extise
  def read_blocks(function: nil, input: nil, &block)
    input = Extise::Data.pack_files input
    Extise.read(function: function, input: input).tap do |raw|
      Extise::Data.parse_blocks(raw).each &block if block
    end
  end

  def read_difference(differencer: nil, original: nil, revision: nil, &block)
    differencer ||= 'MyersTextDifferencer'
    contents = Extise::Data.pack_files original: original, revision: revision
    Extise.read function: differencer, input: contents, &block
  end

  def read_metric(metric: nil, sources: nil, &block)
    sources = Extise::Data.pack_files sources unless sources.is_a? String
    Extise.read function: metric, input: sources, &block
  end

  def compute_difference(differencer: nil, original: nil, revision: nil)
    a, d, m, t = 0, 0, 0, [original.length, revision.length].max

    read_difference(differencer: differencer, original: original, revision: revision) do |l|
      case l[0]
      when '+' then a += 1
      when '-' then d += 1
      when '±' then m += 1
      else
      end
    end

    { additions: a, deletions: d, modifications: m, total: t }
  end
end
