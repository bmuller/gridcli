module GridCLI
  class HelpCommand < BaseCommand
    def self.run(args)
      puts args
    end
  end
  
  Runner.register "help", HelpCommand
end
