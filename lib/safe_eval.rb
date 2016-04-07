module SafeEval
  extend self

  def safe_eval(o, context: nil, as: nil)
    c = context || Object.new
    o = c.instance_eval { binding }.eval o
    if as
      t = [as].flatten
      unless t.empty? || t.find { |u| o.is_a? u }
        raise Exception.new "#{__FILE__}:#{__LINE__}: evaluation error, unexpected #{o.class}, expecting #{t * ' or '}"
      end
    end
    o
  end

  module IO
    extend self

    def read_and_safe_eval(o, context: nil, as: nil)
      o = o.read if o.is_a? ::IO
      SafeEval.safe_eval o, context: context, as: as
    end

    def read_with_safe_eval(o, eval: nil, context: nil, as: nil)
      raise if eval.nil?
      require 'io_open_conditional'
      eval ? read_and_safe_eval(o, context: context, as: as) : File.open_or(o).readlines
    end
  end
end
