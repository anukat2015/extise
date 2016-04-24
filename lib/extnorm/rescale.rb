class Extnorm::Rescale
  def initialize(v)
    @min, @max = v.min, v.max
  end

  def normalize(x)
    { min: @min, max: @max, value: (x.to_f - @min) / (@max - @min) }
  end
end
