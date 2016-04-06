module Extric::Extise
  def read_metric(metric: nil, source: nil)
    Extise.stream(function: metric, input: source) { |o| o.read }
  end

  def stream_source_difference(differencer: nil, original: nil, revision: nil, &block)
    differencer ||= 'MyersTextDifferencer'
    sources = Extise::Data.pack_files(original: original, revision: revision)
    Extise.stream(function: differencer, input: sources) { |o| o.each_line &block }
  end

  def compute_source_difference(differencer: nil, original: nil, revision: nil)
    a, d, m, t = 0, 0, 0, [original.length, revision.length].max

    stream_source_difference(differencer: differencer, original: original, revision: revision) do |l|
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
