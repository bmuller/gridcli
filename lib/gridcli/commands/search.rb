module GridCLI
  class SearchCommand < BaseCommand
    def initialize
      super "search", "Search posts"
      add_format_option
    end

    def usage
      super "<like|dislike|message|status|all> <query> [<since time>][ to <end time>]"
    end

    def run(args)
      usage if args.length < 2
      type = args.shift
      usage if not [ 'like', 'dislike', 'status', 'message', 'all' ].include? type
      query = args.shift
      period = (args.length > 0 and not args.first.start_with? '-') ? args.shift : nil
      dates = parse_dates period
      parse_opts args

      log "Showing #{type} posts in range #{dates.first || 'first'} - #{dates.last || 'last'}"
      GridCLI.storage.search(type, query, dates[0], dates[1], output_format)
    end
  end

  Runner.register "search", SearchCommand
end
