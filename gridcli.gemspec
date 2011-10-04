$:.push File.expand_path("../lib", __FILE__)
require "gridcli/version"

Gem::Specification.new do |s|
  s.name        = "gridcli"
  s.version     = GridCLI::VERSION
  s.authors     = ["Brian Muller"]
  s.email       = ["bamuller@gmail.com"]
  s.homepage    = "http://gridcli.com"
  s.summary     = "A command line interface to The Grid: Social Networking, Web 0.2"
  s.description = "A command line interface to The Grid: Social Networking, Web 0.2"
  s.rubyforge_project = "gridcli"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("activeresource", ">= 3.0.10")
  s.add_dependency("chronic", ">= 0.6.4")
  s.add_dependency("json", ">= 1.6.1")
  s.add_dependency("colorize", ">= 0.5.8")
  s.bindir = "bin"
  s.executables << "grid"
end
