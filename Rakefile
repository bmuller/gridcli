require 'rubygems'
require 'bundler'
require 'rdoc/task'

Bundler::GemHelper.install_tasks

desc "Create documentation"
RDoc::Task.new("doc") { |rdoc|
  rdoc.title = "GridCLI - A command line interface to The Grid: Social Networking, Web 0.2"
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
}
