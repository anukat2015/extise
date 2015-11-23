require 'optparse'

module OptionBinder
  module Binding
    def bind_to_argument(*args, &block)
      v, args, f = (args * ' ').split(/\s+/, 2) << []
      f << :optional if args =~ /\A\[.*\]\z/
      f << :multiple if args =~ /\.\.\.\]?\z/
      (@arguments ||= {})[v] = { block: block, flags: f, default: options_binding.local_variable_get(v) }
      (@bound ||= []) << v.to_sym
      self
    end

    def bind_to_option(*args, &block)
      args = (args * ' ').split /\s+/, 4
      v, desc, args = args[0], args[3], args[1..2].reverse
      args.delete '--'
      a, d = args.first, options_binding.local_variable_get(v)
      args << "#{desc}#{desc ? ', ' : ''}#{"Default #{[d] * ','}" unless d.nil?}"
      a.sub!(/:\w+>/i) { |m| args << Object.const_get(m[1..-2].capitalize); '>' }
      args << $~.to_s[2..-2].split('|') if a =~ /=\(.*\)/
      (@bound ||= []) << v.to_sym
      on(*args) do |x|
        abort "missing argument: #{a.sub(/=.*/, '')}=" if a =~ /\w=/ && (!x || (x.respond_to?(:empty?) && x.empty?))
        options_binding.local_variable_set v, (block || -> (_) { x }).call(x == nil ? d : x)
      end
    end

    def bound
      @bound ? Hash[@bound.map { |v| [v, options_binding.local_variable_get(v)] }] : {}
    end

    def parse!(argv = default_argv)
      super
      (@arguments || {}).each do |v, args|
        x = argv[0] ? argv.shift : args[:default]
        x = ([x] + argv).flatten if args[:flags].include?(:multiple)
        abort('missing arguments') if x.nil? && !args[:flags].include?(:optional)
        options_binding.local_variable_set v, args[:block] ? args[:block].call(x) : x
        return if x.is_a? Array
      end
      abort 'too many arguments' if @arguments && argv.shift
    end
  end

  module Usage
    def banner
      return super unless @usage
      on_head "\n" and on_tail "\n"
      @usage.each_with_index.map { |u, i| "#{i == 0 ? 'usage' : '   or'}: #{program_name} #{u}" } * "\n"
    end

    def usage(*args)
      (@usage ||= []) << args * ' '
    end
  end

  module Syntax
    def use(*args)
      options.usage *args
    end

    alias usage use

    def opt(*args, &block)
      options.bind_to_option *args, &block
    end

    alias option opt

    def arg(*args, &block)
      options.bind_to_argument *args, &block
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
