$:.push File.expand_path("../lib", __FILE__)
require "gridcli/version"

Gem::Specification.new do |s|
  s.name        = "gridcli"
  s.version     = GridCLI::VERSION
  s.authors     = ["Brian Muller"]
  s.email       = ["bamuller@gmail.com"]
  s.homepage    = ""
  s.summary     = "A command line interface to The Grid"
  s.description = "A command line interface to The Grid"
  s.rubyforge_project = "gridcli"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("activeresource", ">= 3.0.10")
  s.bindir = "bin"
  s.executables << "grid"
end
