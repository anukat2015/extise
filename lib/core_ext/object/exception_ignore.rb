class Object
  def ignore(x)
    yield
  rescue x
    nil
  end
end
