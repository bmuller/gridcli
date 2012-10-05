require 'rubygems/gem_runner'
require 'rubygems/commands/query_command'

module GridCLI
  class Plugins < YMLHash
    def initialize
      super "plugins"
    end

    def default_config
      {
        'enabled' => [],
        'disabled' => []
      }
    end

    def install(name)
      name = "grid-plugin-#{name}" unless name.start_with?("grid-plugin-")
      Process.fork { Gem::GemRunner.new.run ["install", name, "--no-rdoc", "--no-ri"]; puts "done" }
      Process.wait

      if Gem::Specification.find_all_by_name(name).length == 0
        puts "There was an issue installing the plugin."
      elsif not fetch('enabled', []).include? name
        self['enabled'] << name
        save
      end
    end

    def uninstall(name)
      name = "grid-plugin-#{name}" unless name.start_with?("grid-plugin-")
      return unless fetch('enabled', []).include? name
      self['enabled'].delete(name)
      save
      Gem::GemRunner.new.run ["uninstall", name]
    end

    def include!
      fetch('enabled', []).each { |m|
        require m
      }
    end
  end
end
