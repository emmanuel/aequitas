# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aequitas/version"

Gem::Specification.new do |s|
  s.name        = "aequitas"
  s.version     = Aequitas::VERSION
  s.authors     = ["Emmanuel Gomez"]
  s.email       = ["emmanuel.gomez@gmail.com"]
  s.homepage    = "https://github.com/emmanuel/aequitas"
  s.summary     = %q{Library for performing validations on Ruby objects.}
  s.description = %q{TODO: Write a gem description}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("minitest", ["~> 2.8"])
end
