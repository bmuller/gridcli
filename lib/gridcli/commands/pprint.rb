module GridCLI
  class PPrintCommand < BaseCommand
    def initialize
      super "pprint", "A program that will pretty print posts/users"
      add_format_option
    end

    def run(args)
      parse_opts args

      ARGV.clear
      ARGF.each { |line| pprint(line) }
    end
  end

  Runner.register "pprint", PPrintCommand
end
