module GridCLI
  class HelpCommand < BaseCommand
    def initialize
      super "help", "Show available commands"
    end

    def run(args)
      if args.length > 0
        cmd = Runner.command(args.first)
        cmd.new.usage if not cmd.nil?
      end

      puts "Usage: grid <cmd>\n\nAvailable commands:\n\n"
      Runner.commands.each { |klass|
        inst = klass.new
        puts "\t#{inst.cmd}\t#{inst.desc}"
      }
      puts "\n\nTo get the options for any individual command, use:"
      puts "\tgrid help <cmd>\n\n"
    end
  end

  Runner.register "help", HelpCommand
end
