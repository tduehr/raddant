# encoding: utf-8

require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "raddant"
  gem.homepage = "http://github.com/tduehr/raddant"
  gem.license = "MIT"
  gem.summary = %Q{File fuzzer}
  gem.description = %Q{Wrapper for radamsa - a mutation based file format fuzzer}
  gem.email = "td@matasano.com"
  gem.authors = ["tduehr"]
  gem.add_development_dependency "yard", "~> 0.6.0"
  gem.add_development_dependency "jeweler", "~> 1.6.4"
  gem.add_development_dependency "rcov", ">= 0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
