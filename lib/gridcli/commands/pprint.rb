module GridCLI
  class PPrintCommand < BaseCommand
    def initialize
      super "pprint", "A program that will pretty print posts/users"
    end

    def run(args)
      usage if args.length != 0

      ARGV.clear
      ARGF.each { |line|
        puts PrettyPrinter.new(line)
        puts
      }
    end
  end

  Runner.register "pprint", PPrintCommand
end
