class IO
  def self.open_if(*args)
    yield(*args) ? open(*args) : args.first
  end

  def self.open_or(*args)
    open_if(*args) { !args.first.is_a? IO }
  end
end
