require 'tempfile'
require 'digest/sha2'

class Raddant
  include Enumerable
  class << self
    attr_accessor :bin
  end


  self.bin = 'radamsa'

  attr_accessor :indat, :seek, :polymerase, :muxers, :muxer_polymerase
  attr_accessor :count, :seed, :fuzzers, :generators, :temp_file

  def self.fuzz(file, opts={}, &block)
    self.new(file, opts, block)
  end

  def initialize(file, opts={}, &block)
    @indat = File.exists?(file) ? File.read(file) : file
    @count = opts[:count]
    @start_seed = opts[:seed]
    @seed = @start_seed || Digest::SHA512.hexdigest(File.read("/dev/urandom",512))
    @temp_file = Tempfile.new(opts[:temp_file] || "raddant")
    @temp_file.close
    @seek = opts[:seek]
    @fuzzers = opts[:fuzzers]
    @generators = opts[:generators]
    @polymerase = opts[:polymerase]
    @muxers = opts[:muxers]
    @muxer_polymerase = opts[:muxer_polymerase]
    self.each(block) if block_given?
  end

  def next?
    (@count && @count < 1) ? false : true
  end

  def each
    cnt = @count
    sd = @seed
    @seed = @start_seed || @seed
    eret = []
    while( self.next?) do
      yield self.next
      pp @seed
      eret << @seed if @count
    end
    @count = cnt
    @seed = sd
    eret
  end
  
  def next
    execute
    ret = ""
    begin
      @temp_file.open
      ret = @temp_file.read
    ensure
      @temp_file.close
    end
    @count = @count - 1
    @seed = Digest::SHA512.hexdigest(@seed)
    ret
  end

  private
  def execute
    args = ["-s", @seed, "-o", @temp_file.path]
    @temp_file.open
    @temp_file.write @indat
    @temp_file.close
    args += ["-f", [@fuzzers].flatten.join(",")] if @fuzzers
    args += ["-g", [@generators].flatten.join(",")] if @generators
    args += ["-p", [@polymerase].flatten.join(",")] if @polymerase
    args += ["-m", [@muxers].flatten.join(",")] if @muxers
    args += ["-P", [@muxer_polymerase].flatten.join(",")] if @muxer_polymerase
    args += ["-S", @seek] if @seek

    system(self.class.bin, *args)
  end
end