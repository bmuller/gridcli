$:.push File.expand_path("../lib", __FILE__)
require "gridcli/version"
require "rake"
require "date"

Gem::Specification.new do |s|
  s.name        = "gridcli"
  s.version     = GridCLI::VERSION
  s.authors     = ["Brian Muller"]
  s.email       = ["bamuller@gmail.com"]
  s.homepage    = ""
  s.summary     = "A command line interface to The Grid: Social Networking, Web 0.2"
  s.description = "A command line interface to The Grid: Social Networking, Web 0.2"
  s.rubyforge_project = "gridcli"
  s.files = FileList["lib/**/*", "[A-Z]*", "Rakefile", "docs/**/*"]
  s.executables   = ["grid"]
  s.require_paths = ["lib"]
  s.add_dependency("activeresource", "~> 3.2")
  s.add_dependency("activesupport", "~> 3.2")
  s.add_dependency("chronic", ">= 0.6.4")
  s.add_dependency("json", ">= 1.6.1")
  s.add_dependency("colorize", ">= 0.5.8")
  s.bindir = "bin"
end
