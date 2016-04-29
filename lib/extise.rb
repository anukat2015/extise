require 'jarun'

module Extise
  MANIFEST = File.expand_path 'extise/META-INF/MANIFEST.MF', __dir__
  VERSION = File.read(MANIFEST).match(/Bundle-Version:\s*(\d+\.\d+\.\d+)/)[1] || raise

  extend Jarun

  self.binary = File.expand_path "extise-#{VERSION}.jar", __dir__

  self.max_heap_size = '512m'
  self.max_perm_size = '64m'

  extend self

  attr_accessor :open_handle

  def resolve(function: nil, input: STDIN)
    functions, files = [function].flatten.compact, []
    files = ['--'] + input.flatten.compact if input.is_a? Array
    input = StringIO.new input if input.is_a? String
    return functions, files, input
  end

  def open(function: nil, input: STDIN)
    open_handle.open(function: function, input: input) { |*a| yield *a }
  end

  def stream(function: nil, input: STDIN)
    open function: function, input: input do |o, _, s|
      t = Thread.new { yield o }
      s.value.to_i == 0 ? t.value : false
    end
  end

  def read(function: nil, input: STDIN)
    stream function: function, input: input do |o|
      block_given? ? o.each_line { |l| yield l } : o.read
    end
  end

  module Command
    def self.open(function: nil, input: nil)
      require 'open3'
      functions, files, input = Extise.resolve function: function, input: input
      Open3.popen3(Extise.command functions + files) do |i, o, e, s|
        i.tap { input.each_line { |l| i.write l } if files.empty? }.close
        yield(o, e, s).tap { [o, e].each &:close }
      end
    end
  end

  class Client
    attr_accessor :host, :port

    def initialize(host: 'localhost', port: 7153)
      @host, @port = host, port
    end

    def open(function: nil, input: nil)
      functions, files, input = Extise.resolve function: function, input: input
      options = %w(-s) + (functions + files).map { |a| "-H 'Argument: #{a}'" }
      options += ["-X POST -H 'Content-type: text/plain; charset=utf-8'", '--data-binary @-'] if input
      Open3.popen3("curl #{options * ' '} #{host}:#{port}") do |i, o, e, s|
        i.tap { input.each_line { |l| i.write l } if files.empty? }.close
        r = o.read.tap { o.close }
        return false if r =~ /\Aextise server: unknown failure/
        yield(StringIO.new(r), e, s).tap { e.close }
      end
    end
  end

  module Data
    FS, US = 28, 31

    def self.pack_files(files)
      files.map { |file, source| "#{[file] * ':'}#{US.chr}#{source}" } * FS.chr
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
