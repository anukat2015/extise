module Extise
  MANIFEST = File.expand_path '../extise/META-INF/MANIFEST.MF', __FILE__
  VERSION = File.read(MANIFEST).match(/Bundle-Version:\s*(\d+\.\d+\.\d+)/)[1] || raise

  def self.binary
    @binary ||= "java -jar #{File.join __dir__, "extise-#{VERSION}.jar"}"
  end

  def self.command(*args)
    "#{binary} #{args * ' '}"
  end

  def self.call(*args)
    `#{command args}`
  end

  def self.open(function: nil, input: STDIN)
    require 'open3'

    functions, files = [function].flatten.compact, []
    files = ['--'] + input.flatten.compact if input.is_a? Array
    input = StringIO.new input if input.is_a? String

    Open3.popen3(command functions + files) do |i, o, e, s|
      i.tap { input.each_line { |l| i.puts l } if files.empty? }.close
      yield(o, e, s).tap { [o, e].each &:close }
    end
  end

  def self.stream(function: nil, input: STDIN)
    open function: function, input: input do |o, _, s|
      Thread.new { yield o }
      s.value.to_i.zero?
    end
  end

  module Parser
    def self.parse_blocks(input)
      input.each_line.inject([]) do |blocks, l|
        if l.start_with? '#'
          file, path, line, offset, length = *l[1..-1].strip.split(/[:\s\+]/)
          blocks << { file: file, path: path, line: line, offset: offset, length: length, source: nil }
        else
          (blocks.last[:source] ||= '') << l
        end

        blocks
      end
    end
  end
end
