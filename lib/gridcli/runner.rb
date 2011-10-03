require 'active_resource'

module GridCLI
  class Runner
    def self.run(args)
      cmd = args.shift
      cmd = "help" if not @@cmds.has_key? cmd
      begin
        @@cmds[cmd].new.run(args)
      rescue ActiveResource::UnauthorizedAccess
        puts "Sorry gridder, your username or auth token is invalid."
      end
    end

    def self.register(name, klass)
      @@cmds ||= {}
      @@cmds[name] = klass
    end

    def self.command(key)
      @@cmds[key]
    end

    def self.commands
      @@cmds.values
    end
  end
end
