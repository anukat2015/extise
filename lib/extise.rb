require 'jarun'

module Extise
  MANIFEST = File.expand_path 'extise/META-INF/MANIFEST.MF', __dir__
  VERSION = File.read(MANIFEST).match(/Bundle-Version:\s*(\d+\.\d+\.\d+)/)[1] || raise

  extend Jarun

  self.binary = File.expand_path "extise-#{VERSION}.jar", __dir__

  self.max_heap_size = '512m'
  self.max_perm_size = '64m'

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
      t = Thread.new { yield o }
      s.value.to_i == 0 ? t.value : false
    end
  end

  module Data
    FS, US = 28, 31

    def self.pack_files(files)
      files.map { |file, source| "#{file}#{US.chr}#{source}" } * FS.chr
    end

    def self.parse_blocks(input)
      input.each_line.inject([]) do |blocks, l|
        if l.start_with? '#'
          file, path, rest = *l[2..-1].strip.split(/:/)
          line, offset, length = *rest.split(/[\s\+]/)
          blocks << { file: file, path: path, line: line, offset: offset, length: length, source: nil }
        else
          (blocks.last[:source] ||= '') << l
        end

        blocks
      end
    end
  end
end
