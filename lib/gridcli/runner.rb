module GridCLI
  class Runner
    def self.run(args)
      cmd = args.shift
      cmd = "help" if not @@cmds.has_key? cmd
      @@cmds[cmd].new.run(args)
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
