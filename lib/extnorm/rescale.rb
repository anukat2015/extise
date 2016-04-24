class Extnorm::Rescale
  RANGE = 0..1

  def initialize(v)
    @min, @max = v.min, v.max
  end

  def normalize(x)
    v = (x.to_f - @min) / (@max - @min) * (RANGE.end - RANGE.begin) + RANGE.begin

    { range: RANGE, min: @min, max: @max, value: v }
  end
end
