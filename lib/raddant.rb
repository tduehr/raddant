require 'tempfile'
require 'digest/sha2'

class Raddant
  include Enumerable
  class << self
    attr_accessor :bin
  end


  self.bin = 'radamsa'

  attr_accessor :indat, :seek, :polymerase, :muxers, :muxer_polymerase
  attr_accessor :count, :seed, :fuzzers, :generators, :temp_file, :out_file

  def self.fuzz(file, opts={}, &block)
    self.new(file, opts, block)
  end

  def initialize(str = "", opts={}, &block)
    @indat = str
    @count = opts[:count] || 0
    @start_seed = opts[:seed]
    @seed = @start_seed || Digest::SHA512.hexdigest(File.read("/dev/urandom",512))
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

  def fuzz_once dat
    self.indat = dat
    self.next
  end

  def each
    cnt = @count
    sd = @seed
    @seed = @start_seed || @seed
    eret = []
    while( self.next?) do
      yield self.next
      eret << @seed if @count
    end
    @count = cnt
    @seed = sd
    eret
  end
  
  def next
    ret = execute
    @count = @count - 1
    @seed = Digest::SHA512.hexdigest(@seed)
    ret
  end

  private
  def execute
    @out_file = Tempfile.new("raddant")
    @out_file.close
    args = ["-s", @seed.to_i(16).to_s, "-o", @out_file.path]
    @temp_file = Tempfile.new("raddant")
    @temp_file.open
    @temp_file.write @indat
    @temp_file.close
    args += ["-f", [@fuzzers].flatten.join(",")] if @fuzzers
    args += ["-g", [@generators].flatten.join(",")] if @generators
    args += ["-p", [@polymerase].flatten.join(",")] if @polymerase
    args += ["-m", [@muxers].flatten.join(",")] if @muxers
    args += ["-P", [@muxer_polymerase].flatten.join(",")] if @muxer_polymerase
    args += ["-S", @seek] if @seek
    args << @temp_file.path

    raise "radamsa didn't work: #{$?}" unless system(self.class.bin, *args)
    @temp_file.close!
    @out_file.open
    ret = @out_file.read
    @out_file.close!
    ret
  end
end