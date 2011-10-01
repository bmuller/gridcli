module GridCLI
  class Runner
    def self.run(args)
      cmd = args.shift
      if not @@cmds.has_key? cmd
        puts "Command not found: #{cmd}"
        cmd = "help"
      end
      @@cmds[cmd].run args
    end

    def self.register(name, klass)
      @@cmds ||= {}
      @@cmds[name] = klass
    end
  end
end
