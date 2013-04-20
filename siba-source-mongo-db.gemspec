# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "siba-source-mongo-db/version"

Gem::Specification.new do |s|
  s.name        = "siba-source-mongo-db"
  s.version     = Siba::Source::MongoDb::VERSION
  s.authors     = ["Evgeny Neumerzhitskiy"]
  s.email       = ["sausageskin@gmail.com"]
  s.homepage    = "https://github.com/evgenyneu/siba-source-mongo-db"
  s.license     = "MIT"
  s.summary     = %q{MongoDB backup and restore extention for SIBA utility}
  s.description = %q{An extension for SIBA backup and restore utility. It allows to backup and restore MongoDB database.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency     'siba', '~>0.6'

  s.add_development_dependency  'minitest', '~>4.7'
  s.add_development_dependency  'rake', '~>10.0'
  s.add_development_dependency  'guard-minitest', '~>0.5'
end
