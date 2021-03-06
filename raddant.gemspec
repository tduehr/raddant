# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: raddant 0.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "raddant"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["tduehr"]
  s.date = "2016-11-03"
  s.description = "Wrapper for radamsa - a mutation based file format fuzzer"
  s.email = "td@matasano.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/raddant.rb",
    "raddant.gemspec",
    "test/helper.rb",
    "test/test_raddant.rb"
  ]
  s.homepage = "http://github.com/tduehr/raddant"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "File fuzzer"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
    else
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    end
  else
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
  end
end

