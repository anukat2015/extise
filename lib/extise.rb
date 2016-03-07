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

    functions = [function].flatten.compact
    files = input.is_a? Array ? ['--'] + input.flatten.compact : []

    Open3.popen3(command functions + files) do |input, output, error, status|
      input.tap { input.each { |line| input.puts line } if input.is_a? IO }.close
      yield output, error, status
    end
  end

  def self.stream(function: nil, input: STDIN)
    open function, input do |output, _, status|
      Thread.new { yield output }
      status.value.to_i.zero?
    end
  end
end
