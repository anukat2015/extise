require 'optparse'

module OptionBinder
  module Binding
    def bind_to_argument(*args)
      var, args = (args * ' ').split /\s+/, 2
      (@arguments ||= {})[var] = args =~ /\A\[.*\]\z/ ? [:optional] : []
    end

    def bind_to_option(*args)
      args = (args * ' ').split /\s+/, 4
      v, desc, args = args[0], args[3], args[1..2].reverse
      args.delete '--'
      a, d = args.first, options_binding.local_variable_get(v)
      args << "#{desc}#{desc ? ', d' : 'D'}#{"efault #{[d] * ','}" unless d.nil?}"
      a.sub!(/:\w+>/i) { |m| args << Object.const_get(m[1..-2].capitalize); '>' }
      args << $~.to_s[2..-2].split('|') if a =~ /=\(.*\)/
      on(*args) do |x|
        abort "missing argument: #{a.sub(/=.*/, '')}=" if a =~ /\w=/ && (!x || (x.respond_to?(:empty?) && x.empty?))
        options_binding.local_variable_set v, x == nil ? d : x
      end
    end

    def parse!(argv = default_argv)
      super
      (@arguments || {}).each do |v, args|
        x = argv.shift
        abort('missing arguments') unless args.include? :optional
        options_binding.local_variable_set v, x
      end
      abort 'too many arguments' unless argv.shift.nil?
    end
  end

  module Usage
    def banner
      return super unless @usage
      on_head "\n" and on_tail "\n"
      @usage.each_with_index.map { |u, i| "#{i == 0 ? 'usage' : '   or'}: #{program_name} #{u}" } * "\n"
    end

    def usage(*args)
      @usage ||= [] << args * ' '
    end
  end

  module Syntax
    def use(*args)
      options.usage *args
    end

    alias usage use

    def opt(*args)
      options.bind_to_option *args
    end

    alias option opt

    def arg(*args)
      options.bind_to_argument *args
    end

    alias argument arg
  end

  module Arguable
    def bind(*args)
      args = args.inject({}) { |h, a| h.merge a.to_h }
      options, binding, target = self.options, args[:binding] || TOPLEVEL_BINDING, args[:to]
      target.extend(Syntax).define_singleton_method(:options) { options }
      options.define_singleton_method(:options_binding) { binding }
      options.extend Binding, Usage
    end

    def bind!(*args)
      options = bind *args
      yield options and options.on_tail('-h', '--help') { abort options.to_s } if block_given?
      options.parse! rescue options.abort
      options
    end
  end
end

ARGV.extend OptionBinder::Arguable

OptBind = OptionBinder
