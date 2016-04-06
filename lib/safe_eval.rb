module SafeEval
  extend self

  def safe_eval(o)
    Object.new.instance_eval { binding }.eval o
  end

  module IO
    extend self

    def read_and_safe_eval(o, as: nil)
      o = o.read if o.is_a? ::IO
      v = SafeEval.safe_eval(o)

      if as && !v.is_a?(as)
        raise Exception.new "#{__FILE__}:#{__LINE__}: evaluation error, unexpected #{v.class}, expecting #{as}"
      end

      v
    end

    def read_with_safe_eval(o, eval: nil, as: nil)
      raise if eval.nil?

      require 'io_open_conditional'

      eval ? read_and_safe_eval(o, as: as) : ::IO.open_or(o).readlines
    end
  end
end
