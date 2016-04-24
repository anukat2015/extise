class Extnorm::Length
  def initialize(v)
    @length = v.size
  end

  def normalize(x)
    { length: @length, value: x.to_f / @length }
  end
end
