module Ignore
  def ignore(x)
    yield
  rescue x
    nil
  end
end

Object.send(:include, Ignore)
