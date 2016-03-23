require 'colored'

module AutoColor
  def self.enable(options = {})
    target = options[:on].extend self::Output
    target.colored = options[:colored] != nil ? !!options[:colored] : true
    target.colorings = options[:colorings].to_h || {}
    target
  end

  def self.disable(options = {})
    enable options.merge colored: false
  end

  module Output
    attr_accessor :colored
    attr_accessor :colorings

    [:abort, :warn, :print, :puts].each do |method|
      alias_method "uncolored_#{method}", method

      define_method method do |*args|
        send "uncolored_#{method}", *enrich(args)
      end
    end

    private

    def enrich(args)
      return colorize(args) if args.is_a? String
      return args.map { |a| a.is_a?(String) ? colorize(a) : a } if args.is_a? Array
      args
    end

    def colorize(s)
      return s.gsub(/\e\[(\d+)m/, '') unless colored

      (colorings || {}).each do |regexp, x|
        next if s !~ regexp
        (s = x.call s, regexp) and next if x.respond_to? :call
        [x].flatten.each { |m| s = s.send m }
      end

      s
    end
  end
end
