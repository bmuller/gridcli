module GridCLI
  class SearchCommand < BaseCommand
    def initialize
      super "search", "Search posts"
    end

    def usage
      super "<like|dislike|message|status|all> <query> [<since time>]"
    end

    def run(args)
      usage if args.length < 2
      type = args.shift
      usage if not [ 'like', 'dislike', 'status', 'message', 'all' ].include? type
      query = args.shift
      dates = (args.length > 0 and not args.first.start_with? '-') ? args.shift : nil
      parse_opts args
      
      GridCLI.storage.search(type, query, dates)
    end
  end

  Runner.register "search", SearchCommand
end
