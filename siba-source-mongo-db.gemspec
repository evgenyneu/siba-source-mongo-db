# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "siba-source-mongo-db/version"

Gem::Specification.new do |s|
  s.name        = "siba-source-mongo-db"
  s.version     = Siba::Source::MongoDb::VERSION
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TOD0: your@email.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "siba-source-mongo-db"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency     'siba', '~>0.4'

  s.add_development_dependency  'minitest', '~>2.10'
  s.add_development_dependency  'rake', '~>0.9'
  s.add_development_dependency  'guard-minitest', '~>0.4'
end
