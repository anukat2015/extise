class Extnorm::ZScore
  def initialize(v)
    @mean, @sd = v.mean, v.sd
  end

  def normalize(x)
    { mean: @mean, standard_deviation: @sd, value: (x.to_f - @mean) / @sd }
  end
end
