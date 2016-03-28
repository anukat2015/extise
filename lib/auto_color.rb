require 'colored'

module AutoColor
  def self.enable(options = {})
    target = options[:on].extend Base
    target.colored = options[:colored] != nil ? !!options[:colored] : true
    target.colorings = options[:colorings].to_h || {}
    target
  end

  def self.disable(options = {})
    enable options.merge colored: false
  end

  module Base
    METHODS = %i(abort inform warn print puts)

    attr_accessor :colored
    attr_accessor :colorings

    def self.extended(target)
      target.singleton_class.class_eval do
        METHODS.each do |method|
          next unless target.respond_to? method, true
          alias_method "uncolored_#{method}", method
          define_method method do |*args|
            send "uncolored_#{method}", *enrich(args)
          end
        end
      end
    end

    private

    def enrich(a)
      return colorize(a) if a.is_a? String
      return a.map { |e| e.is_a?(String) ? colorize(e) : e } if a.is_a? Array
      a
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
