require 'optparse'

module OptBind
  module Binding
    def bind_on(*args)
      args = (args * ' ').split /\s+/, 4
      v, desc, args = args[0], args[3], args[1..2].reverse
      args.delete '--'
      a, d = args.first, _optbin_binding.local_variable_get(v)
      args << "#{desc}#{desc ? ', d' : 'D'}#{"efault #{[d] * ','}" unless d.nil?}"
      a.sub!(/:\w+>/i) { |m| args << Object.const_get(m[1..-2].capitalize); '>' }
      args << $~.to_s[2..-2].split('|') if a =~ /=\(.*\)/
      on(*args) do |x|
        abort "missing argument: #{a.sub(/=.*/, '')}=" if a =~ /\w=/ && (!x || (x.respond_to?(:empty?) && x.empty?))
        _optbin_binding.local_variable_set v, x == nil ? d : x
      end
    end

    def bind_to(*args)
      var, args = (args * ' ').split /\s+/, 2
      (@arguments ||= {})[var] = args =~ /\A\[.*\]\z/ ? [:optional] : []
    end

    def parse!(argv = default_argv)
      super
      (@arguments || {}).each do |v, args|
        x = argv.shift
        abort('missing arguments') unless args.include? :optional
        _optbin_binding.local_variable_set v, x
      end
      abort 'too many arguments' unless argv.shift.nil?
    end
  end

  module Usage
    def banner
      return super unless @usage
      @usage.each_with_index.map { |u, i| "#{i == 0 ? 'usage' : '   or'}: #{program_name} #{u}" } * "\n"
    end

    def usage(*args)
      @usage ||= [] << args * ' '
    end
  end

  module Syntax
    def use(*args)
      _optbin_options.usage *args
    end

    def opt(*args)
      _optbin_options.bind_on *args
    end

    def arg(*args)
      _optbin_options.bind_to *args
    end
  end

  module Extension
    def bind!(*args)
      trap(:SIGINT) { abort }
      args = args.inject({}) { |h, a| h.merge a.to_h }
      options, binding, target = self.options, args[:binding] || TOPLEVEL_BINDING, args[:to]
      target.extend(Syntax).define_singleton_method(:_optbin_options) { options }
      options.define_singleton_method(:_optbin_binding) { binding }
      options.extend Binding, Usage
      yield(options) and options.parse! rescue options.abort if block_given?
      options
    end
  end
end

ARGV.extend OptBind::Extension
