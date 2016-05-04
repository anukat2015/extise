require 'colored'

module Colored
  extend self

  attr_accessor :colorize_defaults

  alias_method :colorize_without_defaults, :colorize

  def colorize(s, options = {})
    colorize_without_defaults s, (Colored.colorize_defaults || {}).merge(options) if s
  end

  def decolorize(s, options = {})
    options.fetch(:escape, -> (v, _) { v.gsub(/\e\[\d+m/, '') }).call s, options if s
  end

  alias_method :emphasize, :bold

  def no_foreground
    self.gsub(/\e\[3[0-7]m/, '')
  end

  def no_background
    self.gsub(/\e\[4[0-7]m/, '')
  end

  def no_extras
    self.gsub(/\e\[[147]m/, '')
  end

  module HTML
    require 'erb'
    require 'strscan'

    NORMAL_COLORS = {
      30 => '#000',
      31 => '#b00',
      32 => '#0b0',
      33 => '#bb0',
      34 => '#00b',
      35 => '#b0b',
      36 => '#0bb',
      37 => '#bbb'
    }

    BRIGHT_COLORS = {
      30 => '#555',
      31 => '#f55',
      32 => '#5f5',
      33 => '#ff5',
      34 => '#55f',
      35 => '#f5f',
      36 => '#5ff',
      37 => '#fff'
    }

    extend self

    def escape(s, options = {})
      s = s.gsub(/((?:\e\[[34][0-7]m)+)(\e\[[17]m)/, '\2\1')
      r, e, t, h = StringScanner.new(ERB::Util.html_escape s), [], options.fetch(:tag, method(:to_tag)), ''

      until r.eos?
        e.push(r[1].to_i) and h << t.call(e, :open).to_s and next if r.scan(/\e\[([147]|[34][0-7])m/)
        h << t.call(e, :close).to_s and e.pop and next if r.scan(/(?:\e\[0m)/)
        h << r.scan(/./m)
      end

      h
    end

    alias_method :call, :escape

    def to_tag(e = [], o = nil)
      return nil if e.last == 1 || e.last == 7
      o == :open ? "<span #{to_attribute e}>" : '</span>'
    end

    def to_attribute(e = [])
      return 'style="text-decoration: underline"' if e.last == 4
      "style=\"#{e.last >= 40 ? 'background' : 'color'}: #{to_color e}\""
    end

    def to_color(e = [])
      k = e.last >= 40 ? e.last - 10 : e.last
      k = e.select { |x| x == 7 }.size.odd? ? 37 - (k % 10) : k
      (e.include?(1) ? BRIGHT_COLORS : NORMAL_COLORS)[k]
    end
  end
end

String.send(:include, Colored)
