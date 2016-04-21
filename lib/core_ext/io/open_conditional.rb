class IO
  def open_if(*args)
    yield(*args) ? open(*args) : args.first
  end

  def open_or(*args)
    open_if(*args) { !args.first.is_a? IO }
  end
end
