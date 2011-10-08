module GridCLI
  class PluginCommand < BaseCommand
    def initialize
      super "plugin", "Install / uninstall plugins"
    end

    def usage
      super "[<install|uninstall> <name>]"
    end

    def run(args)
      if args.length == 0
        puts "The following plugins are installed: "
        puts GridCLI.plugins['enabled'].join(', ')
      elsif args.length == 2 and args.first == "install"
        log "Attempting to install gem grid-plugin-#{args[1]}"
        GridCLI.plugins.install args[1]
      elsif args.length == 2 and args.first == "uninstall"
        log "Attempting to uninstall gem grid-plugin-#{args[1]}"
        GridCLI.plugins.uninstall args[1]
      else
        usage
      end
    end
  end

  Runner.register "plugin", PluginCommand
end
